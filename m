From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000206]: Segmentation fault when trying to start envy24control
Date: Sun, 5 Dec 2004 12:44:11 +0100
Message-ID: <893579eea828a11dd51e749d1a341f98@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1A5EA353
	for <alsa-devel@alsa-project.org>; Sun,  5 Dec 2004 12:44:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=206> 
======================================================================
Reported By:                vulture99
Assigned To:                
======================================================================
Project:                    ALSA - tools
Issue ID:                   206
Category:                   envy24control
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-13-2004 04:56 CEST
Last Modified:              12-05-2004 12:44 CET
======================================================================
Summary:                    Segmentation fault when trying to start
envy24control
Description: 
envy24control was working fine for me yesterday (not sure which version of
alsa I was using - probably 1.0.3 or 1.0.2).  Today I updated to 1.0.4 via
apt-get using the standard Fedora packages from the kernel.org mirror, and
when I try to run envy24control, I get a segmentation fault.  I am using
an M-Audio Audiophile 2496 sound card.
======================================================================

----------------------------------------------------------------------
 tiwai - 04-16-04 12:03 
----------------------------------------------------------------------
could you build envy24control with gcc debug option and
trace the segfault via gdb?

----------------------------------------------------------------------
 shadow - 12-05-04 12:44 
----------------------------------------------------------------------
i experienced this sporadically with envy24control from cvs today
(20041205).  i  don't know what the cause is, but when i ran in gdb it
would crash with an assertion failure somewhere in the driver.  when i ran
with argument '-m3' it began to work again.  it looks like this issue for
me was different except i share a similar sound device.  i have the 
1010lt delta by m-audio.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-13-04 04:56 vulture99      New Issue                                    
04-13-04 04:58 vulture99      Note Added: 0000786                          
04-13-04 22:37 vulture99      Note Added: 0000799                          
04-16-04 12:03 tiwai          Note Added: 0000835                          
12-05-04 12:44 shadow         Note Added: 0002720                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
