From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000546]: 5.1 surround sound output on NForce2 is broken through native output
Date: Wed, 29 Sep 2004 17:37:22 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040929153722.BAECC5003@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2C67B2C4
	for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2004 17:37:23 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000546
======================================================================
Reported By:                AdamW
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     546
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Mandrakelinux Cooker
Kernel Version:             2.6.8.1 (10mdk revision)
======================================================================
Date Submitted:             09-26-2004 20:23 CEST
Last Modified:              09-29-2004 17:37 CEST
======================================================================
Summary:                    5.1 surround sound output on NForce2 is broken through native output
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
 djtm - 09-28-2004 16:01 CEST 
----------------------------------------------------------------------
Please elaborate, I could on my Nforce2 system player native alsa 5.1
surround with mplayer. Which ALSA version? (cat /proc/asound/version)

----------------------------------------------------------------------
 AdamW - 09-29-2004 17:37 CEST 
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

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-26-04 20:23 AdamW          New Bug                                      
09-26-04 20:23 AdamW          Distribution              => Mandrakelinux Cooker
09-26-04 20:23 AdamW          Kernel Version            => 2.6.8.1 (10mdk revision)
09-28-04 16:01 djtm           Bugnote Added: 0001946                       
09-29-04 17:37 AdamW          Bugnote Added: 0001972                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
