From: Diego Jacobi <jacobidiego@gmail.com>
Subject: SBx00 Azalia ALC663 Working but MIC goes away
Date: Tue, 28 Jun 2011 10:33:50 -0300
Message-ID: <BANLkTi=ARHV819LS+JSR2spuj9Qri2_T2g@mail.gmail.com>
References: <BANLkTinxBJ0bqd6PV6buXu_2ZfQKJmy6+A@mail.gmail.com>
	<BANLkTim1k6NzuryDE2_FENTNm1veUja+OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3054a5a51af19204a6c5b90c
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50]) by alsa0.perex.cz (Postfix) with ESMTP id A07032466A
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Jun 2011 15:34:14 +0200 (CEST)
Received: by fxh2 with SMTP id 2so243146fxh.9
	for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2011 06:34:11 -0700 (PDT)
In-Reply-To: <BANLkTim1k6NzuryDE2_FENTNm1veUja+OQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, alsa-user@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

--20cf3054a5a51af19204a6c5b90c
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

I already sended this mail to this list ... many times .. but it gets
bounced or wait for moderation. I find this annoying.
I am attaching the files compressed now.


I tested the solution mentioned by Takashi.
I have installed alsa-driver-kmp-default and restarted, but i found
 the same behavior so, i didnt make more alsa-info files.
However, i dont know what is "the right repository",
i choosed "multimedia:audio:KMP/openSUSE_11.4"
and also tested "multimedia:audio:KMP/openSUSE_11.4_Update" which
provided the same file.

The file is installed in
linux-i1zx:/home/diego # modinfo snd-hda-intel | grep filename
filename:
/lib/modules/2.6.37.6-0.5-default/kernel/sound/pci/hda/snd-hda-intel.ko


 I have also tested model=3Dm51va which also didnt helped.

 I dont think that the model, or model-autodetection is the solution for th=
is.

 I mean, the problems gets solved after restarting alsa. So alsa does
 handles the MIC.



 I noted that in /etc/modprobe.d i have 2 sound.conf files.
 One is 50-sound.conf and the other is 50-sound.conf.YaST2save

 I dont know what is the second one for. If i use yast to edit the
 configuration, which i did, it edits the 50-sound.conf

 And also, all other files are numbered 50.
 What would happen if i change the sound to 51 to make the sound load
 after everything else?
 Could it break something ? like Yast ?


---------- Forwarded message ----------
From: Diego Jacobi <jacobidiego@gmail.com>
Date: 2011/6/26
Subject: SBx00 Azalia ALC663 Working but MIC goes away
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>


Hi people.

I am having this problem for a long time ago, and i couldn't find the
same on google, or a solution for it.
I also don't know the right way to write the question to google,
because almost all are about problems that i don't have.

OpenSUSE 11.4 installed about 2 Months ago.
ASUS laptop n51tp
Athlon X2
ATI Mobility=99 Radeon=AE HD 4650
Audio System:
Built-in Azalia compliant audio chip, with 3D effect & full duplex
Built-in speaker and microphone
Support Audio Jack Detect for Vista Basic Logo
Support Audio CODEC criteria for Vista Premium Logo


AUDIO WORKS but with a problem listed below.

ABSTRACT:
- MIC never works after booting. It needs an alsa restart and gets
broke sometimes..

DETAILED:
If i start the laptop with no external headsets or speaker connected
in front panel. Audio goes through internal speakers.
When i connect an external speaker or headsets (like to talk with
skype), they don't work. And MIC doesn't works.
This is undesired behavior and the windows driver doesn't work that
way. Internal goes mute when i connect an external.
Causes trouble when speaking with skype, as everyone can heard.
I have to reset alsa with "rcalsasound restart" with headsets plugged in.

IF i start the laptop with the headsets plugged in. The internal
speakers will not work at all. Always in mute. But the external will
work. Also the MIC wont work.
I have to reset alsa with "rcalsasound restart" with headsets plugged in.

If i do some work with the laptop using different multimedia sources,
it may broke.
Most of the time i get called by skype and the MIC is surprise
surprise, not working. Then i have to close all programs, restart alsa
and open skype again to be able to talk.
Thats the main reason to post here.

TESTS RESULTS:
I have runned alsa-info.sh with a different set of tests. So i write
the cases for each one, and the filename of the attached.

----------------------------
Boot without anything connected to Front panel.
Open Banshee and play.
Internal speakers works.
Plug headsets.
They don't work.
=3D=3D=3D> alsa-info.txt.noheadsets
Open Skype & do test call.
MIC doesn't work.
"rcalsasound restart" while headsets are plugged
Internal AND headsets are working fine.
Open Skype & do test call.
MIC works. Second call works best.
=3D=3D=3D> alsa-info.txt.workingright

----------------------------
Boot with headsets plugged.
Open Banshee and play.
Headsets works.
Unplug headsets.
Internal Speakers doesn't work.
Open Skype & do test call.
MIC doesn't works.
=3D=3D=3D> alsa-info.txt.headsetsnomic
"rcalsasound restart" while headsets are plugged
Restart Skype & do test call.
First call, noise recorded.
Second call, MIC works.
Unplug headsets.
Internal Speakers works.
=3D=3D=3D> alsa-info.txt.workingright2

----------------------------
With the "working right" condition.
Do normal tasks.
Open emesene & Skype.
Open Opera. (always leaved opened)
Open some pages with Firefox (hotmail & other flashintensiv sites)
Went to take a shower & Came back
Internal speakers don't work anymore.
Headsets works
MIC doesn't works.
=3D=3D=3D> alsa-info.txt.onlyheadsetsnomic
rcalsasound restart
Internal speakers works.
Headsets works
Skype requires to be restarted, banshee doesn't.
First call, noise recorded.
Second call, MIC works.
=3D=3D=3D> =A0alsa-info.txt.workingright3



In the gnome's Audio-preferences dialog, the input tab, the level-bars :
- show as ghosts when it doesn't work.
- shows green changing, when it does works.
- shows as ghosts if no program is using the mic and changes to green
if i start the recorder.
Restarting alsa requires closing Opera, Firefox, Skype, Emesene,
Banshee, etc. to work or some of them will broke the MIC again. It
also requires root privileges.

A broken headset also causes this behavior when i plug it, and then
MIC stops working until a reset.
By a broken headset i mean a very low quality crappy MIC Noganet,
which worked fine about 1 week, and then it started to only function
by placing the cable on special positions and not moving it. Don't buy
Noganet!


MY GUESS about the problems:
as almost electronic engineer.

The MIC may seem an initialization problem, as it never happened on
windows, but i don't have it anymore installed, since long now.

The driver requires to detect check for high impedance at the front
panel and mute the internal ones, and/or provide a way to mute them
separately.
I wonder why i cant see my headsets as a separate entry of the mixers.

A short-circuit problem may be happening in my front panel, and under
some circumstances, like moving the cables, it causes some chipset
failure over the MIC controller. The driver is not handling this error
and it stays crashed until a reset.

However, it doesn't explains why seeing a video in flashplayer in
opera may cause this too.



I will appreciate any help, and thanks to everyone reading this not-short p=
ost.
Cheers.
Diego

Below: Data about my system.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Only "Master" and "Capture" are shown on alsa-mixer. Both full. But
the problem here is not the volume.

diego@linux-i1zx:~> skype --version
Skype 2.2.0.25
Copyright (c) 2004-2011, Skype Limited

linux-i1zx:/home/diego # cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.23.

linux-i1zx:/home/diego # cat /proc/asound/cards
0 [SB ]: HDA-Intel - HDA ATI SB
HDA ATI SB at 0xfacf4000 irq 16
1 [HDMI ]: HDA-Intel - HDA ATI HDMI
HDA ATI HDMI at 0xfadec000 irq 42

linux-i1zx:/home/diego # cat /proc/asound/devices
2: : timer
3: [ 0- 1]: digital audio playback
4: [ 0- 0]: digital audio playback
5: [ 0- 0]: digital audio capture
6: [ 0- 0]: hardware dependent
7: [ 0] : control
8: [ 1- 3]: digital audio playback
9: [ 1- 0]: hardware dependent
10: [ 1] : control
11: : sequencer

linux-i1zx:/home/diego # cat /proc/asound/oss/devices
0: [0- 0]: mixer
3: [0- 0]: digital audio
4: [0- 0]: digital audio
12: [0- 1]: digital audio
16: [1- 0]: mixer

linux-i1zx:/home/diego # cat /proc/asound/timers
G0: system timer : 4000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-1-0: PCM playback 0-1-0 : SLAVE
P1-3-0: PCM playback 1-3-0 : SLAVE
linux-i1zx:/home/diego # cat /proc/asound/pcm
00-00: ALC663 Analog : ALC663 Analog : playback 1 : capture 1
00-01: ALC663 Digital : ALC663 Digital : playback 1
01-03: HDMI 0 : HDMI 0 : playback 1

linux-i1zx:/home/diego # cat /etc/modprobe.d/50-sound.conf

options snd slots=3Dsnd-hda-intel,snd-hda-intel
# 5Dex.PIu7BLVZl12:SBx00 Azalia (Intel HDA)
alias snd-card-0 snd-hda-intel
# NXNs.yqXoVEq89wB:R700 Audio Device [Radeon HD 4000 Series]
alias snd-card-1 snd-hda-intel

linux-i1zx:/home/diego # lspci
00:00.0 Host bridge: Advanced Micro Devices [AMD] RS780 Host Bridge
00:02.0 PCI bridge: Advanced Micro Devices [AMD] RS780 PCI to PCI
bridge (ext gfx port 0)
00:05.0 PCI bridge: Advanced Micro Devices [AMD] RS780 PCI to PCI
bridge (PCIE port 1)
00:06.0 PCI bridge: Advanced Micro Devices [AMD] RS780 PCI to PCI
bridge (PCIE port 2)
00:07.0 PCI bridge: Advanced Micro Devices [AMD] RS780 PCI to PCI
bridge (PCIE port 3)
00:11.0 SATA controller: ATI Technologies Inc SB700/SB800 SATA
Controller [AHCI mode]
00:12.0 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI0 Controll=
er
00:12.1 USB Controller: ATI Technologies Inc SB700 USB OHCI1 Controller
00:12.2 USB Controller: ATI Technologies Inc SB700/SB800 USB EHCI Controlle=
r
00:13.0 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI0 Controll=
er
00:13.1 USB Controller: ATI Technologies Inc SB700 USB OHCI1 Controller
00:13.2 USB Controller: ATI Technologies Inc SB700/SB800 USB EHCI Controlle=
r
00:14.0 SMBus: ATI Technologies Inc SBx00 SMBus Controller (rev 3a)
00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA)
00:14.3 ISA bridge: ATI Technologies Inc SB700/SB800 LPC host controller
00:14.4 PCI bridge: ATI Technologies Inc SBx00 PCI to PCI Bridge
00:14.5 USB Controller: ATI Technologies Inc SB700/SB800 USB OHCI2 Controll=
er
00:18.0 Host bridge: Advanced Micro Devices [AMD] Family 11h Processor
HyperTransport Configuration (rev 40)
00:18.1 Host bridge: Advanced Micro Devices [AMD] Family 11h Processor
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] Family 11h Processor
DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] Family 11h Processor
Miscellaneous Control
00:18.4 Host bridge: Advanced Micro Devices [AMD] Family 11h Processor
Link Control
01:00.0 VGA compatible controller: ATI Technologies Inc M96 [Mobility
Radeon HD 4650]
01:00.1 Audio device: ATI Technologies Inc RV710/730
02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 02)
03:00.0 Network controller: Atheros Communications Inc. AR928X
Wireless Network Adapter (PCI-Express) (rev 01)
06:01.0 FireWire (IEEE 1394): Ricoh Co Ltd R5C832 IEEE 1394 Controller (rev=
 05)
06:01.1 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro
Host Adapter (rev 22)
06:01.2 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host
Adapter (rev 12)
06:01.3 System peripheral: Ricoh Co Ltd xD-Picture Card Controller (rev 12)

linux-i1zx:/home/diego # dmesg | grep sound
[ 9.759600] input: HDA ATI SB Mic as
/devices/pci0000:00/0000:00:14.2/sound/card0/input11
[23782.924422] input: HDA ATI SB Mic as
/devices/pci0000:00/0000:00:14.2/sound/card0/input13
[23897.439740] input: HDA ATI SB Mic as
/devices/pci0000:00/0000:00:14.2/sound/card0/input14
[23924.488713] input: HDA ATI SB Mic as
/devices/pci0000:00/0000:00:14.2/sound/card0/input15
[23999.613391] input: HDA ATI SB Mic as
/devices/pci0000:00/0000:00:14.2/sound/card0/input16
[25937.965371] input: HDA ATI SB Mic as
/devices/pci0000:00/0000:00:14.2/sound/card0/input17

linux-i1zx:/home/diego # dmesg | grep hda
[ 50.625207] hda-intel: IRQ timing workaround is activated for card
#1. Suggest a bigger bdl_pos_adj.
[23786.414301] hda-intel: IRQ timing workaround is activated for card
#1. Suggest a bigger bdl_pos_adj.
[23900.659802] hda-intel: IRQ timing workaround is activated for card
#1. Suggest a bigger bdl_pos_adj.
[23928.322973] hda-intel: IRQ timing workaround is activated for card
#1. Suggest a bigger bdl_pos_adj.
[24003.419618] hda-intel: IRQ timing workaround is activated for card
#1. Suggest a bigger bdl_pos_adj.
[25940.535502] hda-intel: IRQ timing workaround is activated for card
#1. Suggest a bigger bdl_pos_adj.

linux-i1zx:/home/diego # lsmod | grep snd
snd_pcm_oss 47887 0
snd_mixer_oss 16849 1 snd_pcm_oss
snd_seq 57361 0
snd_seq_device 6646 1 snd_seq
snd_hda_codec_hdmi 24875 1
snd_hda_codec_realtek 274207 1
snd_hda_intel 24912 2
snd_hda_codec 95606 3 snd_hda_codec_hdmi,snd_hda_codec_realtek,snd_hda_inte=
l
snd_hwdep 6038 1 snd_hda_codec
snd_pcm 87993 4 snd_pcm_oss,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec
snd_timer 21844 2 snd_seq,snd_pcm
snd 66158 15 snd_pcm_oss,snd_mixer_oss,snd_seq,snd_seq_device,snd_hda_codec=
_hdmi,snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,s=
nd_timer
soundcore 6854 1 snd
snd_page_alloc 7897 2 snd_hda_intel,snd_pcm

--20cf3054a5a51af19204a6c5b90c
Content-Type: application/x-gzip; name="alsa-info-results-20110628.tar.gz"
Content-Disposition: attachment;
	filename="alsa-info-results-20110628.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gpgvw7kt7

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
05KUTADAAwA=
--20cf3054a5a51af19204a6c5b90c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--20cf3054a5a51af19204a6c5b90c--
