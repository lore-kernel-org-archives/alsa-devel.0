From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001133]: openal gives no sound with alsa driver
Date: Tue, 7 Jun 2005 09:06:48 +0200
Message-ID: <184e74e6482016e7156fb17a18fe9552@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (unknown [195.113.161.147])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 337FD142
	for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2005 09:06:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1133> 
======================================================================
Reported By:                qwer1234
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1133
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               slackware-current
Kernel Version:             2.6.12-rc5
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-28-2005 07:22 CEST
Last Modified:              06-07-2005 09:06 CEST
======================================================================
Summary:                    openal gives no sound with alsa driver
Description: 
When I add this to ~/.openalrc
 (define devices '(alsa))
 (define alsa-device "default")
 (define speaker-num 2)
I get no sound with openalrc.
I use dmix plugin.
======================================================================

----------------------------------------------------------------------
 qwer1234 - 06-06-05 22:32 
----------------------------------------------------------------------
I have manage the problem.
The problem was witch openal.
It couldn't rekognize my sound card properly.
With a patch my sound works fine.

----------------------------------------------------------------------
 perex - 06-07-05 09:06 
----------------------------------------------------------------------
Okay, so let's close this bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-28-05 07:22 qwer1234       New Issue                                    
05-28-05 07:22 qwer1234       Distribution              => slackware-current
05-28-05 07:22 qwer1234       Kernel Version            => 2.6.12-rc5      
05-29-05 13:15 qwer1234       Issue Monitored: qwer1234                    
06-03-05 05:29 qwer1234       Note Added: 0004881                          
06-03-05 21:55 qwer1234       Issue End Monitor: qwer1234                    
06-03-05 21:58 qwer1234       Issue Monitored: qwer1234                    
06-03-05 21:58 qwer1234       Issue End Monitor: qwer1234                    
06-06-05 22:32 qwer1234       Note Added: 0004909                          
06-07-05 09:06 perex          Status                   new => resolved     
06-07-05 09:06 perex          Resolution               open => fixed       
06-07-05 09:06 perex          Assigned To               => perex           
06-07-05 09:06 perex          Note Added: 0004912                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
