From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000364]: Driver for VIRTUAL/DUMMY card(s) that forward/mix to real cards
Date: Sat, 8 Jan 2005 11:05:44 +0100
Message-ID: <d7c2306248a44ceb830e8bc9b5e29146@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7E4B22BE
	for <alsa-devel@alsa-project.org>; Sat,  8 Jan 2005 11:05:44 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=364> 
======================================================================
Reported By:                bonbons
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   364
Category:                   OTHERS
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-04-2004 13:33 CEST
Last Modified:              01-08-2005 11:05 CET
======================================================================
Summary:                    Driver for VIRTUAL/DUMMY card(s) that forward/mix to
real cards
Description: 
As all sound devices can only be opened with exclusive access, and there
are quite a few close-source programs that interact with "/dev/dspX"
(OSS), would it be possible to have virtual cards that would mix to the
real one(s)?

======================================================================

----------------------------------------------------------------------
 bonbons - 01-08-05 11:05 
----------------------------------------------------------------------
Is there no interest for such a driver?

This would allow to use closed-source apps that just support old-style OSS
and don't work (correctly) over wrappers (some browser plugins, VMWare and
others). In addition it could be used to get rid of sound-daemons, using
dmix plugin and routing non-alsa apps through that virtual-pcm driver!

Use: same as for virtualmidi, but for PCMs!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-04-04 13:33 bonbons        New Issue                                    
01-08-05 11:05 bonbons        Note Added: 0003128                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
