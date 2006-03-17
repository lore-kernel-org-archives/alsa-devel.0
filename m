From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001843]: regression: no sound with sigmatel stac9200, works in alsa 1.0.10
Date: Sat, 18 Mar 2006 00:07:49 +0100
Message-ID: <be7b4b49afc8fd45a2b5640b89b7979c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D099E1B4
	for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2006 00:07:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1843> 
======================================================================
Reported By:                richardfish
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1843
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             suspend2-sources-2.6.15-r6
======================================================================
Date Submitted:             02-13-2006 04:04 CET
Last Modified:              03-18-2006 00:07 CET
======================================================================
Summary:                    regression: no sound with sigmatel stac9200, works
in alsa 1.0.10
Description: 
With alsa 1.0.10, my Intel HDA with the Sigmatel STAC9200 produces sound
from both speakers and headphones (although the speakers are not muted
when the headphones are inserted, but that is a separate problem).  

With alsa 1.0.11rc3, and the CVS version as of today, no sound is produced
from either speakers or headphones.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001813 STAC9750 not recognised by hda-intel
has duplicate       0001729 Only output through headphone jack
======================================================================

----------------------------------------------------------------------
 tiwai - 03-17-06 21:31 
----------------------------------------------------------------------
OK, I fixed a bit more.  The final version, fix3, is uploaded.

Please let me know if this works.  Then I'll merge it to CVS soon.

----------------------------------------------------------------------
 Jeff250 - 03-18-06 00:07 
----------------------------------------------------------------------
Seems to work great.  The headphone track is gone, and the auto-muting
still works.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-06 04:04 richardfish    New Issue                                    
02-13-06 04:04 richardfish    File Added: alsa-rjf-1.patch                    
02-13-06 04:04 richardfish    Distribution              => Gentoo          
02-13-06 04:04 richardfish    Kernel Version            =>
suspend2-sources-2.6.15-r6
02-14-06 05:43 richardfish    Issue Monitored: richardfish                    
02-20-06 22:51 lrupn          Issue Monitored: lrupn                       
02-25-06 21:40 lrupn          Note Added: 0008192                          
02-26-06 16:08 toshio         Note Added: 0008203                          
02-27-06 23:45 richardfish    Note Added: 0008233                          
03-01-06 17:07 lrupn          Note Added: 0008281                          
03-01-06 17:59 mpt            Issue Monitored: mpt                         
03-17-06 00:39 tiwai          Note Added: 0008622                          
03-17-06 00:41 tiwai          File Added: hda-autoconfig-fix.diff               
    
03-17-06 01:03 tiwai          Relationship added       has duplicate 0001813
03-17-06 01:09 tiwai          Relationship added       has duplicate 0001729
03-17-06 04:55 error10        Note Added: 0008634                          
03-17-06 11:59 tiwai          Note Added: 0008637                          
03-17-06 11:59 tiwai          File Added: hda-autoconfig-fix2.diff              
     
03-17-06 12:00 tiwai          Note Added: 0008638                          
03-17-06 20:39 Jeff250        Note Added: 0008657                          
03-17-06 20:40 Jeff250        Note Edited: 0008657                         
03-17-06 20:55 tiwai          Note Added: 0008658                          
03-17-06 20:55 tiwai          File Added: stac9200-additional-fix.diff          
         
03-17-06 21:31 tiwai          Note Added: 0008660                          
03-17-06 21:31 tiwai          File Added: hda-autoconfig-fix3.diff              
     
03-18-06 00:07 Jeff250        Note Added: 0008664                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
