From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000332]: Unable to enable 'Mic as Center/LFE'
Date: Thu, 30 Jun 2005 13:52:17 +0200
Message-ID: <f37c51e223375360e225d0b0393d59f0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 11EAD1AC
	for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2005 13:52:17 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=332> 
======================================================================
Reported By:                Johan Gorter
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   332
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
======================================================================
Date Submitted:             06-11-2004 09:12 CEST
Last Modified:              06-30-2005 13:52 CEST
======================================================================
Summary:                    Unable to enable 'Mic as Center/LFE'
Description: 
In the alsa versions I have used thus far (1.0.3 and 1.0.5) I am unable to
enable the 'Mic as Center/LFE' option of my onboard AC '97. Alsamixer
cannot change its value from 0 and record / mute is also disabled. I
tracked the problem by using alsactl to store the settings. This results
in a file where this option (nr 47 on my system) is an Integer with the
comment that the value may be from 0 to 0. On other systems I found out
that this is supposed to be a Boolean which can be switched on and off.
======================================================================

----------------------------------------------------------------------
 jdthood - 06-08-05 20:40 
----------------------------------------------------------------------
I asked the submitter of Debian bug report
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=307087 to test alsa-utils
version 1.0.9a.  He says:

The bug seems to be half fixed: in [All] mode of alsamixer it is still
[not] present (no control to select Mic for recording), while in [Capture]
mode the control is present.  Also the recording volume is very low, even
at 100%, but this might be because of the sound card (though I don't now
how to check that).

----------------------------------------------------------------------
 jdthood - 06-30-05 13:52 
----------------------------------------------------------------------
I am waiting for the submitter of the Debian bug report to confirm that the
control really does not appear in the "capture" view.  I find that a bit
hard to believe.

If there are no further additions to this report in a couple of weeks then
please feel free to close it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-11-04 09:12 Johan Gorter   New Issue                                    
01-22-05 03:26 rhal           Issue Monitored: rhal                        
03-20-05 15:45 jdthood        Note Added: 0004093                          
03-31-05 20:23 jdthood        Note Added: 0004284                          
05-02-05 11:10 jdthood        Note Added: 0004584                          
06-08-05 20:40 jdthood        Note Added: 0004972                          
06-30-05 13:52 jdthood        Note Added: 0005325                          
06-30-05 13:52 jdthood        Status                   new => feedback     
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
