From: dbm <db.mo@bigpond.com>
Subject: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG
	(SB0820)
Date: Sun, 21 Feb 2010 11:41:32 +1000
Message-ID: <4B808F4C.1020904@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nskntmtas04p.mx.bigpond.com (nskntmtas04p.mx.bigpond.com
	[61.9.168.146]) by alsa0.perex.cz (Postfix) with ESMTP id 71116103800
	for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2010 02:41:42 +0100 (CET)
Received: from nskntotgx03p.mx.bigpond.com ([124.187.27.162])
	by nskntmtas04p.mx.bigpond.com with ESMTP id
	<20100221014138.QPFI1858.nskntmtas04p.mx.bigpond.com@nskntotgx03p.mx.bigpond.com>
	for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2010 01:41:38 +0000
Received: from [192.168.1.1] (really [124.187.27.162])
	by nskntotgx03p.mx.bigpond.com with ESMTP
	id <20100221014138.EUFD1978.nskntotgx03p.mx.bigpond.com@[192.168.1.1]>
	for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2010 01:41:38 +0000
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

Greetings,

  Just bought one of these to get around the fact the mobo involved 
wouldn't recognize
any soundcard plugged into either PCI slots (onboard sound disabled in 
BIOS) -- it will
however see a soundcard plugged into the pcie 1x slot.....

03:00.0 PCI bridge: Creative Labs Device 7006 (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=03, secondary=04, subordinate=04, sec-latency=32
        Memory behind bridge: ee000000-ee0fffff
        Capabilities: [50] Power Management version 3
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/4 Enable-
        Capabilities: [80] Subsystem: Creative Labs Device 0010
        Capabilities: [90] Express PCI/PCI-X Bridge, MSI 00
        Capabilities: [100] Advanced Error Reporting <?>
        Kernel modules: shpchp

04:00.0 Audio device: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG
        Subsystem: Creative Labs Device 0018
        Flags: bus master, medium devsel, latency 32, IRQ 16
        Memory at ee000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [dc] Power Management version 3
        Kernel driver in use: HDA Intel
        Kernel modules: snd-hda-intel


Does seemed to be claimed by snd-hda-intel  (vid/pid  1102/0009), but 
subsystem descriptor
of 1102/0018 is seemingly unknown by the drivers. Wild guess here is 
this should be claimed
by ctxfi.ko? I can provide a list of hardware IC's fitted to the card -- 
most of them are *not*
codec chips afaict.....that said, 2 oncard chips I cannot readily 
identify. My suspicion is it's
like other cards covered by  ctxfi.ko in that the card  has no 
ac97-codec  fitted and is just a
plain ole' sblive type card....but this is only speculation...

Anyone seens one of these, or have any idea where to start poking for 
clues (if any) to get it
working?

Cheers!
