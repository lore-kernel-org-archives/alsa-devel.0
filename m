From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000707]: Incorrect suspend code
Date: Fri, 7 Jan 2005 17:46:31 +0100
Message-ID: <7c8acfc2cf0c668e7fdfa5ed0cce18c0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3BCBB329
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2005 17:46:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=707> 
======================================================================
Reported By:                Eric Valette
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   707
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-05-2004 10:09 CET
Last Modified:              01-07-2005 17:46 CET
======================================================================
Summary:                    Incorrect suspend code
Description: 
My laptop does not wakeup from suspend to RAM due to intel8xx
driver. Many other are seeing the very same problem. It is due to
incorrect suspend code.

In additionnal information there is a fix for this problem that I tested
on my laptop and that indeed fix the problem.
======================================================================

----------------------------------------------------------------------
 Eric Valette - 12-06-04 14:41 
----------------------------------------------------------------------
This patch has been integrated in the linux kernel tree yesterday...

----------------------------------------------------------------------
 tiwai - 12-06-04 20:52 
----------------------------------------------------------------------
OK, closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-05-04 10:09 Eric Valette   New Issue                                    
12-05-04 10:09 Eric Valette   Distribution              => Debian          
12-06-04 14:21 rgmerk         Note Added: 0002728                          
12-06-04 14:41 Eric Valette   Note Added: 0002729                          
12-06-04 20:52 tiwai          Status                   assigned => resolved
12-06-04 20:52 tiwai          Resolution               open => fixed       
12-06-04 20:52 tiwai          Note Added: 0002732                          
01-07-05 17:46 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
