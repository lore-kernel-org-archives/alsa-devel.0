From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000496]: nearest-neighbor downsampling causes noise
Date: Fri, 10 Sep 2004 22:06:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040910200631.E89891D00B@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 43D90231
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2004 22:06:32 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 00AB721F96
	for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2004 22:06:32 +0200 (MEST)
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


The following bug has been SUBMITTED.
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
Last Modified:              09-10-2004 22:06 CEST
======================================================================
Summary:                    nearest-neighbor downsampling causes noise
Description: 
The rate-conversion plugin in ALSA-1.0.7rc1 uses the nearest-neighbor
method for downsampling (function snd_pcm_rate_shrink in
src/pcm/pcm_rate.c), which causes considerable noise.
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-10-04 22:06 grabner        New Bug                                      
09-10-04 22:06 grabner        File Added: downsample_interpolate.patch                    
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
