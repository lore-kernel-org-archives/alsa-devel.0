From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002263]: All sound plays in an endless
	loop
Date: Fri, 7 Jul 2006 16:52:47 +0200
Message-ID: <d49162beb2fe8e29d5b3e12c2a0ae170@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 701F8147
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 16:52:47 +0200 (MEST)
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
Last Modified:              07-07-2006 16:52 CEST
======================================================================
Summary:                    All sound plays in an endless loop
Description: 
dmesg reports 'snd_via82xx_modem: Unknown symbol snd_verbose_printk'

Playing a sound file results in the first second repeating in an endless
loop until the process is killed. Some applications will not play at all,
flash animations in a browser play silently.
======================================================================

----------------------------------------------------------------------
 NathanF - 07-07-06 16:31 
----------------------------------------------------------------------
Thanks you for the speedy reply, that boosts my confidence. I've attached
the full txt of dmesg. To answer your other question, yes this worked
under 2.6.16, also under 2.4.29 if that is relevent. I'm wondering if
maybe I tried to compile in too much support trying to get a generic
kernel, since you mention an IRQ problem.

I will try reverting the patches you suggest.

----------------------------------------------------------------------
 vsu - 07-07-06 16:52 
----------------------------------------------------------------------
The dmesg output is truncated - probably the message buffer in the kernel
or the dmesg program itself was too small.  You can boot with
"log_buf_len=64k" option to set the kernel message buffer size to 64 KB
(this should be enough, unless something floods the buffer with messages),
and use "dmesg -s 65536" to make sure that dmesg reads all data in the
buffer.

However, that dmesg piece confirms that your system uses PIC for IRQ
routing, which is exactly the mode in which that VIA IRQ problems appear
in 2.6.17 (and also 2.6.16.17 - that buggy patches went there too).  And
there is no "VIA IRQ quirk" message for the 0000:00:11.5 PCI device (this
is the builtin audio device in VIA southbridges). Please give the dmesg
output from 2.6.16 for comparison - probably it contains that IRQ quirk
message, which would explain why sound works on 2.6.16 and fails on
2.6.17.

Lots of "Unknown symbol" messages... Probably you have a mixture of
modules built from different sources in /lib/modules/`uname -r`/ directory
(e.g., some from the in-kernel ALSA, some from the externally compiled
version).  If you intend to compile ALSA separately from the kernel, you
should disable all ALSA support in the kernel configuration (enable just
"Sound card support").  Or maybe this is from multiple attempts to compile
and install ALSA drivers for the same kernel.

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
07-07-06 16:52 vsu            Note Added: 0010916                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
