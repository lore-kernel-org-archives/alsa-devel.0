From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000948]: Odd hda snd behavior / no sound
Date: Sun, 27 Feb 2005 18:23:47 +0100
Message-ID: <be2956667b260d9bcc02fec589482d78@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A866A24B
	for <alsa-devel@alsa-project.org>; Sun, 27 Feb 2005 18:23:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=948> 
======================================================================
Reported By:                Tomsus
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   948
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               SuSE Linux 9.2
Kernel Version:             2.6.8-24.11
======================================================================
Date Submitted:             02-27-2005 18:23 CET
Last Modified:              02-27-2005 18:23 CET
======================================================================
Summary:                    Odd hda snd behavior / no sound
Description: 
Hardware:
MB: Gigabyte GA-8I915G-MF, bios F6 (current)
Sound: onboard Intel chipset: 82801FB/.../(ICH6 Family) HD Audio
Controller
Codec: Realtec ALC880(D) HD Audio

Problem:
After ALSA driver package install (last v. - 1.0.8) alsaconf properly
detects my snd chipset and installs snd-azx module, than I can hear test
sound. But that's the only one sound I can get out of my boxes.
I have connected both headphones and speakers into the same connector
(lightgreen marked, "Line Out (Front Speaker Out)" described in mb man).
What do I mean by odd behavior is, that knocking in my headphone little
speaker produces a sound in speakerboxes as in the same time this output
works as IN and OUT simultaneously.
After all I have no sound in my system except this test sound in alsaconf
and also test sound in YAST tool.
I tried to modify settings in alsamixer, but it changes nothing.
Is there any solution possibility to make my sound card operate properly?
Just to mention, I'm a newbe to Linux, the soundcard operated perfect
under WinXP; having in addition auto-sense jack function. It would be good
enough for me just to have a sound out of this single Line-Out output.
As my chipset seems to become commonly used by MB manufacturers it would
be great to find the solution.
I'll provide any additional informations required.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-27-05 18:23 Tomsus         New Issue                                    
02-27-05 18:23 Tomsus         Distribution              => SuSE Linux 9.2  
02-27-05 18:23 Tomsus         Kernel Version            => 2.6.8-24.11     
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
