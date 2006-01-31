From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001801]: Audiophile USB noisy analog capture
Date: Tue, 31 Jan 2006 16:04:43 +0100
Message-ID: <01f48b14be00e8e1dba7162d5a69c989@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 177571DB
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2006 16:04:44 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1801> 
======================================================================
Reported By:                lemeur
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1801
Category:                   USB - usb-audio
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.15.1-rt3
======================================================================
Date Submitted:             01-31-2006 16:04 CET
Last Modified:              01-31-2006 16:04 CET
======================================================================
Summary:                    Audiophile USB noisy analog capture
Description: 
The audiophile usb analog capture interface seems to be unreliably
initialized by the ALSA driver.

Just after bootup (or after an /etc/init.d/alsasound restart) the sound
recorded on the analog capture port is sometimes either:
- Case A: saturated/distorted (as if it had a very high volume gain)
or
- Case B: completly inaudible and loud white noised
or
- Case C: sometimes the sound is good

This issue affects:
* only the analog capture interface and not the SPDIF digital capture
interface
* playback is always working
* both hw:1,1 (analog capture) and plughw:1,1 (analog cpautre with plug)


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-06 16:04 lemeur         New Issue                                    
01-31-06 16:04 lemeur         Kernel Version            => 2.6.15.1-rt3    
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
