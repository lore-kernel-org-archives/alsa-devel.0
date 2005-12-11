From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001640]: Microphone volume too low
Date: Sun, 11 Dec 2005 01:06:03 +0100
Message-ID: <bcb6b2bb74b9eb0de126914723cfb704@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 90F0A13D
	for <alsa-devel@alsa-project.org>; Sun, 11 Dec 2005 01:06:03 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1640> 
======================================================================
Reported By:                jherazob
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1640
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Mepis
Kernel Version:             2.6.11.6
======================================================================
Date Submitted:             12-11-2005 01:06 CET
Last Modified:              12-11-2005 01:06 CET
======================================================================
Summary:                    Microphone volume too low
Description: 
Mic Volume is too low even when set to 100% and with the +20dB booster
turned on. Hardware is OK since in the windows partition with the Via
driver it works loud and clear with the volume at about 20-25% without the
booster. 
Soundcard is an onboard Via AC97 VT8235. The motherboard is an Asrock
K7VM3.Attaching a txt file with output from lspci, /proc/asound/cards and
various amixer outputs. Will also add a 10 second wav that demonstrates
the unuseable low level of the volume. Any other information you need i'll
provide as possible.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-11-05 01:06 jherazob       New Issue                                    
12-11-05 01:06 jherazob       File Added: outputs.txt                      
12-11-05 01:06 jherazob       Distribution              => Mepis           
12-11-05 01:06 jherazob       Kernel Version            => 2.6.11.6        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
