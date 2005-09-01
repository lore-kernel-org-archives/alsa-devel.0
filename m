From: Mark Knecht <markknecht@gmail.com>
Subject: why is card #2 being set to default?
Date: Thu, 1 Sep 2005 16:43:07 -0700
Message-ID: <5bdc1c8b0509011643199f3101@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Alsa Developers,
   Why is it that on my new AMD64 system the HDSP 9652 is listed as default=
?

lightning ~ # cat /proc/asound/cards
0 [CK804          ]: NFORCE - NVidia CK804
                     NVidia CK804 with ALC850 at 0xda103000, irq 185
1 [default        ]: H-DSP - Hammerfall DSP
                     RME Hammerfall HDSP 9652 at 0xda000000, irq 209
lightning ~ #

   On my previous systems I believe that card 0 has been default. Due
to clocking problems with the HDSP 9652 with OSS emulation I never run
OSS on the HDSP 9652 and want sound from general apps to go to the
NVidia on-board chip. The output of that chip is hooked to an input on
the HDSP which drives the main D/A so I get the best of both worlds -
NVidia does the low-end OSS and Jack runs all day on the HDSP 9652.

   Except on this new system it seems to not work that way.

   I do not use any .asoundrc files.

   Technical stuff follows.

Thanks in advance,
Mark

Distro: Gentoo, Alsa drivers from kernel

lightning ~ # uname -a
Linux lightning 2.6.12-gentoo-r9 #7 SMP Thu Sep 1 14:26:41 PDT 2005
x86_64 AMD Athlon(tm) 64 Processor 3000+ AuthenticAMD GNU/Linux
lightning ~ #

lightning ~ # emerge -pv alsa-tools alsa-utils alsa-oss alsa-headers
alsa-lib alsa-jack

These are the packages that I would merge, in order:

Calculating dependencies ...done!
[ebuild   R   ] media-sound/alsa-tools-1.0.9  +X 0 kB
[ebuild   R   ] media-sound/alsa-utils-1.0.9a-r1  +nls 0 kB
[ebuild   R   ] media-libs/alsa-oss-1.0.8-r1  0 kB
[ebuild   R   ] media-sound/alsa-headers-1.0.9b  0 kB
[ebuild   R   ] media-libs/alsa-lib-1.0.9  -doc +jack 0 kB
[ebuild   R   ] media-plugins/alsa-jack-1.0.9  0 kB

Total size of downloads: 0 kB
lightning ~ #

lightning ~ # cat /etc/modules.d/alsa
# Alsa 0.9.X kernel modules' configuration file.
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-utils/files/alsa-module=
s.con
f-rc,v 1.4 2004/11/16 01:31:22 eradicator Exp $

# ALSA portion
alias char-major-116 snd
# OSS/Free portion
alias char-major-14 soundcore

##
## IMPORTANT:
## You need to customise this section for your specific sound card(s)
## and then run `update-modules' command.
## Read alsa-driver's INSTALL file in /usr/share/doc for more info.
##
##  ALSA portion
alias snd-card-0 snd-intel8x0
options snd-intel8x0 index=3D0
alias snd-card-1 snd-hdsp
options snd-hdsp index=3D1
##  OSS/Free portion
alias sound-slot-0 snd-card-0
## alias sound-slot-1 snd-card-1
##

# OSS/Free portion - card #1
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
##  OSS/Free portion - card #2
## alias sound-service-1-0 snd-mixer-oss
## alias sound-service-1-3 snd-pcm-oss
## alias sound-service-1-12 snd-pcm-oss

alias /dev/mixer snd-mixer-oss
alias /dev/dsp snd-pcm-oss
alias /dev/midi snd-seq-oss

# Set this to the correct number of cards.
options snd cards_limit=3D2
lightning ~ #

lightning ~ # lsmod
Module                  Size  Used by
snd_seq_midi            7872  0
snd_pcm_oss            50912  0
snd_mixer_oss          16960  1 snd_pcm_oss
snd_seq_oss            33152  0
snd_seq_midi_event      8256  2 snd_seq_midi,snd_seq_oss
snd_seq                54752  5 snd_seq_midi,snd_seq_oss,snd_seq_midi_event
snd_hdsp               49860  0
snd_rawmidi            24032  2 snd_seq_midi,snd_hdsp
snd_seq_device          7436  3 snd_seq_midi,snd_seq_oss,snd_rawmidi
snd_hwdep               9376  1 snd_hdsp
snd_intel8x0           32128  1
snd_ac97_codec         85392  1 snd_intel8x0
snd_pcm                89928  4 snd_pcm_oss,snd_hdsp,snd_intel8x0,snd_ac97_=
codec
snd_timer              22408  2 snd_seq,snd_pcm
snd                    51080  14
snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_hdsp,snd_rawmidi,snd_seq_=
device,snd_hwdep,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
soundcore               9120  1 snd
snd_page_alloc          9480  3 snd_hdsp,snd_intel8x0,snd_pcm
lightning ~ #


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
