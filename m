From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000239]: add mmap control/status ioctl for architectures with no cache coherent mapping
Date: Fri, 24 Sep 2004 13:32:18 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924113218.88CA6101DE@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CDFCC288
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:32:18 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 8E3A326204
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:32:18 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000239
======================================================================
Reported By:                perex
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     239
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-27-2004 11:46 CEST
Last Modified:              09-24-2004 13:32 CEST
======================================================================
Summary:                    add mmap control/status ioctl for architectures with no cache coherent mapping
Description: 
Add ioctls to synchronize PCM control/status structures
between the kernel and user space.
======================================================================

----------------------------------------------------------------------
 perex - 05-23-2004 11:59 CEST 
----------------------------------------------------------------------
Implemented.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-27-04 11:46 perex          New Bug                                      
05-23-04 11:59 perex          Bugnote Added: 0001179                       
05-23-04 11:59 perex          Resolution               open => fixed       
05-23-04 11:59 perex          Status                   assigned => resolved
09-24-04 13:32 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
