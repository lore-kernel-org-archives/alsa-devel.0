From: Lars Zobbe <fedesensfar@gmail.com>
Subject: Has hdspmixer been dropped from alsa-tools?
Date: Thu, 12 May 2011 05:57:21 +0200
Message-ID: <BANLkTi=1hPEDb3foK=zmF4en+DOQuxV1dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D71124406
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 05:57:25 +0200 (CEST)
Received: by qyk29 with SMTP id 29so3030697qyk.17
	for <alsa-devel@alsa-project.org>; Wed, 11 May 2011 20:57:22 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi.
Just upgraded to ubuntu 11.04 and went through the usual process with
getting HDSP 9632 to work.
Everything seems to be fine, modules loaded and stuff. But I can't find the
hdspmixer.
Normally it's included in the alsa-tools and alsa-tools-gui packages. And
actually the mixer GUI does get an entry in the menu. But there is no
command for it to execute. It is supposed to run hdspmixer - but it's not
there.
If I write "hdsp" and try to autocomplete with tab in the terminal, I can
now only se hdsploader and hdspconf (both seem to run just fine btw.).
Without the alsamixer I won't get any sound.

Is the error in the ubuntu natty packaging or did hdspmixer get lost?

Is there any way I can install the hdspmixer tool?

Would it break anything if I just snatched an old version fx from ubuntu
10.04 repositories (where it IS present)?




Some info:



00-00: RME Hammerfall HDSP 9632 : RME Hammerfall HDSP 9632 : playback 1 :
capt

>From *lspci*
02:09.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall DSP
(rev 9a)

>From *lshw*:
 description: Multimedia audio controller
       product: RME Hammerfall DSP
       vendor: Xilinx Corporation
       physical id: 9
       bus info: pci@0000:02:09.0
       version: 9a
       width: 32 bits
       clock: 33MHz
       capabilities: bus_master
       configuration: driver=RME Hammerfall DSP latency=255
       resources: irq:19 memory:fdff0000-fdffffff

*uname -a:*
Linux lars-desktop 2.6.38-8-generic #42-Ubuntu SMP Mon Apr 11 03:31:50 UTC
2011 i686 athlon i386 GNU/Linux

*Version of alsa-tools*:
 *** 1.0.24.1-0ubuntu1 0

*Version of alsa-firmware-loaders*:
*** 1.0.24.1-0ubuntu1 0

*cat /proc/asound/version *
Advanced Linux Sound Architecture Driver Version 1.0.23.

*cat /proc/asound/cards*
 0 [DSP            ]: H-DSP - Hammerfall DSP
                      RME Hammerfall HDSP 9632 at 0xfdff0000, irq 19

*cat /proc/asound/modules *
 0 snd_hdsp


*cat /proc/asound/DSP/hdsp *
RME Hammerfall HDSP 9632 (Card #1)
Buffers: capture f2400000 playback f2600000
IRQ: 19 Registers bus: 0xfdff0000 VM: 0xf819c000
Control register: 0x300409a
Control2 register: 0x0
Status register: 0x32000000
Status2 register: 0xffff8701
FIFO status: 0
MIDI1 Output status: 0xffffff00
MIDI1 Input status: 0xffffff00
MIDI2 Output status: 0xffffff00
MIDI2 Input status: 0xffffff00
Use Midi Tasklet: on

Buffer Size (Latency): 2048 samples (2 periods of 8192 bytes)
Hardware pointer (frames): 0
Precise pointer: off
Line out: on
Firmware version: 1

Sample Clock Source: Internal 44.1 kHz
Preferred Sync Reference: ADAT1
AutoSync Reference: None
AutoSync Frequency: 0
System Clock Mode: Master
System Clock Frequency: 44100
System Clock Locked: No

IEC958 input: Coaxial
IEC958 output: Coaxial only
IEC958 quality: Consumer
IEC958 emphasis: off
IEC958 NonAudio: off
IEC958 sample rate: Error flag set

ADAT1: No Lock
SPDIF: No Lock
Word Clock: No Lock
ADAT Sync: No Lock

AD Gain : +4 dBu
DA Gain : -10 dBV
Phones Gain : -12 dB
XLR Breakout Cable : no
AEB : off (ADAT1 external)


*modinfo soundcore*
filename:       /lib/modules/2.6.38-8-generic/kernel/sound/soundcore.ko
license:        GPL
author:         Alan Cox
description:    Core sound module
srcversion:     982D4ED4F640D0B9C43B130
depends:
vermagic:       2.6.38-8-generic SMP mod_unload modversions 686

*lsmod | grep snd*
snd_hdsp               53247  0
snd_pcm                80244  1 snd_hdsp
snd_page_alloc         14073  2 snd_hdsp,snd_pcm
snd_hwdep              13274  1 snd_hdsp
snd_seq_midi           13132  0
snd_rawmidi            25269  2 snd_hdsp,snd_seq_midi
snd_seq_midi_event     14475  1 snd_seq_midi
snd_seq                51291  2 snd_seq_midi,snd_seq_midi_event
snd_timer              28659  2 snd_pcm,snd_seq
snd_seq_device         14110  3 snd_seq_midi,snd_rawmidi,snd_seq
snd                    55295  7
snd_hdsp,snd_pcm,snd_hwdep,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
soundcore              12600  1 snd





Sincerly
Lars Zobbe.
