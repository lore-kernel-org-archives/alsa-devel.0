From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001925]: no sound from hda_intel
Date: Thu, 16 Mar 2006 17:33:07 +0100
Message-ID: <14ef5b0e7ef01de952b3c9b4c7e6c7ef@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 034AF1A1
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 17:33:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1925> 
======================================================================
Reported By:                stefanob
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1925
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Ubuntu Dapper
Kernel Version:             2.6.15-18-686 #1 SMP PREEMPT
Resolution:                 duplicate
Duplicate:                  1926
Fixed in Version:           
======================================================================
Date Submitted:             03-15-2006 14:59 CET
Last Modified:              03-16-2006 17:33 CET
======================================================================
Summary:                    no sound from hda_intel
Description: 
Alsa mixer works but i can't hear any sound. I tried the last cvs branch
with no success ( i tried also with model=laptop ).

My computer is a notebook Asus Model A6J

lspci -nv 

0000:00:1b.0 0403: 8086:27d8 (rev 02)
        Subsystem: 1043:1213
        Flags: bus master, fast devsel, latency 0, IRQ 169
        Memory at febfc000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable-
        Capabilities: [70] #10 [0091]

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001926 No sound and no internal speakers with ...
======================================================================

----------------------------------------------------------------------
 stefanob - 03-16-06 17:12 
----------------------------------------------------------------------
I tried the patch ad1986a-laptop-eapd.diff and with model=laptop-eapd sound
works now!

----------------------------------------------------------------------
 tiwai - 03-16-06 17:33 
----------------------------------------------------------------------
OK, your PCI SSID will be added when the patch is merged to upstream, so
that the model is selected automatically.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-15-06 14:59 stefanob       New Issue                                    
03-15-06 14:59 stefanob       Distribution              => Ubuntu Dapper   
03-15-06 14:59 stefanob       Kernel Version            => 2.6.15-18-686 #1 SMP
PREEMPT
03-16-06 16:01 stefanob       Issue Monitored: stefanob                    
03-16-06 16:59 tiwai          Note Added: 0008611                          
03-16-06 17:10 stefanob       File Added: codec0.txt                       
03-16-06 17:10 stefanob       File Added: codec1.txt                       
03-16-06 17:10 stefanob       File Added: asound.state                     
03-16-06 17:12 stefanob       Note Added: 0008612                          
03-16-06 17:33 tiwai          Relationship added       duplicate of 0001926
03-16-06 17:33 tiwai          Duplicate ID             0 => 1926           
03-16-06 17:33 tiwai          Status                   assigned => resolved
03-16-06 17:33 tiwai          Resolution               open => duplicate   
03-16-06 17:33 tiwai          Note Added: 0008615                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
