From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: cat /proc/asound/version: "No such device": HELP!!
Date: Fri, 14 Feb 2003 12:14:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030214111459.GA19210@rhlx01.fht-esslingen.de>
Reply-To: andi@rhlx01.fht-esslingen.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi all,

I'm almost at my wits end ("ARGH!").
Everything used to work pretty well... until I messed with my system once
again (upgrading some packages and doing other things, or so I think).

After having installed the 0.9rc7 Debian package (or around that time
at least) and having rebuilt ALSA, I didn't manage to start ALSA properly
any more:
root@note:/root# /etc/init.d/alsa start
cat: /proc/asound/version: No such device
Starting ALSA sound driver (version ):/etc/init.d/alsa: line 93: [: =: unary operator expected
 no sound cards defined.
root@note:/root#

root@note:/root# ls -l /proc/asound/
total 0
-r--r--r--    1 root     root            0 Feb 14 12:09 cards
dr-xr-xr-x    2 root     root            0 Feb 14 12:09 dev/
-r--r--r--    1 root     root            0 Feb 14 12:09 devices
-r--r--r--    1 root     root            0 Feb 14 12:09 meminfo
dr-xr-xr-x    2 root     root            0 Feb 14 12:09 oss/
dr-xr-xr-x    2 root     root            0 Feb 14 12:09 seq/
-r--r--r--    1 root     root            0 Feb 14 12:09 version
root@note:/root# cat /proc/asound/version
cat: /proc/asound/version: No such device
root@note:/root#
Modules loaded at that time:
snd                    42532   0
soundcore               3492   0  [snd]

I downgraded to the 0.9rc6 packages: nothing.
I checked out a completely fresh ALSA CVS tree and rebuilt (by using
cvscompile also): nothing.
I checked out an older ALSA tree: nothing.
I waited some weeks: nothing.

I'm almost as desperate as to debug and to rip apart
the whole goddamn thing now (/usr/src/system/CVS/alsa/alsa-kernel/core/info.c).

A reboot didn't help either, of course.

System:
Debian testing/unstable
2.4.20 custom kernel
ALSA latest CVS
root@note:/root# dpkg -l|grep alsa
ii  alsa-base      0.9.0rc7-2     ALSA driver common files
ii  alsa-headers   0.9.0rc7-2     ALSA driver header files
ii  alsa-utils     0.9.0rc7-1     Advanced Linux Sound Architecture (utils)
root@note:/root# dpkg -l|grep gcc
ii  gcc            3.2.2-0        The GNU C compiler.
ii  gcc-2.95       2.95.4-15      The GNU C compiler.
ii  gcc-3.0        3.0.4-0pre0201 The GNU C compiler.
ii  gcc-3.0-base   3.0.4-14       The GNU Compiler Collection (base package)
ii  gcc-3.2        3.2.2-0pre8    The GNU C compiler
ii  gcc-3.2-base   3.2.2-0pre8    The GNU Compiler Collection (base package)
ii  gcc272         2.7.2.3-18     The GNU C compiler.
ii  libgcc1        3.2.3-0pre1    GCC support library

Notebook Dell Inspiron 5000e (ugh!) with Maestro 2E (es1968) soundcard

Does anyone have *any* idea?

Maybe some "slightly too newish" gcc problem or so??
The next thing I'll try is to rebuild with my gcc 3.0.4 version...

Needless to say, I need this ALSA tree to work properly again
(if only to maybe hack on an Aztech PCI338 A3D Aureal AU8820 driver ;-))

Andreas Mohr


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
