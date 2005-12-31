From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001440]: headphone output loops to microphone input
Date: Sat, 31 Dec 2005 03:20:54 +0100
Message-ID: <554360ec8bc5d4d81ed30b0ce0faba8f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 783FF121
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 03:20:54 +0100 (MET)
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
Last Modified:              12-31-2005 03:20 CET
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

----------------------------------------------------------------------
 rlrevell - 12-31-05 03:20 
----------------------------------------------------------------------
Any improvement with later ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-22-05 00:13 dyfrgi         New Issue                                    
09-22-05 00:13 dyfrgi         Distribution              => Gentoo          
09-22-05 00:13 dyfrgi         Kernel Version            => 2.6.13.1        
12-31-05 03:20 rlrevell       Note Added: 0007324                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
