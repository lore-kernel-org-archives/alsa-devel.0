From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001886]: Problems on reboot
Date: Thu, 2 Mar 2006 15:50:17 +0100
Message-ID: <08294b391348da37800bb902d60284f2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5E3881CF
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2006 15:50:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1886> 
======================================================================
Reported By:                eric
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1886
Category:                   PCI - via82xx
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-01-2006 17:59 CET
Last Modified:              03-02-2006 15:50 CET
======================================================================
Summary:                    Problems on reboot
Description: 
Hi, i have little problem with my alsa configuration,

i use kernel 2.6.15 and alsa release 10RC3

on my configuration i use 

1 X snd-via82xx and 2 X snd-ice1724

sometime when i reboot i card as inverted and i have this udev message:

 VIA 82xx Audio: probe of 0000:00:11.5 failed with error -12

======================================================================

----------------------------------------------------------------------
 tiwai - 03-02-06 12:49 
----------------------------------------------------------------------
You have two definitions of snd-ice1724 options, and the latter one
overrides.
Combine the options for ice1724 into a single line.

----------------------------------------------------------------------
 eric - 03-02-06 15:50 
----------------------------------------------------------------------
Hi ,thanks but do you have a sample ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-01-06 17:59 eric           New Issue                                    
03-01-06 18:01 eric           Note Added: 0008285                          
03-02-06 12:49 tiwai          Note Added: 0008299                          
03-02-06 15:50 eric           Note Added: 0008312                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
