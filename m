From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002231]: my system blocks 2 out of 4
	time when starting sound device at startup
Date: Thu, 29 Jun 2006 09:31:03 +0200
Message-ID: <083d31d37f55f75bc98a5f9ae8bc62b9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CCF85280
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 09:31:03 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2231> 
======================================================================
Reported By:                adeel
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   2231
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               redhat
Kernel Version:             2.6.11-1.1369_FC4
======================================================================
Date Submitted:             06-25-2006 16:27 CEST
Last Modified:              06-29-2006 09:31 CEST
======================================================================
Summary:                    my system blocks 2 out of 4 time when starting sound
device at startup
Description: 
Hi guys,
	I sure need a bit of help. My system when starting the sound device got
crazy. I had fedora core 4. It starts the network, sound devices upfront
after its starts the kernel I think. There when it tries to start the
audio 2 out of 4 times it crashes. I had to then reset the system.

======================================================================

----------------------------------------------------------------------
 adeel - 06-29-06 09:31 
----------------------------------------------------------------------
Sorry for the typing error I meant at the initializing the audio device 
(not starting the device).These are the errors at the startup. 
[<c0104137>]	show_stack+0x93/0xc8
[<c01042d87>]	show_registers+0x155/0x1e9
[<c01044fe>]	die+0x10c/0x2c4
[<c00268bd1>]	vt_console_print+0x1bf/0x297
[<c0118df5>]	do_page_fault+0x1d9/0x59f
[<c012152f>]	call_console_drivers+0x80/0x14c
[<c0212448>]	vscnprintf+0x14/0x2
[<c01219a2>]	vprintk+0x14/0x21
[<c01219a2>]	vprintk+0x256/0x518
[<c0118c1c>]	d0_page_fault+0x0/0x59f
[<c0103c6b>]	error_code+0x4f/0x54
[<c010404a>]	show_trace+0x1e/0x78
[<c0121748>]	printk+0x1b/0x1f
[<c010417f>]	dump_stack+0x13/0x17
[<c0120908>]	panic+0c45/0x1e2
[<c0118a12>]	bust_spinlocks+0x42/0x4d
[<c0121748>]	printk+0x1b/0x1f
=============================================================
[<c030c019>]	dev_mc_delete+0x194/0x357
=============================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-25-06 16:27 adeel          New Issue                                    
06-25-06 16:27 adeel          File Added: output.txt                       
06-25-06 16:27 adeel          Distribution              => redhat          
06-25-06 16:27 adeel          Kernel Version            => 2.6.11-1.1369_FC4
06-29-06 09:31 adeel          Note Added: 0010644                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
