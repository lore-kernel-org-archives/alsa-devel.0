From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001134]: alsa 1.0.9rc4 + intel
	82801FB/.../ = No sound (Benq 52-101)
Date: Wed, 7 Jun 2006 20:49:32 +0200
Message-ID: <c3b5dc3f55eba1dc22003af03b564226@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 624DC164
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jun 2006 20:49:33 +0200 (MEST)
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


The issue 0002185 has been set as DUPLICATE OF the following issue.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1134> =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                liangalei
Assigned To:                =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Issue ID:                   1134
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 3
Kernel Version:             2.6.11-1.14
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             05-28-2005 08:49 CEST
Last Modified:              06-07-2006 20:49 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    alsa 1.0.9rc4 + intel 82801FB/.../ =3D No sound=
 (Benq
52-101)
Description: =

My notebook is Benq 52-101, update FC3 to kernel 2.6.11-1.14_FC3

alsamixer report: Card=3Dintel ICH6, chip=3DConexant id 3 (Question, Conexa=
nt
just support modem's AC-97 or else provide whole sound ? )

alsaconf: can find "Intel Corp 82801FB/.../ ICH6 family AC'97 Audio", and
will contine to "Have a lot fun".

I have ever, update linux kernel from 2.6.9 to 2.6.11(yum update, no
recompiling), and alsa driver from 0.9.0/1.0.8/1.0.9rc3/4.

Recomipling ALsa driver/lib/oss/tools/util.., with drive, ever try =

----- ./configure --with-cards=3Dazx (error: no this card)
----- ./configure ; make; make install (no error report), not run
./snddevices

No sound ! So much days, so much test..... (if i915GM chipset + Conexant
chip...(see below lspci), will be powered by alsa-1.0.9rc4 ? --- if still
not, I will just wait for new alsa-driver.)

thanks
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001931 Unknown AC97 codec, digital sound works
has duplicate       0002191 No sound on intel8x0 - 82801FB/FBM/FR/F...
has duplicate       0001756 Detects soundcard, alsamixer is ok, fid...
has duplicate       0002185 No sound from intel ich6 connexant id31...
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 liangalei - 05-28-05 09:17 =

----------------------------------------------------------------------
[root@room-1109 ~]# /sbin/lsmod | grep snd
snd_intel8x0           34752  2
snd_ac97_codec         78588  1 snd_intel8x0
snd_mixer_oss          19072  1
snd_pcm                99848  2 snd_intel8x0,snd_ac97_codec
snd_timer              33668  1 snd_pcm
snd                    59396  7
snd_intel8x0,snd_ac97_codec,snd_mixer_oss,snd_pcm,snd_timer
soundcore              10785  2 snd
snd_page_alloc         10244  2 snd_intel8x0,snd_pcm
[root@room-1109 ~]#

----------------------------------------------------------------------
 liangalei - 05-30-05 03:29 =

----------------------------------------------------------------------
hinted by https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1078
I have a look at my /proc/asound, it looks like following, ----- Is it
strange? I see many "off" ---- but I cannot turn-ONs them, by either
alsamixer or aumix, because in alsamixer jack-bars, them can not be seen
!

[lal@lal ~]$ cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Conexant id 31

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0x0000
Subsys. ID       : 0x0000

Capabilities     :
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=3D0 rev=3D2 AMAP LDAC SDAC CDAC DSA=3D0 SPDIF
Extended status  : PRL SPCV LDAC SDAC CDAC SPDIF=3D10/11
SPDIF Control    : Consumer PCM Category=3D0x2 Generation=3D1 Rate=3D48kHz
Extended modem ID: codec=3D0 LIN1
Modem status     : PRA(GPIO) PRB(res) PRC(ADC1) PRD(DAC1) PRE(ADC2)
PRF(DAC2) PRG(HADC) PRH(HDAC)
Line1 rate       : 48000Hz
[lal@lal ~]$

----------------------------------------------------------------------
 tiwai - 06-01-05 16:58 =

----------------------------------------------------------------------
I suspect it's not a Conexant codec.  The driver seems to fail detection of
the codec.

This kind of problems is often related with ACPI.  Try to tune the ACPI
boot setting.

----------------------------------------------------------------------
 liangalei - 06-02-05 10:42 =

----------------------------------------------------------------------
Thanks for reply. Can you give more hints: about how to tune the ACPI boot
? (I have no idea at all).

By way, I call Benq's tech-support. Because they don't support Linux for
Benq S52, so no much valuable info from them, just they tell sound chip is
Conexant CS20551 (maybe mis-hear, it should be CX20551). And when I ask
him if it refers to modem chip, he don't know. --- I search this chip, but
no result. Q: is it a AMC'97 chip?

----------------------------------------------------------------------
 tiwai - 06-23-05 12:42 =

----------------------------------------------------------------------
If the info is correct, yes, it sounds like an AMC97 chip.

Please attach /etc/asound.state and all /proc/asound/card0/codec97#*/*
files for checking the mixer state.

----------------------------------------------------------------------
 liangalei - 06-24-05 03:18 =

----------------------------------------------------------------------
thanks for reply. =


I have attach three very long file, see above "attach files".

and here is some simply info, does any more info is needed ? =


[lal@lal ~]$ cat /proc/asound/card0/intel8x0
Intel8x0

Global control        : 0xc0000002
Global status         : 0x00700100
SDM                   : 0x00000008
AC'97 codecs ready    : primary
AC'97 codecs SDIN     : 0 0 0


[lal@lal ~]$ tree /proc/asound/card*
/proc/asound/card0
|-- codec97#0
|   |-- ac97#0-0
|   `-- ac97#0-0+regs
|-- id
|-- intel8x0
|-- oss_mixer
|-- pcm0c
|   |-- info
|   |-- oss
|   `-- sub0
|       |-- hw_params
|       |-- info
|       |-- prealloc
|       |-- status
|       `-- sw_params
|-- pcm0p
|   |-- info
|   |-- oss
|   `-- sub0
|       |-- hw_params
|       |-- info
|       |-- prealloc
|       |-- status
|       `-- sw_params
|-- pcm1c
|   |-- info
|   |-- oss
|   `-- sub0
|       |-- hw_params
|       |-- info
|       |-- prealloc
|       |-- status
|       `-- sw_params
|-- pcm2c
|   |-- info
|   `-- sub0
|       |-- hw_params
|       |-- info
|       |-- prealloc
|       |-- status
|       `-- sw_params
|-- pcm3c
|   |-- info
|   `-- sub0
|       |-- hw_params
|       |-- info
|       |-- prealloc
|       |-- status
|       `-- sw_params
`-- pcm4p
    |-- info
    `-- sub0
        |-- hw_params
        |-- info
        |-- prealloc
        |-- status
        `-- sw_params
/proc/asound/cards [error opening dir]

----------------------------------------------------------------------
 ybar - 08-28-05 15:28 =

----------------------------------------------------------------------
i ran alsamixer and set External amplifier to "on" to listen to music
without headphone.

----------------------------------------------------------------------
 derek - 11-29-05 06:03 =

----------------------------------------------------------------------
HI : guys

    i have the same issue. can any body help me out ?
    my notebook is benq s52 too.

HI  liangalei
    did you find the way out already?
    if you have some useful inf.  can you share with me ?
    thank you !!!  my email:   moonkyang+root@gmail.com  =


best Rgds
Derek

----------------------------------------------------------------------
 gandhi - 02-17-06 23:43 =

----------------------------------------------------------------------
same Laptop..same Problem...

are further infos needed?

problem still exist with alsa-driver 1.0.11_rc3


when i unmute IEC958 with alsamixer a red light goes on and off in the
headphone jack (light is on under windows)

when i turn mixer up und unmute microphone i hear every time i change a
value in alsamixer a cracking sound



----------------------------------------------------------------------
 gandhi - 02-18-06 02:05 =

----------------------------------------------------------------------
this bug is assigned..but to nobody..isn't this a problem?

----------------------------------------------------------------------
 liangalei - 02-18-06 08:13 =

----------------------------------------------------------------------
Many people inqure me, if I have solution.
My answer is NO, my S52 has been silent until now. =

I have used to its silent (no music, no movie), and used to alsa's silent
(without any response).

----------------------------------------------------------------------
 gandhi - 02-18-06 15:56 =

----------------------------------------------------------------------
hi.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1134

this bug is assigned, but not to another person. i think that nobody will
see this bug as his task. is it possible to assign this bug to somebody?

i would be willed to code and get rid of this bug by my own, but i did
never before any programming for hardware (but i do for other things)..
neither didn't find a point to start :/

----------------------------------------------------------------------
 robitech - 03-03-06 08:29 =

----------------------------------------------------------------------
HELLO. Please help me. I am using GENTOO LINUX. No sound on my BENQ
S52.Probed module snd-itel8x0. Thank you.

----------------------------------------------------------------------
 JProgrammer - 03-15-06 05:34 =

----------------------------------------------------------------------
It appears to me that this is a problem with ac97_codec as it is not being
identified the id for this card is 0x43585431 I have tried it with
conexant_patch and with no patch however there is still no sound. I am
willing to help in delivering a patch however I am not familiar with
developing for alsa and the CX20551 is not even on the conexant website to
look for documentation like with some of their other chips.

----------------------------------------------------------------------
 Kooper - 03-15-06 06:39 =

----------------------------------------------------------------------
The same hardware (BenQ Joybook S52), the same problem.
Kernel - 2.6.15-1.1833_1.rhfc4.cubbi_swsusp2 (no sound with standard FC4
kernels also)
alsa-utils-1.0.10-1.FC4

----------------------------------------------------------------------
 tiwai - 03-15-06 11:40 =

----------------------------------------------------------------------
Well, the possible problems are:

- Some important codec-specific initialization is missing
- Conflict of audio and modem codec initialization, due to the combined
codec chip

The first one is hard to fix without a proper h/w information.

For the second point, make sure that you never load snd-intel8x0m (note
'm'), e.g. by removing the driver module file.  Then, comment out the
whole codes related with modem.

----------------------------------------------------------------------
 Kooper - 03-15-06 11:53 =

----------------------------------------------------------------------
> The first one is hard to fix without a proper h/w information.

Can I help with it? You need a hardware information from me (customer) or
from BenQ?

> For the second point, make sure that you never load snd-intel8x0m (note
'm'), =

> e.g. by removing the driver module file. Then, comment out the whole
codes =

> related with modem.

# lsmod | grep intel
snd_intel8x0           32093  0
snd_ac97_codec         88161  1 snd_intel8x0
snd_pcm                86981  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd                    54309  9
snd_intel8x0,snd_ac97_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,=
snd_mixer_oss,snd_pcm,snd_timer
snd_page_alloc         10697  2 snd_intel8x0,snd_pcm

# dmesg | grep intel8x0
intel8x0_measure_ac97_clock: measured 55983 usecs
intel8x0: clocking to 48000

# grep intel /etc/modprobe.conf
alias snd-card-0 snd-intel8x0
options snd-intel8x0 index=3D0
remove snd-intel8x0 { /usr/sbin/alsactl store 0 >/dev/null 2>&1 || : ; };
/sbin/modprobe -r --ignore-remove snd-intel8x0

Which 'codes' I should comment out? Comment out from what?

----------------------------------------------------------------------
 JProgrammer - 03-15-06 12:13 =

----------------------------------------------------------------------
intel8x0m is blacklisted on my system Ubuntu Dapper I should get in contact
with BenQ to confirm chip used and then get in contact with Conexant they
have detailed documents for other chips available we may be able to get a
hold of them

----------------------------------------------------------------------
 tiwai - 03-15-06 12:18 =

----------------------------------------------------------------------
The technical detail would be really appreciated.

The code to be fixed is likely in ac97_codec.c.  You can find many
modem-related stuff there.

----------------------------------------------------------------------
 JProgrammer - 03-15-06 23:48 =

----------------------------------------------------------------------
I received a response from BenQ today:

"BenQ does not support the use of Linux on our notebooks, therefor there
are no drivers or support documentation iswritten for this system.

Regards

BenQ Support"

However I phoned them up later and got them to confirm that it is the
CX20551 chip in this laptop. I then proceeded to contact Conexant from
their website literature@conexant.com however the delivery to this address
fails.

If someone in the US or Canada could contact them directly on a toll free
number that would be appreciated.

Headquarters
4000 MacArthur Blvd.
Newport Beach, CA., 92660
Phone: (949) 483-4600
(888) 855-4562 (Toll free U.S. & Canada)

----------------------------------------------------------------------
 tiwai - 03-16-06 15:04 =

----------------------------------------------------------------------
The patch attached is just a blind shot to remove the modem part from
ac97_codec.c.  Give it a try.

----------------------------------------------------------------------
 Kooper - 03-17-06 04:10 =

----------------------------------------------------------------------
I've applied the patch (patch, make modules, cp
sound/pci/ac97/snd-ac97-codec.ko /lib/modules/..., remove all sound/intel
modules with rmmod, modprobe) - nothing changed at the first glance. Are
there any debug information I can provide?

----------------------------------------------------------------------
 tiwai - 03-17-06 12:07 =

----------------------------------------------------------------------
To make sure, could you upload /proc/asound/card0/codec97#0/* files and
/etc/asound.state for checking?

----------------------------------------------------------------------
 Kooper - 03-17-06 12:35 =

----------------------------------------------------------------------
>  To make sure, could you upload /proc/asound/card0/codec97#0/* files and

> /etc/asound.state for checking?

kooper-alsa-bugreport.tgz attached

----------------------------------------------------------------------
 JProgrammer - 03-21-06 02:38 =

----------------------------------------------------------------------
I also applied the patch there is no sound that comes from internal
speakers, headphone or microphone jack and all of the controls except for
pcm do not display.

----------------------------------------------------------------------
 alessiodf - 03-26-06 20:15 =

----------------------------------------------------------------------
Hi all!
I've a benq S53 and i have the same problem with the mute sound! :(

some informations...
---------------------------------------------------------------------
root@joybook[~]# cat /proc/asound/card0/intel8x0
Intel8x0

Global control        : 0xc0000002
Global status         : 0x00700100
SDM                   : 0x00000008
AC'97 codecs ready    : primary
AC'97 codecs SDIN     : 0 0 0

---------------------------------------------------------------------
root@joybook[~]# cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Conexant id 31

PCI Subsys Vendor: 0x17ff
PCI Subsys Device: 0x058b

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0x0000
Subsys. ID       : 0x0000

Capabilities     :
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=3D0 rev=3D2 AMAP LDAC SDAC CDAC DSA=3D0 SPDIF
Extended status  : PRL SPCV LDAC SDAC CDAC SPDIF=3D10/11
SPDIF Control    : Consumer PCM Copyright Category=3D0x22 Generation=3D1
Rate=3D48kHz
Extended modem ID: codec=3D0 LIN1
Modem status     : PRA(GPIO) PRB(res) PRC(ADC1) PRD(DAC1) PRE(ADC2)
PRF(DAC2) PRG(HADC) PRH(HDAC)
Line1 rate       : 48000Hz

---------------------------------------------------------------
root@joybook[~]# cat /proc/asound/cards
 0 [ICH6           ]: ICH4 - Intel ICH6
                      Intel ICH6 with unknown codec at 0xb0040800, irq 11

---------------------------------------------------------------



----------------------------------------------------------------------
 trava - 03-30-06 15:47 =

----------------------------------------------------------------------
I've the same problem on benq s53y.01, the sound is mute. I tried also to
use snd-hda-intel, but this module don't work at all.
I don't know what to do... :(

----------------------------------------------------------------------
 kesiev - 04-07-06 13:06 =

----------------------------------------------------------------------
I'm using a Kubuntu 6.06 (Dapper Drake) Flight and sound is still mute. But
using earphones, i can hear sometime some noise (like a radio tuner) while
changing volume from alsamixer.

EDIT: Using a Benq Joybook S53W.Y01



----------------------------------------------------------------------
 alt_ackbar - 04-09-06 03:23 =

----------------------------------------------------------------------
Same problem on benq s53w-s07
- KUbuntu Dapper
- Kernel 2.6.15-12-386
- snd_intel8x0

----------------------------------------------------------------------
 kesiev - 04-12-06 16:21 =

----------------------------------------------------------------------
Just a note: I'm posting the .inf file from the windows driver. I don't
know if it is useful (for example, the first lines confirms that is a AC97
based driver) but is full of numbers that, I hope, can be useful for ALSA
hackers.

Drivers are here:
http://www.benq.it/ServiceAndSupport/downloads/downloads.cfm?product=3D829&=
type=3DD

----------------------------------------------------------------------
 kesiev - 04-15-06 12:33 =

----------------------------------------------------------------------
Ok... is not too nice but I'm posting also the windows exported file about
"multimedia" of the Benq S53w.y1 . Is in italian but I thing is quite
readable for anyone.

Notice that the IRQ is different from windows to linux. Dunno if is useful
but I'm trying to provide as many information I can, as asked in this
thread.

EDIT: can be just an IRQ/Port address pointing error?

EDIT: tried with some PCI configurations but with no luck (however I've
seen that there are some IRQ problems with Benq S53). However, playing
with alsamixer and any PCI setitng, I've found a configuration that, if
used, makes a noise that changes while playing from the speakers. I'm
sending the "alsamixer -f alsasound.conf store" resulting file. I hope it
helps.



----------------------------------------------------------------------
 fedukoff - 04-18-06 09:35 =

----------------------------------------------------------------------
I'm using BenQ Joybook S53. Same problem.
Gentoo Linux
Kernel 2.6.16
Alsa 1.0.11rc5
Any hints?

----------------------------------------------------------------------
 drseergio - 05-09-06 14:36 =

----------------------------------------------------------------------
I am also a user of Benq (S53). Is this issue being proccessed, is it
possible to fix it at all?

----------------------------------------------------------------------
 rlrevell - 05-09-06 16:40 =

----------------------------------------------------------------------
As tiwai has explained, more info about the hardware is needed to fix it. =

This will have to come from Benq.

----------------------------------------------------------------------
 drseergio - 05-09-06 17:31 =

----------------------------------------------------------------------
Benq will never reply :(, I know them. Their support is awful... Btw, audio
chips are not made by Benq, they are generic from other manufacturers. Or
not?
As already mentioned - Conexant CX20551. I cannot believe that no
documentation is available :(.



----------------------------------------------------------------------
 rlrevell - 05-09-06 17:28 =

----------------------------------------------------------------------
Yeah but the vendors modify them.  snd-hda-intel is a real pain - it's so
flexible that we get lots of bugs that only affect a specific laptop.

If there's no chance of Benq helping someone will have to reverse engineer
it

----------------------------------------------------------------------
 drseergio - 05-09-06 17:41 =

----------------------------------------------------------------------
Conexant does not provide information too? You mean reverse engineer the
windows drivers? The chip is conexant for sure as it is obvious from
windows inf file. Toshiba P100 uses this chip as well maybe it is possible
to contact them? At least I will try.



----------------------------------------------------------------------
 rlrevell - 05-09-06 17:49 =

----------------------------------------------------------------------
Yes exactly, if Benq won't provide the hardware information needed to get
it working someone must reverse engineer the Windows drivers.

----------------------------------------------------------------------
 drseergio - 05-09-06 17:52 =

----------------------------------------------------------------------
But probably no one will do this because it seems that this problem only
occurs on this notebook and there aren't so many benq s53 linux users ;/.
This is really disappointing as I wanted to use this machine on gentoo.

----------------------------------------------------------------------
 rlrevell - 05-09-06 17:57 =

----------------------------------------------------------------------
Sorry, I don't know what to tell you.  When you buy a laptop with the
intent of running linux on it it's important to check with other users
that the hardware is supported and the vendor not hostile to Linux.

----------------------------------------------------------------------
 drseergio - 05-09-06 18:00 =

----------------------------------------------------------------------
Yes, I agree. Probably dual-boot is the solution and I will wait until the
development of the driver becomes reality. I would help but currently I do
not have enough programming skills.

----------------------------------------------------------------------
 fedukoff - 05-09-06 18:33 =

----------------------------------------------------------------------
I have bought this laptop because it was on sale with Linux (CD in a box,
not preinstalled). It was for me the guarantor, that all is compatible.
Who knew... Linux referred to Linpus 9.2. Installation of this miracle has
come to full grief.

----------------------------------------------------------------------
 drseergio - 05-09-06 18:44 =

----------------------------------------------------------------------
Mine came with linpus too, strange, isn't it? Ships with linux but not
supported. Btw, found this
http://www.ubuntuforums.org/showthread.php?t=3D120070 . Can it be related to
our S52/S53 as well? Or that guy has some other codec?

----------------------------------------------------------------------
 fedukoff - 05-09-06 19:11 =

----------------------------------------------------------------------
Have you Linpus Linux installed on your laptop? =

Look at http://www.linpus.com/PDF/HW_compalibility_list_LL92.pdf and
http://www.linpus.com/PDF/HW_compalibility_list_LL93.pdf
It is very interesting. Linpus 9.3 has row "INTEL 82801FB/FBM/FR/FW/FRW
(ICH6 Fam ily) AC'97 Audio Co" in their compatibility list, but 9.2 not.

----------------------------------------------------------------------
 rlrevell - 05-09-06 19:12 =

----------------------------------------------------------------------
Yes it's probably related - it seems that sound does not work on any Benq
notebook.

You could try the OSS i810_audio module

----------------------------------------------------------------------
 drseergio - 05-09-06 19:21 =

----------------------------------------------------------------------
fedukoff, have you tried using linpus 9.3?

----------------------------------------------------------------------
 fedukoff - 05-09-06 19:27 =

----------------------------------------------------------------------
I have no Linpus 9.3.
I have Linpus 9.2 CD which came with my laptop. And 9.3 is not for public
download now.

----------------------------------------------------------------------
 rlrevell - 05-09-06 19:28 =

----------------------------------------------------------------------
If it does not work with the latest ALSA release then changing distros is
not going to help

----------------------------------------------------------------------
 drseergio - 05-09-06 19:30 =

----------------------------------------------------------------------
rlrevell, do you think this distro may be using OSS?

----------------------------------------------------------------------
 fedukoff - 05-09-06 19:39 =

----------------------------------------------------------------------
I now have installed Linpus 9.2
I hear system beeps. I need to play a little to try listen the music.

----------------------------------------------------------------------
 rlrevell - 05-09-06 19:42 =

----------------------------------------------------------------------
No:

snd_intel8x0 -> ALSA
i810_audio -> OSS

----------------------------------------------------------------------
 drseergio - 05-09-06 19:50 =

----------------------------------------------------------------------
i810 audio is the driver for the same chip?
http://www.ubuntuforums.org/showthread.php?t=3D111870 found this... Looks
like people have many problems with HDA codec.

----------------------------------------------------------------------
 fedukoff - 05-09-06 20:16 =

----------------------------------------------------------------------
hmm. how to configure oss? (I want to try)

----------------------------------------------------------------------
 rlrevell - 05-09-06 20:17 =

----------------------------------------------------------------------
Sorry my previous post was incorrect - these systems do not have HDA codec,
they use the older AC97 codec.

And yes, snd_intel8x0 and i810_audio are drivers for the same chip.  It's
a long shot that i810_audio would work

----------------------------------------------------------------------
 rlrevell - 05-09-06 20:19 =

----------------------------------------------------------------------
Um, just unload the alsa modules and load i810_audio

----------------------------------------------------------------------
 drseergio - 05-09-06 20:28 =

----------------------------------------------------------------------
So, does the OSS work?

----------------------------------------------------------------------
 fedukoff - 05-09-06 20:29 =

----------------------------------------------------------------------
I have some problems with it... (I'm on Linpus)

# modprobe i810_audio
/lib/modules/2.4.20-8lp/kernel/drivers/sound/i810_audio.o: init_module: No
such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.20-8lp/kernel/drivers/sound/i810_audio.o: insmod
/lib/modules/2.4.20-8lp/kernel/drivers/sound/i810_audio.o failed
/lib/modules/2.4.20-8lp/kernel/drivers/sound/i810_audio.o: insmod
i810_audio failed

no any messages in /var/log/messages, but dmesg show one new line: =

Intel 810 + AC97 Audio, version 0.24, 17:47:13 Apr 21 2004

----------------------------------------------------------------------
 rlrevell - 05-09-06 20:34 =

----------------------------------------------------------------------
I think that's a "no" - it seems that the OSS driver does not support the
device.

You did make sure to unload all snd-* modules first right?

----------------------------------------------------------------------
 fedukoff - 05-09-06 22:07 =

----------------------------------------------------------------------
I found oss not loads without alsa on kernel 2.6.16. But with alsa
i810-audio loads without problem... But no sound...

----------------------------------------------------------------------
 fedukoff - 05-10-06 15:58 =

----------------------------------------------------------------------
Bad news:
http://www.4front-tech.com/forum/viewtopic.php?t=3D743&highlight=3Dbenq

----------------------------------------------------------------------
 rlrevell - 05-10-06 17:10 =

----------------------------------------------------------------------
Just to clarify, you should bother Benq, not Conexant, if you want sound on
these machines to work.  If everyone who posts in this thread sends them
an email they might notice.  We aren't asking for Linux support, just the
hardware details needed to get sound working.

----------------------------------------------------------------------
 kesiev - 05-10-06 17:19 =

----------------------------------------------------------------------
Clear. So let's take a significative Benq's mailbox and send everybody a
"soundcard specs" request. (seems that they aren't friendly - someone
asked infos before, as reported into this bugreport)

Can someone provide a valid mail address?

----------------------------------------------------------------------
 trava - 05-10-06 17:21 =

----------------------------------------------------------------------
I just wrote to benq and I said we need hardware specification. I'm waiting
for an answer...
Everyone have to do the same thing and I hope we will obtain the
information.

----------------------------------------------------------------------
 trava - 05-10-06 17:25 =

----------------------------------------------------------------------
I used this address

http://bcc.benq.com/BCCFRONTUI/process/newcase.aspx

----------------------------------------------------------------------
 fedukoff - 05-10-06 17:41 =

----------------------------------------------------------------------
>From oss forum: (http://4front-tech.com/forum/viewtopic.php?p=3D3300#3300)
some more info: they told me that it looks like the driver is using the
modem for sound. I should try to disable the modem in the bios..but you
know..there isn't such in option in the bios

And I found on linpus site "Conexant 6.03-1 HSF modem driver"
http://www.linpus.com/Downloads/desktop/2004-10-1_hsf.htm

----------------------------------------------------------------------
 fedukoff - 05-10-06 18:03 =

----------------------------------------------------------------------
I have received an automatic email from BenQ:
Thank you for choosing BenQ!=A0 In order to serve your inquiry more
effectively, please =

link to BenQ Contact Center http://Support.BenQ.com for assistance
regarding any =

product and service inquiry, our BenQ Technical Expert will be glad to
serve you. =


And when ask status of my enquiry
(http://bcc.benq.com/BCCFRONTUI/process/querycase.aspx) it is SOLVED!

----------------------------------------------------------------------
 trava - 05-10-06 18:20 =

----------------------------------------------------------------------
the same :(

----------------------------------------------------------------------
 fedukoff - 05-10-06 18:34 =

----------------------------------------------------------------------
I have received one more answer from BenQ
Dear Sir,
=A0
Please consider that we not support Linux operation system.
For us as BenQ Support we are not able to help you on this,because is
more related to Marketing and sales issue.
=A0
I will forward your request to the factory, but I cant guratee that you
will get answer on this , since this is more related to other vendor (
connexant) product.
=A0
Regards,
BenQ Europe Support.

----------------------------------------------------------------------
 fedukoff - 05-11-06 08:15 =

----------------------------------------------------------------------
Please, read the latest post on OSS forum:
http://4front-tech.com/forum/viewtopic.php?p=3D3300#3300

I'll try it today...

----------------------------------------------------------------------
 JProgrammer - 05-11-06 08:42 =

----------------------------------------------------------------------
Sounds like the external amplifier setting in alsa and like all the other
settings nothing seems to change

----------------------------------------------------------------------
 fedukoff - 05-11-06 08:45 =

----------------------------------------------------------------------
Yes, but in OSS?

----------------------------------------------------------------------
 fedukoff - 05-11-06 18:25 =

----------------------------------------------------------------------
One more reply from BenQ:
Please go to the website at www.conexant.com. Refer to the list of sales =

offices by selecting Worldwide Sales on left side of screen and contact =

the one nearest you. The Applications Engineers in that office will be =

able to assist you.
Thank you.

----------------------------------------------------------------------
 fedukoff - 05-12-06 08:14 =

----------------------------------------------------------------------
Can somebody call to Conexant? I can't becouse no any offices in my country
and my spoken English is extrimally bad, and no one of sales offices has
email :)

http://www.conexant.com/wwsales/



----------------------------------------------------------------------
 rlrevell - 05-15-06 14:49 =

----------------------------------------------------------------------
Sorry, I don't understand your comment.

----------------------------------------------------------------------
 fedukoff - 05-15-06 14:57 =

----------------------------------------------------------------------
It is online russian-english translator. :)
I want to know is there some news from conexant?

----------------------------------------------------------------------
 rlrevell - 05-15-06 15:25 =

----------------------------------------------------------------------
Well, since no one reported calling them, I would guess not.

I really would not be too optimistic about this being fixed soon.  They
don't seem to care that their hardware doesn't work with Linux.

I would look into an external USB audio device.

----------------------------------------------------------------------
 fedukoff - 05-18-06 12:45 =

----------------------------------------------------------------------
I ask many services of BenQ around the world for documentation. Answer is
the same: "Dear Sir, Unfortunately we cannot give you any hardware
documentation."

Somebody have call to Conexant?

----------------------------------------------------------------------
 fedukoff - 05-18-06 13:37 =

----------------------------------------------------------------------
Is it usefull? =

http://www.linuxant.com/drivers/riptide/index.php

----------------------------------------------------------------------
 fedukoff - 05-19-06 08:07 =

----------------------------------------------------------------------
response from Linuxant:

Hi,

as far as I know, Conexant does not manufacture an AC97 bus, however,
they manufacture modems that can connect to the AC97 bus and we provide
the HSF modem driver that you can download at:

http://www.linuxant.com/drivers/hsf/downloads-license.php

for these modem devices.

We do not provide an audio driver for a Conexant device that is attached
to the AC97 bus. We do provide however the riptide driver, which is an
audio driver for a PCI riptide device and it not related to the AC97 bus.

Regards,


Jonathan
Technical specialist / Linuxant
www.linuxant.com
support@linuxant.com

----------------------------------------------------------------------
 thoroughfare - 05-25-06 23:03 =

----------------------------------------------------------------------
I tried calling Conexant's US documentation line from the UK - they seemed
confused by:

1) That I'm from the UK
2) I was helping to make a Linux driver for their chip

...so I got redirected to someone (a lady, can't remember her name), and
she was out of the office so just got her voicemail.

Can someone else give it another shot?

----------------------------------------------------------------------
 rlrevell - 06-02-06 17:54 =

----------------------------------------------------------------------
Off topic.  Please file a new bug and delete comment #0010049.  This bug
report is about BenQ laptops.

----------------------------------------------------------------------
 thoroughfare - 06-02-06 19:29 =

----------------------------------------------------------------------
Erm, I don't think his comment was really off-topic? I'm following this bug
because I have the exact same chipset in my Packard Bell Easynote A2808.

Unfortunately few people run Linux on Packard Bells (actually manufactured
by NEC).

----------------------------------------------------------------------
 rlrevell - 06-02-06 19:40 =

----------------------------------------------------------------------
The contents of /proc/asound/card0/codec97#0/ac97#0-0 are exactly the same
as #0004795?

----------------------------------------------------------------------
 thoroughfare - 06-02-06 21:34 =

----------------------------------------------------------------------
Sure are:

~$ cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Conexant id 31

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0x0000
Subsys. ID       : 0x0000

Capabilities     :
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=3D0 rev=3D2 AMAP LDAC SDAC CDAC DSA=3D0 SPDIF
Extended status  : PRL SPCV LDAC SDAC CDAC SPDIF=3D10/11
SPDIF Control    : Consumer PCM Category=3D0x2 Generation=3D1 Rate=3D48kHz
Extended modem ID: codec=3D0 LIN1
Modem status     : PRA(GPIO) PRB(res) PRC(ADC1) PRD(DAC1) PRE(ADC2)
PRF(DAC2) PRG(HADC) PRH(HDAC)
Line1 rate       : 48000Hz


That's on my Packard Bell (NEC) EasyNote A2808.

----------------------------------------------------------------------
 kickstart - 06-03-06 01:51 =

----------------------------------------------------------------------
Hi all,

I've Packard Bell A8810 running linux Slackware current, with the same
problem.

- My lspci:

00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express
Processor to DRAM Controller (rev 03)
00:02.0 VGA compatible controller: Intel Corporation Mobile
915GM/GMS/910GML Express Graphics Controller (rev 03)
00:02.1 Display controller: Intel Corporation Mobile 915GM/GMS/910GML
Express Graphics Controller (rev 03)
00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
PCI Express Port 1 (rev 04)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 04)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 04)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 04)
00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #4 (rev 04)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 04)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4)
00:1e.2 Multimedia audio controller: Intel Corporation
82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 04)
00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97
Modem Controller (rev 04)
00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface
Bridge (rev 04)
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) IDE Controller (rev 04)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus
Controller (rev 04)
06:01.0 CardBus bridge: Texas Instruments PCIxx21/x515 Cardbus Controller
06:01.2 FireWire (IEEE 1394): Texas Instruments OHCI Compliant IEEE 1394
Host Controller
06:01.3 Mass storage controller: Texas Instruments PCIxx21 Integrated
FlashMedia Controller
06:03.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev
05)
06:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)

- The audio codec seems to be a Conexant 20468-31 AC'97:

http://support.packardbell.com/it/item/index.php?i=3Dspec_sound_cnx20468-31=
&ppn=3DPB30Q01306]

- Conexant info:

http://www.conexant.com/products/entry.jsp?id=3D24

This laptop seems quite similar to Benq JoyBook S53 and NEC Versa s940:

http://forum.hardware.fr/hardwarefr/MiniPCPortablesPDA/Topic-Unique-NEC-Ver=
sa-S940-Packard-Bell-EasyNote-A5510-A7715-sujet-17891-1.htm
http://www.nec-online.co.nz/Products/Product_Specs.asp?CID=3D9&RangeID=3D15=
&CatID=3D30&ModID=3D79

Since this audio codec family seems to bee supported ( see
sound/pci/ac97/ac97_codec.c ) with id =3D 0x43585428 Cx20468 , I've compiled
a vanilla 2.6.16.19 kernel adding my ac97_codec_id taken from:

cat /proc/asound/card0/codec97#0/ac97#0-0+regs

<snip>
0:7c =3D 4358
0:7e =3D 5431

My ID =3D 0x43585431 [ 0:7c + 0:7e value ]

to sound/pci/ac97/ac97_codec.c

<snip>
{ 0x43585421, 0xffffffff, "HSD11246", NULL, NULL }, // SmartMC II
{ 0x43585428, 0xfffffff8, "Cx20468",patch_conexant, NULL }, // SmartAMC
fixme:
{ 0x43585431, 0xffffffff, "Cx20468-31",patch_conexant, NULL }, // <--
ADDED
{ 0x44543031, 0xfffffff0, "DT0398", NULL, NULL },
<snip>


Now, cat /proc/asound/cards gives:

 0 [ICH6           ]: ICH4 - Intel ICH6
                      Intel ICH6 with Cx20468-31 at 0xb0040800, irq 16

but STILL NO SOUND!

I'll try to contact Packard Bell trying to get some info about the codec
...

rlrevell: =


Here is the output of 'cat /proc/asound/card0/codec97#0/ac97#0-0'
BEFORE adding { 0x43585431, 0xffffffff, "Cx20468-31",patch_conexant, NULL
}
to sound/pci/ac97/ac97_codec.c
---------------------------------------------------------------------------=
----
0-0/0: Conexant id 31

PCI Subsys Vendor: 0x152d
PCI Subsys Device: 0x0745

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0x0000
Subsys. ID       : 0x0000

Capabilities     :
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=3D0 rev=3D2 AMAP LDAC SDAC CDAC DSA=3D0 SPDIF
Extended status  : PRL SPCV LDAC SDAC CDAC SPDIF=3D10/11
SPDIF Control    : Consumer PCM Copyright Category=3D0x22 Generation=3D1
Rate=3D48kHz
Extended modem ID: codec=3D0 LIN1
Modem status     : PRA(GPIO) PRB(res) PRC(ADC1) PRD(DAC1) PRE(ADC2)
PRF(DAC2) PRG(HADC) PRH(HDAC)
Line1 rate       : 48000Hz


And this AFTER:

---------------------------------------------------------------------------=
----
0-0/0: Conexant Cx20468-31

PCI Subsys Vendor: 0x152d
PCI Subsys Device: 0x0745

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0x0000
Subsys. ID       : 0x0000

Capabilities     :
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=3D0 rev=3D2 AMAP LDAC SDAC CDAC DSA=3D0 SPDIF
Extended status  : PRL SPCV LDAC SDAC CDAC SPDIF=3D10/11
SPDIF Control    : Consumer PCM Copyright Category=3D0x0 Generation=3D0
Rate=3D48kHz
Extended modem ID: codec=3D0 LIN1
Modem status     : PRA(GPIO) PRB(res) PRC(ADC1) PRD(DAC1) PRE(ADC2)
PRF(DAC2) PRG(HADC) PRH(HDAC)
Line1 rate       : 48000Hz




Let me know if I'm off topic ....

Issue History
Date Modified  Username       Field                    Change              =

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
05-28-05 08:49 liangalei      New Issue                                    =

05-28-05 08:49 liangalei      Distribution              =3D> Fedora Core 3 =
  =

05-28-05 08:49 liangalei      Kernel Version            =3D> 2.6.11-1.14   =
  =

05-28-05 09:17 liangalei      Note Added: 0004759                          =

05-28-05 09:18 liangalei      Issue Monitored: liangalei                    =

05-30-05 03:29 liangalei      Note Added: 0004795                          =

06-01-05 16:58 tiwai          Note Added: 0004863                          =

06-01-05 17:04 tiwai          Category                 0_compilation proble=
m_!!!
=3D> PCI - intel8x0
06-02-05 10:42 liangalei      Note Added: 0004875                          =

06-06-05 09:53 perex          Assigned To              perex =3D>          =
  =

06-23-05 12:42 tiwai          Note Added: 0005182                          =

06-24-05 03:12 liangalei      File Added: asound.state                     =

06-24-05 03:13 liangalei      File Added: ac97#0-0                         =

06-24-05 03:14 liangalei      File Added: ac97#0-0+regs                    =

06-24-05 03:18 liangalei      Note Added: 0005202                          =

08-28-05 15:28 ybar           Note Added: 0005962                          =

11-29-05 05:59 derek          Issue Monitored: derek                       =

11-29-05 06:00 derek          Issue End Monitor: derek                     =

11-29-05 06:03 derek          Note Added: 0006870                          =

02-07-06 10:03 anhi1968       Issue Monitored: anhi1968                    =

02-17-06 22:22 gandhi         Note Added: 0008110                          =

02-17-06 23:26 gandhi         Issue Monitored: gandhi                      =

02-17-06 23:28 gandhi         Note Edited: 0008110                         =

02-17-06 23:43 gandhi         Note Edited: 0008110                         =

02-18-06 02:05 gandhi         Note Added: 0008112                          =

02-18-06 08:13 liangalei      Note Added: 0008116                          =

02-18-06 15:56 gandhi         Issue Monitored: tiwai                       =

02-18-06 15:56 gandhi         Note Added: 0008120                          =

02-28-06 12:02 anhi1968       Issue End Monitor: anhi1968                  =
  =

03-03-06 08:29 robitech       Note Added: 0008336                          =

03-15-06 05:34 JProgrammer    Note Added: 0008526                          =

03-15-06 05:37 JProgrammer    Issue Monitored: JProgrammer                 =
   =

03-15-06 06:39 Kooper         Note Added: 0008527                          =

03-15-06 11:40 tiwai          Note Added: 0008531                          =

03-15-06 11:53 Kooper         Note Added: 0008535                          =

03-15-06 12:13 JProgrammer    Note Added: 0008538                          =

03-15-06 12:18 tiwai          Note Added: 0008540                          =

03-15-06 23:48 JProgrammer    Note Added: 0008579                          =

03-16-06 15:04 tiwai          Note Added: 0008606                          =

03-16-06 15:05 tiwai          File Added: ac97-remove-modem.diff           =
     =

   =

03-16-06 19:34 rlrevell       Relationship added       has duplicate 0001931
03-17-06 04:10 Kooper         Note Added: 0008633                          =

03-17-06 12:07 tiwai          Note Added: 0008641                          =

03-17-06 12:32 Kooper         File Added: kooper-alsa-bugreport.tgz        =
     =

      =

03-17-06 12:35 Kooper         Note Added: 0008644                          =

03-21-06 02:38 JProgrammer    Note Added: 0008736                          =

03-25-06 10:51 alessiodf      Note Added: 0008944                          =

03-26-06 20:12 alessiodf      Note Edited: 0008944                         =

03-26-06 20:15 alessiodf      Note Edited: 0008944                         =

03-30-06 15:47 trava          Note Added: 0009034                          =

04-07-06 13:05 kesiev         Note Added: 0009137                          =

04-07-06 13:06 kesiev         Note Edited: 0009137                         =

04-09-06 03:23 alt_ackbar     Note Added: 0009177                          =

04-11-06 11:34 kesiev         Issue Monitored: kesiev                      =

04-11-06 11:39 kesiev         Issue End Monitor: kesiev                    =

04-12-06 16:21 kesiev         Note Added: 0009246                          =

04-12-06 16:21 kesiev         File Added: qta058Ba.inf                     =

04-13-06 14:00 kesiev         Note Added: 0009259                          =

04-13-06 14:00 kesiev         File Added: windows-details.txt              =
     =


04-13-06 14:54 kesiev         Note Edited: 0009259                         =

04-13-06 15:34 kesiev         Issue Monitored: kesiev                      =

04-15-06 12:33 kesiev         Note Edited: 0009259                         =

04-15-06 12:33 kesiev         File Added: alsasound.conf                    =

04-18-06 09:35 fedukoff       Note Added: 0009326                          =

05-01-06 20:24 rawsock        Issue Monitored: rawsock                     =

05-03-06 15:55 fedukoff       Issue Monitored: fedukoff                    =

05-09-06 14:36 drseergio      Note Added: 0009658                          =

05-09-06 16:40 rlrevell       Note Added: 0009661                          =

05-09-06 17:16 drseergio      Note Added: 0009662                          =

05-09-06 17:19 drseergio      Note Edited: 0009662                         =

05-09-06 17:28 rlrevell       Note Added: 0009664                          =

05-09-06 17:31 drseergio      Note Edited: 0009662                         =

05-09-06 17:32 drseergio      Note Added: 0009665                          =

05-09-06 17:41 drseergio      Note Edited: 0009665                         =

05-09-06 17:49 rlrevell       Note Added: 0009667                          =

05-09-06 17:52 drseergio      Note Added: 0009668                          =

05-09-06 17:57 rlrevell       Note Added: 0009669                          =

05-09-06 18:00 drseergio      Note Added: 0009670                          =

05-09-06 18:33 fedukoff       Note Added: 0009672                          =

05-09-06 18:44 drseergio      Note Added: 0009673                          =

05-09-06 19:11 fedukoff       Note Added: 0009674                          =

05-09-06 19:12 rlrevell       Note Added: 0009675                          =

05-09-06 19:21 drseergio      Note Added: 0009676                          =

05-09-06 19:27 fedukoff       Note Added: 0009677                          =

05-09-06 19:28 rlrevell       Note Added: 0009678                          =

05-09-06 19:30 drseergio      Note Added: 0009679                          =

05-09-06 19:39 fedukoff       Note Added: 0009680                          =

05-09-06 19:42 rlrevell       Note Added: 0009681                          =

05-09-06 19:50 drseergio      Note Added: 0009682                          =

05-09-06 20:16 fedukoff       Note Added: 0009683                          =

05-09-06 20:17 rlrevell       Note Added: 0009684                          =

05-09-06 20:19 rlrevell       Note Added: 0009685                          =

05-09-06 20:28 drseergio      Note Added: 0009686                          =

05-09-06 20:29 fedukoff       Note Added: 0009687                          =

05-09-06 20:34 rlrevell       Note Added: 0009688                          =

05-09-06 22:07 fedukoff       Note Added: 0009691                          =

05-10-06 15:58 fedukoff       Note Added: 0009719                          =

05-10-06 17:10 rlrevell       Note Added: 0009735                          =

05-10-06 17:19 kesiev         Note Added: 0009738                          =

05-10-06 17:21 trava          Note Added: 0009740                          =

05-10-06 17:25 trava          Note Added: 0009741                          =

05-10-06 17:41 fedukoff       Note Added: 0009743                          =

05-10-06 18:03 fedukoff       Note Added: 0009745                          =

05-10-06 18:20 trava          Note Added: 0009746                          =

05-10-06 18:34 fedukoff       Note Added: 0009748                          =

05-11-06 08:15 fedukoff       Note Added: 0009759                          =

05-11-06 08:42 JProgrammer    Note Added: 0009760                          =

05-11-06 08:45 fedukoff       Note Added: 0009761                          =

05-11-06 18:25 fedukoff       Note Added: 0009764                          =

05-12-06 08:13 fedukoff       Note Added: 0009773                          =

05-12-06 08:14 fedukoff       Note Edited: 0009773                         =

05-15-06 14:15 fedukoff       Note Added: 0009822                          =

05-15-06 14:49 rlrevell       Note Added: 0009824                          =

05-15-06 14:57 fedukoff       Note Added: 0009825                          =

05-15-06 15:25 rlrevell       Note Added: 0009826                          =

05-18-06 12:45 fedukoff       Note Added: 0009866                          =

05-18-06 13:37 fedukoff       Note Added: 0009867                          =

05-18-06 13:48 fedukoff       Note Deleted: 0009822                        =

05-19-06 08:07 fedukoff       Note Added: 0009873                          =

05-25-06 23:03 thoroughfare   Note Added: 0009969                          =

06-02-06 17:37 kickstart      Note Added: 0010049                          =

06-02-06 17:53 kickstart      Note Edited: 0010049                         =

06-02-06 17:54 rlrevell       Note Added: 0010050                          =

06-02-06 18:00 kickstart      Note Deleted: 0010049                        =

06-02-06 19:29 thoroughfare   Note Added: 0010051                          =

06-02-06 19:40 rlrevell       Note Added: 0010052                          =

06-02-06 21:34 thoroughfare   Note Added: 0010056                          =

06-03-06 01:51 kickstart      Note Added: 0010057                          =

06-07-06 10:49 jmpmjmpm       Note Added: 0010078                          =

06-07-06 11:03 jmpmjmpm       Note Deleted: 0010078                        =

06-07-06 20:46 rlrevell       Relationship added       has duplicate 0002191
06-07-06 20:47 rlrevell       Relationship added       has duplicate 0001756
06-07-06 20:49 rlrevell       Relationship added       has duplicate 0002185
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
