From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001271]: Changes in ALSA driver between 2.6.11.10 and 2.6.12.3 mean echo-cancelling mics fail
Date: Thu, 26 Jan 2006 23:22:58 +0100
Message-ID: <8af310ae9ff5ffdc55c8c551f5146f8e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 573D119E
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2006 23:22:58 +0100 (MET)
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


The following issue has been CLOSED
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
Status:                     closed
Distribution:               Debian Sarge
Kernel Version:             2.6.12.3
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             07-21-2005 18:50 CEST
Last Modified:              01-26-2006 23:22 CET
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

----------------------------------------------------------------------
 rlrevell - 01-26-06 23:22 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-21-05 18:50 dcpiper        New Issue                                    
07-21-05 18:50 dcpiper        Distribution              => Debian Sarge    
07-21-05 18:50 dcpiper        Kernel Version            => 2.6.12.3        
12-31-05 00:01 rlrevell       Note Added: 0007307                          
01-26-06 23:22 rlrevell       Status                   new => closed       
01-26-06 23:22 rlrevell       Note Added: 0007793                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
