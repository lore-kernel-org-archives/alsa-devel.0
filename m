From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000496]: nearest-neighbor downsampling causes noise
Date: Thu, 16 Sep 2004 11:24:14 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040916092414.282163F01A@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7D08A2FC
	for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2004 11:25:55 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000496
======================================================================
Reported By:                grabner
Assigned To:                
======================================================================
Project:                    ALSA - lib
Bug ID:                     496
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-10-2004 22:06 CEST
Last Modified:              09-16-2004 11:24 CEST
======================================================================
Summary:                    nearest-neighbor downsampling causes noise
Description: 
The rate-conversion plugin in ALSA-1.0.7rc1 uses the nearest-neighbor
method for downsampling (function snd_pcm_rate_shrink in
src/pcm/pcm_rate.c), which causes considerable noise.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-15-2004 18:18 CEST 
----------------------------------------------------------------------
The patch looks fine.

Could you provide the summary, description and signed-off-by
for the patch to apply to ALSA CVS tree?

thanks.

----------------------------------------------------------------------
 grabner - 09-16-2004 11:24 CEST 
----------------------------------------------------------------------
Ok, here is the required information:

-----
Summary: Fix the downsampling noise problem
 
The patch replaces the nearest neighbor downsampling method in the sample
rate conversion plugin by linear interpolation of the closest two samples,
thus significantly reducing the resampling noise.
 
Signed-off-by: Markus Grabner <grabner@icg.tu-graz.ac.at>
-----

Regards,
Markus

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-10-04 22:06 grabner        New Bug                                      
09-10-04 22:06 grabner        File Added: downsample_interpolate.patch                    
09-10-04 22:08 grabner        Bug Monitored: grabner                       
09-15-04 18:18 tiwai          Bugnote Added: 0001763                       
09-16-04 11:24 grabner        Bugnote Added: 0001768                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
