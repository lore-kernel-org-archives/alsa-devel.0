From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001361]: sound choppy when resuming alsa client process
Date: Mon, 14 Nov 2005 09:58:05 +0100
Message-ID: <18e02c9eed8fd2ab59384fc8a5ab1636@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5B7C219D
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 09:58:05 +0100 (MET)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1361> 
======================================================================
Reported By:                mbwardle
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1361
Category:                   1_pcm_d - direct PCM plugins (dmix+)
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
======================================================================
Date Submitted:             08-23-2005 12:39 CEST
Last Modified:              11-14-2005 09:58 CET
======================================================================
Summary:                    sound choppy when resuming alsa client process
Description: 
If I start an ALSA client process from a terminal, begin playback of a
song, suspend the process, then resume the process, the playback becomes
choppy (has many intermittent periods of silence per second).

A possibly related similar problem seems to occur if there is a runaway
process on the system which starves the ALSA client of CPU time.  Even
after the client gets a good slice of CPU time, the sound remains choppy.

This issue was originally reported as a bug in Ubuntu Linux
<http://bugzilla.ubuntu.com/show_bug.cgi?id=13003>.

======================================================================

----------------------------------------------------------------------
 perex - 11-14-05 09:58 
----------------------------------------------------------------------
Could you try 1.0.10rc3 alsa-lib package?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-23-05 12:39 mbwardle       New Issue                                    
08-23-05 12:39 mbwardle       File Added: asound.conf                      
11-14-05 09:58 perex          Note Added: 0006699                          
11-14-05 09:58 perex          Status                   assigned => feedback
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
