From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: ALSA CVS is broken for Linux 2.4
Date: Sat, 2 Aug 2003 09:56:48 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030802085648.39461.qmail@web40602.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Hi,

These breakages have existed for a day or two.

In alsa-driver:

gcc -D__KERNEL__ -DMODULE=1
-I/home/chris/Programs/alsa/alsa-driver/include 
-I/home/chris/linux-2.4.21/include -O2
-mpreferred-stack-boundary=2 -march=i686 -D__SMP__
-DCONFIG_SMP -DLINUX -Wall -Wstrict-prototypes
-fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD 
-DKBUILD_BASENAME=emufx   -c -o emufx.o emufx.c
In file included from emufx.c:2:
../../alsa-kernel/pci/emu10k1/emufx.c: In function
`snd_emu10k1_gpr_ctl_put':
../../alsa-kernel/pci/emu10k1/emufx.c:367:
`EMU10K1_GRP_TRANSLATION_BASS' undeclared (first use
in this function)
../../alsa-kernel/pci/emu10k1/emufx.c:367: (Each
undeclared identifier is reported only once
../../alsa-kernel/pci/emu10k1/emufx.c:367: for each
function it appears in.)
../../alsa-kernel/pci/emu10k1/emufx.c:372:
`EMU10K1_GRP_TRANSLATION_TREBLE' undeclared (first use
in this function)
In file included from emufx.c:2:
../../alsa-kernel/pci/emu10k1/emufx.c: In function
`_snd_emu10k1_audigy_init_efx':
../../alsa-kernel/pci/emu10k1/emufx.c:1437:
`EMU10K1_GRP_TRANSLATION_BASS' undeclared (first use
in this function)
../../alsa-kernel/pci/emu10k1/emufx.c:1446:
`EMU10K1_GRP_TRANSLATION_TREBLE' undeclared (first use
in this function)
In file included from emufx.c:2:
../../alsa-kernel/pci/emu10k1/emufx.c: In function
`_snd_emu10k1_init_efx':
../../alsa-kernel/pci/emu10k1/emufx.c:1949:
`EMU10K1_GRP_TRANSLATION_BASS' undeclared (first use
in this function)
../../alsa-kernel/pci/emu10k1/emufx.c:1958:
`EMU10K1_GRP_TRANSLATION_TREBLE' undeclared (first use
in this function)
make[2]: *** [emufx.o] Error 1
make[2]: Leaving directory
`/home/chris/Programs/alsa/alsa-driver/pci/emu10k1'
make[1]: *** [_modsubdir_emu10k1] Error 2
make[1]: Leaving directory
`/home/chris/Programs/alsa/alsa-driver/pci'
make: *** [compile] Error 1

And in alsa-lib:

make[2]: Entering directory
`/home/chris/Programs/alsa/alsa-lib/src/rawmidi'
if /bin/sh ../../libtool --mode=compile gcc
-DHAVE_CONFIG_H -I. -I. -I../../include
-I../../include    -O2 -Wall -W -pipe -g -MT
rawmidi_virt.lo -MD -MP -MF ".deps/rawmidi_virt.Tpo" \
  -c -o rawmidi_virt.lo `test -f 'rawmidi_virt.c' ||
echo './'`rawmidi_virt.c; \
then mv -f ".deps/rawmidi_virt.Tpo"
".deps/rawmidi_virt.Plo"; \
else rm -f ".deps/rawmidi_virt.Tpo"; exit 1; \
fi
 gcc -DHAVE_CONFIG_H -I. -I. -I../../include
-I../../include -O2 -Wall -W -pipe -g -MT
rawmidi_virt.lo -MD -MP -MF .deps/rawmidi_virt.Tpo -c
rawmidi_virt.c  -fPIC -DPIC -o .libs/rawmidi_virt.o
rawmidi_virt.c: In function `_snd_rawmidi_virt_open':
rawmidi_virt.c:449: `pinfo' undeclared (first use in
this function)
rawmidi_virt.c:449: (Each undeclared identifier is
reported only once
rawmidi_virt.c:449: for each function it appears in.)
make[2]: *** [rawmidi_virt.lo] Error 1
make[2]: Leaving directory
`/home/chris/Programs/alsa/alsa-lib/src/rawmidi'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory
`/home/chris/Programs/alsa/alsa-lib/src'
make: *** [all-recursive] Error 1

Oops!

Chris


________________________________________________________________________
Want to chat instantly with your online friends?  Get the FREE Yahoo!
Messenger http://uk.messenger.yahoo.com/


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
