From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000773]: Kernel 2.6.10 with ALSA 1.08rc1 from CVS (12/30/2004)
Date: Sat, 1 Jan 2005 18:44:34 +0100
Message-ID: <20050101174435.29D062FF@alsa.alsa-project.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 29D062FF
	for <alsa-devel@alsa-project.org>; Sat,  1 Jan 2005 18:44:35 +0100 (MET)
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

Audigy2 Value - SB0400 card
Audigy2 Value- AUX-In and LINE-IN no sound
Message-ID: <9c51e00286af3922c52394521bf8f222@bugtrack.alsa-project.org>
X-Priority: 3
X-Mailer: PHPMailer [version 1.72]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="iso-8859-1"


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=773> 
======================================================================
Reported By:                hodgesw
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   773
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               1.08rc1
Kernel Version:             2.6.10
======================================================================
Date Submitted:             01-01-2005 01:21 CET
Last Modified:              01-01-2005 18:44 CET
======================================================================
Summary:                    Kernel 2.6.10 with ALSA 1.08rc1 from CVS
(12/30/2004)
Audigy2 Value - SB0400 card
Audigy2 Value- AUX-In and LINE-IN no sound
Description: 
Kernel 2.6.10 with ALSA 1.08rc1 from CVS (12/30/2004)
Audigy2 Value - SB0400 card
After trying many modprobe.preload/modprobe.conf alternatives I
manually loaded driver  using  "modprobe -v snd-emu10k1"
with /etc/modprobe.conf: "options snd-emu10k1  extin="0x3fff"
After setting alsamixer volumes
"speakertest" works; "aplay" produces good sound; mic produces good
sound;
"line in" does not work; "auxin" does nor work.
kde configure plays sound.
xmms cannot find sound card.

======================================================================

----------------------------------------------------------------------
 hodgesw - 01-01-05 16:13 
----------------------------------------------------------------------
Used alsamixer to set everything to 100%

----------------------------------------------------------------------
 rlrevell - 01-01-05 18:44 
----------------------------------------------------------------------
Are you *sure* you pushed F4 in alsamixer and set all of the capture
controls to maximum?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-01-05 01:21 hodgesw        New Issue                                    
01-01-05 01:21 hodgesw        Distribution              => 1.08rc1         
01-01-05 01:21 hodgesw        Kernel Version            => 2.6.10          
01-01-05 02:27 rlrevell       Note Added: 0003029                          
01-01-05 16:13 hodgesw        Note Added: 0003032                          
01-01-05 18:44 rlrevell       Note Added: 0003033                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
