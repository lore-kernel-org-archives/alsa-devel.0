From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001032]: 1.0.9rc2 causes mplayer -ao alsa to crash on startup
Date: Tue, 24 May 2005 13:55:43 +0200
Message-ID: <33173a2fe4dbeb1100c14808e0236219@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5EB351E3
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2005 13:55:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1032> 
======================================================================
Reported By:                bero
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1032
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-02-2005 16:10 CEST
Last Modified:              05-24-2005 13:55 CEST
======================================================================
Summary:                    1.0.9rc2 causes mplayer -ao alsa to crash on startup
Description: 
1.0.9rc2 causes mplayer -ao alsa to crash on startup
======================================================================

----------------------------------------------------------------------
 rlrevell - 04-05-05 21:17 
----------------------------------------------------------------------
Please try ALSA CVS.  This bug should be fixed.

----------------------------------------------------------------------
 jdthood - 05-24-05 13:55 
----------------------------------------------------------------------
Debian bug https://bugtrack.alsa-project.org/alsa-bug/view.php?id=310189 is
possibly the same bug.  With 1.0.9rc2 the submitter
found that he couldn't quit mplayer cleanly and had to kill it.  He
attached an strace.

    http://bugs.debian.org/310189

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-02-05 16:10 bero           New Issue                                    
04-02-05 16:10 bero           File Added: alsa-lib-mplayer.patch                
   
04-05-05 21:08 Toph           Note Added: 0004340                          
04-05-05 21:17 rlrevell       Note Added: 0004341                          
04-29-05 09:07 mandreiana     Issue Monitored: mandreiana                    
05-24-05 13:55 jdthood        Note Added: 0004726                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
