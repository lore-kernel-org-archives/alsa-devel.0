From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000197]: No sound from speakers
Date: Fri, 30 Dec 2005 05:17:03 +0100
Message-ID: <ac1a7fe0ca7ab0ad1a7262c9fe9b728a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E4F41193
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 05:17:03 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=197> 
======================================================================
Reported By:                edhall
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   197
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             04-09-2004 15:03 CEST
Last Modified:              12-30-2005 05:17 CET
======================================================================
Summary:                    No sound from speakers
Description: 
Debian distribution with KDE 3.2.1 No sound from speakers.

I get this message from the control panel

Sound server informational message:
Error while initializing the sound driver:
device: default can't be opened for playback (No such file or directory)
The sound server will continue, using the null output device.

I think I hear system sounds through the speaker on the MB.
======================================================================

----------------------------------------------------------------------
 jdthood - 03-23-05 16:03 
----------------------------------------------------------------------
Please send the output of

   lsmod
   uname -a
   lspci
   cat /proc/asound/version
   cat /proc/asound/cards

----------------------------------------------------------------------
 rlrevell - 12-30-05 05:17 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-09-04 15:03 edhall         New Issue                                    
04-09-04 15:03 edhall         Distribution              => Debian          
03-23-05 15:42 jdthood        Note Added: 0004164                          
03-23-05 16:03 jdthood        Note Added: 0004170                          
12-30-05 05:17 rlrevell       Status                   new => closed       
12-30-05 05:17 rlrevell       Note Added: 0007239                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
