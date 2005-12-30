From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001396]: Unable to set capture source
Date: Fri, 30 Dec 2005 22:51:57 +0100
Message-ID: <9f3677d31b796065dc42919711be73a3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CB90B141
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 22:51:57 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1396> 
======================================================================
Reported By:                keirlawson
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   1396
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.12
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-03-2005 22:53 CEST
Last Modified:              12-30-2005 22:51 CET
======================================================================
Summary:                    Unable to set capture source
Description: 
using amixer, alsamixer or gnome-volume-control it seems to be impossible
to capture from microphone on my audigy 2 value.  alsamixer does nothign
when i attempt to select a capture device, the amixer error is below,
gnome-volume-manager displays only playback volume sliders, no capture
ones
======================================================================

----------------------------------------------------------------------
 rlrevell - 09-04-05 00:35 
----------------------------------------------------------------------
Also you forgot the attachment containing the amixer error.

----------------------------------------------------------------------
 keirlawson - 09-04-05 14:26 
----------------------------------------------------------------------
Sorry, this problem was fixed when i upgraded to kernel 2.6.13

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-03-05 22:53 keirlawson     New Issue                                    
09-03-05 22:53 keirlawson     Kernel Version            => 2.6.12          
09-04-05 00:33 rlrevell       Note Added: 0006032                          
09-04-05 00:35 rlrevell       Note Added: 0006033                          
09-04-05 14:26 keirlawson     Note Added: 0006037                          
12-30-05 22:51 rlrevell       Status                   new => resolved     
12-30-05 22:51 rlrevell       Resolution               open => fixed       
12-30-05 22:51 rlrevell       Assigned To               => rlrevell        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
