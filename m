From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000535]: via82xx: "codec 0 is not valid..."
Date: Fri, 24 Sep 2004 14:29:05 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924122905.E58CB3E01B@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3A8912A3
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 14:29:06 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id F24172732F
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 14:29:05 +0200 (MEST)
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


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000535
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     535
Category:                   PCI - via82xx
Reproducibility:            have not tried
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             09-24-2004 14:29 CEST
Last Modified:              09-24-2004 14:29 CEST
======================================================================
Summary:                    via82xx: "codec 0 is not valid..."
Description: 
Trying to play any sound at all generates lines like this in the syslog:

kernel: ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/via82xx.c:588:
codec_read: codec 0 is not valid [0xfe0000]
kernel: ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/via82xx.c:727:
invalid via82xx_cur_ptr, using last valid pointer


with no sound ever being produced.  I don't know anything about sound
hardware, so don't know what other information you need.  It's an onboard
chip, listed in the debconf data below.



======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-24-04 14:29 jdthood        New Bug                                      
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
