From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000712]: Setting <4 channels in surround40 fails
Date: Tue, 7 Dec 2004 18:42:19 +0100
Message-ID: <2f7a8cf748199bf5f86adabcf78e242c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E5E6E3AD
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2004 18:42:19 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=712> 
======================================================================
Reported By:                darkbrain
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   712
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-07-2004 18:36 CET
Last Modified:              12-07-2004 18:42 CET
======================================================================
Summary:                    Setting <4 channels in surround40 fails
Description: 
If you try
alsa-lib/test/pcm -D surround40:0
You obtain: Channels count (1) not available for playbacks: Invalid
argument
But we have 4 channels!
I've tried to find the problem into the sources without luck :(
======================================================================

----------------------------------------------------------------------
 tiwai - 12-07-04 18:42 
----------------------------------------------------------------------
This is not a bug.
surround40 is for 4 seprated channels.

If you want to duplicate 2-channel stereo signal to 4-channels, try the
CVS version.  It can have a new mixer control 'Duplicate Front'. 
Otherwise, you can do it via asoundrc (see bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=617).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-07-04 18:36 darkbrain      New Issue                                    
12-07-04 18:42 tiwai          Note Added: 0002757                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
