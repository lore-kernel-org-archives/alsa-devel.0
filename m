From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000922]: "make install" should place libasound.so in /usr/lib64
Date: Sat, 19 Feb 2005 01:50:40 +0100
Message-ID: <b3ad48f3e21bd783883bffc77e4438f7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EB23B248
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2005 01:50:40 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=922> 
======================================================================
Reported By:                Cus
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   922
Category:                   general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-19-2005 01:50 CET
Last Modified:              02-19-2005 01:50 CET
======================================================================
Summary:                    "make install" should place libasound.so in
/usr/lib64
Description: 
In SuSE Linux, the 64-bit versions of the libs are in /usr/lib64 instead of
in /usr/lib. If the "make install" script put the just compiled
libasound.so in /usr/lib instead of /usr/lib64, then the programs will
still use the old version of libasound.so in /usr/lib64. 
So if the architecture is x86_64, then putting libasound.so in /usr/lib64
can solve this issue.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-19-05 01:50 Cus            New Issue                                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
