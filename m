From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001749]: SPDIF sound only in stereo
Date: Fri, 14 Apr 2006 07:55:27 +0200
Message-ID: <a274d0a7c3614e2ac36e99647a75ce3f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6D10F18B
	for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2006 07:55:27 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1749> 
======================================================================
Reported By:                MechCow
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1749
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               Debian
Kernel Version:             2.6.12
======================================================================
Date Submitted:             01-15-2006 04:56 CET
Last Modified:              04-14-2006 07:55 CEST
======================================================================
Summary:                    SPDIF sound only in stereo
Description: 
I can only get stereo sound out of the ca0106. All other volumes are at
standard levels. 

I'm using the SB Live 24Bit card. 

0000:00:09.0 Multimedia audio controller: Creative Labs SB Audigy LS

I'm using a 2.6.12 kernel I compiled myself and alsa installed from debian
unstable. 

I have connected the soundcard up as it specifies in the manual, the top
slot connected by a miniplug-to-rca into the coaxial of my panasonic 5.1
surround sound system. 
======================================================================

----------------------------------------------------------------------
 jcdutton - 04-13-06 21:55 
----------------------------------------------------------------------
You will only get more than stereo sound when playing a DVD movie or
similar AC3 encoded sound track.
How are you testing it?

----------------------------------------------------------------------
 MechCow - 04-14-06 07:55 
----------------------------------------------------------------------
I'm testing it by running:

speaker-test -c6 -Dplug:surround51

And listening for sound. Also the sound unit heads up display has an
indicator for what channels of input it is receiving.

I assume speaker-test outputs AC3 sounds surely

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-15-06 04:56 MechCow        New Issue                                    
01-15-06 04:56 MechCow        Distribution              => Debian          
01-15-06 04:56 MechCow        Kernel Version            => 2.6.12          
01-15-06 05:22 rlrevell       Note Added: 0007661                          
01-15-06 06:37 MechCow        Note Added: 0007662                          
01-15-06 13:59 rlrevell       Note Added: 0007664                          
01-16-06 00:22 MechCow        Note Added: 0007681                          
01-16-06 00:32 rlrevell       Note Added: 0007683                          
04-13-06 21:55 jcdutton       Note Added: 0009275                          
04-13-06 21:55 jcdutton       Status                   assigned => feedback
04-14-06 07:55 MechCow        Note Added: 0009283                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
