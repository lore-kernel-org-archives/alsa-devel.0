From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001458]: hda - High frequency noise in background and muting when changing volume
Date: Fri, 10 Mar 2006 17:10:07 +0100
Message-ID: <ae11e5b30e7ea36b29f60afc772839c8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9693B198
	for <alsa-devel@alsa-project.org>; Fri, 10 Mar 2006 17:10:08 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1458> 
======================================================================
Reported By:                andres
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1458
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               ubuntu breezy badger
Kernel Version:              2.6.12-9-386
======================================================================
Date Submitted:             09-25-2005 16:07 CEST
Last Modified:              03-10-2006 17:10 CET
======================================================================
Summary:                    hda - High frequency noise in background and muting
when changing volume
Description: 
When i play sound i hear a high (constant) frequency beep additionally to
what i intend to play. I also tried to set position_fix=[0,1,2] and model,
but that didnt help (for both, related?, problems)
If i change volume via alsamixer no sound can be heard anymore till i
unload and load the snd_hda_intel module.

Thanks for helping

Andres

======================================================================

----------------------------------------------------------------------
 tiwai - 03-10-06 16:38 
----------------------------------------------------------------------
Try the patch and model option described in #1841.

----------------------------------------------------------------------
 andres - 03-10-06 17:10 
----------------------------------------------------------------------
Will do, as soon as i get my hands on the hardware again. Unfortunately
this is two or three weeks away (its not my laptop...)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-25-05 16:07 andres         New Issue                                    
09-25-05 16:07 andres         Distribution              => ubuntu breezy badger
09-25-05 16:07 andres         Kernel Version            =>  2.6.12-9-386   
09-25-05 16:12 andres         Issue Monitored: andres                      
09-28-05 10:12 andres         Note Added: 0006407                          
09-28-05 10:12 andres         Note Added: 0006408                          
09-28-05 13:30 andres         Note Deleted: 0006408                        
10-18-05 11:22 cartman        Issue Monitored: cartman                     
11-24-05 20:36 marcel         Note Added: 0006844                          
12-05-05 19:59 marcel         Issue Monitored: marcel                      
01-25-06 20:52 Ka-Ka          Issue Monitored: Ka-Ka                       
02-07-06 00:48 gerick         Issue Monitored: gerick                      
02-08-06 13:15 simonckenyon   Issue Monitored: simonckenyon                    
03-10-06 16:29 sova           Issue Monitored: sova                        
03-10-06 16:31 sova           Note Added: 0008403                          
03-10-06 16:38 tiwai          Note Added: 0008404                          
03-10-06 17:10 andres         Note Added: 0008405                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
