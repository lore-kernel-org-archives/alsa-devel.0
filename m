From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000528]: Please support ADPCM
Date: Fri, 24 Sep 2004 05:52:02 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924035202.4A0209005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A4AF52E1
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 05:52:02 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 5E0372623E
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 05:52:02 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000528
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - utils
Bug ID:                     528
Category:                   aplay/arecord
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-24-2004 05:52 CEST
Last Modified:              09-24-2004 05:52 CEST
======================================================================
Summary:                    Please support ADPCM
Description: 
Hi,

together with some help from Steven Kowalik, I was able to find out that
aplay fails to play some pcm encoded files. A closer look reveals that the
files, that fail to play, are encoded with ADPCM encoded. I've found some
explanation about ADPCM at these URLs:

http://www-mobile.ecs.soton.ac.uk/speech_codecs/standards/adpcm.html
http://www.hr/josip/DSP/FAQ/23.html

I would appreciate if aplay would also support those kind of pcm encoded
files. Thanks for adding that support.

Christian
======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-24-04 05:52 jdthood        New Bug                                      
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
