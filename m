From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000226]: Sound hangs after APM resume
Date: Mon, 17 Jan 2005 10:59:47 +0100
Message-ID: <9cec5bdf718b8cbd680f7d9c547666be@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8768F193
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2005 10:59:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=226> 
======================================================================
Reported By:                marke
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   226
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             &nbsp;2.6.5
======================================================================
Date Submitted:             04-20-2004 13:07 CEST
Last Modified:              01-17-2005 10:59 CET
======================================================================
Summary:                    Sound hangs after APM resume
Description: 
After a suspend/resume of the laptop with the cs46xx chipset the sound no
longer works. I need to kill all sound apps unload the alsa modules and
reload them.
======================================================================

----------------------------------------------------------------------
 tiwai - 04-20-04 15:14 
----------------------------------------------------------------------
already fixed in the recent CVS.
please give a try.

----------------------------------------------------------------------
 jdthood - 01-17-05 10:59 
----------------------------------------------------------------------
Duplicate of https://bugtrack.alsa-project.org/alsa-bug/view.php?id=305.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-20-04 13:07 marke          New Issue                                    
04-20-04 13:07 marke          Distribution              => Debian          
04-20-04 13:07 marke          Kernel Version            =>  2.6.5          
04-20-04 13:10 marke          Issue Monitored: marke                       
04-20-04 15:14 tiwai          Note Added: 0000884                          
01-17-05 10:59 jdthood        Note Added: 0003227                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
