From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001058]: CMI9880 sometimes produces distorted sound
Date: Sat, 16 Apr 2005 16:37:55 +0200
Message-ID: <5dfdc535134941f3e03a9c48a145e4f9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E12DB228
	for <alsa-devel@alsa-project.org>; Sat, 16 Apr 2005 16:37:55 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1058> 
======================================================================
Reported By:                ahessling
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1058
Category:                   OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.11.6
======================================================================
Date Submitted:             04-16-2005 16:37 CEST
Last Modified:              04-16-2005 16:37 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-16-05 16:37 ahessling      New Issue                                    
04-16-05 16:37 ahessling      Distribution              => Gentoo          
04-16-05 16:37 ahessling      Kernel Version            => 2.6.11.6        
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
