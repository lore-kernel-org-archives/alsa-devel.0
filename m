From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000789]: With AZX Sound card
Date: Fri, 7 Jan 2005 17:52:24 +0100
Message-ID: <de9aeaf7b584661fec893e8cdb99a9cc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 885ED214
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2005 17:52:24 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=789> 
======================================================================
Reported By:                footcow
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   789
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.10
======================================================================
Date Submitted:             01-07-2005 00:42 CET
Last Modified:              01-07-2005 17:52 CET
======================================================================
Summary:                    With AZX Sound card
Description: 
Since Alsa v1.0.8rc2 not in v1.0.7

Alsa Start but in my dmesg I get :

ALSA /usr/src/alsa-cvs/alsa-driver/acore/pcm_native.c:1872: BUG? (err >=
0) (called from f8b19f16)
ALSA /usr/src/alsa-cvs/alsa-driver/acore/pcm_native.c:2011:
snd_pcm_hw_constraints_complete failed

I think it's under KDE when the ARTS server start ... then I have no sound
unsing ALSA sound server neighter and OSS (same message when I switch the
sound server under KDE, each time my dmesg).
======================================================================

----------------------------------------------------------------------
 tiwai - 01-07-05 17:52 
----------------------------------------------------------------------
Which card model do you have?  Show the output of /proc/asound/cards.
Also, attach the content of /proc/asound/card0/codec* file.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-07-05 00:42 footcow        New Issue                                    
01-07-05 00:42 footcow        Distribution              => Debian          
01-07-05 00:42 footcow        Kernel Version            => 2.6.10          
01-07-05 17:52 tiwai          Note Added: 0003103                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
