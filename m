From: Colin Kincaid Williams <discord@uw.edu>
Subject: poor sound from ALC 850/880 in alsa 1.0.21 and 1.0.23
Date: Fri, 26 Nov 2010 20:19:49 -0800
Message-ID: <AANLkTikE8tMisXQZfmKA_VqureL3iLU7gJhA4-L0p4HV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 637041037E3
	for <alsa-devel@alsa-project.org>; Sat, 27 Nov 2010 05:19:53 +0100 (CET)
Received: by bwz8 with SMTP id 8so2434366bwz.38
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 20:19:52 -0800 (PST)
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

 Hello,

 I'm experiencing crap sound preformance from my ALC 850/880 chipset.
 I'm first wondering if their is a way to set the model other than the
 /etc/modprobe.d/alsa-base.conf file? Can I try different models
 without rebooting? So far I've tried the model 6stack, since that
 sounds like what I have on my motherboard. Furthermore, does anybody
 have any ideas on what else I can do so that my computer can sound at
 least as good as my $20 coby mp3 player?

I've tried both driver version 1.0.21 and more recently 1.0.23, with
no improvment in sound.


cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.23.
Compiled on Nov 26 2010 for kernel 2.6.32-5-amd64 (SMP).


 cat /proc/asound/version
 Advanced Linux Sound Architecture Driver Version 1.0.21.



 The output from lspci :


 00:10.1 Audio device [0403]: nVidia Corporation MCP51 High Definition
 Audio [10de:026c] (rev a2)
 =A0 =A0 =A0 =A0Subsystem: Giga-byte Technology Device [1458:a102]
 =A0 =A0 =A0 =A0Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop=
- ParErr-
 Stepping- SERR- FastB2B- DisINTx-
 =A0 =A0 =A0 =A0Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >T=
Abort-
 <TAbort- <MAbort- >SERR- <PERR- INTx-
 =A0 =A0 =A0 =A0Latency: 0 (500ns min, 1250ns max)
 =A0 =A0 =A0 =A0Interrupt: pin B routed to IRQ 22
 =A0 =A0 =A0 =A0Region 0: Memory at f5100000 (32-bit, non-prefetchable) [s=
ize=3D16K]
 =A0 =A0 =A0 =A0Capabilities: [44] Power Management version 2
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0=
mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Status: D0 NoSoftRst- PME-Enable- DSel=3D0=
 DScale=3D0 PME-
 =A0 =A0 =A0 =A0Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable+ 64bi=
t+
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address: 0000000000000000 =A0Data: 0000
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Masking: 00000000 =A0Pending: 00000000
 =A0 =A0 =A0 =A0Capabilities: [6c] HyperTransport: MSI Mapping Enable+ Fix=
ed+
 =A0 =A0 =A0 =A0Kernel driver in use: HDA Intel
