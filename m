From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000888]: Mic IN is not working with kernel 2.6.10 on Asus A8V Deluxe
Date: Wed, 9 Feb 2005 11:46:07 +0100
Message-ID: <9b47cb53b995a0d76a5dbe6da502b5e2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3321925E
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2005 11:46:08 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=888> 
======================================================================
Reported By:                pv2c
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   888
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.10
======================================================================
Date Submitted:             02-06-2005 18:09 CET
Last Modified:              02-09-2005 11:46 CET
======================================================================
Summary:                    Mic IN is not working with kernel 2.6.10 on Asus A8V
Deluxe
Description: 
After upgrade from kernel 2.6.9 to 2.6.10 the mic in stopped to work on my
Asus A8V Deluxe motherboard integrated soundcard. I'm using alsa kernel
module via82xx and it seems that after adding support for revision 8237 it
stops to work. So I obfuscated the
#define VIA_REV_8237        0x60
to a fake value and the mic started to work again.
======================================================================

----------------------------------------------------------------------
 pv2c - 02-06-05 18:13 
----------------------------------------------------------------------
Ups.... Forgotten to add the lspci output...
=====================
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 812a
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 209
	Region 0: I/O ports at e800
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

----------------------------------------------------------------------
 tiwai - 02-09-05 11:46 
----------------------------------------------------------------------
Could you elaborate what you exactly did?

Changing the above value shouldn't affect the behavior since it'll result
in the probe of same model.
Also, make sure that you set "Input Source" correctly to "Input1".

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-06-05 18:09 pv2c           New Issue                                    
02-06-05 18:09 pv2c           Distribution              => Gentoo          
02-06-05 18:09 pv2c           Kernel Version            => 2.6.10          
02-06-05 18:13 pv2c           Note Added: 0003526                          
02-09-05 11:46 tiwai          Note Added: 0003541                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
