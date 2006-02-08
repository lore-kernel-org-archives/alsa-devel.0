From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001832]: when I try to listen music with xmms, sometimes the soundcard get silent. The O.S. works normally.
Date: Thu, 9 Feb 2006 00:47:43 +0100
Message-ID: <4dcdc9624acf51c456a5b44b441d97ed@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 278281C8
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2006 00:47:43 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1832> 
======================================================================
Reported By:                apolinux
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1832
Category:                   PCI - intel8x0
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian 3.1
Kernel Version:             2.6.14.3
======================================================================
Date Submitted:             02-09-2006 00:47 CET
Last Modified:              02-09-2006 00:47 CET
======================================================================
Summary:                    when I try to listen music with xmms, sometimes the
soundcard get silent. The O.S. works normally.
Description: 
The only problem is with the soundcard driver. I try to restart the
module:
/etc/init.d/alsa restart
but doesn't work. This problem affects the modem too.

The problems happens when the system have booted normally. the first time
I can listen music with xmms, but, If I left the desktop idle many hours,
and after that, I try to listen music with the same session of xmms, I get
silence. The error produced in the kernel is:

irq 177: nobody cared (try booting with the "irqpoll" option)
 [<c0132e55>] __report_bad_irq+0x31/0x77
 [<c0132f28>] note_interrupt+0x75/0x99
 [<c01328c4>] __do_IRQ+0x99/0xe1
 [<c0104dc7>] do_IRQ+0x1b/0x28
 [<c0103c16>] common_interrupt+0x1a/0x20
 [<c010101c>] default_idle+0x0/0x29
 [<c010103f>] default_idle+0x23/0x29
 [<c01010aa>] cpu_idle+0x36/0x4b
 [<c030a69c>] start_kernel+0x185/0x187
handlers:
[<deb7359e>] (snd_intel8x0_interrupt+0x0/0x1ec [snd_intel8x0])
[<debd8480>] (hsfmc97ich10_+0x0/0x20 [hsfmc97ich])
Disabling IRQ #177

and after that, I can't get the soundcard works, until I rebooted the
laptop.

My kernel version is 
Linux andromeda 2.6.14.3 #1 PREEMPT Tue Dec 13 19:00:27 COT 2005 i686
GNU/Linux


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-09-06 00:47 apolinux       New Issue                                    
02-09-06 00:47 apolinux       Distribution              => Debian 3.1      
02-09-06 00:47 apolinux       Kernel Version            => 2.6.14.3        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
