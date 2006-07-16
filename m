From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002282]: configure file misinterprets
	with-sequencer option
Date: Sun, 16 Jul 2006 04:42:38 +0200
Message-ID: <c6b84793eefb0d32204dc15675a48e59@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 046A021C
	for <alsa-devel@alsa-project.org>;
	Sun, 16 Jul 2006 04:42:38 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2282> 
======================================================================
Reported By:                jvp256
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2282
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               ubuntu
Kernel Version:             Linux buldeo 2.6.15-26-386 #1 PREEMPT Fri Jul 7
19:27:00 UTC 2006 i686 GNU/Linux
======================================================================
Date Submitted:             07-15-2006 07:21 CEST
Last Modified:              07-16-2006 04:42 CEST
======================================================================
Summary:                    configure file misinterprets with-sequencer option
Description: 
HTML documentation on the intel8x0 driver 
advises to use the configuration option:
--with-sequencer=yes

However, the sequencer is built by default. 
In fact specifying this option does the 
exact opposite of what one would expect. 
It seems to EXCLUDE the sequencer from 
the build!
======================================================================

----------------------------------------------------------------------
 Raymond - 07-16-06 04:42 
----------------------------------------------------------------------
intel8x0 does not support mpu401, the mpu401 interface (snd-mpu401) is
provided by a superio chip on the motherboard.

The sequencer is built by default, but it does not loaded automatically if
you only loaded snd-intel8x0 since there is no dependency between
snd-intel8x0 and sequencer modules

If you want to play midi using softsynth which use alsa sequencer api, you
may need to loaded snd-seq-dummy or snd-virmidi, ... which automatically
load the sequencer module

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-15-06 07:21 jvp256         New Issue                                    
07-15-06 07:21 jvp256         Distribution              => ubuntu          
07-15-06 07:21 jvp256         Kernel Version            => Linux buldeo
2.6.15-26-386 #1 PREEMPT Fri Jul 7 19:27:00 UTC 2006 i686 GNU/Linux
07-16-06 04:42 Raymond        Note Added: 0011027                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
