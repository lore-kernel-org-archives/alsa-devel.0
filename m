From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000795]: Broken Pipe
Date: Sat, 8 Jan 2005 23:22:40 +0100
Message-ID: <fcee62e8678ba504f016194885403355@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0CBD4259
	for <alsa-devel@alsa-project.org>; Sat,  8 Jan 2005 23:22:41 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=795> 
======================================================================
Reported By:                ajir
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   795
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-08-2005 23:21 CET
Last Modified:              01-08-2005 23:22 CET
======================================================================
Summary:                    Broken Pipe
Description: 
Hi!

I got a problem, with softvolume plugin and 1.0.8rc2 drivers( without
softvol plugin too).
When I changed ALSA from 1.0.5 to 1.0.8rc2 after system boot all modules
load perfectly but! any program like amp(in text mode) or xmms(X mode)
report broken pipe (no dsp device). When I enable softvol it remains the
same. But if softvol is on and manualy set to off(deleting of .asoundrc
without rebooting) Sustem is OK, I got all programs playing and I CAN
FINALY set volume!!! (but starting and stoping .asoundrd by hand is
annoying!). Without softvol set by asoundrc only aplay can give a sound
from wave file
======================================================================

----------------------------------------------------------------------
 ajir - 01-08-05 23:22 
----------------------------------------------------------------------
I use 1.08.rc2 drivers, OSS, lib, utils codec is CMI9739A

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-08-05 23:21 ajir           New Issue                                    
01-08-05 23:22 ajir           Note Added: 0003130                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
