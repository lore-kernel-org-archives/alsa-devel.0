From: Christoph Lukas <christoph.lukas@gmx.net>
Subject: ACPI S3 support in intel8x0
Date: Tue, 23 Mar 2004 22:46:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1080078395.1080.51.camel@beja>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-AxXB4Dv7KUFBPDvDjIT1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.126.184])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA04572
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2004 22:47:05 +0100
Received: from [212.227.126.208] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1B5tjf-0000RW-00
	for alsa-devel@alsa-project.org; Tue, 23 Mar 2004 22:46:59 +0100
Received: from [217.235.144.27] (helo=endo.staad.pingworks.net)
	by mrelayng.kundenserver.de with asmtp (TLSv1:EDH-RSA-DES-CBC3-SHA:168)
	(Exim 3.35 #1)
	id 1B5tjf-0003zb-00
	for alsa-devel@alsa-project.org; Tue, 23 Mar 2004 22:46:59 +0100
Received: from beja.staad.pingworks.net
	([192.168.0.61] helo=sat1-w2k ident=cluk)
	by endo.staad.pingworks.net with asmtp
	(Cipher TLSv1:RC4-MD5:128) (Exim 3.35 #1 (Debian))
	id 1B5tjI-0001al-00
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2004 22:46:36 +0100
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


--=-AxXB4Dv7KUFBPDvDjIT1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I have spent some time to get ACPI S3 working on my Dell Latitude D800.
The remaining problem is that the soundcard does not work after resume.

I am running a patched 2.6.3 Kernel with Alsa 1.0.2c.

Without unloading the drivers before suspend I get lots of the following
messages after resume:

Mar 23 21:24:57 beja kernel: ALSA
/usr/src/modules/alsa-driver/kbuild/../pci/int
el8x0.c:606: codec_read 0: semaphore is not ready for register 0x2

I found a posting[1] on acpi-devel@lists.sourceforge.net which seemed to
describe a similar problem with the pci config space not being correctly
saved and restored by the driver.

I used a shell script to save and restore pci config space with
lspci/setpci before suspend and after resume. 
Using this script to restore the pci config space after resume and
calling  
alsactl power D3
alsactl power D0
after resume made the soundcard working again!

Although I have hardly any C skills I then tried to fix the driver code.
You can find my poor patch attached. But now it seems to me that
snd_intel8x0_suspend isn't even called before suspend and I am a bit at
a loss.

Any hints appreciated.

Christoph


[1]:http://sourceforge.net/mailarchive/message.php?msg_id=7591163




--=-AxXB4Dv7KUFBPDvDjIT1
Content-Disposition: attachment; filename=intel8x0.c.diff
Content-Type: text/plain; name=intel8x0.c.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- pci/intel8x0.c.orig	Tue Mar 23 20:04:03 2004
+++ pci/intel8x0.c	Tue Mar 23 21:21:56 2004
@@ -426,6 +426,7 @@
 	
 #ifdef CONFIG_PM
 	int in_suspend;
+	u32 pm_state[16];
 #endif
 };
 
@@ -2182,13 +2183,25 @@
 static int snd_intel8x0_suspend(struct pci_dev *dev, u32 state)
 {
 	intel8x0_t *chip = snd_magic_cast(intel8x0_t, pci_get_drvdata(dev), return -ENXIO);
+	snd_printk("IN SUSPEND0\n");
 	intel8x0_suspend(chip);
+	
+	snd_printk("IN SUSPEND\n");
+	pci_save_state(dev, chip->pm_state);
+	pci_disable_device(dev);
+	pci_set_power_state(dev, state);
+	
 	return 0;
 }
 static int snd_intel8x0_resume(struct pci_dev *dev)
 {
 	intel8x0_t *chip = snd_magic_cast(intel8x0_t, pci_get_drvdata(dev), return -ENXIO);
 	intel8x0_resume(chip);
+	
+	snd_printk("IN RESUME\n");
+	pci_set_power_state(dev, 0);
+	pci_restore_state(dev, chip->pm_state);
+	
 	return 0;
 }
 #else

--=-AxXB4Dv7KUFBPDvDjIT1--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
