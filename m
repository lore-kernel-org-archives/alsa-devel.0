From: Hans-Juergen Lange <hjl@simulated-universe.de>
Subject: Creative XFi not working CA0110 IBG
Date: Mon, 20 Sep 2010 15:48:26 +0200
Message-ID: <4C97662A.2040505@simulated-universe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.fubb.de (mail.fubb.de [78.46.67.120])
	by alsa0.perex.cz (Postfix) with ESMTP id D7AA2103840
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Sep 2010 15:48:32 +0200 (CEST)
Received: from [85.183.55.49] (helo=[192.168.10.10])
	by mail.fubb.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hjl@simulated-universe.de>)
	id 1OxgjL-00059Q-UW
	for alsa-devel@alsa-project.org; Mon, 20 Sep 2010 15:48:28 +0200
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

I did make the failure to not check before buy, but because the last 
problem reports are from about a year ago, I think the card should work.


-- from lspci

86:00.0 Audio device [0403]: Creative Labs [SB X-Fi Xtreme Audio] 
CA0110-IBG [1102:0009]
       Subsystem: Creative Labs Device [1102:0018]
       Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B+ DisINTx-
       Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
       Interrupt: pin A routed to IRQ 18
       Region 0: Memory at d0100000 (32-bit, non-prefetchable) [size=16K]
       Capabilities: [dc] Power Management version 3
               Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
               Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
       Kernel modules: snd-hda-intel

-- 

The kernel is a 64-Bit linux-2.6.33.2 original unpatched from kernel.org

The mainboard is a Tyan S4985E.
I dont want to fill up the message with boot log and all that stuff 
before there is a need.

I am willing to help to find the problem in nearly any way because this 
is my workstation and I do need the PCI slot for some other purpose so 
I   do want to get this card working.

the alsa driver snd-hda-intel gives the following messages.

[ 3361.622125] hda-intel: spurious response 0x0:0x0, last cmd=0x000000
[ 3361.622125] hda-intel: spurious response 0x0:0x0, last cmd=0x000000
[ 3361.622125] hda-intel: spurious response 0x0:0x0, last cmd=0x000000
[ 3361.622125] hda-intel: spurious response 0x0:0x0, last cmd=0x000000
[ 3361.622125] hda-intel: spurious response 0x0:0x0, last cmd=0x000000
[ 3361.622125] hda-intel: spurious response 0x0:0x0, last cmd=0x000000
[ 3361.622125] hda-intel: spurious response 0x0:0x0, last cmd=0x000000
[ 3361.622125] hda-intel: spurious response 0x0:0x0, last cmd=0x000000
[ 3361.622125] hda-intel: spurious response 0x0:0x0, last cmd=0x000000
[ 3361.622125] hda-intel: spurious response 0x0:0x0, last cmd=0x000000
[ 3361.622125] hda-intel: spurious response 0x0:0x0, last cmd=0x000000
[ 3361.622125] hda-intel: spurious response 0x0:0x0, last cmd=0x000000
[ 3361.622125] hda-intel: spurious response 0x0:0x0, last cmd=0x000000

and with a quick look into the kernel I would think that the driver has 
a wrong idea about the interrupts received and the work that has to be 
done.

More Infos infos if needed.

Any help would be great.


BR
Hans-Juergen Lange
