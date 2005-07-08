From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000318]: alsaconf: -bash: syntax error in conditional expression
Date: Fri, 8 Jul 2005 10:34:58 +0200
Message-ID: <f46b1aa14701e20dcf73bbefbbcac7b0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BCB2F17A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:34:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=318> 
======================================================================
Reported By:                Toralf Förster
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   318
Category:                   alsaconf
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-31-2004 12:25 CEST
Last Modified:              07-08-2005 10:34 CEST
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
02-22-05 18:05 tiwai          Assigned To              tiwai =>            
07-08-05 10:34 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
