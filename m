From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000305]: sound is locked up after suspend/resume (APM)
Date: Mon, 17 Jan 2005 10:57:32 +0100
Message-ID: <362e8758ff392bfd1d5de4270181e38f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 33E041DC
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2005 10:57:32 +0100 (MET)
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
Last Modified:              01-17-2005 10:57 CET
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

----------------------------------------------------------------------
 klausr - 05-29-04 09:36 
----------------------------------------------------------------------
sound hangs with both output plugins, alsa and oss. in both cases sound is
back after closing xmms, unloading snd-cs46xx module and loading it
again.

one difference though. with alsa output plugin when i press pause in xmms
to pause music pressing pause again does not work. the playing just does
not start. i have to press play, then the playing starts again but from
the beginning of the title.

with oss output plugin it works as expected. pressing pause pauses
playing. pressing pause again resumes playing at the position it was when
pausing.

regards
klaus

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
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
