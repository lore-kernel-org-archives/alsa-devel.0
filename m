From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000948]: Odd hda snd behavior / no sound
Date: Thu, 22 Sep 2005 14:59:31 +0200
Message-ID: <db774763ac6a631b5b5e20f0c48d050f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B54FA147
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 14:59:31 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=948> 
======================================================================
Reported By:                Tomsus
Assigned To:                jdthood
======================================================================
Project:                    ALSA - driver
Issue ID:                   948
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               SuSE Linux 9.2
Kernel Version:             2.6.8-24.11
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-27-2005 18:23 CET
Last Modified:              09-22-2005 14:59 CEST
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

----------------------------------------------------------------------
 tiwai - 03-09-05 18:51 
----------------------------------------------------------------------
Also, please update both alsa-driver and alsa-lib if you use CVS version.

----------------------------------------------------------------------
 jdthood - 09-22-05 14:59 
----------------------------------------------------------------------
It sounds as if the problem is one of configuration or bugs in software
other than ALSA.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-27-05 18:23 Tomsus         New Issue                                    
02-27-05 18:23 Tomsus         Distribution              => SuSE Linux 9.2  
02-27-05 18:23 Tomsus         Kernel Version            => 2.6.8-24.11     
03-04-05 20:11 Tomsus         Note Added: 0003801                          
03-09-05 18:50 tiwai          Note Added: 0003837                          
03-09-05 18:51 tiwai          Note Added: 0003838                          
09-22-05 14:59 jdthood        Status                   new => resolved     
09-22-05 14:59 jdthood        Resolution               open => fixed       
09-22-05 14:59 jdthood        Assigned To               => jdthood         
09-22-05 14:59 jdthood        Note Added: 0006339                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
