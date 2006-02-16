From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001849]: sound hangs after quarter of a second
Date: Thu, 16 Feb 2006 12:01:20 +0100
Message-ID: <fdea5c9af6902cd16794d70dbbf23ef6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BF1FE1C8
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2006 12:01:20 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1849> 
======================================================================
Reported By:                Marijn Schouten
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1849
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               gentoo
Kernel Version:             2.6.15
======================================================================
Date Submitted:             02-16-2006 12:01 CET
Last Modified:              02-16-2006 12:01 CET
======================================================================
Summary:                    sound hangs after quarter of a second
Description: 
everything seems to work normally, until I actually try to get some sound.
Then it works for a very short time, then the driver hangs the program and
I get a repetition of the first sound produced ad infinitum. For example
speaker-test doesn't get to any "Time per period = 2.662410". Output stops
right before. 

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-16-06 12:01 Marijn SchoutenNew Issue                                    
02-16-06 12:01 Marijn SchoutenDistribution              => gentoo          
02-16-06 12:01 Marijn SchoutenKernel Version            => 2.6.15          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
