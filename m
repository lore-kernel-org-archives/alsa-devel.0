From: iriXx <m@iriXx.org>
Subject: problem compiling cvs of  2003-04-19
Date: Sat, 19 Apr 2003 23:13:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EA1CA04.5090601@iriXx.org>
Reply-To: m@iriXx.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: linux-audio-user@music.columbia.edu, alsa-devel@sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi,

i've just downloaded the cvs from the repository of 2003-04-19 and am 
trying to compile for use on my desktop machine... which has the 
wonderful and rather overkill combination of a sbawe, msnd-pinnacle and 
usb-audio (quattro)...

i'm getting the following error on making cvs:

gcc -D__KERNEL__ -DMODULE=1 -I/usr/src/alsa/alsa-driver/include 
-I/lib/modules/2.4.18-6mdk/build/include -O2 
-mpreferred-stack-boundary=2 -march=i586 -DLINUX -Wall 
-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD 
-DKBUILD_BASENAME=init   -c -o init.o init.c
In file included from init.c:2:
../alsa-kernel/core/init.c:671: conflicting types for 
`snd_power_wait_Rc1205744'/usr/src/alsa/alsa-driver/include/sound/core.h:187: 
previous declaration of `snd_power_wait_Rc1205744'
make[1]: *** [init.o] Error 1
make[1]: Leaving directory `/usr/src/alsa/alsa-driver/acore'
make: *** [compile] Error 1

any ideas if i've got a missing library or something?

bw
m~



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
