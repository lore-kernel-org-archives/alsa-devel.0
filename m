From: Colin Kincaid Williams <discord@uw.edu>
Subject: Re: terrible sound from my ALC850 / 880 [Alsa driver
 version 1.0.21] debian ( squeeze )
Date: Thu, 25 Nov 2010 15:11:27 -0800
Message-ID: <AANLkTikFY-g=O=41ws3Co8MQi_qCY1ZFrbqCupvFqv8q@mail.gmail.com>
References: <AANLkTikNk4+LZw8bHrUgjgVSkxP7kmi3bGe=RqGCYgFD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 17202103C83
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 00:11:28 +0100 (CET)
Received: by bwz8 with SMTP id 8so1350459bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 15:11:27 -0800 (PST)
In-Reply-To: <AANLkTikNk4+LZw8bHrUgjgVSkxP7kmi3bGe=RqGCYgFD@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 24, 2010 at 12:12 AM, Colin Kincaid Williams <discord@uw.edu> w=
rote:
> Hello,
>
> I'm experiencing crap sound preformance from my ALC 850/880 chipset.
> I'm first wondering if their is a way to set the model other than the
> /etc/modprobe.d/alsa-base.conf file? Can I try different models
> without rebooting? So far I've tried the model 6stack, since that
> sounds like what I have on my motherboard. Furthermore, does anybody
> have any ideas on what else I can do so that my computer can sound at
> least as good as my $20 coby mp3 player?
>
>
> cat /proc/asound/version
> Advanced Linux Sound Architecture Driver Version 1.0.21.
>
>
>
> The output from lspci :
>
>
> 00:10.1 Audio device [0403]: nVidia Corporation MCP51 High Definition
> Audio [10de:026c] (rev a2)
> =A0 =A0 =A0 =A0Subsystem: Giga-byte Technology Device [1458:a102]
> =A0 =A0 =A0 =A0Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop=
- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
> =A0 =A0 =A0 =A0Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >T=
Abort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
> =A0 =A0 =A0 =A0Latency: 0 (500ns min, 1250ns max)
> =A0 =A0 =A0 =A0Interrupt: pin B routed to IRQ 22
> =A0 =A0 =A0 =A0Region 0: Memory at f5100000 (32-bit, non-prefetchable) [s=
ize=3D16K]
> =A0 =A0 =A0 =A0Capabilities: [44] Power Management version 2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0=
mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 NoSoftRst- PME-Enable- DSel=3D0=
 DScale=3D0 PME-
> =A0 =A0 =A0 =A0Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable+ 64bi=
t+
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 0000000000000000 =A0Data: 0000
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Masking: 00000000 =A0Pending: 00000000
> =A0 =A0 =A0 =A0Capabilities: [6c] HyperTransport: MSI Mapping Enable+ Fix=
ed+
> =A0 =A0 =A0 =A0Kernel driver in use: HDA Intel
>
