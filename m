From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001749]: SPDIF sound only in stereo
Date: Thu, 13 Apr 2006 21:55:13 +0200
Message-ID: <183f34944ae3c4b5e705bfc1b3a0c50c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D7A7C178
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 21:55:13 +0200 (MEST)
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


The following issue requires your FEEDBACK.
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
Last Modified:              04-13-2006 21:55 CEST
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
 rlrevell - 01-16-06 00:32 
----------------------------------------------------------------------
SPDIF only supports stereo PCM, unless it's AC3 encoded.

----------------------------------------------------------------------
 jcdutton - 04-13-06 21:55 
----------------------------------------------------------------------
You will only get more than stereo sound when playing a DVD movie or
similar AC3 encoded sound track.
How are you testing it?

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
