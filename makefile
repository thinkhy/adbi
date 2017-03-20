SHELL=C:/Windows/System32/cmd.exe

MODULE_NAME=inject

STORE_PATH=/sdcard/ndk/$(MODULE_NAME)
EXE_PATH=/data/local/$(MODULE_NAME)
LOCAL_PATH=./libs/armeabi-v7a/$(MODULE_NAME)
STORE_DIR=/sdcard/ndk
STORE_PATH=/sdcard/ndk/$(MODULE_NAME)
EXE_PATH=/data/$(MODULE_NAME)

OBJS=$(MODULE_NAME).o \
	$(PLATFORM_LIB)/crtbegin_dynamic.o \
	$(PLATFORM_LIB)/crtend_android.o
		
all: example

hijack:
	cd hijack\jni&&ndk-build

base: hijack
	cd instruments\base\jni&&ndk-build

example: base
	pwd
	cd instruments\example\jni&&pwd&&ndk-build
		
clean:
	$(RM) *.o
			
install:
	adb -s eea29c8 push $(LOCAL_PATH) $(STORE_PATH)
	adb -s eea29c8 shell su -c mkdir -p $(STORE_DIR)
	adb -s eea29c8 shell su -c cp $(STORE_PATH) $(EXE_PATH)
	adb -s eea29c8 shell su -c chmod 755 $(EXE_PATH)
			 	
test:
	adb -s eea29c8 shell su -c $(EXE_PATH)
		

