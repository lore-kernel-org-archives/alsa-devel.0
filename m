From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000796]: Behavior of LED on mute button
Date: Sun, 9 Jan 2005 02:26:37 +0100
Message-ID: <31910fcbfe1004bdd8f418fa3256501e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 621CB2BF
	for <alsa-devel@alsa-project.org>; Sun,  9 Jan 2005 02:26:37 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=796> 
======================================================================
Reported By:                kempokaraterulz
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   796
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             01-09-2005 02:26 CET
Last Modified:              01-09-2005 02:26 CET
======================================================================
Summary:                    Behavior of LED on mute button
Description: 
On my laptop, there is this little blue LED on the mute button, muting  /
unmuting the sound doesnt have any effect on this LED currently, if i
unload the sound module the LED turns on, and if i reload the sound module
it turns back off. Since the sound driver turns the light on when being
unloaded, my (possibly incorrect) guess is that this would be a fairly
easy thing to implement properly, or at least allow control of the light
through the proc interface or something. 
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-09-05 02:26 kempokaraterulzNew Issue                                    
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
