From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000429]: Feature: Ability to cap the volume
Date: Sat, 31 Dec 2005 07:26:58 +0100
Message-ID: <89ff6284d3500bb5b254bebac079cce3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A901A17A
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 07:26:58 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=429> 
======================================================================
Reported By:                morgoth
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   429
Category:                   alsamixer
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-07-2004 23:39 CEST
Last Modified:              12-31-2005 07:26 CET
======================================================================
Summary:                    Feature: Ability to cap the volume
Description: 
For my soundcard (SB Live! 1024) I can't have the PCM higher then 74%
before I get some werd noises. If there was a way to cap or lock the
volume so that _no_ programs (like xmms or mplayer) could turn it higher.
That would be great :)
I don't know why all programs try to adjust the PCM instead of Master or
any of the others. But a cap would be a start ;)
======================================================================

----------------------------------------------------------------------
 afran - 08-08-04 19:52 
----------------------------------------------------------------------
Just wanted to say that I have the same problem here with my Soundblaster
Live 5.1. Unfortunately, I don't know how to solve this: but in any case,
internally mapping the before-mentioned 74% to a mixer setting of 100%
could be a temporary solution. But of course, any real solution to this
problem would be very nice. :-)

----------------------------------------------------------------------
 rlrevell - 12-31-05 07:26 
----------------------------------------------------------------------
Is this still a problem with the latest ALSA release?  I cannot reproduce
it (setting volume to 100% with my Audigy2 ZS is loud but not distorted).

Make sure bass and treble controls are set to the middle position.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-07-04 23:39 morgoth        New Issue                                    
08-08-04 19:41 afran          Issue Monitored: afran                       
08-08-04 19:52 afran          Note Added: 0001545                          
12-31-05 07:26 rlrevell       Note Added: 0007350                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
