From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000527]: snd_pcm_set_rate_near used always
Date: Thu, 23 Sep 2004 21:43:55 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040923194355.598563E00F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A97061B5
	for <alsa-devel@alsa-project.org>; Thu, 23 Sep 2004 21:43:55 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 6BB3527211
	for <alsa-devel@alsa-project.org>; Thu, 23 Sep 2004 21:43:55 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000527
======================================================================
Reported By:                AKennedy
Assigned To:                
======================================================================
Project:                    ALSA - utils
Bug ID:                     527
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-23-2004 21:43 CEST
Last Modified:              09-23-2004 21:43 CEST
======================================================================
Summary:                    snd_pcm_set_rate_near used always
Description: 
When selecting to record using a speific device, say hw1,0, this craps out.
. . using plughw1,0 or default works, however.  Should this have an if
statement to control if the device selected is hw/can you _near if the
device is NOT default or plughw?
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-23-04 21:43 AKennedy       New Bug                                      
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
