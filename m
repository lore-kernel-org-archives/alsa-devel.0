From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002208]: No sound from Laptop
Date: Thu, 15 Jun 2006 06:06:39 +0200
Message-ID: <1bd378999cf7269f3a6c25c7c0d82fd5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8C19D193
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jun 2006 06:06:39 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2208> 
======================================================================
Reported By:                paragn
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   2208
Category:                   alsamixer
Reproducibility:            have not tried
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-14-2006 07:25 CEST
Last Modified:              06-15-2006 06:06 CEST
======================================================================
Summary:                    No sound from Laptop
Description: 
On newly installed FC5 OS on IBM R52 laptop, i am not able to listen a
sound. The problem happened when i played with alsamixer. I want to check
what Headphone Jack Sense and Line Jack Sense functions are? i was able to
listen thru' headphone as well as laptop's speaker but after making a lot
of changes like mutting headphone/mutting other controls/unmutting them
and each time executing alsactl store. I lost my sound.
======================================================================

----------------------------------------------------------------------
 rlrevell - 06-14-06 07:30 
----------------------------------------------------------------------
Locate your asound.state file, remove it, then reboot.  After booting,
unmute and raise volumes like you did the first time.  It should work.

----------------------------------------------------------------------
 paragn - 06-15-06 06:06 
----------------------------------------------------------------------
thanks it worked

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-14-06 07:25 paragn         New Issue                                    
06-14-06 07:25 paragn         File Added: scsound.log                      
06-14-06 07:30 rlrevell       Note Added: 0010206                          
06-15-06 06:06 paragn         Note Added: 0010233                          
======================================================================
