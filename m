From: patrick <bizshort@earthlink.net>
Subject: 0.9.4 compile error in memalloc.c
Date: Sun, 08 Jun 2003 16:09:01 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EE3A5ED.2880B174@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

kernel: 2.4.18
card: hammerfall lite

i'm currently running 0.9.3 and tried upgrading to 0.9.4.  i get the following message in
configure's output: 

#./configure --with-cards=rme9652 --with-oss=no --with-isapnp=no --with-sequencer=no
.
.
checking for GCC version... ./configure: ${kernel_compiler_version:0:5}: bad substitution
./configure: ${my_compiler:0:4}: bad substitution
Kernel compiler: gcc 2.95.1 19990816/Linux (release) Used compiler: 2.95.1
.
.


then the following errors for 

#make
.
.
make[2]: Entering directory `/usr/src/alsa/driver/alsa-driver-0.9.4/acore'
make  -C ioctl32 fastdep
make[3]: Entering directory `/usr/src/alsa/driver/alsa-driver-0.9.4/acore/ioctl32'
make[3]: Leaving directory `/usr/src/alsa/driver/alsa-driver-0.9.4/acore/ioctl32'
make  -C oss fastdep
make[3]: Entering directory `/usr/src/alsa/driver/alsa-driver-0.9.4/acore/oss'
make[3]: Leaving directory `/usr/src/alsa/driver/alsa-driver-0.9.4/acore/oss'
make  -C seq fastdep
make[3]: Entering directory `/usr/src/alsa/driver/alsa-driver-0.9.4/acore/seq'
make  -C instr fastdep
make[4]: Entering directory `/usr/src/alsa/driver/alsa-driver-0.9.4/acore/seq/instr'
make[4]: Leaving directory `/usr/src/alsa/driver/alsa-driver-0.9.4/acore/seq/instr'
make[3]: Leaving directory `/usr/src/alsa/driver/alsa-driver-0.9.4/acore/seq'
/bin/sh: ${xtmp:0:5}: bad substitution
make[2]: *** [memalloc.c] Error 1
make[2]: Leaving directory `/usr/src/alsa/driver/alsa-driver-0.9.4/acore'
make[1]: *** [dep] Error 1
make[1]: Leaving directory `/usr/src/alsa/driver/alsa-driver-0.9.4'
make: *** [include/sndversions.h] Error 2


maybe this is related to recent posts on "hammerfall_men.c?"  at any rate, 0.9.3 is alive
and well and if this isn't a bug in 0.9.4, does anyone have a suggestion about what might
be wrong?  i've never seen a message like that in configure's output before.

thanks,
patrick


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
