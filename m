From: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Subject: Noise on snd-hda-intel
Date: Tue, 21 Jun 2011 21:39:31 +0200
Message-ID: <4E00F373.6050001@molgaard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.fullrate.dk (smtp.fullrate.dk [90.185.1.42])
	by alsa0.perex.cz (Postfix) with ESMTP id F2D0D2444E
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jun 2011 21:39:32 +0200 (CEST)
Received: from [10.0.0.2] (1407ds3-arsy.0.fullrate.dk [95.166.154.201])
	by smtp.fullrate.dk (Postfix) with ESMTP id EF0F49D0A7
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jun 2011 21:39:33 +0200 (CEST)
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

Plugging almost any headset into the front headset jacks on my machine =

results in noise in the headphones as well as in Skype conversations =

and/or recording. Said noise is, however not head in the regular =

speakers (except when playing back recordings, of course.

lspci -vvnn gives

00:1b.0 Audio device [0403]: Intel Corporation 82801JI (ICH10 Family) HD =

Audio Controller [8086:3a3e]
	Subsystem: ASUSTeK Computer Inc. Device [1043:82ea]
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =

Stepping- SERR+ FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- =

<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 256 bytes
	Interrupt: pin A routed to IRQ 70
	Region 0: Memory at f7ff8000 (64-bit, non-prefetchable) [size=3D16K]
	Capabilities: <access denied>
	Kernel driver in use: HDA Intel
	Kernel modules: snd-hda-intel

and aplay -l gives

**** List of PLAYBACK Hardware Devices ****
card 0: Device [USB Multimedia Audio Device], device 0: USB Audio [USB =

Audio]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 2: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

I have tried with no modules options as well as

options snd_hda_intel model=3D6stack

and

options snd_hda_intel model=3D6stack-dig

Best regards,

Sune M=F8lgaard

-- =

You buy Windows, and you put it on your machine-you can't do a whole lot =

with it.
- Bob Muglia, Microsoft Senior Vice President
