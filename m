From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002217]: Problems with ASUS A6Km
Date: Wed, 21 Jun 2006 21:37:07 +0200
Message-ID: <25cead559225313796bf76a58771c69e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C04FE142
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jun 2006 21:37:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2217> 
======================================================================
Reported By:                mafm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2217
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-18-2006 05:06 CEST
Last Modified:              06-21-2006 21:37 CEST
======================================================================
Summary:                    Problems with ASUS A6Km
Description: 
I have the same problems described here:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1898 , but I'm
opening a new report because I can't find a way to add a comment there.

I tried that asus-a6km-fix.diff but it doesn't work, in fact it doesn't
appear to have any effect at all.
======================================================================

----------------------------------------------------------------------
 mafm - 06-20-06 20:16 
----------------------------------------------------------------------
Do you mean subsystem_vendor and subsystem_device? Despite the hexadecimal
0x before the numbers in the patch, it looks like the same -- I assume
that lspci uses hexadecimals too but doesn't print the 0x in front of the
numbers.

My model is A6KM Q0012H, with amd64 and DDR instead of DDRII of the Intel
models; and currently I use "acpi=ht" because it has some problems with
the BIOS (it won't boot with the USB attached otherwise). Doing 'echo "7a
57c1" > /proc/asound/card0/codec97#0/ac97#0-0+regs' doesn't work saying
that the device doesn't exists, but I can't think of any other difference
with the other bug reports talking about the same problem: symptoms are
the same, the models of the hardware seem to be the same too, etc.

The patch:
------------------------------------------------------------------------------
diff -r 10a2ea6ebebc pci/ac97/ac97_patch.c
--- a/pci/ac97/ac97_patch.c	Thu Apr 20 12:37:00 2006 +0200
+++ b/pci/ac97/ac97_patch.c	Thu Apr 20 14:55:55 2006 +0200
@@ -2048,7 +2048,10 @@ int patch_alc650(struct snd_ac97 * ac97)
 	/* Enable SPDIF-IN only on Rev.E and above */
 	val = snd_ac97_read(ac97, AC97_ALC650_CLOCK);
 	/* SPDIF IN with pin 47 */
-	if (ac97->spec.dev_flags)
+	if (ac97->spec.dev_flags &&
+	    /* ASUS A6KM requires EAPD */
+	    ! (ac97->subsystem_vendor == 0x1043 &&
+	       ac97->subsystem_device == 0x1103))
 		val |= 0x03; /* enable */
 	else
 		val &= ~0x03; /* disable */
------------------------------------------------------------------------------

lspci -v
------------------------------------------------------------------------------
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
AC'97 Sound Controller (rev a0)
        Subsystem: ASUSTeK Computer Inc. Unknown device 1103
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at e400 [size=256]
        I/O ports at e000 [size=128]
        Capabilities: [48] Power Management version 2
------------------------------------------------------------------------------

lspci -v -n
------------------------------------------------------------------------------
00:02.7 0401: 1039:7012 (rev a0)
        Subsystem: 1043:1103
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at e400 [size=256]
        I/O ports at e000 [size=128]
        Capabilities: [48] Power Management version 2
------------------------------------------------------------------------------

----------------------------------------------------------------------
 eNTi - 06-21-06 21:37 
----------------------------------------------------------------------
any news on this. i'm having EXACTLY the same problem and even the same
laptop. i had it working a while back, with 2.6.16 + patch, which went
into 2.6.17. this is all very confusing.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-18-06 05:06 mafm           New Issue                                    
06-18-06 16:51 ryswic         Issue Monitored: ryswic                      
06-19-06 15:49 mafm           Issue Monitored: mafm                        
06-19-06 15:50 mafm           Note Added: 0010315                          
06-20-06 19:46 tiwai          Note Added: 0010345                          
06-20-06 20:16 mafm           Note Added: 0010354                          
06-21-06 21:37 eNTi           Note Added: 0010405                          
======================================================================



All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
