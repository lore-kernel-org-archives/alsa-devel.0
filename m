From: David Favor <david@davidfavor.com>
Subject: No Sound - X-Fi CA0110 IBG - Ubuntu 910 with Kernel
	2.6.31-6
Date: Sun, 23 Aug 2009 11:06:16 -0500
Message-ID: <4A9168F8.4070102@davidfavor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp104.sbc.mail.mud.yahoo.com (smtp104.sbc.mail.mud.yahoo.com
	[68.142.198.203]) by alsa0.perex.cz (Postfix) with SMTP id 8A0ED2446B
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Aug 2009 22:06:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA-Devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

root@home1:~# uname -r
2.6.31-6-generic

root@home1:~# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Generic [HD-Audio Generic], device 0: CA0110 Analog [CA0110 Analog]
   Subdevices: 0/1
   Subdevice #0: subdevice #0
card 0: Generic [HD-Audio Generic], device 1: CA0110 Digital [CA0110 Digital]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

root@home1:~# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.20.

root@home1:~# cat /proc/asound/card0/codec#1
Codec: Creative CA0110-IBG
Address: 1
Function Id: 0x1
Vendor Id: 0x1102000a
Subsystem Id: 0x11021007
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
N/A
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=255, o=255, i=255, unsolicited=1, wake=1

root@home1:~# lsmod | grep snd
snd_hda_codec_ca0110     7868  1
snd_hda_intel          26600  6
snd_hda_codec          69276  2 snd_hda_codec_ca0110,snd_hda_intel
snd_pcm                75360  4 snd_hda_intel,snd_hda_codec
snd_timer              22244  1 snd_pcm
snd                    59204  15 snd_hda_codec_ca0110,snd_hda_intel,snd_hda_codec,snd_pcm,snd_timer
soundcore               7264  1 snd
snd_page_alloc          9156  2 snd_hda_intel,snd_pcm

root@home1:~# lspci -vvnn
0d:00.0 Audio device [0403]: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG [1102:0009]
	Subsystem: Creative Labs Device [1102:0018]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 26
	Region 0: Memory at fbefc000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [dc] Power Management version 3
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Kernel driver in use: HDA Intel
	Kernel modules: snd-hda-intel

I find no mention anywhere of anyone getting this card to work.

Someone let me know if you have a working card or if I should toss this one.

Thanks.
