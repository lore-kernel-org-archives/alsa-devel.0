From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000496]: nearest-neighbor downsampling causes noise
Date: Wed, 15 Sep 2004 18:18:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040915161801.CBCAA47007@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 36B5C309
	for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2004 18:18:02 +0200 (MEST)
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
Last Modified:              09-15-2004 18:18 CEST
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

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-10-04 22:06 grabner        New Bug                                      
09-10-04 22:06 grabner        File Added: downsample_interpolate.patch                    
09-10-04 22:08 grabner        Bug Monitored: grabner                       
09-15-04 18:18 tiwai          Bugnote Added: 0001763                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
