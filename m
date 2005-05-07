From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001095]: 'alsamixer' segfaults with M-Audio Revolution 7.1
Date: Sat, 7 May 2005 21:12:50 +0200
Message-ID: <4ceffbe62475c09d5a9b16a4a8e4fb1d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 51CF9234
	for <alsa-devel@alsa-project.org>; Sat,  7 May 2005 21:12:50 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1095> 
======================================================================
Reported By:                sst4
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1095
Category:                   alsamixer
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-07-2005 21:12 CEST
Last Modified:              05-07-2005 21:12 CEST
======================================================================
Summary:                    'alsamixer' segfaults with M-Audio Revolution 7.1
Description: 
'alsamixer' crashes with

Segmentation fault

message when F4 (capture view) is pressed.

The audio card is M-Audio Revolution 7.1.

'alsamixer -V capture' produces this:

"
[root <at> athlon ~]# alsamixer -V capture
No mixer elems found

[root <at> athlon ~]#
".

System configuration and ALSA configuration can be seen in these posts of
mine:

http://sourceforge.net/mailarchive/forum.php?thread_id=7195261&forum_id=1751
http://sourceforge.net/forum/forum.php?thread_id=1276291&forum_id=86660
.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-07-05 21:12 sst4           New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
