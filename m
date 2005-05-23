From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001095]: 'alsamixer' segfaults with M-Audio Revolution 7.1
Date: Mon, 23 May 2005 21:26:45 +0200
Message-ID: <b7b025bc0449474e6d3ad886f26d4077@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AEEE2241
	for <alsa-devel@alsa-project.org>; Mon, 23 May 2005 21:26:45 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1095> 
======================================================================
Reported By:                sst4
Assigned To:                perex
======================================================================
Project:                    ALSA - utils
Issue ID:                   1095
Category:                   alsamixer
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-07-2005 21:12 CEST
Last Modified:              05-23-2005 21:26 CEST
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

----------------------------------------------------------------------
 perex - 05-23-05 21:26 
----------------------------------------------------------------------
Should be fixed in CVS (not in 0.9.0rc4).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-07-05 21:12 sst4           New Issue                                    
05-23-05 21:26 perex          Status                   new => resolved     
05-23-05 21:26 perex          Resolution               open => fixed       
05-23-05 21:26 perex          Assigned To               => perex           
05-23-05 21:26 perex          Note Added: 0004706                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
