From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002303]: A lot of warning during
	compilation of alsa-driver 1.0.12rc1
Date: Thu, 27 Jul 2006 14:28:31 +0200
Message-ID: <5e8dab3903486c7fe867858f7bd7483e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 81CD91AC
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Jul 2006 14:28:31 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D2303> =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                croiset
Assigned To:                perex
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Issue ID:                   2303
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               =

Kernel Version:             2.4.7-10
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             07-25-2006 13:05 CEST
Last Modified:              07-27-2006 14:28 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    A lot of warning during compilation of alsa-dri=
ver
1.0.12rc1
Description: =

This is the list of warnings during thez compilation some of them creates
some undefined symbols when you want to use the driver.


+ make
make[3]: D=E9pendance circulaire io.c <- io.c abandonn=E9e.
sound.c: In function `snd_open':
sound.c:177: warning: assignment discards qualifiers from pointer target
type
sound.c:182: warning: assignment discards qualifiers from pointer target
type
sound.c: At top level:
sound.c:45: warning: `device_mode' defined but not used
info.c: In function `snd_iprintf':
info.c:119: warning: implicit declaration of function `might_sleep'
In file included from sound_oss.c:6:
../alsa-kernel/core/sound_oss.c: In function `snd_register_oss_device':
../alsa-kernel/core/sound_oss.c:139: warning: passing arg 1 of
`register_sound_special_Rd53e3aa3' discards qualifiers from pointer target
type
../alsa-kernel/core/sound_oss.c:143: warning: passing arg 1 of
`register_sound_special_Rd53e3aa3' discards qualifiers from pointer target
type
aloop-kernel.c:43: warning: `pcm_devs' defined but not used
mts64.c: In function `snd_mts64_attach':
mts64.c:894: warning: implicit declaration of function
`platform_device_alloc'
mts64.c:894: warning: assignment makes pointer from integer without a
cast
mts64.c:901: warning: implicit declaration of function
`platform_device_register'
mts64.c:902: warning: implicit declaration of function
`platform_device_put'
In file included from
/lib/modules/2.4.7-10/build/include/linux/module.h:11,
                 from
/home/redhat/BUILD/alsa-driver-1.0.12rc1/include/adriver.h:45,
                 from
/home/redhat/BUILD/alsa-driver-1.0.12rc1/include/sound/driver.h:47,
                 from ../alsa-kernel/isa/als100.c:23,
                 from als100.c:1:
ad1889.c: In function `snd_ad1889_playback_pointer':
ad1889.c:555: warning: implicit declaration of function `unlikely'
In file included from als4000.c:1:
../alsa-kernel/pci/als4000.c: In function `snd_als4000_create_gameport':
../alsa-kernel/pci/als4000.c:596: warning: `r' might be used uninitialized
in t
his function
../alsa-kernel/pci/atiixp_modem.c:55: warning: `enable' defined but not
used
../alsa-kernel/pci/atiixp.c:61: warning: `enable' defined but not used
intel8x0.c:93: warning: `enable' defined but not used
intel8x0.c:95: warning: `joystick' defined but not used
../alsa-kernel/pci/intel8x0m.c:72: warning: `enable' defined but not used
maestro3.c: In function `snd_m3_ac97_wait':
maestro3.c:1958: warning: implicit declaration of function `cpu_relax'
../alsa-kernel/pci/via82xx_modem.c:70: warning: `enable' defined but not
used
../alsa-kernel/pci/via82xx.c:107: warning: `enable' defined but not used
../../alsa-kernel/pci/ali5451/ali5451.c:64: warning: `enable' defined but
not used
In file included from ../../alsa-kernel/pci/au88x0/au8810.c:9,
                 from au8810.c:1:
../../alsa-kernel/pci/au88x0/au88x0_core.c: In function
`vortex_interrupt':
../../alsa-kernel/pci/au88x0/au88x0_core.c:2414: warning: implicit
declaration of function `unlikely'
In file included from ../../alsa-kernel/pci/au88x0/au8820.c:10,
                 from au8820.c:1:
../../alsa-kernel/pci/au88x0/au88x0_core.c: In function
`vortex_interrupt':
../../alsa-kernel/pci/au88x0/au88x0_core.c:2414: warning: implicit
declaration of function `unlikely'
In file included from ../../alsa-kernel/pci/au88x0/au8830.c:10,
                 from au8830.c:1:
../../alsa-kernel/pci/au88x0/au88x0_core.c: In function
`vortex_interrupt':
../../alsa-kernel/pci/au88x0/au88x0_core.c:2414: warning: implicit
declaration of function `unlikely'
../../alsa-kernel/pci/hda/hda_intel.c:74: warning: `enable' defined but
not used
../../alsa-kernel/pci/nm256/nm256.c:90: warning: `enable' defined but not
used In file included from pcxhr.c:1:
../../alsa-kernel/pci/pcxhr/pcxhr.c: In function `pcxhr_trigger':
../../alsa-kernel/pci/pcxhr/pcxhr.c:640: warning: `stream' might be used
uninitialized in this function In file included from pcxhr_core.c:2:
../../alsa-kernel/pci/pcxhr/pcxhr_core.c: In function
`pcxhr_update_timer_pos':
../../alsa-kernel/pci/pcxhr/pcxhr_core.c:1074: warning: `new_sample_count'
migh t be used uninitialized in this function
In file included from ymfpci_main.c:2:
../../alsa-kernel/pci/ymfpci/ymfpci_main.c: In function
`snd_ymfpci_pcm_interrupt':
../../alsa-kernel/pci/ymfpci/ymfpci_main.c:329: warning: implicit
declaration of function `unlikely'
In file included from usx2yhwdeppcm.c:65:
usbusx2yaudio.c: In function `i_usX2Y_urb_complete':
usbusx2yaudio.c:318: warning: implicit declaration of function `unlikely'
usbusx2yaudio.c:329: warning: implicit declaration of function `likely'

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 croiset - 07-27-06 13:45 =

----------------------------------------------------------------------
I found where I can put the last lines.

snd.o creates unresolved symbols since the function might_sleep is
undefined.
info.c: In function `snd_iprintf':
info.c:119: warning: implicit declaration of function `might_sleep'
If I comment this function, everything is fine for snd.o.


All unresolved symbols :
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/acore/snd.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/drivers/snd-mts64.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/drivers/snd-portman2x4.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/i2c/other/snd-tea575x-tuner.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/isa/msnd/snd-msnd-pinnacle.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pci/au88x0/snd-au8810.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pci/au88x0/snd-au8820.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pci/au88x0/snd-au8830.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pci/cs46xx/snd-cs46xx.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pci/cs5535audio/snd-cs5535audio.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pci/hda/snd-hda-intel.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pci/snd-als4000.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pci/snd-azt3328.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pci/snd-cmipci.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pci/snd-cs4281.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pci/snd-ens1370.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pci/snd-ens1371.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pci/snd-es1938.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pci/snd-es1968.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pci/snd-maestro3.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pci/snd-sonicvibes.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pci/snd-via82xx.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pci/trident/snd-trident.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pci/ymfpci/snd-ymfpci.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pcmcia/pdaudiocf/snd-pdaudiocf.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/pcmcia/vx/snd-vxpocket.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/usb/snd-usb-audio.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/usb/snd-usb-lib.o
depmod: *** Unresolved symbols in
/var/tmp/alsa-driver-1.0.12rc1-root//lib/modu
les/2.4.7-10/kernel/sound/usb/usx2y/snd-usb-usx2y.o

----------------------------------------------------------------------
 tiwai - 07-27-06 14:28 =

----------------------------------------------------------------------
OK, the second try.  The patch is to ALSA HG version.  I don't make a patch
for 1.0.12rc1.  It's not worth to fix.

Issue History
Date Modified  Username       Field                    Change              =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
07-25-06 13:05 croiset        New Issue                                    =

07-25-06 13:05 croiset        Kernel Version            =3D> 2.4.7-10      =
  =

07-27-06 12:53 tiwai          Note Added: 0011267                          =

07-27-06 12:54 tiwai          File Added: 2.4.x-likely-fix.diff            =
     =

  =

07-27-06 13:17 croiset        Note Added: 0011273                          =

07-27-06 13:45 croiset        Note Added: 0011274                          =

07-27-06 14:28 tiwai          Note Added: 0011275                          =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
