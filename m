From: Lars Zobbe <fedesensfar@gmail.com>
Subject: snd-hdsp driver error?
Date: Mon, 2 Nov 2009 13:33:19 +0100
Message-ID: <933ed0910911020433j59c4907q94ee073e5f09e328@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.148])
	by alsa0.perex.cz (Postfix) with ESMTP id E42A6103873
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2009 13:33:20 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 3so981306eyh.16
	for <alsa-devel@alsa-project.org>; Mon, 02 Nov 2009 04:33:19 -0800 (PST)
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

Hi.

Talking to one of the pulseaudio developers (*Colin Guthrie*) about a
problem with pulseaudio loading modules and my sound card (RME HDSP 9632), I
was adviced to inform you about the problem.

I'm on ubuntu 9.10, 64bit, kernel 2.6.31 with an amd64 x2 3800+ processor.


Symptoms are:
Can only make pulseaudio load modules with the deprecated load-module
module-detect command, module-udev-detect doesn't detect anything (no sound
- only null sink output in padevchooser).
I get terrible stuttering.
I can remove pulseaudio and make things work, more or less. However, that
leaves me without software mixing and apps fighting for the rights to make
sound. And more inconveniences (fx. no volume-control).
I can play sound from audacity without stuttering by choosing the cardname
directly in output HDSP, not ALSA, not pulseaudio.


When trying to run alsa-info.sh I get a lot of "not found" errors. So you'll
get some manual info (they might have moved som files around in ubuntu
9.10).

This is part of my syslog during a boot. (I did the formatting to bold).

Nov  2 10:57:32 lars-desktop pulseaudio[1524]: module.c: module-detect is
deprecated: Please use module-udev-detect instead of module-detect!
Nov  2 10:57:37 lars-desktop pulseaudio[1524]: ratelimit.c: 27 events
suppressed
Nov  2 10:57:39 lars-desktop pulseaudio[1612]: module.c: module-detect is
deprecated: Please use module-udev-detect instead of module-detect!
Nov  2 10:57:44 lars-desktop pulseaudio[1612]: ratelimit.c: 23 events
suppressed
Nov  2 10:57:44 lars-desktop pulseaudio[1612]: alsa-sink.c: ALSA woke us up
to write new data to the device, but there was actually nothing to write!
Nov  2 10:57:44 lars-desktop pulseaudio[1612]: alsa-sink.c: *Most likely
this is a bug in the ALSA driver 'snd_hdsp'. Please report this issue to the
ALSA developers.*
Nov  2 10:57:44 lars-desktop pulseaudio[1612]: alsa-sink.c: We were woken up
with POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 or
another value < min_avail.
Nov  2 10:57:49 lars-desktop pulseaudio[1612]: ratelimit.c: 99 events
suppressed

Later if I try to play audio I get terrible skipping or stuttering and my
syslog (in less than a minute) writes:
Nov  2 11:55:16 lars-desktop pulseaudio[1612]: ratelimit.c: 16 events
suppressed
Nov  2 11:55:21 lars-desktop pulseaudio[1612]: ratelimit.c: 34 events
suppressed
Nov  2 11:55:26 lars-desktop pulseaudio[1612]: ratelimit.c: 70 events
suppressed
Nov  2 11:55:31 lars-desktop pulseaudio[1612]: ratelimit.c: 29 events
suppressed
Nov  2 11:55:36 lars-desktop pulseaudio[1612]: ratelimit.c: 43 events
suppressed
Nov  2 11:55:41 lars-desktop pulseaudio[1612]: ratelimit.c: 161 events
suppressed
Nov  2 11:55:46 lars-desktop pulseaudio[1612]: ratelimit.c: 28 events
suppressed
Nov  2 11:55:51 lars-desktop pulseaudio[1612]: ratelimit.c: 18 events
suppressed
Nov  2 11:55:56 lars-desktop pulseaudio[1612]: ratelimit.c: 16 events
suppressed

Here's the relevant part (concerning my sound card) of lspci -vvv

02:09.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall DSP
(rev 9a)
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 255
    Interrupt: pin A routed to IRQ 19
    Region 0: Memory at fdff0000 (32-bit, non-prefetchable) [size=64K]
    Kernel driver in use: RME Hammerfall DSP
    Kernel modules: snd-hdsp

And:
lars@lars-desktop:~$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: DSP [Hammerfall DSP], device 0: RME Hammerfall HDSP 9632 [RME
Hammerfall HDSP 9632]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


lars@lars-desktop:~$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.21.
Compiled on Oct 15 2009 for kernel 2.6.31-14-generic (SMP).

lars@lars-desktop:~$ cat /proc/asound/cards
 0 [DSP            ]: H-DSP - Hammerfall DSP
                      RME Hammerfall HDSP 9632 at 0xfdff0000, irq 19


lars@lars-desktop:~$ cat /proc/asound/modules
 0 snd_hdsp

I don't have .asound.conf files.

lars@lars-desktop:~$ hdsploader
hdsploader - firmware loader for RME Hammerfall DSP cards
Looking for HDSP + Multiface or Digiface cards :
Card 0 : RME Hammerfall HDSP 9632 at 0xfdff0000, irq 19

And of course. My computer makes no sound if I don't load the hdspmixer at
startup. I guess that's just normal for this card though.

Please let me know, if you need more info. I really hope you can help out
here. And that this might help you to.

Thanks for the great work you do. Greetings.
Lars Zobbe.
