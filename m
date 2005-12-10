From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001638]: Wrong Channel Mapping
Date: Sat, 10 Dec 2005 20:57:50 +0100
Message-ID: <af67c8006b0623c18f710092b247e264@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A593716C
	for <alsa-devel@alsa-project.org>; Sat, 10 Dec 2005 20:57:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1638> 
======================================================================
Reported By:                Nikratio
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1638
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Breezy
Kernel Version:             Linux nokile 2.6.12-10-686 #1 Fri Nov 18 12:09:04
UTC 2005 i686 GNU/Linux
======================================================================
Date Submitted:             12-10-2005 20:57 CET
Last Modified:              12-10-2005 20:57 CET
======================================================================
Summary:                    Wrong Channel Mapping
Description: 
I'm using a Terratec Aureon Mk II. According to speaker-test,
the channels are mapped wrong (--> actual speaker):

0 - Front Left -> Front Left 
4 - Center -> Rear Left
1 - Front Right -> Front Right
3 - Rear Right -> LSM
2 - Rear Left -> Center
5 - LFE -> Rear Right

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-10-05 20:57 Nikratio       New Issue                                    
12-10-05 20:57 Nikratio       Distribution              => Ubuntu Breezy   
12-10-05 20:57 Nikratio       Kernel Version            => Linux nokile
2.6.12-10-686 #1 Fri Nov 18 12:09:04 UTC 2005 i686 GNU/Linux
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
