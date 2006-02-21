From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001863]: Roland ua-20 stops working
Date: Tue, 21 Feb 2006 13:25:33 +0100
Message-ID: <680ebd6132cd4809606c32e150925f8e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E50A8170
	for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2006 13:25:33 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1863> 
======================================================================
Reported By:                ldk_linux
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1863
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian Sarge, SUSE Linux OSS
Kernel Version:             2.6.15
======================================================================
Date Submitted:             02-21-2006 13:25 CET
Last Modified:              02-21-2006 13:25 CET
======================================================================
Summary:                    Roland ua-20 stops working
Description: 
With the usb-audio alsa driver shipped with kernel 2.6.15 this unit (Roland
ua-20 audio & midi interface) stops working. Under a standard vanilla
kernel alsa clients (xmms, alsaplayer, jack) reports "unable to set hw
parameters" and quit. Under the kernel from the jacklab project
(http://jacklab.net/) no error message is visualized, all seems to work
but there is no audio output.

I've tested the unit with 2.6.12 and 2.6.13 kernels and it works
perfectly.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-21-06 13:25 ldk_linux      New Issue                                    
02-21-06 13:25 ldk_linux      Distribution              => Debian Sarge, SUSE
Linux OSS
02-21-06 13:25 ldk_linux      Kernel Version            => 2.6.15          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
