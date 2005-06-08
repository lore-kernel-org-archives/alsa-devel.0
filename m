From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001024]: [PATCH] typos in manpages
Date: Wed, 8 Jun 2005 15:56:17 +0200
Message-ID: <b6fb8a2effa26d7204c519f07c7e3c24@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 968BF1F2
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 15:56:17 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1024> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1024
Category:                   aconnect
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-30-2005 17:16 CEST
Last Modified:              06-08-2005 15:56 CEST
======================================================================
Summary:                    [PATCH] typos in manpages
Description: 
The submitter of Debian bug report
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=302147 writes:

> Found some typos in '/usr/share/man/man1/aconnect.1.gz', see attached
'.diff'.
> Found a typo in '/usr/share/man/man1/alsamixer.1.gz', see attached
'.diff'.


He also attached two patches which I show below.

   http://bugs.debian.org/302147
======================================================================

----------------------------------------------------------------------
 jdthood - 06-05-05 10:43 
----------------------------------------------------------------------
Two of the three reported typos were not actually fixed for 1.0.9a.

In aconnect.1:
< Similary, to see the output ports, use
---
> Similarly, to see the output ports, use

In alsamixer.1
125c125
< On terminals that can't use funtion keys like gnome-terminal, \fI?\fP
and
---
> On terminals that can't use function keys like gnome-terminal, \fI?\fP
and

----------------------------------------------------------------------
 tiwai - 06-08-05 15:56 
----------------------------------------------------------------------
Thanks, now fixed again on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-30-05 17:16 jdthood        New Issue                                    
03-30-05 18:11 tiwai          Status                   new => resolved     
03-30-05 18:11 tiwai          Resolution               open => fixed       
03-30-05 18:11 tiwai          Assigned To               => tiwai           
03-30-05 18:11 tiwai          Note Added: 0004267                          
06-05-05 10:43 jdthood        Status                   resolved => feedback
06-05-05 10:43 jdthood        Resolution               fixed => reopened   
06-05-05 10:43 jdthood        Note Added: 0004889                          
06-05-05 10:44 jdthood        Status                   feedback => assigned
06-05-05 10:44 jdthood        version                  1.0.8 => 1.0.9      
06-08-05 15:56 tiwai          Status                   assigned => resolved
06-08-05 15:56 tiwai          Resolution               reopened => fixed   
06-08-05 15:56 tiwai          Note Added: 0004939                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
