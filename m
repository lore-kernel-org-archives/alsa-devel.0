From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001021]: codec_semaphore: semaphore is not ready [0x1][0x700300]
Date: Tue, 29 Mar 2005 16:02:20 +0200
Message-ID: <ce45b7d7ed1386b10e3f65efd1924f86@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 96610267
	for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2005 16:02:20 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1021> 
======================================================================
Reported By:                brujo66
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1021
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Linux Gentoo
Kernel Version:             2.6.11-r4
======================================================================
Date Submitted:             03-29-2005 16:02 CEST
Last Modified:              03-29-2005 16:02 CEST
======================================================================
Summary:                    codec_semaphore: semaphore is not ready
[0x1][0x700300]
Description: 
Hi,

I've tried to install ALSA by two ways: Using the Linux kernel modules and
compiling ALSA with the original files.

When the system load the 'snd-intel8x0' module, it produces the next
messages, visibles by dmesg:

PCI: Enabling device 0000:00:1f.5 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/intel8x0.c:582:
codec_semaphore: semaphore is not ready [0x1][0x700300]
[...] 
[...]
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/intel8x0.c:582:
codec_semaphore: semaphore is not ready [0x1][0x700300]
intel8x0_measure_ac97_clock: measured 49228 usecs
intel8x0: clocking to 48000
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/intel8x0.c:582:
codec_semaphore: semaphore is not ready [0x1][0x700300]
ALSA
/var/tmp/portage/alsa-driver-1.0.8/work/alsa-driver-1.0.8/pci/intel8x0.c:596:
codec_write 0: semaphore is not ready forregister 0x2

Those are the unique kind of message that reports error on the system. 

The module is loaded on the system, but the sound of the music is
distorsionated .

The only solution that i find is to use OSS (not ALSA with OSS
compatibility).

Sorry about my english.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-29-05 16:02 brujo66        New Issue                                    
03-29-05 16:02 brujo66        Distribution              => Linux Gentoo    
03-29-05 16:02 brujo66        Kernel Version            => 2.6.11-r4       
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
