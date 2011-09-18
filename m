From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Noise on snd-hda-intel
Date: Sun, 18 Sep 2011 16:03:32 +0800
Message-ID: <CAN8cciYvCb-mbifQ7ZoGES8WTVt1yy3tfKoa2p9GJq=y4jBAJw@mail.gmail.com>
References: <4E00F373.6050001@molgaard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 203B82450B
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Sep 2011 10:03:34 +0200 (CEST)
Received: by fxe22 with SMTP id 22so3042930fxe.38
	for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2011 01:03:32 -0700 (PDT)
In-Reply-To: <4E00F373.6050001@molgaard.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/6/22 Sune M=F8lgaard <sune@molgaard.org>:
> Plugging almost any headset into the front headset jacks on my machine
> results in noise in the headphones as well as in Skype conversations
> and/or recording. Said noise is, however not head in the regular
> speakers (except when playing back recordings, of course.
>
> lspci -vvnn gives
>
> 00:1b.0 Audio device [0403]: Intel Corporation 82801JI (ICH10 Family) HD
> Audio Controller [8086:3a3e]
> =A0 =A0 =A0 =A0Subsystem: ASUSTeK Computer Inc. Device [1043:82ea]
> =A0 =A0 =A0 =A0Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop=
- ParErr-
> Stepping- SERR+ FastB2B- DisINTx+
> =A0 =A0 =A0 =A0Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >T=
Abort- <TAbort-
> <MAbort- >SERR- <PERR- INTx-
> =A0 =A0 =A0 =A0Latency: 0, Cache Line Size: 256 bytes
> =A0 =A0 =A0 =A0Interrupt: pin A routed to IRQ 70
> =A0 =A0 =A0 =A0Region 0: Memory at f7ff8000 (64-bit, non-prefetchable) [s=
ize=3D16K]
> =A0 =A0 =A0 =A0Capabilities: <access denied>
> =A0 =A0 =A0 =A0Kernel driver in use: HDA Intel
> =A0 =A0 =A0 =A0Kernel modules: snd-hda-intel
>
> and aplay -l gives
>
> **** List of PLAYBACK Hardware Devices ****
> card 0: Device [USB Multimedia Audio Device], device 0: USB Audio [USB
> Audio]
> =A0 Subdevices: 1/1
> =A0 Subdevice #0: subdevice #0
> card 2: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
> =A0 Subdevices: 1/1
> =A0 Subdevice #0: subdevice #0
>
> I have tried with no modules options as well as
>
> options snd_hda_intel model=3D6stack
>
> and
>
> options snd_hda_intel model=3D6stack-dig
>
> Best regards,
>
> Sune M=F8lgaard
>

Are you sure that it is noise ?

Just test Ubuntu 11.04 Live CD

HP has no sound when select Analog Headphone connector in gnome sound
preference and HP has sound when select Analog Output as connector

I guess PA server cannot find "Headphone Playback Volume". since only
"Headphone Playback Switch" exist in Ubuntu 11.04

The other strange thing is alsamixer can mute but unmute has no effect
,need to use gnome sound preference
