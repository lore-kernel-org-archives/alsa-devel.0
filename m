From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001613]: Wish
Date: Wed, 7 Dec 2005 16:02:19 +0100
Message-ID: <a7d023f6010d6dba35f37e78528f1845@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4E021171
	for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2005 16:02:19 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1613> 
======================================================================
Reported By:                amp77
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1613
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Debian stable (sarge)
Kernel Version:             2.6.8-2
======================================================================
Date Submitted:             12-03-2005 10:32 CET
Last Modified:              12-07-2005 16:02 CET
======================================================================
Summary:                    Wish
Description: 
The Four Channel Mode is great, but is there a possibility to do this for
6ch? i would like to be able to listen from Line-In and SPDIF-in (with a
stereo source) to all channels, or at least 4+LFE.  Right now i just
swaped C/LFE with SR/SL in order to get at least some LFE.
The method stated in FAQ028 is only for Wave-Out (or not?)
======================================================================

----------------------------------------------------------------------
 tiwai - 12-07-05 16:02 
----------------------------------------------------------------------
There seems no signal routing from 2-channel input to 6-channels.  So, it
has to be done on software...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-03-05 10:32 amp77          New Issue                                    
12-03-05 10:32 amp77          Distribution              => Debian stable (sarge)
12-03-05 10:32 amp77          Kernel Version            => 2.6.8-2         
12-03-05 10:33 amp77          Issue Monitored: amp77                       
12-07-05 16:02 tiwai          Note Added: 0006944                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
