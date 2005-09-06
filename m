From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001400]: sys_siglist unavalible in uclibc
Date: Tue, 6 Sep 2005 22:10:58 +0200
Message-ID: <64f9bfafacce22e31feff3ff505b1764@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 582061B2
	for <alsa-devel@alsa-project.org>; Tue,  6 Sep 2005 22:10:58 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1400> 
======================================================================
Reported By:                mithro
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1400
Category:                   amixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             09-06-2005 21:56 CEST
Last Modified:              09-06-2005 22:10 CEST
======================================================================
Summary:                    sys_siglist unavalible in uclibc
Description: 
amixer uses sys_siglist, this symbol is unavalible when compiling against
the uclibc library. strsignal should be used instead. The patch below
fixes the problem,


--- alsamixer.c.orig    2005-09-06 21:49:26.808435472 +0200
+++ alsamixer.c 2005-09-06 21:49:41.019275096 +0200
@@ -2188,7 +2188,7 @@
 mixer_signal_handler (int signal)
 {
   if (signal != SIGSEGV)
-    mixer_abort (ERR_SIGNAL, sys_siglist[signal], 0);
+    mixer_abort (ERR_SIGNAL, strsignal(signal), 0);
   else
     {
       fprintf (stderr, "\nSegmentation fault.\n");

======================================================================

----------------------------------------------------------------------
 rlrevell - 09-06-05 22:10 
----------------------------------------------------------------------
Does this work equally well with glibc?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-06-05 21:56 mithro         New Issue                                    
09-06-05 22:10 rlrevell       Note Added: 0006049                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
