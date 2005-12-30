From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001271]: Changes in ALSA driver between 2.6.11.10 and 2.6.12.3 mean echo-cancelling mics fail
Date: Sat, 31 Dec 2005 00:01:51 +0100
Message-ID: <6d3feeadc6682884261c9c31d38591f4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AB3DE176
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 00:01:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1271> 
======================================================================
Reported By:                dcpiper
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1271
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             2.6.12.3
======================================================================
Date Submitted:             07-21-2005 18:50 CEST
Last Modified:              12-31-2005 00:01 CET
======================================================================
Summary:                    Changes in ALSA driver between 2.6.11.10 and
2.6.12.3 mean echo-cancelling mics fail
Description: 
Under 2.6.12.3, terrible feedback happens when the echo-cancelling
microphone (A ClearOne AccuMic II) is enabled. No matter if the microphone
is set to mute or not through alsamixer or gnome-volume-control there is
persistent feedback that howls increasingly louder until the microphone's
own enable button is turned off again.

Rebooting solved nothing, as did resetting the power on the microphone.
Reboot to 2.6.11.10 and the problem is gone again. Something changed in
ALSA somewhere between those kernel versions.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-31-05 00:01 
----------------------------------------------------------------------
Was this resolved in later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-21-05 18:50 dcpiper        New Issue                                    
07-21-05 18:50 dcpiper        Distribution              => Debian Sarge    
07-21-05 18:50 dcpiper        Kernel Version            => 2.6.12.3        
12-31-05 00:01 rlrevell       Note Added: 0007307                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
