From: "Philipp E. Letschert" <letschert@scsteam.de>
Subject: Intel HDA (ICH8) unsupported model?
Date: Sun, 27 Jan 2008 19:31:33 +0100
Message-ID: <479CCE05.7000009@scsteam.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 788691037EA
	for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2008 19:31:34 +0100 (CET)
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

This is for the Zepto Znote 6224W Notebook (and probably others):

lspci -v

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio 
Controller (rev 03)
        Subsystem: Inventec Corporation Unknown device 0040
        Flags: bus master, fast devsel, latency 0, IRQ 22
        Memory at f0500000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)

lspci -vvn

00:1b.0 0403: 8086:284b (rev 03)
        Subsystem: 1170:0040
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 22
        Region 0: Memory at f0500000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express Unknown type IRQ 0
                Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag-
                Device: Latency L0s <64ns, L1 <1us
                Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                Link: Supported Speed unknown, Width x0, ASPM unknown, 
Port 0
                Link: Latency L0s <64ns, L1 <1us
                Link: ASPM Disabled CommClk- ExtSynch-
                Link: Speed unknown, Width x0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)


Enabling sound caused some headaches. I finally ended with kernel 2.6.24 
and alsa 1.0.16rc1. The card was autodetected as Realtec ALC268, but no 
sound output.

Using  option model=toshiba instead, when loading the snd-hda-intel 
module did work, but sound has a really poor quality, with lots of 
crackling noises. Enabling the samplerate plugin didnt help...

Please let me know, if this card is already supported and I just have 
errors in my configuration, or further informations are helpful for 
develepment.


Thanks,
Phil
