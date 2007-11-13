From: glv <glvals@internet.is>
Subject: Mitac 8252D hda_intel
Date: Tue, 13 Nov 2007 20:51:10 +0000
Message-ID: <200711132051.10170.glvals@internet.is>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vxout-2.c.is (vxout-2.c.is [213.176.128.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 667BF24641
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 21:50:57 +0100 (CET)
Received: from mail.internet.is (mail.aknet.is [193.4.194.58])
	by vxout-2.c.is (Postfix) with ESMTP id EB2142C80F4
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 20:50:47 +0000 (GMT)
Received: from localhost (194-144-122-157.du.xdsl.is [194.144.122.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.internet.is (Postfix) with ESMTP id BC4491754
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 20:50:47 +0000 (CUT)
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

(Second attempt, hope this works)

Hello,
I have a Mitac 8252D computer with hda_intel, it has 3 sockets in front: =

microphone, audio(headphones)and S/PDIF. =

When using 5.1 the manual says:
Microphone: rear speakers
Audio:=A0=A0front speakers
S/PDIF:=A0center and subwoofer =A0
Modprobing without any options gives me sound to the headphone and digital =

socket and =

Modprobing with model=3D6stack-hp gives me sound to the speakers to but the=
y =

stay on when headph. are pluged in

Output from alsa-info.sh:
http://pastebin.ca/772406

Output from lspci -vv:
00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio =

Controller (rev 03)
=A0 =A0 =A0 =A0 Subsystem: Mitac Unknown device 8253
=A0 =A0 =A0 =A0 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr- =

Stepping- SERR+ FastB2B-
=A0 =A0 =A0 =A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TA=
bort- =

<TAbort- <MAbort- >SERR- <PERR-
=A0 =A0 =A0 =A0 Latency: 0, Cache Line Size: 64 bytes
=A0 =A0 =A0 =A0 Interrupt: pin A routed to IRQ 22
=A0 =A0 =A0 =A0 Region 0: Memory at fc200000 (64-bit, non-prefetchable) [si=
ze=3D16K]
=A0 =A0 =A0 =A0 Capabilities: [50] Power Management version 2
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D55=
mA =

PME(D0+,D1-,D2-,D3hot+,D3cold+)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 =
PME-
=A0 =A0 =A0 =A0 Capabilities: [60] Message Signalled Interrupts: Mask- 64bi=
t+ =

Queue=3D0/0 Enable-
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Address: 0000000000000000 =A0Data: 0000
=A0 =A0 =A0 =A0 Capabilities: [70] Express Unknown type IRQ 0
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Device: Supported: MaxPayload 128 bytes, Ph=
antFunc 0, ExtTag-
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Device: Latency L0s <64ns, L1 <1us
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Device: Errors: Correctable- Non-Fatal- Fat=
al- Unsupported-
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr-=
 NoSnoop+
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Device: MaxPayload 128 bytes, MaxReadReq 12=
8 bytes
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Link: Supported Speed unknown, Width x0, AS=
PM unknown, Port 0
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Link: Latency L0s <64ns, L1 <1us
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Link: ASPM Disabled CommClk- ExtSynch-
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Link: Speed unknown, Width x0
=A0 =A0 =A0 =A0 Capabilities: [100] Virtual Channel
=A0 =A0 =A0 =A0 Capabilities: [130] Unknown (5)

thank you.
