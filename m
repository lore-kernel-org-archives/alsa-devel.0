From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001058]: CMI9880 sometimes produces distorted sound
Date: Wed, 22 Jun 2005 16:32:57 +0200
Message-ID: <b8e700ca12bcc8845861d9eae6be9695@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1E0AE1FD
	for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2005 16:32:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1058> 
======================================================================
Reported By:                ahessling
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1058
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.11.6
======================================================================
Date Submitted:             04-16-2005 16:37 CEST
Last Modified:              06-22-2005 16:32 CEST
======================================================================
Summary:                    CMI9880 sometimes produces distorted sound
Description: 
I am using the CVS version of alsa-kernel from a few days and because of
the soundchip CMI9880, I have to activate Intel HDA in the kernel.
Sound is working quite fine in stereo mode, but if I want to play a DVD
with 5.1 sound, all speakers are activated but the sound is a little bit
distorted.
xine uses plug:surround51:0 as the surround device.

My asound.conf looks like this:
pcm.!default {
type plug
slave.pcm "svol"
}

pcm.svol {
type softvol
slave.pcm "hw:0,0"
control {
name "PCM Playback Volume"
}
}

I also tried the one from http://www.sabi.co.uk/Cfg/ALSA/
Again, stereo sound works fine and also dmix does its work, but this time
I only get stereo sound in xine although the same configuration of xine is
used.

I also noticed that playing some files using aplay produces the same
distortions, e.g.:

aplay /usr/share/sounds/k3b_success1.wav
Playing WAVE '/usr/share/sounds/k3b_success1.wav' : Unsigned 8 bit, Rate
8000 Hz, Mono

Seems to have to do something with sample rate.
Using the other asound.conf from the homepage above just gives an error:
Playing WAVE '/usr/share/sounds/k3b_success1.wav' : Unsigned 8 bit, Rate
8000 Hz, Mono
aplay: set_params:857: Sample format non available
 
Is there a way to play 5.1 sound without these distortions? Maybe some
lines added to my asound.conf would do the work.

Thanks in advance!

Regards,
André
======================================================================

----------------------------------------------------------------------
 ahessling - 04-21-05 11:41 
----------------------------------------------------------------------
I am already using 1.0.9rc2 and the problem with the noise in aplay isn't
the greatest one.
I want to be able to enjoy 5.1 sound without distortion.

----------------------------------------------------------------------
 andersin - 06-22-05 16:32 
----------------------------------------------------------------------
I have a similar (same) problem, using SB Extigy. Since surround51 is not
defined, I use plug:hw to play. Essentially, as soon as I route/test/play
on any other but the 2 front speakers all speakers produce noise
(speaker-test) or very distorted sound

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-16-05 16:37 ahessling      New Issue                                    
04-16-05 16:37 ahessling      Distribution              => Gentoo          
04-16-05 16:37 ahessling      Kernel Version            => 2.6.11.6        
04-19-05 17:47 tiwai          Note Added: 0004527                          
04-19-05 17:47 tiwai          Category                 OTHERS => PCI - hda-intel
04-21-05 11:41 ahessling      Note Added: 0004550                          
06-22-05 16:32 andersin       Note Added: 0005133                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
