From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001360]: 16bit mono -> 24bit stereo conversion (plughw) produces noise in right channel
Date: Wed, 21 Sep 2005 01:52:54 +0200
Message-ID: <c6a3e1e5a0311563e3d09a156ad10911@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 255F8192
	for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2005 01:52:55 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1360> 
======================================================================
Reported By:                grabner
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1360
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-22-2005 22:42 CEST
Last Modified:              09-21-2005 01:52 CEST
======================================================================
Summary:                    16bit mono -> 24bit stereo conversion (plughw)
produces noise in right channel
Description: 
The sample conversion from 16bit mono format to 24bit stereo format (using
plughw:n) produces the correct signal in the left channel, but only noise
in the right channel.
======================================================================

----------------------------------------------------------------------
 grabner - 09-11-05 03:01 
----------------------------------------------------------------------
Unfortunately the problem still exists. I did "cvs update" and recompile
the library several times, but nothing changed.

----------------------------------------------------------------------
 grabner - 09-21-05 01:52 
----------------------------------------------------------------------
Ok, I overlooked that the libraries get installed in /usr/lib by default
even on the AMD64 platform (instead of /usr/lib64), so the new libraries
were never used :-( After explicitly forcing installation in /usr/lib64,
the noise in the right channel is no longer present.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-22-05 22:42 grabner        New Issue                                    
08-23-05 16:25 tiwai          Note Added: 0005906                          
08-24-05 00:15 grabner        Note Added: 0005919                          
09-02-05 19:14 tiwai          Note Added: 0006013                          
09-11-05 03:01 grabner        Note Added: 0006133                          
09-21-05 01:52 grabner        Note Added: 0006319                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
