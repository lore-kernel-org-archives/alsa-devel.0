From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002263]: All sound plays in an endless
	loop
Date: Fri, 7 Jul 2006 16:31:36 +0200
Message-ID: <7cb10404413902a1524fab5f28a29e35@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6792527D
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 16:31:36 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2263> 
======================================================================
Reported By:                NathanF
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2263
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Grafpup Linux
Kernel Version:             2.6.17.3
======================================================================
Date Submitted:             07-07-2006 08:06 CEST
Last Modified:              07-07-2006 16:31 CEST
======================================================================
Summary:                    All sound plays in an endless loop
Description: 
dmesg reports 'snd_via82xx_modem: Unknown symbol snd_verbose_printk'

Playing a sound file results in the first second repeating in an endless
loop until the process is killed. Some applications will not play at all,
flash animations in a browser play silently.
======================================================================

----------------------------------------------------------------------
 vsu - 07-07-06 10:58 
----------------------------------------------------------------------
This looks like an IRQ problem.  Did sound work with older kernels (e.g.,
2.6.16)?

Please attach dmesg output - it may contain useful information to diagnose
the problem.

Also you may try to revert (patch -p1 -R <file.patch) these patches from
your 2.6.17.3 kernel:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=a7b862f663d81858531dfccc0537bc9d8a2a4121

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=75cf7456dd87335f574dcd53c4ae616a2ad71a11

These patches were supposed to stop VIA IRQ setup code from running on
non-motherboard devices, but they seem to break IRQ routing on many
systems.

----------------------------------------------------------------------
 NathanF - 07-07-06 16:31 
----------------------------------------------------------------------
Thanks you for the speedy reply, that boosts my confidence. I've attached
the full txt of dmesg. To answer your other question, yes this worked
under 2.6.16, also under 2.4.29 if that is relevent. I'm wondering if
maybe I tried to compile in too much support trying to get a generic
kernel, since you mention an IRQ problem.

I will try reverting the patches you suggest.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-07-06 08:06 NathanF        New Issue                                    
07-07-06 08:06 NathanF        Distribution              => Grafpup Linux   
07-07-06 08:06 NathanF        Kernel Version            => 2.6.17.3        
07-07-06 10:58 vsu            Note Added: 0010902                          
07-07-06 10:59 vsu            Issue Monitored: vsu                         
07-07-06 16:25 NathanF        File Added: dmesgout.txt                     
07-07-06 16:31 NathanF        Note Added: 0010915                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
