From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000766]: Truble with alsa 1.0.7 (1.0.8rc1 too) on 2.6.10
Date: Fri, 31 Dec 2004 14:38:49 +0100
Message-ID: <30a6082b1fa4b33c8685fa644eebfb58@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EFB8B311
	for <alsa-devel@alsa-project.org>; Fri, 31 Dec 2004 14:38:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=766> 
======================================================================
Reported By:                cyclon
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   766
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-31-2004 14:38 CET
Last Modified:              12-31-2004 14:38 CET
======================================================================
Summary:                    Truble with alsa 1.0.7 (1.0.8rc1 too) on 2.6.10
Description: 
Don't compile.

/var/tmp/portage/alsa-driver-1.0.7-r4/work/alsa-driver-1.0.7/drivers/serialmidi.c:
In function `tx_loop':
/var/tmp/portage/alsa-driver-1.0.7-r4/work/alsa-driver-1.0.7/drivers/serialmidi.c:327:
warning: passing arg 3 of pointer to function makes integer from
pointerwithout a cast
/var/tmp/portage/alsa-driver-1.0.7-r4/work/alsa-driver-1.0.7/drivers/serialmidi.c:327:
error: too many arguments to function
make[4]: ***
[/var/tmp/portage/alsa-driver-1.0.7-r4/work/alsa-driver-1.0.7/kbuild/../drivers/serialmidi.o]
Error 1
make[3]: ***
[/var/tmp/portage/alsa-driver-1.0.7-r4/work/alsa-driver-1.0.7/kbuild/../drivers]
Error 2
make[2]: ***
[_module_/var/tmp/portage/alsa-driver-1.0.7-r4/work/alsa-driver-1.0.7/kbuild]
Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.10-gentoo-r1-na'
make: *** [compile] Error 2

!!! ERROR: media-sound/alsa-driver-1.0.7-r4 failed.
!!! Function src_compile, Line 88, Exitcode 2
!!! Parallel Make Failed
!!! If you need support, post the topmost build error, NOT this status
message.

Use: gcc version 3.3.4 20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2,
pie-8.7.6)

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-31-04 14:38 cyclon         New Issue                                    
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
