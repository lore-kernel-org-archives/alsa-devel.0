From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000305]: sound is locked up after suspend/resume (APM)
Date: Wed, 23 Mar 2005 00:39:26 +0100
Message-ID: <f31040ce5e05d57883dcac37e374adb9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 899CF297
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 00:39:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=305> 
======================================================================
Reported By:                klausr
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   305
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             Debian kernel 2.6.5-4-686
======================================================================
Date Submitted:             05-25-2004 14:49 CEST
Last Modified:              03-23-2005 00:39 CET
======================================================================
Summary:                    sound is locked up after suspend/resume (APM)
Description: 
Until recently I was running oss driver cs46xx without a problem. I could
suspend in the middle of playback and xmms would keep playing after resume
as if nothing happend at all.
After switching to the 2.6 kernel, currently running 2.6.5, I also
switched to ALSA beeing the new sound architecture of choice.
Unforunately now when I suspend and resume my notebook sound stops working
at all. Sometimes unloading all ALSA modules helps, sometimes even that is
not possible anymore.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000226 Sound hangs after APM resume
======================================================================

----------------------------------------------------------------------
 jdthood - 01-17-05 10:57 
----------------------------------------------------------------------
> one difference though. with alsa output plugin when i press pause in xmms
to
> pause music pressing pause again does not work.

This is probably a separate bug.  See
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=495, for example.

Note that this bug (re: snd-cs46xx not working after suspend-'n'-resume)
can probably be merged with ALSA bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=226.

----------------------------------------------------------------------
 rlrevell - 03-23-05 00:39 
----------------------------------------------------------------------
Make sure to turn off all "Fast Boot" BIOS options on Thinkpads.  Otherwise
you may have bizarre sound problems.  This advice is from Alan Cox.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-25-04 14:49 klausr         New Issue                                    
05-25-04 14:49 klausr         Kernel Version            => Debian kernel
2.6.5-4-686
05-25-04 15:02 tiwai          Note Added: 0001213                          
05-25-04 15:31 klausr         Note Added: 0001215                          
05-25-04 15:59 klausr         Note Added: 0001217                          
05-25-04 16:02 klausr         Issue Monitored: klausr                      
05-25-04 16:05 tiwai          Note Added: 0001218                          
05-25-04 16:44 klausr         Note Added: 0001220                          
05-25-04 16:56 klausr         Note Edited: 0001220                         
05-27-04 08:49 klausr         Issue End Monitor: klausr                    
05-28-04 17:08 tiwai          Note Added: 0001269                          
05-29-04 09:36 klausr         Note Added: 0001276                          
01-17-05 10:57 jdthood        Note Added: 0003226                          
03-22-05 15:02 jdthood        Relationship added       has duplicate 0000226
03-23-05 00:39 rlrevell       Note Added: 0004145                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
