From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000784]: CMI 9739A PCM does not allow volume control only on/off (when on starts with full volume)
Date: Fri, 7 Jan 2005 17:54:52 +0100
Message-ID: <5ba837104ca0c2fc5160fd0c52af61e3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0E4E524F
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2005 17:54:52 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=784> 
======================================================================
Reported By:                ajir
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   784
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             01-04-2005 20:34 CET
Last Modified:              01-07-2005 17:54 CET
======================================================================
Summary:                    CMI 9739A PCM does not allow volume control only
on/off (when on starts with full volume)
Description: 
This issue was studied before but without any effect. Some says that this
codec has different hadrware and it can not be controled.BUT WINDOWS
DRIVER CAN CONTROL damn VOLUME. Please can it be fixed?
======================================================================

----------------------------------------------------------------------
 ajir - 01-06-05 12:03 
----------------------------------------------------------------------
Thanks a lot, You are making a peace of GOOD JOB for all of us. :)
And sorry for disturbing You!

----------------------------------------------------------------------
 tiwai - 01-07-05 17:54 
----------------------------------------------------------------------
ALSA 1.0.8rc2 includes the softvol feature.

When you access to the PCM "default", softvol is automatically enabled.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-04-05 20:34 ajir           New Issue                                    
01-04-05 20:34 ajir           Kernel Version            => 2.6.8.1         
01-04-05 20:57 rlrevell       Note Added: 0003080                          
01-04-05 22:42 rlrevell       Note Added: 0003087                          
01-06-05 12:03 ajir           Note Added: 0003091                          
01-07-05 17:54 tiwai          Note Added: 0003104                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
