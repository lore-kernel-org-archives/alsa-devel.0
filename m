From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000948]: Odd hda snd behavior / no sound
Date: Fri, 4 Mar 2005 20:11:21 +0100
Message-ID: <1ea85764af065d8104fcafaa214a87e1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9097C1A4
	for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2005 20:11:21 +0100 (MET)
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
Last Modified:              03-04-2005 20:11 CET
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
 Tomsus - 03-04-05 20:11 
----------------------------------------------------------------------
Although I didn't get any answer to my issue I assume the topic is worth to
be discussed. Therefore I'll provide few additional informations regarding
progress I've done.
Well, after some kind of fight [:)] I have sound in my system, but...

Maybe from the very beginning:
I succed to install both Alsa drvs and tools, but from rpms. Any manual
trials were unsuccesfull fully or partially - I guess because of my small
experience with linux and bugs in software. If somebody here's interested
I can provide my suggestions about it.
At last drivers and tools are properly installed but still devices are NOT
recognised by system.
Applications like XMMS or Kaffeine are working properly immediately after
1.0.8 installed. System sound is not.
I switched the sound system in KDE to OSS mode - it's the only one
working. Automatic detection mode or ALSA mode simply produces no sound.
(Howewer, I can use arts or alsa option in Kacd - in direct digital sound
output mode.)
Next bug: I can turn on/off and adjust volume in Kmix but only in output
section only. Input section tab is EMPTY (only tab title visible).
I can change input values in alsamixer, after that I can record thru my
mic but I can not play (system sound busy).
Next issue - Skype. Each trial to perform a call is terminated by msg "IO
error".

As I'm less experienced in matters provided above I tried to describe the
problems as I can. I hope these informations will be useful for alsa's
sound software engineers and help to develop better drivers in the future.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-27-05 18:23 Tomsus         New Issue                                    
02-27-05 18:23 Tomsus         Distribution              => SuSE Linux 9.2  
02-27-05 18:23 Tomsus         Kernel Version            => 2.6.8-24.11     
03-04-05 20:11 Tomsus         Note Added: 0003801                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
