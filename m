From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000872]: Mixer not functioning correctly
Date: Sun, 13 Feb 2005 17:19:05 +0100
Message-ID: <959cdb9811da533dac4b8f67b2823d3c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id ABD13236
	for <alsa-devel@alsa-project.org>; Sun, 13 Feb 2005 17:19:05 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=872> 
======================================================================
Reported By:                Mutant_Fruit
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   872
Category:                   CORE OSS - mixer
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     new
Distribution:               Debian Testing (Sarge)
Kernel Version:             2.6.8
======================================================================
Date Submitted:             01-31-2005 21:29 CET
Last Modified:              02-13-2005 17:19 CET
======================================================================
Summary:                    Mixer not functioning correctly
Description: 
Some things seem to not be set up correctly in the volume controls in
alsamixer (and therefore possibly everything based on alsamixer).

1) The "Master" volume has no effect when i'm using headphones.

2) If i turn everything off except "Headphones" i still get sound in
headphones when i play music. I would have assumed this wouldn't be the
case, as PCM volume is at zero. However if i mute PCM, i get no sound. The
same is true for when i take out headphones and turn everything off except
the master volume.

3) I'm not sure if this is a bug with the mixer or the intel drivers, so i
posted this as a bug for the drivers... I get severe distortion when the
PCM volume is turned up.
======================================================================

----------------------------------------------------------------------
 tiwai - 02-09-05 12:06 
----------------------------------------------------------------------
First, use ac97_quirk=hp_only option.  This will control the headphone
volume as the master volume.

STAC9750/51 has a switch to bypass the PCM volume control.  This is
labelled as a different name "PCM Output Path & Mute".  Choose "pre 3D" to
avoid bypassing.  This strange control must be fixed in the future
version.

The PCM volume of this codec can be up to +12dB, i.e. when you raise more
than 75%, it'll be overloaded.

If ac97_quirk=hp_only works, please  provide the output of lspci -nv to
set this option as default.

----------------------------------------------------------------------
 Mutant_Fruit - 02-13-05 17:19 
----------------------------------------------------------------------
The distortion is fixed when i compiled using the ac97_quirk option.
Everything is perfect except for the problem with the earphones. The
"master" volume still does not affect the volume at all when i use
earphones.

Here's the contents of  lspci -nv:

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-05 21:29 Mutant_Fruit   New Issue                                    
01-31-05 21:29 Mutant_Fruit   Distribution              => Debian Testing
(Sarge)
01-31-05 21:29 Mutant_Fruit   Kernel Version            => 2.6.8           
02-04-05 13:21 tiwai          Note Added: 0003505                          
02-05-05 01:32 Mutant_Fruit   Note Added: 0003516                          
02-09-05 12:06 tiwai          Note Added: 0003546                          
02-13-05 17:19 Mutant_Fruit   Note Added: 0003584                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
