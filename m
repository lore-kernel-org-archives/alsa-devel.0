From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000318]: alsaconf: -bash: syntax error in conditional expression
Date: Tue, 22 Feb 2005 18:05:03 +0100
Message-ID: <b615007eaaf9a015617370e0c5b4e1dc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 546F4165
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2005 18:05:03 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=318> 
======================================================================
Reported By:                Toralf Förster
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   318
Category:                   alsaconf
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-31-2004 12:25 CEST
Last Modified:              02-22-2005 18:05 CET
======================================================================
Summary:                    alsaconf: -bash: syntax error in conditional
expression
Description: 
The error above results from lines like:
  
elif [ -f /etc/redhat-release -a `grep -c "Red Hat" /etc/redhat-release
2>/dev/null` -ne 0 ]; then

instead it should be 
elif [[ -f /etc/redhat-release && `grep -c "Red Hat" /etc/redhat-release
2>/dev/null` -ne 0 ]; then

notice the doubled '[[' and ']]' and '&&' instead of '-a', isn't it ?
======================================================================

----------------------------------------------------------------------
 jdthood - 02-18-05 22:04 
----------------------------------------------------------------------
This should be fixed.

----------------------------------------------------------------------
 tiwai - 02-22-05 18:05 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-31-04 12:25 Toralf Förster New Issue                                    
01-19-05 15:36 jdthood        Note Added: 0003288                          
01-19-05 16:44 tiwai          Note Added: 0003292                          
01-19-05 17:00 Toralf Förster Note Added: 0003299                          
02-18-05 22:04 jdthood        Note Added: 0003666                          
02-22-05 18:05 tiwai          Status                   new => resolved     
02-22-05 18:05 tiwai          Resolution               open => fixed       
02-22-05 18:05 tiwai          Assigned To               => tiwai           
02-22-05 18:05 tiwai          Note Added: 0003706                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
