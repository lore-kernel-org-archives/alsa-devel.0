From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000608]: module snd-bt87x throws "kernel: Aieee - PCI error!" repeatedly
Date: Tue, 26 Oct 2004 22:08:21 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <b73185eccbad35ed6520557b9dc7ed9a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2ED99312
	for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2004 22:08:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=608> 
======================================================================
Reported By:                orclex
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   608
Category:                   PCI - bt87x
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               debian Linux
Kernel Version:             2.6.9
======================================================================
Date Submitted:             10-26-2004 22:08 CEST
Last Modified:              10-26-2004 22:08 CEST
======================================================================
Summary:                    module snd-bt87x throws "kernel: Aieee - PCI error!"
repeatedly
Description: 
The audio module snd-bt87x throws repeatedly errors.
So dmesg lists errors continual:
Aieee - PCI error! status 0x008008, PCI status 0x8280

/var/log/syslog contains these lines:
Oct 26 20:53:01 orclex kernel: Aieee - PCI error! status 0x008008, PCI
status 0x8280
Oct 26 20:53:36 orclex last message repeated 4 times
Oct 26 20:54:36 orclex last message repeated 7 times
Oct 26 20:55:36 orclex last message repeated 4 times
Oct 26 20:56:36 orclex last message repeated 35 times
Oct 26 20:57:38 orclex last message repeated 28 times
Oct 26 20:58:36 orclex last message repeated 37 times
Oct 26 20:59:36 orclex last message repeated 9 times
Oct 26 21:00:36 orclex last message repeated 157 times
Oct 26 21:01:36 orclex last message repeated 48 times

When I remove the snd-bt87x module the error does not appear.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-26-04 22:08 orclex         New Issue                                    
10-26-04 22:08 orclex         Distribution              => debian Linux    
10-26-04 22:08 orclex         Kernel Version            => 2.6.9           
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
