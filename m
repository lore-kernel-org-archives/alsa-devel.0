From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001273]: snd_intel8x0 and kexec() don't work together
Date: Sun, 4 Sep 2005 07:30:34 +0200
Message-ID: <c5b158fb88405ff4b838d6986c35ba6b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 47C0F169
	for <alsa-devel@alsa-project.org>; Sun,  4 Sep 2005 07:30:35 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1273> 
======================================================================
Reported By:                hildeb
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1273
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian/unstable
Kernel Version:             2.6.13-rc3-git4
======================================================================
Date Submitted:             07-22-2005 10:23 CEST
Last Modified:              09-04-2005 07:30 CEST
======================================================================
Summary:                    snd_intel8x0 and kexec() don't work together
Description: 
Whenever I use kexec() to reboot into a new kernel, sound doesn't work
properly. KDE doesn't display a mixer.

All modules seem to be loaded, though - and after a reboot using
"reboot" instead of "kexec", sound works flawlessly with the same setup.

/etc/init.d/alsa restart doesn't change things, either.

If I unload the sounddriver:

# rmmod snd_intel8x0

and the reload it:

# modprobe snd_intel8x0

I get:

ACPI: PCI Interrupt 0000:00:06.0[A] -> Link [LACI] -> GSI 22 (level, low)
-> IRQ 19
PCI: Setting latency timer of device 0000:00:06.0 to 64
AC'97 warm reset still in progress? [0xffffffff]
Intel ICH: probe of 0000:00:06.0 failed with error -5

======================================================================

----------------------------------------------------------------------
 cartan - 08-09-05 16:19 
----------------------------------------------------------------------
I get the same error messages with a different setting:

This is Linux 2.6.10 on a Foxconn 915 motherboard.  In /proc/pci it says

Bus  0, device  30, function  2:
    Multimedia audio controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6
Family) AC'97 Audio Controller (rev 3).
      IRQ 17.
      I/O at 0xfb00 [0xfbff].
      I/O at 0xfa00 [0xfa3f].
      Non-prefetchable 32 bit memory at 0xfdffe000 [0xfdffe1ff].
      Non-prefetchable 32 bit memory at 0xfdffd000 [0xfdffd0ff].

After I run alsaconf, I get no error and snd_intel8x0 is loaded.  But
alsamixer fails:

alsamixer: function snd_ctl_open failed for default: No such file or
directory

In dmesg, I get similar messages as hildeb:

ACPI: PCI interrupt 0000:00:1e.2[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1e.2 to 64
ALSA /usr/src/alsa-driver-1.0.9b/pci/intel8x0.c:2182: AC'97 warm reset
still in progress? [0x6]
Intel ICH: probe of 0000:00:1e.2 failed with error -5

I installed the alsa-driver-1.0.9b package, but that didn't help, either.



----------------------------------------------------------------------
 hildeb - 09-04-05 07:30 
----------------------------------------------------------------------
I updated to 2.6.13-git3 today and the issue is gone!
You can close this bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-22-05 10:23 hildeb         New Issue                                    
07-22-05 10:23 hildeb         Distribution              => Debian/unstable 
07-22-05 10:23 hildeb         Kernel Version            => 2.6.13-rc3-git4 
07-22-05 10:25 hildeb         Note Added: 0005545                          
07-25-05 11:50 hildeb         Issue Monitored: hildeb                      
08-09-05 15:43 hildeb         Note Added: 0005733                          
08-09-05 16:18 cartan         Note Added: 0005734                          
08-09-05 16:19 cartan         Note Edited: 0005734                         
08-09-05 16:19 cartan         Issue Monitored: cartan                      
09-04-05 07:30 hildeb         Note Added: 0006035                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
