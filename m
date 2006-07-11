From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000890]: no dialtone with modem &
	strange log "semaphore is not ready [0x1][0x701300]"
Date: Tue, 11 Jul 2006 12:39:05 +0200
Message-ID: <c824d9cad758e63e9276f691865a2dee@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4E80F220
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 12:39:05 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=890> 
======================================================================
Reported By:                hothead
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   890
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.6.9
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             02-08-2005 14:33 CET
Last Modified:              07-11-2006 12:39 CEST
======================================================================
Summary:                    no dialtone with modem & strange log "semaphore is
not ready [0x1][0x701300]"
Description: 
Hi,

I want to tell you that snd-intel8x0m works with the ag&#232;re modem on
my 
thinkpad t41p. The problem is that I can not get the dialtone working.
Do you have any suggestion concerning this problem?


# System Information
# ***********************
System uname: 2.6.9-thinkpad-r1 i686 Intel(R) Pentium(R) M processor
1700MHz
Gentoo Base System version 1.6.9
Python:              dev-lang/python-2.3.4 [2.3.4 (#1, Dec 30 2004,
09:19:20)]
distcc 2.16 i686-pc-linux-gnu (protocols 1 and 2) (default port 3632) 
[enabled]
dev-lang/python:     2.3.4
sys-devel/autoconf:  2.13, 2.59-r6
sys-devel/automake:  1.4_p6, 1.7.9-r1, 1.8.5-r3, 1.6.3, 1.9.4, 1.5
sys-devel/binutils:  2.15.92.0.2-r1
sys-devel/libtool:   1.5.10-r4
virtual/os-headers:  2.6.8.1-r2



# Furthermore I get curious messages from the driver:
# *********************************************************
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/../alsa-kernel/pci/intel8x0m.c:401:

codec_semaphore: semaphore is not ready [0x1][0x701300]
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/../alsa-kernel/pci/intel8x0m.c:415:

codec_write 1: semaphore is not ready for register 0x54
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/../alsa-kernel/pci/intel8x0m.c:401:

codec_semaphore: semaphore is not ready [0x1][0x701300]
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/../alsa-kernel/pci/intel8x0m.c:415:

codec_write 1: semaphore is not ready for register 0x54
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/../alsa-kernel/pci/intel8x0m.c:401:

codec_semaphore: semaphore is not ready [0x1][0x701300]
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/../alsa-kernel/pci/intel8x0m.c:415:

codec_write 1: semaphore is not ready for register 0x54
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/../alsa-kernel/pci/intel8x0m.c:401:

codec_semaphore: semaphore is not ready [0x1][0x701300]
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/../alsa-kernel/pci/intel8x0m.c:415:

codec_write 1: semaphore is not ready for register 0x54


It would be great if you could help me!

Regards

Ruben Jenster
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000509 Conexant Moden &quot;not ready&quot;
related to          0000857 intel8x0m does not work on asus a3n laptop
======================================================================

----------------------------------------------------------------------
 perex - 03-02-05 15:19 
----------------------------------------------------------------------
Please, can you provide output of ac97*regs like in bug #509?

----------------------------------------------------------------------
 jals - 03-03-05 03:13 
----------------------------------------------------------------------
You can take the line off hook using alsamixer. You'll find an Off-Hook
control.
When it is muted, the line is on hook. To take off-hook, unmute it. This
should do.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-08-05 14:33 hothead        New Issue                                    
02-08-05 14:33 hothead        Kernel Version            => 2.6.9           
03-02-05 14:12 perex          Note Added: 0003772                          
03-02-05 15:15 perex          Note Added: 0003778                          
03-02-05 15:17 perex          Relationship added       related to 0000509  
03-02-05 15:19 perex          Note Added: 0003779                          
03-02-05 15:19 perex          Relationship added       related to 0000857  
03-03-05 03:13 jals           Note Added: 0003782                          
07-11-06 12:39 Adrian Bunk    Status                   assigned => closed  
07-11-06 12:39 Adrian Bunk    Resolution               open => unable to
duplicate
07-11-06 12:39 Adrian Bunk    Description Updated                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
