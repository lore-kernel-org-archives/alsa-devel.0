From: Andrei Boros <andrei@srr.ro>
Subject: cvs alsa-lib compilation :
Date: Mon, 22 Sep 2003 12:06:38 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F6EBB9E.C9C13190@srr.ro>
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


 running ./cvscompile in alsa-lib (cvs tree) yields the following : 

 gate:~/install/alsa-cvs/alsa-lib# ./cvscompile
configure.in:44: warning: do not use m4_patsubst: use patsubst or
m4_bpatsubst
configure.in:182: warning: do not use m4_regexp: use regexp or
m4_bregexp
autoheader: `include/config.h.in' is unchanged
CFLAGS=-O2 -Wall -W -pipe -g


Then : 

checking whether build environment is sane... yes
/root/install/alsa-cvs/alsa-lib/missing: Unknown `--run' option
Try `/root/install/alsa-cvs/alsa-lib/missing --help' for more
information
configure: WARNING: `missing' script is too old or missing


Note : make is 
GNU Make version 3.79.1, by Richard Stallman and Roland McGrath.

gcc is 
Reading specs from /usr/lib/gcc-lib/i386-slackware-linux/2.95.3/specs
gcc version 2.95.3 20010315 (release)

Kernel is 2.2.24
glibc is 2.1.3 (would like to update to 2.2.5, but still having problems
with it).

Ok, so far these seem to be warnings. 

./cvscompile finally fails with : 

/bin/sh ../../libtool --mode=compile gcc -DHAVE_CONFIG_H -I. -I.
-I../../include -I../../include    -O2 -Wall -W -pipe -g -c -o
control_symbols.lo `test -f control_symbols.c || echo
'./'`control_symbols.c
make[2]: stat:control_symbols.lo: Too many levels of symbolic links
/bin/sh ../../libtool --mode=link gcc  -O2 -Wall -W -pipe -g   -o
libcontrol.la   cards.lo hcontrol.lo control.lo control_hw.lo
control_shm.lo setup.lo control_symbols.lo
rm -fr .libs/libcontrol.la .libs/libcontrol.* .libs/libcontrol.*
(cd . && ln -s cards.lo cards.lo)
ln: cards.lo: File exists
make[2]: *** [libcontrol.la] Error 1
make[2]: Leaving directory
`/serve/install/alsa-cvs/alsa-lib/src/control'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/serve/install/alsa-cvs/alsa-lib/src'
make: *** [all-recursive] Error 1



-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
