From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000469]: volume of sblive mic recording too low
Date: Fri, 30 Dec 2005 03:53:57 +0100
Message-ID: <a8e1e0173a83b181639757b0f70e4dbd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 961571A6
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 03:53:57 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=469> 
======================================================================
Reported By:                wouter
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   469
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.8
======================================================================
Date Submitted:             08-28-2004 01:36 CEST
Last Modified:              12-30-2005 03:53 CET
======================================================================
Summary:                    volume of sblive mic recording too low
Description: 
The recordings made with the Mic input on my sblive (5.1) are substantially
lower in volume than direct playback output. If fact, they are too low to
be really useful in for instance video conferencing, barely reaching 1/4
in the VU meter of the gnomemeeting voip program - with Mic boost on.

Setting "Capture" to anything but zero stops any sound from being
captured.

"AC97 Capture" seems to be controlling the volume of the recording, but it
is too low even with the slider on 100%.

People on the users mailinglist seem to indicate that "Capture" actually
should work, which it doesn't.
======================================================================

----------------------------------------------------------------------
 wouter - 09-18-04 01:48 
----------------------------------------------------------------------
For what it's worth, sliding the "Capture" from 0% to 1% while recording
produces a little pop before muting the record source, which seems to
indicate something is modified; it's not a gradual change, like for
instance sliding the "AC97 Capture" or any normal volume slider is.

----------------------------------------------------------------------
 rlrevell - 12-30-05 03:53 
----------------------------------------------------------------------
Any improvement with later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-28-04 01:36 wouter         New Issue                                    
08-28-04 01:36 wouter         File Added: amixer.txt                       
08-28-04 01:36 wouter         Distribution              => Debian          
08-28-04 01:36 wouter         Kernel Version            => 2.6.8           
09-07-04 09:40 pzad           Note Added: 0001704                          
09-07-04 16:47 wouter         Note Added: 0001716                          
09-16-04 10:22 pzad           Note Added: 0001767                          
09-16-04 15:58 wouter         File Added: can_capture.txt                    
09-16-04 15:58 wouter         File Added: cannot_capture.txt                    
09-16-04 16:00 wouter         Note Added: 0001774                          
09-17-04 10:35 pzad           Note Added: 0001777                          
09-18-04 01:33 wouter         File Added: can_capture.txt                    
09-18-04 01:39 wouter         Note Added: 0001780                          
09-18-04 01:40 wouter         File Added: can_capture.state                    
09-18-04 01:41 wouter         File Added: cannot_capture.state                  
 
09-18-04 01:48 wouter         Note Added: 0001781                          
12-30-05 03:53 rlrevell       Note Added: 0007192                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
