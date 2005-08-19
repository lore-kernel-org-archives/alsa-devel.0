From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001349]: ATI SB400 chipset multiple problems
Date: Fri, 19 Aug 2005 02:43:38 +0200
Message-ID: <d3b23b7bfd8a189620db59ce1ed08e6a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 03B0B207
	for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2005 02:43:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1349> 
======================================================================
Reported By:                gopakita
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1349
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             2.6.12-1.1487
======================================================================
Date Submitted:             08-19-2005 02:43 CEST
Last Modified:              08-19-2005 02:43 CEST
======================================================================
Summary:                    ATI SB400 chipset multiple problems
Description: 
# gst-launch-0.8 filesrc location="/usr/share/sounds/email.wav" ! wavparse
! alsasink
RUNNING pipeline ...
ERROR: from element /pipeline0/alsasink0: ALSA device "default" had an
error.
Additional debug info:
gstalsa.c(1613): gst_alsa_open_audio: /pipeline0/alsasink0:
ALSA error -22: Invalid argument
ERROR: from element /pipeline0/alsasink0: Internal GStreamer error: state
change failed.  File a bug.
Execution ended after 1 iterations (sum 75111000 ns, average 75111000 ns,
min 75111000 ns, max 75111000 ns).

I got this new Laptop - MSI 1013. Basically sound doesn't work on it.
Running xmms/OSS output and using headphones I can hear someything very
very quite.




======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-19-05 02:43 gopakita       New Issue                                    
08-19-05 02:43 gopakita       Distribution              => Fedora Core 4   
08-19-05 02:43 gopakita       Kernel Version            => 2.6.12-1.1487   
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
