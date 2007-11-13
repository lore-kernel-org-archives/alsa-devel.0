From: glv <glvals@internet.is>
Subject: Re: Mitac 8252D hda_intel
Date: Tue, 13 Nov 2007 20:31:47 +0000
Message-ID: <200711132031.47715.glvals@internet.is>
References: <61445c750711131042qed654b8s17454534fdaa68e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vxout-1.c.is (vxout-1.c.is [213.176.128.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 1540B2460D
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 21:31:45 +0100 (CET)
Received: from mail.internet.is (xs.heimsnet.is [193.4.194.50])
	by vxout-1.c.is (Postfix) with ESMTP id 533C62C02AD
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 20:31:35 +0000 (GMT)
Received: from localhost (194-144-122-157.du.xdsl.is [194.144.122.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.internet.is (Postfix) with ESMTP id 8DDF230711
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 20:31:25 +0000 (CUT)
In-Reply-To: <61445c750711131042qed654b8s17454534fdaa68e7@mail.gmail.com>
Content-Disposition: inline
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
I have a Mitac 8252D computer with hda_intel, it has 3 sockets in front: 
microphone, audio(headphones)and S/PDIF. 
When using 5.1 the manual says:
Microphone: rear speakers
Audio:	front speakers
S/PDIF:	center and subwoofer  
Modprobing without any options gives me sound to the headphone and digital 
socket and 
Modprobing with model=6stack-hp gives me sound to the speakers to but they 
stay on when headph. are pluged in

Output from alsa-info.sh:
http://pastebin.ca/772406

Output from lspci -vv:
00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio 
Controller (rev 03)
        Subsystem: Mitac Unknown device 8253
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at fc200000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express Unknown type IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
                Link: Latency L0s <64ns, L1 <1us
                Link: ASPM Disabled CommClk- ExtSynch-
                Link: Speed unknown, Width x0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

thank you.
