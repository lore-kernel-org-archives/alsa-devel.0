From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0000492]: EMU10K1 and OSS emulation PCM volume problem
Date: Thu,  9 Sep 2004 16:51:24 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040909145124.D69E114026@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 316722B7
	for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2004 16:51:25 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id E5E4721862
	for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2004 16:51:24 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000492
======================================================================
Reported By:                croiset
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Bug ID:                     492
Category:                   
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-09-2004 16:51 CEST
Last Modified:              09-09-2004 16:51 CEST
======================================================================
Summary:                    EMU10K1 and OSS emulation PCM volume problem
Description: 
when I use a sound card :
0 [Live           ]: EMU10K1 - Sound Blaster Live!
                     Sound Blaster Live! (rev.10) at 0x8400, irq 10
when I use the oss emulation, the only way to have sound on the audio
analog output, is to use the mixer call Wave (ALTPCM) instead of PCM like
other cards. The mixer I used for the test is alsamixer.

My tests are on alsa driver 1.0.5a.

======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-09-04 16:51 croiset        New Bug                                      
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
