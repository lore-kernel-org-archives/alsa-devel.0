From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001843]: regression: no sound with sigmatel stac9200, works in alsa 1.0.10
Date: Mon, 20 Mar 2006 02:48:24 +0100
Message-ID: <19598cd08e5966f5e5d5fa1b15ce95bf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3C4DB1F1
	for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2006 02:48:24 +0100 (MET)
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
Last Modified:              03-20-2006 02:48 CET
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
 richardfish - 03-20-06 02:08 
----------------------------------------------------------------------
I have debugged why this didn't work for my Dell e1705.  It seems this
model reports 2 speaker pins, and no line outs.  But only the first
speaker pin actually seems to result in speaker output...the second needs
to be ignored.

The attached patch rjf-ignore-extra-speakers.diff provides a fix.

Also, one of the debug print statements in fix3 is incorrect. 
rjf-fix-debug-print.diff provides a fix.

----------------------------------------------------------------------
 richardfish - 03-20-06 02:48 
----------------------------------------------------------------------
The other possibility for the e1705 is to treat the extra speaker pins as
line_outs.  But it is necessary to add some speaker_pin handling to
patch_sigmatel.c for that.  See rjf-extra-speakers-as-lineouts.diff.

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
03-18-06 05:22 richardfish    Note Added: 0008669                          
03-18-06 12:41 gsmet          Note Added: 0008670                          
03-18-06 12:43 gsmet          Issue Monitored: gsmet                       
03-19-06 11:56 lrupn          Note Added: 0008688                          
03-20-06 02:08 richardfish    Note Added: 0008704                          
03-20-06 02:09 richardfish    File Added: rjf-ignore-extra-speakers.diff        
           
03-20-06 02:09 richardfish    File Added: rjf-fix-debug-print.diff              
     
03-20-06 02:48 richardfish    Note Added: 0008705                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
