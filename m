From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002004]: Via say unknown codec on FSC Amilo 1667G
Date: Mon, 10 Apr 2006 17:01:47 +0200
Message-ID: <76a7db0dc173b6b76a892b9647aced45@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0A2C7184
	for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2006 17:01:47 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2004> 
======================================================================
Reported By:                deathlove23
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2004
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.16
======================================================================
Date Submitted:             04-05-2006 18:40 CEST
Last Modified:              04-10-2006 17:01 CEST
======================================================================
Summary:                    Via say unknown codec on FSC Amilo 1667G
Description: 
Hello,
 
I have a Notebook from FSC: Amilo 1667G
and is get thes messages in boot bzw. on dmesg:

---
ALSA device list:
#0: VIA 8237 with unknown codec at 0xc800, irq 50
---

my Alsa Kernel config is:

---
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_MPU401_UART=y
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_AC97_BUS=y
CONFIG_SND_VIA82XX=y
---

and my lspci -vv is:

---
00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
        Subsystem: Fujitsu Siemens Computer GmbH Unknown device 1093
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 50
        Region 0: I/O ports at c800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
---

can you my soundcard to the ID lists eg. another Amilio's?

Thanks
Alex - Deathlove23
======================================================================

----------------------------------------------------------------------
 deathlove23 - 04-07-06 20:21 
----------------------------------------------------------------------
thanks for you replay, i upload the Files.

----------------------------------------------------------------------
 tiwai - 04-10-06 17:01 
----------------------------------------------------------------------
Actaully, it's an unknown codec chip.  Looks like an ac97 codec from VIA,
but no idea what model is.  Do you have any information?
Also, any missing features with the current version?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-05-06 18:40 deathlove23    New Issue                                    
04-05-06 18:40 deathlove23    Distribution              => Gentoo          
04-05-06 18:40 deathlove23    Kernel Version            => 2.6.16          
04-07-06 19:21 tiwai          Note Added: 0009145                          
04-07-06 20:17 deathlove23    Issue Monitored: deathlove23                    
04-07-06 20:19 deathlove23    File Added: ac97#0-0                         
04-07-06 20:19 deathlove23    File Added: ac97#0-0+regs                    
04-07-06 20:19 deathlove23    Issue End Monitor: deathlove23                    
04-07-06 20:21 deathlove23    Note Added: 0009155                          
04-10-06 17:01 tiwai          Note Added: 0009201                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
