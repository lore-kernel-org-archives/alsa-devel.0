From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000546]: 5.1 surround sound output on NForce2 is broken through native output
Date: Sat, 9 Apr 2005 14:39:13 +0200
Message-ID: <e0b83e2b2893a4bdf4ae119a6fa7a718@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2B69421D
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 14:39:13 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=546> 
======================================================================
Reported By:                AdamW
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   546
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Mandrakelinux Cooker
Kernel Version:             2.6.8.1 (10mdk revision)
======================================================================
Date Submitted:             09-26-2004 20:23 CEST
Last Modified:              04-09-2005 14:39 CEST
======================================================================
Summary:                    5.1 surround sound output on NForce2 is broken
through native output
Description: 
Despite much fiddling with levels, it seems to be impossible to get 5.1
sound to play correctly through NForce2's onboard sound with native ALSA
output and the snd-intel8x0 driver. I have a test file which plays a sound
through each speaker of a 5.1 setup in turn and using native ALSA output
through mplayer -channels 6, totem, aplay or any other app mangles it;
depending on the mixer setting I can get some of the sounds through some
of the speakers but never all the sounds and never anywhere near the right
speakers. However, if I use OSS output instead of native ALSA output, it
works perfectly; the speaker identification file plays exactly correct and
my 5.1 movies sound great. Having it working through native output would
obviously be better, though.
======================================================================

----------------------------------------------------------------------
 AdamW - 09-29-04 17:37 
----------------------------------------------------------------------
I can *play* the files, but they don't play *correctly* - sounds are not
coming out of the right speakers. When I play the chan-id test file, which
simply makes the front left speaker say "front left", the front right
speaker say "front right", the centre speaker say "centre", the subwoofer
say something inaudible, the rear left say "rear left" and then the rear
right say "rear right", front left and front right are OK, I hear nothing
for centre, then I get a weird kind of multiplexed sound coming from the
front speakers when it tries to id the rear speakers. This is how it
sounds with mplayer -ao alsa -channels 6 chan-id.wav . If I run mplayer
-channels 6 chan-id.wav - i.e. the same command but using OSS instead of
ALSA output - every speaker identifies itself correctly. The behaviour is
similar in real 5.1 content, i.e. movies - they sound messed up through
ALSA output, sounds missing or playing through the wrong speakers; with
OSS output they sound perfect.

----------------------------------------------------------------------
 jdthood - 04-09-05 14:39 
----------------------------------------------------------------------
Submitter: Has this problem been fixed in a later ALSA release?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-26-04 20:23 AdamW          New Issue                                    
09-26-04 20:23 AdamW          Distribution              => Mandrakelinux Cooker
09-26-04 20:23 AdamW          Kernel Version            => 2.6.8.1 (10mdk
revision)
09-28-04 16:01 djtm           Note Added: 0001946                          
09-29-04 17:37 AdamW          Note Added: 0001972                          
04-09-05 14:39 jdthood        Note Added: 0004402                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
