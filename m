From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001240]: compile fails on ak4114, macro missing second parameter
Date: Fri, 26 Aug 2005 13:55:24 +0200
Message-ID: <a30f10ffc208854aa077d029dca2391b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4DAE3218
	for <alsa-devel@alsa-project.org>; Fri, 26 Aug 2005 13:55:24 +0200 (MEST)
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


The following issue has been RESOLVED.
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
Status:                     resolved
Distribution:               Gentoo 2005.0 (amd64)
Kernel Version:             2.6.11
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             07-07-2005 20:05 CEST
Last Modified:              08-26-2005 13:55 CEST
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
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001160 Compilation hangs on hda_codec.c and ak...
======================================================================

----------------------------------------------------------------------
 perex - 07-08-05 10:18 
----------------------------------------------------------------------
Yep, it's a dupe, but you're using another special kernel. Can we pass zero
as the second parameter with the Gentoo kernel, too? The current CVS does
it in this way.

----------------------------------------------------------------------
 perex - 08-26-05 13:55 
----------------------------------------------------------------------
No response to additional info and the issue is fixed in CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-07-05 20:05 allanw         New Issue                                    
07-07-05 20:05 allanw         File Added: ak4114-fix.patch                    
07-07-05 20:05 allanw         Distribution              => Gentoo 2005.0 (amd64)
07-07-05 20:05 allanw         Kernel Version            => 2.6.11          
07-07-05 20:07 allanw         Note Added: 0005402                          
07-08-05 10:15 perex          Relationship added       related to 0001160  
07-08-05 10:18 perex          Note Added: 0005403                          
08-26-05 13:55 perex          Status                   assigned => resolved
08-26-05 13:55 perex          Resolution               open => fixed       
08-26-05 13:55 perex          Note Added: 0005946                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
