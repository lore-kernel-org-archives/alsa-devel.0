From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000922]: "make install" should place libasound.so in /usr/lib64
Date: Fri, 8 Jul 2005 10:35:01 +0200
Message-ID: <93df3c05a95f5782cdb1f9d319319eb4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C5F2117A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:35:01 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=922> 
======================================================================
Reported By:                Cus
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   922
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             02-19-2005 01:50 CET
Last Modified:              07-08-2005 10:35 CEST
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

----------------------------------------------------------------------
 tiwai - 02-22-05 14:37 
----------------------------------------------------------------------
Pass --libdir=/usr/lib64 to configure.
It's not a bug.  Every lib and app do in this way.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-19-05 01:50 Cus            New Issue                                    
02-22-05 14:37 tiwai          Status                   new => resolved     
02-22-05 14:37 tiwai          Resolution               open => not an issue
02-22-05 14:37 tiwai          Assigned To               => tiwai           
02-22-05 14:37 tiwai          Note Added: 0003702                          
02-22-05 14:37 tiwai          Assigned To              tiwai =>            
07-08-05 10:35 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
