From: Simos Xenitellis <simos.lists@googlemail.com>
Subject: Audio problems with AD1981A (Subsystem: 0e11:00ad)
Date: Wed, 23 Sep 2009 14:13:52 +0300
Message-ID: <598e9210909230413n3bc1d4a2y1a23bf8a60d80883@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f178.google.com (mail-yw0-f178.google.com
	[209.85.211.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E28F24594
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 13:14:14 +0200 (CEST)
Received: by ywh8 with SMTP id 8so699124ywh.16
	for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2009 04:14:12 -0700 (PDT)
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

Hi All,
I am helping a user with the following hardware,

http://www.alsa-project.org/db/?f=7f926200ee31b5b22222336b9e25bb0e60671a90
(Desktop computer Compaq Evo D510 SFF, with onboard sound card)

lspci -vvc shows:
00:1f.5 0401: 8086:24c5 (rev 01)
        Subsystem: 0e11:00ad
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 17
        Region 0: I/O ports at 2000 [size=256]
        Region 1: I/O ports at 2400 [size=64]
        Region 2: Memory at fc480400 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at fc480600 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: Intel ICH
        Kernel modules: snd-intel8x0

What does not work:
1. Jack sense. Audio plays on onboard speakers (the computer has
in-built speakers) but does not work with headset.
2. Recording. Only a 'Capture' control is shown in the recording tab.
No other controls for recording are available.
When trying to record with gnome-sound-recorder, the application
hangs, which then kills pulseaudio.

Cheers,
Simos
