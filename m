From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000603]: dshare & VIA Technologies VT82xxxxx UHCI USB 1.1 Controller pops
Date: Wed, 14 Sep 2005 15:57:18 +0200
Message-ID: <f5bab672d4ff18339ed0444e9195b8b6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 864E2191
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2005 15:57:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=603> 
======================================================================
Reported By:                Stuart
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   603
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Debian
Kernel Version:             2.6.8-1-686 #1
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-25-2004 23:13 CEST
Last Modified:              09-14-2005 15:57 CEST
======================================================================
Summary:                    dshare & VIA Technologies VT82xxxxx UHCI USB 1.1
Controller pops
Description: 
I changed my motherboard and now sound via dshare pops. My new (very old)
SL-67EV1 motherboard has a VIA VT82xxxxx UHCI USB 1.1 Controller.
Listening with alsaplayer to music on my USB Audiotrak Maya EX7 with
"plug" works fine but listening to music via dshare pops.
/proc/asound/version contains
Advanced Linux Sound Architecture Driver Version 1.0.7rc2.
Compiled on Oct 17 2004 for kernel 2.6.8-1-686.

======================================================================

----------------------------------------------------------------------
 Stuart - 11-02-04 15:06 
----------------------------------------------------------------------
Jaroslav Kysela found the bug in pcm_dmix.c and has corrected it in the
CVS.
On the alsa-user@lists.sourceforge.net list on 29 Oct 2004 he said

"Ok, this problem is that period_time was to set to default value and has

highter priority than period_size. The patch bellow should fix the 
problem:

Index: pcm_dmix.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_dmix.c,v
retrieving revision 1.56
diff -u -r1.56 pcm_dmix.c
--- pcm_dmix.c	15 Sep 2004 18:44:24 -0000	1.56
+++ pcm_dmix.c	29 Oct 2004 10:54:00 -0000
@@ -1206,7 +1206,7 @@

----------------------------------------------------------------------
 jdthood - 09-14-05 15:57 
----------------------------------------------------------------------
>  Jaroslav Kysela found the bug in pcm_dmix.c and has corrected it in the
CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-25-04 23:13 Stuart         New Issue                                    
10-25-04 23:13 Stuart         File Added: .asoundrc                        
10-25-04 23:13 Stuart         Distribution              => Debian          
10-25-04 23:13 Stuart         Kernel Version            => 2.6.8-1-686 #1  
10-25-04 23:17 Stuart         Note Added: 0002263                          
11-02-04 15:01 Stuart         Note Added: 0002296                          
11-02-04 15:06 Stuart         Note Added: 0002297                          
09-14-05 15:57 jdthood        Status                   assigned => resolved
09-14-05 15:57 jdthood        Resolution               open => fixed       
09-14-05 15:57 jdthood        Note Added: 0006165                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
