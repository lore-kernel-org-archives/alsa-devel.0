From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000712]: Setting <4 channels in surround40 fails
Date: Sat, 19 Mar 2005 16:34:07 +0100
Message-ID: <76508f785b883e8124bfa5296ee1fa15@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0824C1D5
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 16:34:08 +0100 (MET)
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
Last Modified:              03-19-2005 16:34 CET
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

----------------------------------------------------------------------
 darkbrain - 12-07-04 18:51 
----------------------------------------------------------------------
BTW with cmipci driver it's possible. There is an incompatibility with
openal witch try to open 2 channels without luck.

----------------------------------------------------------------------
 tiwai - 12-07-04 18:54 
----------------------------------------------------------------------
No, cmipci driver doesn't do it, too.

----------------------------------------------------------------------
 darkbrain - 12-07-04 18:59 
----------------------------------------------------------------------
I'll investigate better into openal source tree.

----------------------------------------------------------------------
 jdthood - 03-19-05 16:34 
----------------------------------------------------------------------
Submitter: Is there still an issue here or can this report be closed?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-07-04 18:36 darkbrain      New Issue                                    
12-07-04 18:42 tiwai          Note Added: 0002757                          
12-07-04 18:51 darkbrain      Note Added: 0002759                          
12-07-04 18:54 tiwai          Note Added: 0002761                          
12-07-04 18:59 darkbrain      Note Added: 0002762                          
03-19-05 16:34 jdthood        Note Added: 0004056                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
