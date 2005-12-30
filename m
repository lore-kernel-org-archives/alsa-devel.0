From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001021]: codec_semaphore: semaphore is not ready [0x1][0x700300]
Date: Fri, 30 Dec 2005 23:33:29 +0100
Message-ID: <2addad1bb9b71e6e5c5a6f001544f3e6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A5F06154
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:33:29 +0100 (MET)
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
Last Modified:              12-30-2005 23:33 CET
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

----------------------------------------------------------------------
 th - 08-04-05 07:51 
----------------------------------------------------------------------
i've got the same problem. When i'm maximizing the volume -- sound gets
noise and distortion.

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:33 
----------------------------------------------------------------------
Any improvement in later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-29-05 16:02 brujo66        New Issue                                    
03-29-05 16:02 brujo66        Distribution              => Linux Gentoo    
03-29-05 16:02 brujo66        Kernel Version            => 2.6.11-r4       
08-04-05 07:51 th             Note Added: 0005639                          
09-28-05 01:49 th             Issue Monitored: th                          
12-30-05 23:33 rlrevell       Note Added: 0007293                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
