From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000689]: No Optical output/toslink on riser card for Envy 24PT onboard
Date: Mon, 29 Nov 2004 15:12:29 +0100
Message-ID: <7a5a0eccdbdd2a35d247efb5d254a03f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E49A1176
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2004 15:12:29 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=689> 
======================================================================
Reported By:                bana
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   689
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core
Kernel Version:             2.6.9
======================================================================
Date Submitted:             11-29-2004 02:17 CET
Last Modified:              11-29-2004 15:12 CET
======================================================================
Summary:                    No Optical output/toslink on riser card for Envy
24PT onboard
Description: 
After getting my sound working for my headphones for my onboard Envy24PT
soundcard (on a Chaintech ZNF5-150) my optical isn't working (has never
worked). It is on a riser card off of the motherboard (a CNR slot type
card) that came with the motherboard. I have tried the different outputs
by alsaplay -D hw:0,x /home/bana/test.wav but the only thing that works is
putting in default. 
======================================================================

----------------------------------------------------------------------
 bana - 11-29-04 02:26 
----------------------------------------------------------------------
Readout of lspci -vv: 

01:0f.0 Multimedia audio controller: VIA Technologies Inc. VT1720/24
[Envy24PT/HT] PCI Multi-Channel Audio Controller (rev 01)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at c800 [size=32]
        Region 1: I/O ports at cc00 [size=128]
        Capabilities: [80] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

cat /proc/asound/cards:
0 [ZNF3150        ]: ICE1724 - Chaintech ZNF3-150
                     Chaintech ZNF3-150 at 0xc800, irq 5

----------------------------------------------------------------------
 tiwai - 11-29-04 15:12 
----------------------------------------------------------------------
It's not supported in the current driver.  We need the detailed technical
information to implement this feature, i.e. which SPDIF controller is used
(either via ac97, an independent controller or directly from envy chip)
and how is it connected with envy chip (e.g. which GPIO pins if any).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-29-04 02:17 bana           New Issue                                    
11-29-04 02:17 bana           Distribution              => Fedora Core     
11-29-04 02:17 bana           Kernel Version            => 2.6.9           
11-29-04 02:26 bana           Note Added: 0002630                          
11-29-04 02:26 bana           Issue Monitored: bana                        
11-29-04 15:12 tiwai          Note Added: 0002635                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
