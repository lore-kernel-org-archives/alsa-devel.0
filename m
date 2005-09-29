From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001010]: Speaker output does not work.
Date: Thu, 29 Sep 2005 22:16:01 +0200
Message-ID: <334c559ac5184a4b98660210e4483e42@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 086F9137
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2005 22:16:01 +0200 (MEST)
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
Last Modified:              09-29-2005 22:16 CEST
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
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001441 snd-powermac: Burgundy: controls for he...
======================================================================

----------------------------------------------------------------------
 sylware - 04-25-05 17:31 
----------------------------------------------------------------------
Ok I did some testing: there is sound on the speaker output that is
controled with (PCM,0) and not (PCM,1)... but the sound is very weak... I
had to put almost my hi-fi system to the max to hear something!(I
rebooted... I almost burned my hi-fi speakers with the "apple sound" at
the start of the computer.
If I do the same kind of testing when connected to the headphone output, I
get the same results when the headphone output is mutted. Namely I get a
very weak sound even it is muted. BTW I'm an electrical engineer, so you
can ask me *hardcore* questions, I'm supposed to understand, and I have
setup a little build environ on the targeted computer(with alsa 1.0.9rc2):
I can recompile snd-powermac and try it.



----------------------------------------------------------------------
 Quietti - 09-29-05 22:16 
----------------------------------------------------------------------
How is this supposed to be related to 1441?  

We're talking about two different soundchips and two different C files
within the snd-powermac realm. Also, in this case, speakers don't work at
all, while in 1441 they do but thanks to improper burgundy support they
appear on the wrong sliders.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-05 10:24 sylware        New Issue                                    
03-24-05 10:24 sylware        Distribution              => Ubuntu Hoary    
03-24-05 10:24 sylware        Kernel Version            => 2.6.10          
03-24-05 19:49 tiwai          Note Added: 0004198                          
03-25-05 20:55 sylware        Note Added: 0004211                          
03-29-05 03:20 sylware        Note Added: 0004242                          
04-25-05 17:22 sylware        Note Deleted: 0004211                        
04-25-05 17:25 sylware        Note Edited: 0004242                         
04-25-05 17:31 sylware        Note Edited: 0004242                         
09-29-05 21:01 jdthood        Relationship added       related to 0001441  
09-29-05 22:15 sylware        Issue Monitored: sylware                     
09-29-05 22:16 Quietti        Note Added: 0006425                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
