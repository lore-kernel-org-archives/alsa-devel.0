From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000347]: Driver works with xmms, but not with kino or dvgrab
Date: Thu, 7 Apr 2005 21:01:08 +0200
Message-ID: <3a2de8f9eec709e31d4e4fbcef579680@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C6F9323C
	for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2005 21:01:08 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=347> 
======================================================================
Reported By:                winjer
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   347
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian GNU/Linux
Kernel Version:             2.6.7
======================================================================
Date Submitted:             06-26-2004 14:44 CEST
Last Modified:              04-07-2005 21:01 CEST
======================================================================
Summary:                    Driver works with xmms, but not with kino or dvgrab
Description: 
I get fine sound playing with xmms, but when I try to grab dv via firewire
from my camcorder the sound is badly out of sync with the pictures and is
much slower.

When I switch to my second soundcard, an es1371, grabbing dv works
perfectly.
======================================================================

----------------------------------------------------------------------
 winjer - 07-04-04 16:21 
----------------------------------------------------------------------
I've finally found the time to do some more testing.  I've now configured
both cards to make life easier.  My setup is:

doug@jarlsberg:~$ cat /proc/asound/cards
0 [ZNF3150        ]: ICE1724 - Chaintech ZNF3-150
                     Chaintech ZNF3-150 at 0xac00, irq 11
1 [AudioPCI       ]: ENS1371 - Ensoniq AudioPCI
                     Ensoniq AudioPCI ENS1371 at 0x9000, irq 11

My .asoundrc is:

pcm.ice1724 {
    type hw
    card 0
}
ctl.ice1724 {
    type hw
    card 0
}

pcm.ens1371 {
    type hw
    card 1
}

ctl.ens1371 {
    type hw
    card 1
}

If I run kino with audio device /dev/dsp0, I now get video but the audio
is way too fast and squeaky.  Everyone sounds like the smurfs.

if I run it with audo device /dev/dsp1, it works fine.

Presumably this is in OSS emulation mode, since it's using the dsp
devices.

mplayer has alsa native support, so i've tried that.  With either:

mplayer -ao alsa:ice1724

or 

mplayer -ao alsa:ens1371

I don't get any sound.  It says:

alsa-init: soundcard set to ice1724
alsa-init: playback open error: Invalid argument
Could not open/initialize audio device -> no sound.
Audio: no sound

Presumably I'm doing something wrong, but I can't work out what.  If you
can tell me the correct options to mplayer to try, I'll give it a shot.

Running mplayer in oss emulation mode, I get the same symptions as with
kino.

----------------------------------------------------------------------
 jdthood - 04-07-05 21:01 
----------------------------------------------------------------------
Submitter: Has there been any progress on this issue?
Do you have the necessary device files in /dev/snd/?
Are you using udev, devfs or static device files?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-26-04 14:44 winjer         New Issue                                    
06-26-04 14:44 winjer         Distribution              => Debian GNU/Linux
06-26-04 14:44 winjer         Kernel Version            => 2.6.7           
06-30-04 16:36 tiwai          Note Added: 0001358                          
07-04-04 16:21 winjer         Note Added: 0001380                          
04-07-05 21:01 jdthood        Note Added: 0004367                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
