From: g000fy g000fy <g000fy@live.com>
Subject: add TV-CARD to alsa driver
Date: Thu, 3 Jul 2008 18:32:00 -0400
Message-ID: <BAY130-W470A5DD02A8584340E266EEB980@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc2-s34.bay0.hotmail.com (bay0-omc2-s34.bay0.hotmail.com
	[65.54.246.170]) by alsa0.perex.cz (Postfix) with ESMTP id C866A249D5
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 00:32:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi:

im responing to:

"If you have an unknown card, please mail the ID and board name to <alsa-de=
vel[AT]alsa-project[DOT]org>, regardless of whether audio capture works or =
not, so that future versions of this driver know about your card."

i have an ATI TV WONDER VE (PCI) card.
im using slackware 12.1 with default kernel "root@cpu99:~# uname -a
Linux cpu99 2.6.24.5-smp #2 SMP Wed Apr 30 13:41:38 CDT 2008 i686 AMD Athlo=
n(tm) XP 2600+ AuthenticAMD GNU/Linux"

im following this project here: http://www.domenech.org/bt878a-adc/alsa-e.h=
tm
if you wouldnt mind telling me which version of alsa and with what config s=
ettings to get that to work i would much appreciate it.

"dmesg | grep alsa" reports the following

root@cpu99:~# dmesg | grep alsa
ALSA /root/building_area/ALSA/alsa-driver-1.0.16/alsa-driver-1.0.16/pci/bt8=
7x.c:876: unknown card 0x878-0x1002:0x03
ALSA /root/building_area/ALSA/alsa-driver-1.0.16/alsa-driver-1.0.16/pci/bt8=
7x.c:879: please mail id, board name, and, if it works, the correct digital=
_rate option to <alsa-devel@alsa-project.org>
ALSA /root/building_area/ALSA/alsa-driver-1.0.16/alsa-driver-1.0.16/pci/bt8=
7x.c:947: bt87x0: Using board 0, analog, digital (rate 32000 Hz)
root@cpu99:~#

here is my /etc/modprobe.d/sound contents:

alias snd-card-0 snd-intel8x0
alias sound-slot-0 snd-intel8x0
alias snd-card-1 snd-bt87x
alias sound-slot-1 snd-bt87x
options snd-bt87x index=3D1 load_all=3D1

when i built the driver i used:

"./configure --with-cards=3Dintel8x0,bt87x" as per the project guide

i updated these  alsa alsa-driver-1.0.16, alsa-lib-1.0.16, alsa-utils-1.0.1=
6 and alsa-oss-1.0.15

here is some more info

http://img53.imageshack.us/img53/6453/snapshot2fh8.jpg
http://img124.imageshack.us/img124/6185/alsamixerc1ok3.jpg
http://www.imagecoast.com/gallery.php?u=3Den1gma&g=3Dtv-card

oot@cpu99:~# ls /dev/snd*
controlC0  controlC1  pcmC0D0c  pcmC0D0p  pcmC0D1c  pcmC0D2p  pcmC1D0c  pcm=
C1D1c  seq  timer
root@cpu99:~# ls /dev/mixer*
/dev/mixer  /dev/mixer1
root@cpu99:~# ls /dev/dsp*
/dev/dsp  /dev/dsp1
root@cpu99:~# cat /proc/asound/cards
 0 [nForce2        ]: NFORCE - NVidia nForce2
                      NVidia nForce2 with ALC650F at irq 17
 1 [Bt878          ]: Bt87x - Brooktree Bt878
                      Brooktree Bt878 at 0xe4000000, irq 19

basically i just want the oscilloscope project to work.
I followed the oscilloscope project guide pretty good. http://www.domenech.=
org/bt878a-adc/alsa-e.htm

patched "aplay.c"
configured the "alsa-driver" like it said.

alsamixer -c1, alsaconf, kmix, audacity and baudline dont pick up the "FM",=
 "CAPTURE", "MIC" and "CAPTURE BOOST" i think.

anyhow i apprecaite your work and if you could help me on this i would appr=
ecaite it.



_________________________________________________________________
Watch =93Cause Effect,=94 a show about real people making a real difference=
.  Learn more.
http://im.live.com/Messenger/IM/MTV/?source=3Dtext_watchcause
