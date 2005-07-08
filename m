From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000859]: alsactl does not report error status when given an illegal option
Date: Fri, 8 Jul 2005 10:35:21 +0200
Message-ID: <68a456c45f0723ad3cd4d1ae97d76cf4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7850A17A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:35:21 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=859> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   859
Category:                   alsactl
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-29-2005 17:16 CET
Last Modified:              07-08-2005 10:35 CEST
======================================================================
Summary:                    alsactl does not report error status when given an
illegal option
Description: 
$ /usr/sbin/alsactl --foobar > /dev/null/usr/sbin/alsactl: unrecognized
option `--foobar'
$ echo $?
0

======================================================================

----------------------------------------------------------------------
 tiwai - 01-31-05 18:49 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-29-05 17:16 jdthood        New Issue                                    
01-31-05 18:49 tiwai          Status                   new => resolved     
01-31-05 18:49 tiwai          Resolution               open => fixed       
01-31-05 18:49 tiwai          Assigned To               => tiwai           
01-31-05 18:49 tiwai          Note Added: 0003448                          
01-31-05 18:49 tiwai          Assigned To              tiwai =>            
07-08-05 10:35 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
