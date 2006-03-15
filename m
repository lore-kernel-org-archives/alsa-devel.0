From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001926]: No sound and no internal speakers with Samsung R65-T2300 Charis notebook
Date: Wed, 15 Mar 2006 18:21:15 +0100
Message-ID: <71e520a378705d44437729f70faca4b5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 644D7205
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2006 18:21:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1926> 
======================================================================
Reported By:                tassilo80
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1926
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-15-2006 18:21 CET
Last Modified:              03-15-2006 18:21 CET
======================================================================
Summary:                    No sound and no internal speakers with Samsung
R65-T2300 Charis notebook
Description: 
I have no sound on my laptop. 

First I tried alsa-diver-1.0.11rc3:
* The headphones are listed in alsamixer, but the internal speakers are
not listed.
* There's no sound with headphones
* If I apply the patch mentioned in bug #1793
(http://quaggaspace.org/a8nvm/a8nvmsound.patch) I have at least sound with
my headphones

The I tried the current CVS:
* without model-option I had short a sound on my right headphone till I
tweaked the mixer settings
* with model=laptop I had no sound at all
* with model=3stack I had no sount at all, too
* if I apply the patch mentioned above and give no model-option, the sound
works again (only headphones)

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-15-06 18:21 tassilo80      New Issue                                    
03-15-06 18:21 tassilo80      File Added: asound.state                     
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
