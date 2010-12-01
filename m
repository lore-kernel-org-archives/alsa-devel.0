From: c0 <elcorreodelcoco@gmail.com>
Subject: MAYA44E
Date: Wed, 01 Dec 2010 01:28:41 +0100
Message-ID: <1291163321.6691.7.camel@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 49FD1244DC
	for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2010 01:28:35 +0100 (CET)
Received: by wyi11 with SMTP id 11so6316765wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 16:28:34 -0800 (PST)
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

Hi. My name is Jose.

The maya44 (pci) seems to be supported in snd-ice17xx drivers.
But the new maya44e (pci express) is "only" recognized in my system as:

root@debian:/home/co# lspci -vvv -s 04:00.0
04:00.0 Multimedia audio controller: Device 19fe:7000 (rev 03)
        Subsystem: Device 0e51:0001
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64 (40000ns max)
        Interrupt: pin A routed to IRQ 7
        Region 0: Memory at fd9fc000 (32-bit, non-prefetchable)
[size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-

I would like to help to make this card work.

Best regards.
Jose.
