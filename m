From: James Courtier-Dutton <James@superbug.co.uk>
Subject: alsa-lib does not compile
Date: Sat, 04 Nov 2006 18:42:21 +0000
Message-ID: <454CDF0D.3000403@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2592

The current alsa hg repository  alsa-lib fails to compile here.
Details contained in alsa bug #2592

make fails with:
/bin/sh ../libtool --tag=CC --mode=link gcc -g -O2 -version-info 2:0:0 
-o libasound.la -rpath /usr/lib conf.lo confmisc.lo input.lo output.lo 
async.lo error.lo dlmisc.lo socket.lo shmarea.lo userfile.lo names.lo 
control/libcontrol.la mixer/libmixer.la pcm/libpcm.la timer/libtimer.la 
rawmidi/librawmidi.la hwdep/libhwdep.la seq/libseq.la instr/libinstr.la 
alisp/libalisp.la compat/libcompat.la -lm -ldl -lpthread
gcc -shared .libs/conf.o .libs/confmisc.o .libs/input.o .libs/output.o 
.libs/async.o .libs/error.o .libs/dlmisc.o .libs/socket.o 
.libs/shmarea.o .libs/userfile.o .libs/names.o -Wl,--whole-archive 
control/.libs/libcontrol.a mixer/.libs/libmixer.a pcm/.libs/libpcm.a 
timer/.libs/libtimer.a rawmidi/.libs/librawmidi.a hwdep/.libs/libhwdep.a 
seq/.libs/libseq.a instr/.libs/libinstr.a alisp/.libs/libalisp.a 
compat/.libs/libcompat.a -Wl,--no-whole-archive -lm -ldl -lpthread 
-Wl,-soname -Wl,libasound.so.2 -o .libs/libasound.so.2.0.0
/usr/lib/gcc/i686-pc-linux-gnu/4.1.1/../../../../i686-pc-linux-gnu/bin/ld: 
.libs/libasound.so.2.0.0: undefined versioned symbol name 
snd_pcm_hw_params_get_buffer_size_max@ALSA_0.9
/usr/lib/gcc/i686-pc-linux-gnu/4.1.1/../../../../i686-pc-linux-gnu/bin/ld: 
failed to set dynamic section sizes: Bad value
collect2: ld returned 1 exit status
make[2]: *** [libasound.la] Error 1
make[2]: Leaving directory `/u/alsahg/alsa-lib.local/src'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/u/alsahg/alsa-lib.local/src'
make: *** [all-recursive] Error 1

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
