From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000166]: strange high-pitched noise
Date: Wed, 30 Mar 2005 19:38:53 +0200
Message-ID: <87b118842a34a740f7c070e2d13df3d1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 76FE910D
	for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2005 19:38:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=166> 
======================================================================
Reported By:                lichentrope
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   166
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-29-2004 22:45 CEST
Last Modified:              03-30-2005 19:38 CEST
======================================================================
Summary:                    strange high-pitched noise
Description: 
My HW: MSI K7N2 Delta-L with integrated AC97 soundcard (intel-8x0 with
ac97_codec drivers used).

I could always hear some high-pitched noise. It is quite low in volume,
altough quite annoying when playing silent music/videos; the noise could
be best described as "wind", there is some random static audible in it.
The noise is independent from CPU load, whether some sound is being played
or not. At first I thought it was caused by heat noise from the
motherboard. Once I noticed it disappeared after reboot and reappeared
after running alsamixer to restore previous mixer settings. I played a bit
with the sound controls and found out what was the cause: the "Video"
control caused this. I had to unmute it and put it at full volume, then
the noise disappeared (strange though, I'd understand it if it were other
way round).
======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 13:05 
----------------------------------------------------------------------
It seems that there are two problems here:

* Video slider operates in reverse

* alsamixer sets Video mixer level to an inappropriate value
  without the user touching the control itself

Is that right?  Do both problems still exist in the current ALSA release?

----------------------------------------------------------------------
 jdthood - 03-30-05 19:38 
----------------------------------------------------------------------
It seems that there are two problems here:

* Video slider operates in reverse

* alsamixer sets Video mixer level to an inappropriate value
  without the user touching the control itself

Submitter: Is that right? Do both problems still exist in the current ALSA
release?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-29-04 22:45 lichentrope    New Issue                                    
03-19-05 13:05 jdthood        Note Added: 0004045                          
03-30-05 19:38 jdthood        Note Added: 0004274                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
