From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000777]: Kernel crashes when using external sound controls
Date: Mon, 3 Jan 2005 12:03:16 +0100
Message-ID: <745f99ff4adb5eaaa148fa9327aeec8b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2C6322CD
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2005 12:03:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=777> 
======================================================================
Reported By:                jan
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   777
Category:                   CORE - control
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               Slackware current
Kernel Version:             Kernel 2.6.10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-02-2005 14:49 CET
Last Modified:              01-03-2005 12:03 CET
======================================================================
Summary:                    Kernel crashes when using external sound controls
Description: 
Since I upgraded from Kernel 2.6.8.1 to 2.6.10 (ALSA 1.0.6) the whole
system crashes when I try to adjust to sound volume via the external
volume controls of my laptop. Everything else including the alsamixer
works as expected. (Whole system crashes means, that I can do nothing, but
hard reset.)
I could use these external controls successfully with previous kernel
versions.
When I compile the kernel without ALSA support it doesn't crash (I have no
sound support then of course).
The soundchip in this laptop is:
00:08.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev
10)
Please let me know what additional infos you need.
Thanks in advance
======================================================================

----------------------------------------------------------------------
 tiwai - 01-03-05 12:03 
----------------------------------------------------------------------
Already fixed in CVS (or 1.0.8).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-02-05 14:49 jan            New Issue                                    
01-02-05 14:49 jan            Distribution              => Slackware current
01-02-05 14:49 jan            Kernel Version            => Kernel 2.6.10   
01-03-05 12:03 tiwai          Status                   new => resolved     
01-03-05 12:03 tiwai          Resolution               open => fixed       
01-03-05 12:03 tiwai          Assigned To               => tiwai           
01-03-05 12:03 tiwai          Note Added: 0003051                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
