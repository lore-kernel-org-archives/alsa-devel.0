From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000318]: alsaconf: -bash: syntax error in conditional expression
Date: Wed, 19 Jan 2005 17:00:28 +0100
Message-ID: <e446f22b2affeab69ccf937267cdbac5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9E45926D
	for <alsa-devel@alsa-project.org>; Wed, 19 Jan 2005 17:00:28 +0100 (MET)
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
Status:                     new
======================================================================
Date Submitted:             05-31-2004 12:25 CEST
Last Modified:              01-19-2005 17:00 CET
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
 tiwai - 01-19-05 16:44 
----------------------------------------------------------------------
Even the second [] isn't necessary when you use grep -q.

----------------------------------------------------------------------
 Toralf Förster - 01-19-05 17:00 
----------------------------------------------------------------------
Ok, what I mean, is:
tfoerste@nhh221 ~ $ [ -f /etc/redhat-release -a `grep "Red Hat"
/etc/redhat-release 2>/dev/null` -ne 0 ] && echo yes || echo no
bash: [: too many arguments
no
tfoerste@nhh221 ~ $ [[ -f /etc/redhat-release && `grep "Red Hat"
/etc/redhat-release 2>/dev/null` -ne 0 ]] && echo yes || echo no
no
tfoerste@nhh221 ~ $

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-31-04 12:25 Toralf Förster New Issue                                    
01-19-05 15:36 jdthood        Note Added: 0003288                          
01-19-05 16:44 tiwai          Note Added: 0003292                          
01-19-05 17:00 Toralf Förster Note Added: 0003299                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
