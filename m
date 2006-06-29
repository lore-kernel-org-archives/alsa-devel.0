From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002226]: Intel 82801G / ASUSTeK 1153 -
	driver snd_hda_loads but no sound and freeze when doing
	alsasound restart
Date: Thu, 29 Jun 2006 18:02:15 +0200
Message-ID: <ab714d3ce1d20bd1e31b2400aabd2b4f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2850029A
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jun 2006 18:02:16 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2226> 
======================================================================
Reported By:                bgrieder
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2226
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2133_FC5smp #1 SMP
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-23-2006 07:58 CEST
Last Modified:              06-29-2006 18:02 CEST
======================================================================
Summary:                    Intel 82801G / ASUSTeK 1153 - driver snd_hda_loads
but no sound and freeze when doing alsasound restart
Description: 
Hi,

I upgraded to alsa-driver 1.0.11 but to no avail.

My card is running on an ASUS A8JM laptop
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Aud io Controller (rev 02)
        Subsystem: ASUSTeK Computer Inc. Unknown device 1153
        Flags: bus master, fast devsel, latency 0, IRQ 23
        Memory at febfc000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0
Enable -
        Capabilities: [70] Express Unknown type IRQ 0
        Capabilities: [100] Virtual Channel
        Capabilities: [130] Unknown (5)


Th driver was compiled with debug flags; a modprobe snd_hda_intel produces
the following entry in /var/log/messages
Jun 23 07:55:15 asusbg kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI
21 (level, low) -> IRQ 23
Jun 23 07:55:15 asusbg kernel: ALSA
/tmp/alsa-driver-1.0.11/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:654:
codec_mask = 0x3
Jun 23 07:55:17 asusbg kernel: ALSA
/tmp/alsa-driver-1.0.11/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:516:
hda_intel: azx_get_response timeout, switching to single_cmd mode..

Issuing /etc/init.d/alsasound restart will freeze the machine.
No signififcant entry in /var/log/messages

Let me know if you need additional details
Many Thanks and Best Regards


======================================================================

----------------------------------------------------------------------
 tiwai - 06-26-06 16:10 
----------------------------------------------------------------------
It's a bug of FC5 kernel.

----------------------------------------------------------------------
 tiwai - 06-29-06 18:02 
----------------------------------------------------------------------
A workaround was applied to ALSA HG version.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-23-06 07:58 bgrieder       New Issue                                    
06-23-06 07:58 bgrieder       Distribution              => Fedora Core 5   
06-23-06 07:58 bgrieder       Kernel Version            => 2.6.16-1.2133_FC5smp
#1 SMP
06-25-06 16:11 bgrieder       Note Added: 0010513                          
06-25-06 16:42 bgrieder       Note Added: 0010514                          
06-26-06 16:10 tiwai          Note Added: 0010542                          
06-29-06 18:02 tiwai          Status                   assigned => resolved
06-29-06 18:02 tiwai          Resolution               open => fixed       
06-29-06 18:02 tiwai          Note Added: 0010681                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
