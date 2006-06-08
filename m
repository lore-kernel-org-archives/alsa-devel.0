From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002195]: alsa-driver-1.0.11 doesn't
	compile with Linux Kernel 2.6.17-rc6
Date: Thu, 8 Jun 2006 21:06:12 +0200
Message-ID: <46cf4d14cf8b05b9e0ff5d1da41da7d4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 32A6F177
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jun 2006 21:06:13 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2195> 
======================================================================
Reported By:                JLP
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2195
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.17-rc6
======================================================================
Date Submitted:             06-08-2006 21:06 CEST
Last Modified:              06-08-2006 21:06 CEST
======================================================================
Summary:                    alsa-driver-1.0.11 doesn't compile with Linux Kernel
2.6.17-rc6
Description: 
When I try to compile ALSA drivers 1.0.11 with Linux Kernel 2.6.17-rc6 I
get this error:

In file included from
/var/tmp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/acore/info_oss.c:2:
/var/tmp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/acore/../alsa-kernel/core/info_oss.c:
In function 'snd_sndstat_proc_read':
/var/tmp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/acore/../alsa-kernel/core/info_oss.c:97:
error: 'system_utsname' undeclared (first use in this function)
/var/tmp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/acore/../alsa-kernel/core/info_oss.c:97:
error: (Each undeclared identifier is reported only once
/var/tmp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/acore/../alsa-kernel/core/info_oss.c:97:
error: for each function it appears in.)
make[4]: ***
[/var/tmp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/acore/info_oss.o]
Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: ***
[/var/tmp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11/acore] Error
2
make[3]: *** Waiting for unfinished jobs....
make[2]: ***
[_module_/var/tmp/portage/alsa-driver-1.0.11/work/alsa-driver-1.0.11]
Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.17-rc6'
make: *** [compile] Error 2
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-06 21:06 JLP            New Issue                                    
06-08-06 21:06 JLP            Distribution              => Gentoo Linux    
06-08-06 21:06 JLP            Kernel Version            => 2.6.17-rc6      
======================================================================
