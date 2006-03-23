From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001423]: dxs_support=5 works on EPoX EP-8KRAI
Date: Thu, 23 Mar 2006 17:11:52 +0100
Message-ID: <7bed08c4fe107d630ec90d2298da9ab8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CFA991BB
	for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2006 17:11:52 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1423> 
======================================================================
Reported By:                wrar
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1423
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-15-2005 19:06 CEST
Last Modified:              03-23-2006 17:11 CET
======================================================================
Summary:                    dxs_support=5 works on EPoX EP-8KRAI
Description: 
I set options snd-via82xx dxs_support=5  and didn't encounter any sound
problems. I use ALSA 1.0.9b from kernel 2.6.13.

I have EPoX EP-8KRAI on KT600/8237:

$ lspci -vvx
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
        Subsystem: EPoX Computer Co., Ltd.: Unknown device 300c
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin C routed to IRQ 185
        Region 0: I/O ports at e700
        Capabilities: <available only to root>
00: 06 11 59 30 01 00 10 02 60 00 01 04 00 00 00 00
10: 01 e7 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 95 16 0c 30
30: 00 00 00 00 c0 00 00 00 00 00 00 00 09 03 00 00

$ lspci -vn
0000:00:11.5 Class 0401: 1106:3059 (rev 60)
        Subsystem: 1695:300c

======================================================================

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:09 
----------------------------------------------------------------------
Can someone look at this?

----------------------------------------------------------------------
 tiwai - 03-23-06 17:11 
----------------------------------------------------------------------
Fixed on CVS.  WIll appear in 1.0.11-final.
Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-15-05 19:06 wrar           New Issue                                    
03-22-06 03:09 rlrevell       Note Added: 0008798                          
03-23-06 17:11 tiwai          Status                   new => resolved     
03-23-06 17:11 tiwai          Resolution               open => fixed       
03-23-06 17:11 tiwai          Assigned To               => tiwai           
03-23-06 17:11 tiwai          Note Added: 0008892                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
