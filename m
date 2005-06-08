From: Sebastian Stein <seb_stein@gmx.de>
Subject: Compilation alsa-driver-1.0.9b still broken
Date: Wed, 8 Jun 2005 17:14:59 +0200
Message-ID: <20050608151459.GA1492@hpfsc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I have seen you already updated the alsa-driver package twice to fix
compilation on 2.4. kernels, but it is still broken for me.

make[1]: Leaving directory `/usr/src/alsa/alsa-driver-1.0.9b/support'
make[1]: Entering directory `/usr/src/alsa/alsa-driver-1.0.9b/pci'
gcc -D__KERNEL__ -DMODULE=1 -I/usr/src/alsa/alsa-driver-1.0.9b/include
-I/lib/modules/2.4.31/build/include -O2 -mpreferred-stack-boundary=2
-march=k6 -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
-nostdinc -iwithprefix include -DMODVERSIONS -include
/lib/modules/2.4.31/build/include/linux/modversions.h
-DKBUILD_BASENAME=ens1371   -c -o ens1371.o ens1371.c
In file included from ../alsa-kernel/pci/ens1371.c:2,
                 from ens1371.c:1:
../alsa-kernel/pci/ens1370.c: In function `snd_ensoniq_playback1_prepare':
../alsa-kernel/pci/ens1370.c:852: error: `e' undeclared (first use in this
function)
../alsa-kernel/pci/ens1370.c:852: error: (Each undeclared identifier is
reported only once
../alsa-kernel/pci/ens1370.c:852: error: for each function it appears in.)
../alsa-kernel/pci/ens1370.c:852: error: parse error before "se"
make[1]: *** [ens1371.o] Error 1
make[1]: Leaving directory `/usr/src/alsa/alsa-driver-1.0.9b/pci'
make: *** [compile] Error 1

I have a Creative Sound Blaster card on the system I try to compile for. The
system is running a 2.4.31 kernel on a Slackware 10.0 system.


Please cc me, I'm not subscribed.

Sebastian


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
