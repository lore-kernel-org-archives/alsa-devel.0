From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001010]: Speaker output does not work.
Date: Fri, 25 Mar 2005 20:55:44 +0100
Message-ID: <1480a5df7ec7d68fd0012d819a8ae7b0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E99D5252
	for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2005 20:55:44 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1010> 
======================================================================
Reported By:                sylware
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1010
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Hoary
Kernel Version:             2.6.10
======================================================================
Date Submitted:             03-24-2005 10:24 CET
Last Modified:              03-25-2005 20:55 CET
======================================================================
Summary:                    Speaker output does not work.
Description: 
I use a powermac windtunnel newworld with a keywest snapper audio
controller on the uninorth i2c bus (according to the /sys and /proc
filesystems). I'm able to get sound from the headphone output at the front
of the computer(it does automute the computer speaker when I plug the jack
in) but I'm unable to get sound from the speaker output at the rear of the
computer.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-24-05 19:49 
----------------------------------------------------------------------
Snapper has two PCM volumes (you can see in alsamixer).  Does the second
PCM (PCM,1) have any influence?

----------------------------------------------------------------------
 sylware - 03-25-05 20:55 
----------------------------------------------------------------------
As far as I tried it, Nope.

But if I'm not mistaken, sound is sent on the (PCM,0)? You mean that if I
modify the default PCM device on which the sound is sent, I will hear
something from the speaker output? (I may be completely wrong).
If what's above is right (will check it out tonight, coze guilty computer
at girlfriend's place), "basic users" will never get their speaker output
working! I just realized that there is no way to configure that from a
"basic user" perspective (GNOME alsa mixer, esd emulation from polysound,
gstreamer default audio output plugin)! Seems to be a job for direct or
indirect alsa clients and no concern for ALSA... In order to do so, can we
l10n name the PCMs in order to get some to configure the target alsa PCM
(I'm thinking gstreamer alsa/polysound output filters)?
(BTW... sorry for the "FAQ" level question).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-05 10:24 sylware        New Issue                                    
03-24-05 10:24 sylware        Distribution              => Ubuntu Hoary    
03-24-05 10:24 sylware        Kernel Version            => 2.6.10          
03-24-05 19:49 tiwai          Note Added: 0004198                          
03-25-05 20:55 sylware        Note Added: 0004211                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
