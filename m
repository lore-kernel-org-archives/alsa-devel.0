From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001697]: Sound does not work
Date: Sun, 1 Jan 2006 10:27:15 +0100
Message-ID: <797b35d181610a7b66501f46957e751f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 17921181
	for <alsa-devel@alsa-project.org>; Sun,  1 Jan 2006 10:27:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1697> 
======================================================================
Reported By:                rkoenig
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   1697
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               doesn't matter
Kernel Version:             doesn't matter
======================================================================
Date Submitted:             01-01-2006 10:27 CET
Last Modified:              01-01-2006 10:27 CET
======================================================================
Summary:                    Sound does not work
Description: 
The SiS 7012 based sound controllers on all the mainboards of Fujitsu
Siemens Computers refuse to work. 

The reason is that the hardware setup is done in a way so that the codec
is the tertiary codec. Problem is that during initialisation the
snd_intel8x0 driver checks the ready bit for the tertiary codec on bit 28
of the global status register, but on SiS 7012 the codec ready status is
set in bit 18. But even fixing that in source doesn't help much because
the driver has to many branches that are depending on the chip type
(INTEL, SIS, whatever) so that I get a codec ready, but then subsequent
errors from the codecs.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-01-06 10:27 rkoenig        New Issue                                    
01-01-06 10:27 rkoenig        Distribution              => doesn't matter  
01-01-06 10:27 rkoenig        Kernel Version            => doesn't matter  
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
