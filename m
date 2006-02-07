From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001801]: Audiophile USB noisy analog capture
Date: Tue, 7 Feb 2006 10:23:30 +0100
Message-ID: <a4ce8b514002c585487a1d868019e7f8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 043851BA
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2006 10:23:30 +0100 (MET)
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
Last Modified:              02-07-2006 10:23 CET
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

----------------------------------------------------------------------
 lemeur - 02-07-06 10:23 
----------------------------------------------------------------------
I've done more tests and found that Reproducibility is in fact "Always" if
you follow these steps:
* boot the PC with Audiophile USB turned Off
* turn on the Audiophile USB and wait for ALSA to auto-setup it
=> At this point there is a one byte alignment shift (captured sound on
the analog Input is distorted)
* restart alsa once by issuing "/etc/init.d/alsasound restart"
=> At this point there is a 2 bytes alignment shift (captured sound on the
analog Input is white noise only)
* restart alsa once by issuing "/etc/init.d/alsasound restart"
=> At this point there is a 3 bytes alignment shift (captured sound on the
analog Input is back to normal)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-06 16:04 lemeur         New Issue                                    
01-31-06 16:04 lemeur         Kernel Version            => 2.6.15.1-rt3    
02-02-06 14:20 lemeur         Issue Monitored: lemeur                      
02-07-06 10:23 lemeur         Note Added: 0007956                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
