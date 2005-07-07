From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001240]: compile fails on ak4114, macro missing second parameter
Date: Thu, 7 Jul 2005 20:05:10 +0200
Message-ID: <2cebc6ad99b2db266caa22b21548c61b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E137A1A8
	for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2005 20:05:10 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1240> 
======================================================================
Reported By:                allanw
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1240
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo 2005.0 (amd64)
Kernel Version:             2.6.11
======================================================================
Date Submitted:             07-07-2005 20:05 CEST
Last Modified:              07-07-2005 20:05 CEST
======================================================================
Summary:                    compile fails on ak4114, macro missing second
parameter
Description: 
In file included from
/var/tmp/portage/alsa-driver-1.0.9b/work/alsa-driver-1.0.9b/i2c/other/ak4114.c:1:
/var/tmp/portage/alsa-driver-1.0.9b/work/alsa-driver-1.0.9b/i2c/other/../../alsa-kernel/i2c/other/ak4114.c:109:49:
macro "create_workqueue" requires 2 arguments, but only 1 given
In file included from
/var/tmp/portage/alsa-driver-1.0.9b/work/alsa-driver-1.0.9b/i2c/other/ak4114.c:1:
/var/tmp/portage/alsa-driver-1.0.9b/work/alsa-driver-1.0.9b/i2c/other/../../alsa-kernel/i2c/other/ak4114.c:
In function `snd_ak4114_create':
/var/tmp/portage/alsa-driver-1.0.9b/work/alsa-driver-1.0.9b/i2c/other/../../alsa-kernel/i2c/other/ak4114.c:109:
error: `create_workqueue' undeclared (first use in this function)
/var/tmp/portage/alsa-driver-1.0.9b/work/alsa-driver-1.0.9b/i2c/other/../../alsa-kernel/i2c/other/ak4114.c:109:
error: (Each undeclared identifier is reported only once
/var/tmp/portage/alsa-driver-1.0.9b/work/alsa-driver-1.0.9b/i2c/other/../../alsa-kernel/i2c/other/ak4114.c:109:
error: for each function it appears in.)
make[5]: ***
[/var/tmp/portage/alsa-driver-1.0.9b/work/alsa-driver-1.0.9b/i2c/other/ak4114.o]
Error 1

I can fix the problem by editing ak4114.c and passing PF_SYNCTHREAD as the
second argument to create_workqueue.

Patch attached.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-07-05 20:05 allanw         New Issue                                    
07-07-05 20:05 allanw         File Added: ak4114-fix.patch                    
07-07-05 20:05 allanw         Distribution              => Gentoo 2005.0 (amd64)
07-07-05 20:05 allanw         Kernel Version            => 2.6.11          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
