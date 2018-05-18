From: "orbea@fredslev.dk" <orbea@fredslev.dk>
Subject: alsa plugins + slibtool
Date: Fri, 18 May 2018 08:14:37 -0700
Message-ID: <20180518081437.4d30120d@Akita.witch.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/krtXM3oWxNC2ZH+0ZkKttdF"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay1.pub.mailoutpod1-wdc1.one.com
 (mailrelay1.pub.mailoutpod1-wdc1.one.com [104.37.34.214])
 by alsa0.perex.cz (Postfix) with ESMTP id 401BB266F44
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 17:14:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: o-takashi@sakamocchi.jp
List-Id: alsa-devel@alsa-project.org

--MP_/krtXM3oWxNC2ZH+0ZkKttdF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am experiencing build issues with alsa-plugins when using slibtool
instead of libtool. This build issue is because of a bug in
alsa-plugins which libtool hides so I have attached a log showing the
build error and a small patch to solve it. This patch will require
regenerating the autotools files with a command like 'autoreconf -fi'
to take effect.

If this could be applied in the next alsa-plugins release I would be
very grateful. Also note that I have tried to send this patch to the
mailing list before and am unsure if it ever made it past moderation?

For reference here is a link to the slibtool source.

https://git.midipix.org/cgit.cgi/slibtool/

And to their README that explains the project.

https://git.midipix.org/cgit.cgi/slibtool/plain/README

Thanks,
Hunter

--MP_/krtXM3oWxNC2ZH+0ZkKttdF
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=slibtool.patch

diff -ur alsa-plugins-1.1.5/arcam-av/Makefile.am alsa-plugins-1.1.5/arcam-av/Makefile.am
--- alsa-plugins-1.1.5/arcam-av/Makefile.am	2017-11-13 23:52:10.000000000 -0800
+++ alsa-plugins-1.1.5/arcam-av/Makefile.am	2017-11-29 15:19:56.025415638 -0800
@@ -3,7 +3,7 @@
 asound_module_ctl_arcam_avdir = @ALSA_PLUGIN_DIR@
 
 AM_CFLAGS = -Wall -g @ALSA_CFLAGS@
-AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined
+AM_LDFLAGS = -module -avoid-version -export-dynamic -no-undefined -pthread
 
 libasound_module_ctl_arcam_av_la_SOURCES = ctl_arcam_av.c arcam_av.c arcam_av.h
 libasound_module_ctl_arcam_av_la_LIBADD = @ALSA_LIBS@

--MP_/krtXM3oWxNC2ZH+0ZkKttdF
Content-Type: text/x-log
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=alsa-plugins.slibtool.log

checking for a BSD-compatible install... /usr/bin/ginstall -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /usr/bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking whether to enable maintainer-specific portions of Makefiles... yes
checking for gcc... gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables... 
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking for gcc option to accept ISO C89... none needed
checking for style of include used by make... GNU
checking dependency style of gcc... gcc3
checking build system type... x86_64-unknown-linux-gnu
checking host system type... x86_64-unknown-linux-gnu
checking how to print strings... printf
checking for a sed that does not truncate output... /usr/bin/sed
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for fgrep... /usr/bin/grep -F
checking for ld used by gcc... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
checking the name lister (/usr/bin/nm -B) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1572864
checking whether the shell understands some XSI constructs... yes
checking whether the shell understands "+="... yes
checking how to convert x86_64-unknown-linux-gnu file names to x86_64-unknown-linux-gnu format... func_convert_file_noop
checking how to convert x86_64-unknown-linux-gnu file names to toolchain format... func_convert_file_noop
checking for /usr/bin/ld option to reload object files... -r
checking for objdump... objdump
checking how to recognize dependent libraries... pass_all
checking for dlltool... dlltool
checking how to associate runtime and link libraries... printf %s\n
checking for ar... ar
checking for archiver @FILE support... @
checking for strip... strip
checking for ranlib... ranlib
checking command to parse /usr/bin/nm -B output from gcc object... ok
checking for sysroot... no
checking for mt... no
checking if : is a manifest tool... no
checking how to run the C preprocessor... gcc -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking for dlfcn.h... yes
checking for objdir... .libs
checking if gcc supports -fno-rtti -fno-exceptions... no
checking for gcc option to produce PIC... -fPIC -DPIC
checking if gcc PIC flag -fPIC -DPIC works... yes
checking if gcc static flag -static works... yes
checking if gcc supports -c -o file.o... yes
checking if gcc supports -c -o file.o... (cached) yes
checking whether the gcc linker (/usr/bin/ld -m elf_x86_64) supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... no
checking for ANSI C header files... (cached) yes
./configure: line 11552: CC_NOUNDEFINED: command not found
checking for pkg-config... /usr/bin/pkg-config
checking pkg-config is at least version 0.9.0... yes
checking for ALSA... yes
checking for snd_pcm_ioplug_create in -lasound... yes
checking for JACK... no
checking for pulseaudio... no
checking for samplerate... yes
./configure: line 12421: test: =: unary operator expected
checking for speexdsp... yes
checking for speex_resampler_init in -lspeexdsp... yes
checking speex/speexdsp_types.h usability... yes
checking speex/speexdsp_types.h presence... yes
checking for speex/speexdsp_types.h... yes
checking for plugins version... 1.1.6
checking that generated files are newer than configure... done
configure: creating ./config.status
config.status: creating Makefile
config.status: creating oss/Makefile
config.status: creating pph/Makefile
config.status: creating jack/Makefile
config.status: creating pulse/Makefile
config.status: creating mix/Makefile
config.status: creating rate/Makefile
config.status: creating a52/Makefile
config.status: creating rate-lavc/Makefile
config.status: creating maemo/Makefile
config.status: creating doc/Makefile
config.status: creating usb_stream/Makefile
config.status: creating speex/Makefile
config.status: creating arcam-av/Makefile
config.status: creating config.h
config.status: executing depfiles commands
config.status: executing libtool commands

Plugin directory: /usr/lib/alsa-lib
ALSA_CFLAGS: -I/usr/include/alsa 
ALSA_LIBS: -lasound 
JACK plugin:        no
Pulseaudio plugin:  no
Samplerate plugin:  yes
  samplerate_CFLAGS: 
  samplerate_LIBS: -lsamplerate 
Maemo plugin:       no
  Using Osso resource manager: no
A52, lavc plugins:  
Speex rate plugin:  lib
Speex preprocess plugin:  yes
make  all-recursive
make[1]: Entering directory '/tmp/alsa-plugins-1.1.6'
Making all in oss
make[2]: Entering directory '/tmp/alsa-plugins-1.1.6/oss'
slibtool-shared --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..    -Wall -g -I/usr/include/alsa  -g -O2 -MT ctl_oss.lo -MD -MP -MF .deps/ctl_oss.Tpo -c -o ctl_oss.lo ctl_oss.c
slibtool-shared --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..    -Wall -g -I/usr/include/alsa  -g -O2 -MT pcm_oss.lo -MD -MP -MF .deps/pcm_oss.Tpo -c -o pcm_oss.lo pcm_oss.c
slibtool-shared: compile: gcc -DHAVE_CONFIG_H -I. -I.. -Wall -g -I/usr/include/alsa -g -O2 -MT ctl_oss.lo -MD -MP -MF .deps/ctl_oss.Tpo -c ctl_oss.c -DPIC -fPIC -USLIBTOOL_PLACEHOLDER_COMPILE_ASSEMBLE -USLIBTOOL_PLACEHOLDER_NO_UNDEFINED -USLIBTOOL_PLACEHOLDER_SONAME -USLIBTOOL_PLACEHOLDER_LSONAME -USLIBTOOL_PLACEHOLDER_SYMDEF_SWITCH -USLIBTOOL_PLACEHOLDER_SYMDEF_FILE -o .libs/ctl_oss.o -USLIBTOOL_PLACEHOLDER_RPATH_SWITCH -USLIBTOOL_PLACEHOLDER_RPATH_DIR
slibtool-shared: compile: gcc -DHAVE_CONFIG_H -I. -I.. -Wall -g -I/usr/include/alsa -g -O2 -MT pcm_oss.lo -MD -MP -MF .deps/pcm_oss.Tpo -c pcm_oss.c -DPIC -fPIC -USLIBTOOL_PLACEHOLDER_COMPILE_ASSEMBLE -USLIBTOOL_PLACEHOLDER_NO_UNDEFINED -USLIBTOOL_PLACEHOLDER_SONAME -USLIBTOOL_PLACEHOLDER_LSONAME -USLIBTOOL_PLACEHOLDER_SYMDEF_SWITCH -USLIBTOOL_PLACEHOLDER_SYMDEF_FILE -o .libs/pcm_oss.o -USLIBTOOL_PLACEHOLDER_RPATH_SWITCH -USLIBTOOL_PLACEHOLDER_RPATH_DIR
mv -f .deps/ctl_oss.Tpo .deps/ctl_oss.Plo
slibtool-shared --tag=CC   --mode=link gcc -Wall -g -I/usr/include/alsa  -g -O2 -module -avoid-version -export-dynamic -no-undefined   -o libasound_module_ctl_oss.la -rpath /usr/lib/alsa-lib ctl_oss.lo -lasound  -lasound 
mv -f .deps/pcm_oss.Tpo .deps/pcm_oss.Plo
slibtool-shared --tag=CC   --mode=link gcc -Wall -g -I/usr/include/alsa  -g -O2 -module -avoid-version -export-dynamic -no-undefined   -o libasound_module_pcm_oss.la -rpath /usr/lib/alsa-lib pcm_oss.lo -lasound  -lasound 
slibtool-shared: link: ln -s /dev/null .libs/libasound_module_pcm_oss.a
slibtool-shared: link: gcc .libs/pcm_oss.o -Wall -g -I/usr/include/alsa -g -O2 -lasound -lasound -shared -fPIC -USLIBTOOL_PLACEHOLDER_COMPILE_ASSEMBLE -Wl,--no-undefined -USLIBTOOL_PLACEHOLDER_SONAME -USLIBTOOL_PLACEHOLDER_LSONAME -USLIBTOOL_PLACEHOLDER_SYMDEF_SWITCH -USLIBTOOL_PLACEHOLDER_SYMDEF_FILE -o .libs/libasound_module_pcm_oss.so -USLIBTOOL_PLACEHOLDER_RPATH_SWITCH -USLIBTOOL_PLACEHOLDER_RPATH_DIR -Wl,--export-dynamic
slibtool-shared: link: ln -s /dev/null .libs/libasound_module_ctl_oss.a
slibtool-shared: link: gcc .libs/ctl_oss.o -Wall -g -I/usr/include/alsa -g -O2 -lasound -lasound -shared -fPIC -USLIBTOOL_PLACEHOLDER_COMPILE_ASSEMBLE -Wl,--no-undefined -USLIBTOOL_PLACEHOLDER_SONAME -USLIBTOOL_PLACEHOLDER_LSONAME -USLIBTOOL_PLACEHOLDER_SYMDEF_SWITCH -USLIBTOOL_PLACEHOLDER_SYMDEF_FILE -o .libs/libasound_module_ctl_oss.so -USLIBTOOL_PLACEHOLDER_RPATH_SWITCH -USLIBTOOL_PLACEHOLDER_RPATH_DIR -Wl,--export-dynamic
slibtool-shared: link: ln -s ../libasound_module_pcm_oss.la .libs/libasound_module_pcm_oss.la
slibtool-shared: link: ln -s ../libasound_module_pcm_oss.la .libs/libasound_module_pcm_oss.lai
slibtool-shared: link: ln -s ../libasound_module_ctl_oss.la .libs/libasound_module_ctl_oss.la
slibtool-shared: link: ln -s ../libasound_module_ctl_oss.la .libs/libasound_module_ctl_oss.lai
make[2]: Leaving directory '/tmp/alsa-plugins-1.1.6/oss'
Making all in mix
make[2]: Entering directory '/tmp/alsa-plugins-1.1.6/mix'
slibtool-shared --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..    -Wall -g -I/usr/include/alsa  -g -O2 -MT pcm_upmix.lo -MD -MP -MF .deps/pcm_upmix.Tpo -c -o pcm_upmix.lo pcm_upmix.c
slibtool-shared --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..    -Wall -g -I/usr/include/alsa  -g -O2 -MT pcm_vdownmix.lo -MD -MP -MF .deps/pcm_vdownmix.Tpo -c -o pcm_vdownmix.lo pcm_vdownmix.c
slibtool-shared: compile: gcc -DHAVE_CONFIG_H -I. -I.. -Wall -g -I/usr/include/alsa -g -O2 -MT pcm_upmix.lo -MD -MP -MF .deps/pcm_upmix.Tpo -c pcm_upmix.c -DPIC -fPIC -USLIBTOOL_PLACEHOLDER_COMPILE_ASSEMBLE -USLIBTOOL_PLACEHOLDER_NO_UNDEFINED -USLIBTOOL_PLACEHOLDER_SONAME -USLIBTOOL_PLACEHOLDER_LSONAME -USLIBTOOL_PLACEHOLDER_SYMDEF_SWITCH -USLIBTOOL_PLACEHOLDER_SYMDEF_FILE -o .libs/pcm_upmix.o -USLIBTOOL_PLACEHOLDER_RPATH_SWITCH -USLIBTOOL_PLACEHOLDER_RPATH_DIR
slibtool-shared: compile: gcc -DHAVE_CONFIG_H -I. -I.. -Wall -g -I/usr/include/alsa -g -O2 -MT pcm_vdownmix.lo -MD -MP -MF .deps/pcm_vdownmix.Tpo -c pcm_vdownmix.c -DPIC -fPIC -USLIBTOOL_PLACEHOLDER_COMPILE_ASSEMBLE -USLIBTOOL_PLACEHOLDER_NO_UNDEFINED -USLIBTOOL_PLACEHOLDER_SONAME -USLIBTOOL_PLACEHOLDER_LSONAME -USLIBTOOL_PLACEHOLDER_SYMDEF_SWITCH -USLIBTOOL_PLACEHOLDER_SYMDEF_FILE -o .libs/pcm_vdownmix.o -USLIBTOOL_PLACEHOLDER_RPATH_SWITCH -USLIBTOOL_PLACEHOLDER_RPATH_DIR
mv -f .deps/pcm_vdownmix.Tpo .deps/pcm_vdownmix.Plo
mv -f .deps/pcm_upmix.Tpo .deps/pcm_upmix.Plo
slibtool-shared --tag=CC   --mode=link gcc -Wall -g -I/usr/include/alsa  -g -O2 -module -avoid-version -export-dynamic -no-undefined   -o libasound_module_pcm_vdownmix.la -rpath /usr/lib/alsa-lib pcm_vdownmix.lo -lasound  -lasound 
slibtool-shared --tag=CC   --mode=link gcc -Wall -g -I/usr/include/alsa  -g -O2 -module -avoid-version -export-dynamic -no-undefined   -o libasound_module_pcm_upmix.la -rpath /usr/lib/alsa-lib pcm_upmix.lo -lasound  -lasound 
slibtool-shared: link: ln -s /dev/null .libs/libasound_module_pcm_vdownmix.a
slibtool-shared: link: gcc .libs/pcm_vdownmix.o -Wall -g -I/usr/include/alsa -g -O2 -lasound -lasound -shared -fPIC -USLIBTOOL_PLACEHOLDER_COMPILE_ASSEMBLE -Wl,--no-undefined -USLIBTOOL_PLACEHOLDER_SONAME -USLIBTOOL_PLACEHOLDER_LSONAME -USLIBTOOL_PLACEHOLDER_SYMDEF_SWITCH -USLIBTOOL_PLACEHOLDER_SYMDEF_FILE -o .libs/libasound_module_pcm_vdownmix.so -USLIBTOOL_PLACEHOLDER_RPATH_SWITCH -USLIBTOOL_PLACEHOLDER_RPATH_DIR -Wl,--export-dynamic
slibtool-shared: link: ln -s /dev/null .libs/libasound_module_pcm_upmix.a
slibtool-shared: link: gcc .libs/pcm_upmix.o -Wall -g -I/usr/include/alsa -g -O2 -lasound -lasound -shared -fPIC -USLIBTOOL_PLACEHOLDER_COMPILE_ASSEMBLE -Wl,--no-undefined -USLIBTOOL_PLACEHOLDER_SONAME -USLIBTOOL_PLACEHOLDER_LSONAME -USLIBTOOL_PLACEHOLDER_SYMDEF_SWITCH -USLIBTOOL_PLACEHOLDER_SYMDEF_FILE -o .libs/libasound_module_pcm_upmix.so -USLIBTOOL_PLACEHOLDER_RPATH_SWITCH -USLIBTOOL_PLACEHOLDER_RPATH_DIR -Wl,--export-dynamic
slibtool-shared: link: ln -s ../libasound_module_pcm_vdownmix.la .libs/libasound_module_pcm_vdownmix.la
slibtool-shared: link: ln -s ../libasound_module_pcm_vdownmix.la .libs/libasound_module_pcm_vdownmix.lai
slibtool-shared: link: ln -s ../libasound_module_pcm_upmix.la .libs/libasound_module_pcm_upmix.la
slibtool-shared: link: ln -s ../libasound_module_pcm_upmix.la .libs/libasound_module_pcm_upmix.lai
make[2]: Leaving directory '/tmp/alsa-plugins-1.1.6/mix'
Making all in usb_stream
make[2]: Entering directory '/tmp/alsa-plugins-1.1.6/usb_stream'
slibtool-shared --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..    -Wall -g -I/usr/include/alsa  -g -O2 -MT pcm_usb_stream.lo -MD -MP -MF .deps/pcm_usb_stream.Tpo -c -o pcm_usb_stream.lo pcm_usb_stream.c
slibtool-shared: compile: gcc -DHAVE_CONFIG_H -I. -I.. -Wall -g -I/usr/include/alsa -g -O2 -MT pcm_usb_stream.lo -MD -MP -MF .deps/pcm_usb_stream.Tpo -c pcm_usb_stream.c -DPIC -fPIC -USLIBTOOL_PLACEHOLDER_COMPILE_ASSEMBLE -USLIBTOOL_PLACEHOLDER_NO_UNDEFINED -USLIBTOOL_PLACEHOLDER_SONAME -USLIBTOOL_PLACEHOLDER_LSONAME -USLIBTOOL_PLACEHOLDER_SYMDEF_SWITCH -USLIBTOOL_PLACEHOLDER_SYMDEF_FILE -o .libs/pcm_usb_stream.o -USLIBTOOL_PLACEHOLDER_RPATH_SWITCH -USLIBTOOL_PLACEHOLDER_RPATH_DIR
mv -f .deps/pcm_usb_stream.Tpo .deps/pcm_usb_stream.Plo
slibtool-shared --tag=CC   --mode=link gcc -Wall -g -I/usr/include/alsa  -g -O2 -module -avoid-version -export-dynamic   -o libasound_module_pcm_usb_stream.la -rpath /usr/lib/alsa-lib pcm_usb_stream.lo -lasound  -lasound 
slibtool-shared: link: ln -s /dev/null .libs/libasound_module_pcm_usb_stream.a
slibtool-shared: link: gcc .libs/pcm_usb_stream.o -Wall -g -I/usr/include/alsa -g -O2 -lasound -lasound -shared -fPIC -USLIBTOOL_PLACEHOLDER_COMPILE_ASSEMBLE -USLIBTOOL_PLACEHOLDER_NO_UNDEFINED -USLIBTOOL_PLACEHOLDER_SONAME -USLIBTOOL_PLACEHOLDER_LSONAME -USLIBTOOL_PLACEHOLDER_SYMDEF_SWITCH -USLIBTOOL_PLACEHOLDER_SYMDEF_FILE -o .libs/libasound_module_pcm_usb_stream.so -USLIBTOOL_PLACEHOLDER_RPATH_SWITCH -USLIBTOOL_PLACEHOLDER_RPATH_DIR -Wl,--export-dynamic
slibtool-shared: link: ln -s ../libasound_module_pcm_usb_stream.la .libs/libasound_module_pcm_usb_stream.la
slibtool-shared: link: ln -s ../libasound_module_pcm_usb_stream.la .libs/libasound_module_pcm_usb_stream.lai
make[2]: Leaving directory '/tmp/alsa-plugins-1.1.6/usb_stream'
Making all in arcam-av
make[2]: Entering directory '/tmp/alsa-plugins-1.1.6/arcam-av'
slibtool-shared --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..    -Wall -g -I/usr/include/alsa  -g -O2 -MT ctl_arcam_av.lo -MD -MP -MF .deps/ctl_arcam_av.Tpo -c -o ctl_arcam_av.lo ctl_arcam_av.c
slibtool-shared --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..    -Wall -g -I/usr/include/alsa  -g -O2 -MT arcam_av.lo -MD -MP -MF .deps/arcam_av.Tpo -c -o arcam_av.lo arcam_av.c
slibtool-shared: compile: gcc -DHAVE_CONFIG_H -I. -I.. -Wall -g -I/usr/include/alsa -g -O2 -MT ctl_arcam_av.lo -MD -MP -MF .deps/ctl_arcam_av.Tpo -c ctl_arcam_av.c -DPIC -fPIC -USLIBTOOL_PLACEHOLDER_COMPILE_ASSEMBLE -USLIBTOOL_PLACEHOLDER_NO_UNDEFINED -USLIBTOOL_PLACEHOLDER_SONAME -USLIBTOOL_PLACEHOLDER_LSONAME -USLIBTOOL_PLACEHOLDER_SYMDEF_SWITCH -USLIBTOOL_PLACEHOLDER_SYMDEF_FILE -o .libs/ctl_arcam_av.o -USLIBTOOL_PLACEHOLDER_RPATH_SWITCH -USLIBTOOL_PLACEHOLDER_RPATH_DIR
slibtool-shared: compile: gcc -DHAVE_CONFIG_H -I. -I.. -Wall -g -I/usr/include/alsa -g -O2 -MT arcam_av.lo -MD -MP -MF .deps/arcam_av.Tpo -c arcam_av.c -DPIC -fPIC -USLIBTOOL_PLACEHOLDER_COMPILE_ASSEMBLE -USLIBTOOL_PLACEHOLDER_NO_UNDEFINED -USLIBTOOL_PLACEHOLDER_SONAME -USLIBTOOL_PLACEHOLDER_LSONAME -USLIBTOOL_PLACEHOLDER_SYMDEF_SWITCH -USLIBTOOL_PLACEHOLDER_SYMDEF_FILE -o .libs/arcam_av.o -USLIBTOOL_PLACEHOLDER_RPATH_SWITCH -USLIBTOOL_PLACEHOLDER_RPATH_DIR
mv -f .deps/arcam_av.Tpo .deps/arcam_av.Plo
mv -f .deps/ctl_arcam_av.Tpo .deps/ctl_arcam_av.Plo
slibtool-shared --tag=CC   --mode=link gcc -Wall -g -I/usr/include/alsa  -g -O2 -module -avoid-version -export-dynamic -no-undefined  -o libasound_module_ctl_arcam_av.la -rpath /usr/lib/alsa-lib ctl_arcam_av.lo arcam_av.lo -lasound  -lasound 
slibtool-shared: link: ln -s /dev/null .libs/libasound_module_ctl_arcam_av.a
slibtool-shared: link: gcc .libs/ctl_arcam_av.o .libs/arcam_av.o -Wall -g -I/usr/include/alsa -g -O2 -lasound -lasound -shared -fPIC -USLIBTOOL_PLACEHOLDER_COMPILE_ASSEMBLE -Wl,--no-undefined -USLIBTOOL_PLACEHOLDER_SONAME -USLIBTOOL_PLACEHOLDER_LSONAME -USLIBTOOL_PLACEHOLDER_SYMDEF_SWITCH -USLIBTOOL_PLACEHOLDER_SYMDEF_FILE -o .libs/libasound_module_ctl_arcam_av.so -USLIBTOOL_PLACEHOLDER_RPATH_SWITCH -USLIBTOOL_PLACEHOLDER_RPATH_DIR -Wl,--export-dynamic
.libs/arcam_av.o: In function `arcam_av_server_thread':
/tmp/alsa-plugins-1.1.6/arcam-av/arcam_av.c:560: undefined reference to `sem_post'
/tmp/alsa-plugins-1.1.6/arcam-av/arcam_av.c:534: undefined reference to `sem_post'
/tmp/alsa-plugins-1.1.6/arcam-av/arcam_av.c:547: undefined reference to `sem_post'
.libs/arcam_av.o: In function `arcam_av_server_start':
/tmp/alsa-plugins-1.1.6/arcam-av/arcam_av.c:575: undefined reference to `sem_init'
/tmp/alsa-plugins-1.1.6/arcam-av/arcam_av.c:580: undefined reference to `pthread_create'
/tmp/alsa-plugins-1.1.6/arcam-av/arcam_av.c:585: undefined reference to `sem_destroy'
/tmp/alsa-plugins-1.1.6/arcam-av/arcam_av.c:583: undefined reference to `sem_wait'
.libs/arcam_av.o: In function `arcam_av_server_stop':
/tmp/alsa-plugins-1.1.6/arcam-av/arcam_av.c:598: undefined reference to `pthread_join'
collect2: error: ld returned 1 exit status
slibtool-shared: exec error upon slbt_exec_link_create_library(), line 1200: (see child process error messages).
slibtool-shared: < returned to > slbt_exec_link(), line 1546.
make[2]: *** [Makefile:331: libasound_module_ctl_arcam_av.la] Error 2
make[2]: Leaving directory '/tmp/alsa-plugins-1.1.6/arcam-av'
make[1]: *** [Makefile:351: all-recursive] Error 1
make[1]: Leaving directory '/tmp/alsa-plugins-1.1.6'
make: *** [Makefile:282: all] Error 2

real	0m0.210s
user	0m0.158s
sys	0m0.137s

--MP_/krtXM3oWxNC2ZH+0ZkKttdF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--MP_/krtXM3oWxNC2ZH+0ZkKttdF--
