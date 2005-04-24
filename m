From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001076]: Can't use mmap with device
Date: Mon, 25 Apr 2005 00:08:00 +0200
Message-ID: <932e3ec7c3cfd15f5fda10257cf37840@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2DFF61EA
	for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2005 00:08:00 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1076> 
======================================================================
Reported By:                nachoexr
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1076
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu Linux 4.05 Hoary
Kernel Version:             2.6.11.7
======================================================================
Date Submitted:             04-25-2005 00:08 CEST
Last Modified:              04-25-2005 00:08 CEST
======================================================================
Summary:                    Can't use mmap with device
Description: 
Detected with the Quake 3 (Q3 1.32b linux-i386 Nov 14 2002) that can't
initialize audio with this error:

------- sound initialization -------
Could not mmap dma buffer PROT_WRITE|PROT_READ
trying mmap PROT_WRITE (with associated better compatibility / less
performance code)
/dev/dsp: Input/output error
Could not mmap /dev/dsp
------------------------------------

after many tests the audio works except in applications using mmap. 
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-25-05 00:08 nachoexr       New Issue                                    
04-25-05 00:08 nachoexr       Distribution              => Ubuntu Linux 4.05
Hoary
04-25-05 00:08 nachoexr       Kernel Version            => 2.6.11.7        
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
