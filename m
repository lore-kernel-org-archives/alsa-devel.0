From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: ALSA 1.0.13 + 2.6.19rc5 configuration/compilation error
Date: Sun, 19 Nov 2006 11:58:31 +0100
Message-ID: <456038d70cf0a@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
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

Hello,

I tried to build an alsa 1.0.13 with kernel 2.6.19rc5 for ARM.

Configuration worked ok, but then compilation failed. I used
these commands:

./configure ARCH=3Darm --with-cross=3Darm-linux- \
--with-kernel=3D/usr/src/linux-2.6.18

make ARCH=3Darm

The error returned:

make -C /usr/src/linux-2.6.18 SUBDIRS=3D/usr/src/alsa-driver-1.0.13
 CPP=3D"arm-linux-gcc -E" CC=3D"arm-linux-gcc " modules
make[1]: Entering directory `/usr/src/linux-2.6.18'
  CC [M]  /usr/src/alsa-driver-1.0.13/acore/hwdep.o
In file included from
/usr/src/alsa-driver-1.0.13/include/sound/driver.h:46,
                 from /usr/src/alsa-driver-1.0.13/acore/hwdep.c:22:
/usr/src/alsa-driver-1.0.13/include/adriver.h:742: error:
redefinition of 'jiffies_to_msecs'
include/linux/jiffies.h:268: error: previous definition of
'jiffies_to_msecs' was here
/usr/src/alsa-driver-1.0.13/include/adriver.h:761: error:
redefinition of 'msecs_to_jiffies'
include/linux/jiffies.h:290: error: previous definition of
'msecs_to_jiffies' was here
make[3]: *** [/usr/src/alsa-driver-1.0.13/acore/hwdep.o] Error 1
make[2]: *** [/usr/src/alsa-driver-1.0.13/acore] Error 2
make[1]: *** [_module_/usr/src/alsa-driver-1.0.13] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.18'
make: *** [compile] Error 2

I traced the problem back to configuration script. It uses the
linux/config.h in few tests programs and this file does not exist
in the $KERNEL/include/linux directory.
Here is a snippet from configuration log:

configure:7720: checking for msecs_to_jiffies
configure:7751: arm-linux-gcc  -c -Wall -fno-strict-aliasing -g
-O2 -I/usr/src/linux-2.6.18/include  -nostdinc -iwithprefix
include -DKBUILD_STR(s)=3D#s -DKBUILD_BASENAME=3DKBUILD_STR(dummy)
-Iinclude  conftest.c >&5
conftest.c:20:26: linux/config.h: No such file or directory
In file included from /usr/src/linux-2.6.18/include/linux/bitops.h:9,
                 from
/usr/src/linux-2.6.18/include/linux/kernel.h:15,
                 from
/usr/src/linux-2.6.18/include/linux/jiffies.h:5,
                 from conftest.c:21:
/usr/src/linux-2.6.18/include/asm/bitops.h: In function
`____atomic_set_bit':
/usr/src/linux-2.6.18/include/asm/bitops.h:40: warning: implicit
declaration of function `local_irq_save'
/usr/src/linux-2.6.18/include/asm/bitops.h:42: warning: implicit
declaration of function `local_irq_restore'
In file included from conftest.c:21:
/usr/src/linux-2.6.18/include/linux/jiffies.h:33:3: #error You lose.


I hope someone can point how to fix it (or fix it).
Krzysztof

----------------------------------------------------
WROC=A3AWSKIE TARGI PRACY! Najwi=EAksze Targi Pracy w Polsce, ponad 150
firm, tysi=B1ce ofert pracy - Wroc=B3aw 22.11.2006 Hala Ludowa - Zobacz:
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fd36.html&sid=
=3D935



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
