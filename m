From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000546]: 5.1 surround sound output on NForce2 is broken through native output
Date: Sun, 17 Apr 2005 22:19:47 +0200
Message-ID: <572a8b130f06db2ef898e77d6807abf5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 13020223
	for <alsa-devel@alsa-project.org>; Sun, 17 Apr 2005 22:19:47 +0200 (MEST)
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
Last Modified:              04-17-2005 22:19 CEST
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
 jdthood - 04-09-05 14:39 
----------------------------------------------------------------------
Submitter: Has this problem been fixed in a later ALSA release?

----------------------------------------------------------------------
 AdamW - 04-17-05 22:19 
----------------------------------------------------------------------
Yes, it's pretty much fixed, I can now get proper 5.1 output via native
ALSA output or OSS emulation. Oddly enough I need _different_ mixer
settings for each method, but that's not too much of a hassle. I can
provide the two asound.state files if anyone's interested, but this is
basically fixed.

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
04-17-05 22:19 AdamW          Note Added: 0004512                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
