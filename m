From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001440]: headphone output loops to microphone input
Date: Thu, 22 Sep 2005 00:13:28 +0200
Message-ID: <addfa9ed09005edd6d08ec929708b007@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E330A176
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 00:13:28 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1440> 
======================================================================
Reported By:                dyfrgi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1440
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.13.1
======================================================================
Date Submitted:             09-22-2005 00:13 CEST
Last Modified:              09-22-2005 00:13 CEST
======================================================================
Summary:                    headphone output loops to microphone input
Description: 
I cannot use the headphone port when using full duplex on my laptop. Here
are four scenarios, and the results:

1. System speakers, no microphone plugged in
RESULTS:
When recording from the microphone input, there is no sound. As expected.

2. System speakers, microphone plugged in
RESULTS:
Only the sound that should be picked up by the microphone is recorded
through the microphone input. As expected.

3. Headphones plugged in, microphone not plugged in.
RESULTS:
No sound when recording. As expected.

4. Headphones plugged in, microphone plugged in.
RESULTS:
Audio coming in through the microphone input is a combination of the
expected audio and the audio that is being played through the headphone
output. This is the problem.

Could this be an ALSA issue, or should I have the laptop hardware looked
at? I should note that this also happens if I use the OSS driver. That
doesn't mean it's not a driver issue, though; it could be that some
register is not being set up properly.

The loopbacked volume is lower than if I set Mix or Mix Mono to be the
capture channel. I'm using jaaa with noise output turned on to monitor.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-22-05 00:13 dyfrgi         New Issue                                    
09-22-05 00:13 dyfrgi         Distribution              => Gentoo          
09-22-05 00:13 dyfrgi         Kernel Version            => 2.6.13.1        
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
