From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001136]: No soundcards found
Date: Sat, 28 May 2005 11:26:12 +0200
Message-ID: <ba71b311f709e5e4d1d31bea875e5858@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C2FBE224
	for <alsa-devel@alsa-project.org>; Sat, 28 May 2005 11:26:12 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1136> 
======================================================================
Reported By:                bassvandijk
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1136
Category:                   PCI - intel8x0
Reproducibility:            random
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.11-gentoo-r9
======================================================================
Date Submitted:             05-28-2005 11:26 CEST
Last Modified:              05-28-2005 11:26 CEST
======================================================================
Summary:                    No soundcards found
Description: 
Hello,

( I first posted this bug on bugs.gentoo.org, but we couldn't figure it
out: 
http://bugs.gentoo.org/show_bug.cgi?id=93086 )

My sound sometimes works and sometimes doesn't.  
  
I have a "SiS AC97 Controller" and I compiled the driver for it in the
kernel.  
Note that the error also occurs when using modules. 
  
The kernel gives the following error while booting:  
  
> dmesg   
...   
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13
09:39:32   
2005 UTC).   
PCI: Enabling device 0000:00:02.7 (0000 -> 0001)   
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5   
ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 5 (level, low) -> IRQ 5   
codec_ready: codec is not ready [0x300000]   
Intel ICH: probe of 0000:00:02.7 failed with error -5   
ALSA device list:   
  No soundcards found.   
...   
   
> lspci -v   
...   
0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
  
Sound Controller (rev a0)   
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 2440  

        Flags: medium devsel, IRQ 5   
        I/O ports at 1400   
        I/O ports at 1080 [size=128]   
        Capabilities: [48] Power Management version 2   
...  
  
> uname -r  
2.6.11-gentoo-r9  

As you can see from the Gentoo bug report, the same error occured on a
vanilla 
sources 2.6.12 kernel.

Like I said, sometimes it just works. This is dmesg when it works:

> dmesg
...
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13
09:39:32 2005 UTC).
PCI: Enabling device 0000:00:02.7 (0000 -> 0001)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 5 (level, low) -> IRQ 5
AC'97 1 does not respond - RESET
AC'97 1 access is not valid [0xffffffff], removing mixer.
Unable to initialize codec
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1
intel8x0_measure_ac97_clock: measured 49639 usecs
intel8x0: clocking to 48000
ALSA device list:
  https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0: SiS SI7012 with
ALC200/200P at 0x1400, irq 5
...

How can I fix this?

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-28-05 11:26 bassvandijk    New Issue                                    
05-28-05 11:26 bassvandijk    Kernel Version            => 2.6.11-gentoo-r9
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
