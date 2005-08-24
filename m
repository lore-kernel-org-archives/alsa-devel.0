From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001254]: "invalid argument" error when pressing tab
Date: Wed, 24 Aug 2005 18:15:51 +0200
Message-ID: <3a941ecba5242dd2afe07b85adc8f83b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D9D7D24F
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2005 18:15:51 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1254> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1254
Category:                   alsamixer
Reproducibility:            have not tried
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-12-2005 15:31 CEST
Last Modified:              08-24-2005 18:15 CEST
======================================================================
Summary:                    "invalid argument" error when pressing tab
Description: 
when pressing <Tab> in alsamixer, the program exits with:

$ alsamixer
alsamixer: function snd_mixer_find_selem() failed: Invalid argument

$ echo $?
2

Pressing <F4> instead, the program stays in playback mode.

trying to run in capture mode:
$ alsamixer -V capture
No mixer elems found


======================================================================

----------------------------------------------------------------------
 jdthood - 08-24-05 18:15 
----------------------------------------------------------------------
+ alsamixer
    - Summary: Fix unexpected abort of alsamixer
      Fixed unexpected abort of alsamixer when no playback or capture
elements
      are available.  Also fixed the wrong use of temporary array in
      displaying item name.

Is the change reported a fix for the bug reported here?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-12-05 15:31 jdthood        New Issue                                    
08-24-05 18:15 jdthood        Note Added: 0005932                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
