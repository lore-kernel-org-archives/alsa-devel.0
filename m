From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000306]: compiles, but no sound comes out
Date: Fri, 7 Jan 2005 00:00:35 +0100
Message-ID: <91ece466b88b44be54779b4f492b82e8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C86EE222
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2005 00:00:35 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=306> 
======================================================================
Reported By:                Quietti
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   306
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             self-compiled 2.6.6 vanilla.
======================================================================
Date Submitted:             05-25-2004 20:35 CEST
Last Modified:              01-07-2005 00:00 CET
======================================================================
Summary:                    compiles, but no sound comes out
Description: 
This is a plain vanilla kernel 2.6.6, which uses ALSA 1.0.4.

The kernel compiles fine, the snd_powermac module loads without any error,
but no sound comes up.

Running alsamixer gives me a mixer screen where none of the sliders can be
moved.
======================================================================

----------------------------------------------------------------------
 Quietti - 01-06-05 19:43 
----------------------------------------------------------------------
I never try CVS, so I cannot say.  I only test stable Linux 2.6 release
kernels.

----------------------------------------------------------------------
 Quietti - 01-07-05 00:00 
----------------------------------------------------------------------
The content of CVS and kernel 2.6.10 completely match for the PPC drivers
(CVS cruft shows up as the only difference):

diff -ruN linux-2.6.10/sound/ppc/CVS/Entries alsa-kernel/ppc/CVS/Entries
--- linux-2.6.10/sound/ppc/CVS/Entries  1970-01-01 02:00:00.000000000
+0200
+++ alsa-kernel/ppc/CVS/Entries 2005-01-06 21:10:26.000000000 +0200
@@ -0,0 +1,15 @@
+/Kconfig/1.5/Mon Sep 13 07:14:59 2004//
+/Makefile/1.6/Mon Aug  2 10:06:38 2004//
+/awacs.c/1.26/Wed Aug 18 09:50:49 2004//
+/awacs.h/1.3/Wed May 15 16:31:40 2002//
+/beep.c/1.1/Mon Aug  2 10:06:38 2004/-ko/
+/burgundy.c/1.13/Tue Jul 20 15:54:28 2004//
+/burgundy.h/1.2/Sun Dec 30 09:26:48 2001//
+/daca.c/1.14/Tue Nov 30 14:44:30 2004//
+/keywest.c/1.17/Fri Apr 23 14:18:25 2004//
+/pmac.c/1.43/Tue Dec 21 10:52:47 2004//
+/pmac.h/1.18/Tue Nov 30 14:44:30 2004//
+/powermac.c/1.20/Mon Aug  2 10:06:38 2004//
+/tumbler.c/1.35/Tue Nov 30 14:44:30 2004//
+/tumbler_volume.h/1.2/Tue Aug 27 13:46:15 2002/-ko/
+D
diff -ruN linux-2.6.10/sound/ppc/CVS/Repository
alsa-kernel/ppc/CVS/Repository
--- linux-2.6.10/sound/ppc/CVS/Repository       1970-01-01
02:00:00.000000000 +0200
+++ alsa-kernel/ppc/CVS/Repository      2005-01-06 21:10:26.000000000
+0200
@@ -0,0 +1 @@
+alsa-kernel/ppc
diff -ruN linux-2.6.10/sound/ppc/CVS/Root alsa-kernel/ppc/CVS/Root
--- linux-2.6.10/sound/ppc/CVS/Root     1970-01-01 02:00:00.000000000
+0200
+++ alsa-kernel/ppc/CVS/Root    2005-01-06 21:10:26.000000000 +0200
@@ -0,0 +1 @@
+:pserver:anonymous@cvs.sourceforge.net:/cvsroot/alsa


...therefore, yes, even what's in CVS is broken.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-25-04 20:35 Quietti        New Issue                                    
05-25-04 20:35 Quietti        File Added: asound.state                     
05-25-04 20:35 Quietti        Distribution              => Debian          
05-25-04 20:35 Quietti        Kernel Version            => self-compiled 2.6.6
vanilla.
05-25-04 20:38 Quietti        Issue Monitored: Quietti                     
05-28-04 21:18 tiwai          Note Added: 0001274                          
05-28-04 21:37 Quietti        Note Added: 0001275                          
07-25-04 20:16 Quietti        Note Added: 0001473                          
09-08-04 06:32 Quietti        Note Added: 0001726                          
10-20-04 00:38 Quietti        Note Added: 0002209                          
01-06-05 18:14 Quietti        Note Added: 0003093                          
01-06-05 18:27 rlrevell       Note Added: 0003094                          
01-06-05 19:43 Quietti        Note Added: 0003095                          
01-07-05 00:00 Quietti        Note Added: 0003096                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
