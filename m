From: Matt Flax <flatmax@ieee.org>
Subject: Changing BIOS IRQs and I/O addresses
Date: Wed, 28 May 2003 20:00:42 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030528100042.GA7426@ee.unsw.edu.au>
Reply-To: Matt Flax <flatmax@pgb.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.unsw.edu.au (smtp3.unsw.EDU.AU [149.171.96.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA14907
	for <alsa-devel@alsa-project.org>; Wed, 28 May 2003 11:15:28 +0200
Received: from smtp.unsw.edu.au (antivirus-01.services.comms.unsw.EDU.AU [149.171.193.80])
	by smtp3.unsw.edu.au (8.11.2/8.11.2) with ESMTP id h4S93vu08655
	for <alsa-devel@alsa-project.org>; Wed, 28 May 2003 19:03:57 +1000 (EST)
Received: from maillationax ([149.171.36.140])
	by smtp.unsw.edu.au (8.11.2/8.11.2) with ESMTP id h4S93tL08641
	for <alsa-devel@alsa-project.org>; Wed, 28 May 2003 19:03:57 +1000 (EST)
Received: from flatmax by maillationax with local (Exim 3.36 #1 (Debian))
	id 19Kxjf-0001wP-00
	for <alsa-devel@alsa-project.org>; Wed, 28 May 2003 20:00:43 +1000
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I have traced my problem with my sound card to the function 
'request_irq' in the intel8x0 module.

Unfortunatly the IRQ is set up by the BIOS to be 0.
This bios does not let the user alter the IRQs.

Can anyone tell me how to change the IRQ manually ?

Here is some extended info about the card :
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] 
SiS7012 PCI Audio Accelerator (rev a0)
        Subsystem: CLEVO/KAPOK Computer: Unknown device 0400
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 0
        Region 0: I/O ports at 1c00 [disabled] [size=256]
        Region 1: I/O ports at 1800 [disabled] [size=128]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

thanks
Matt
-- 
http://mffm.ee.unsw.edu.au

WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
Vector Bass                : http://mffmvectorbass.sourceforge.net/
Multimedia Time Code       : http://mffmtimecode.sourceforge.net/


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
