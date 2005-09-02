From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 5/6] include, sound: pci_find_device remove (s/pci/cs46xx/cs46xx_lib.c)
Date: Fri, 2 Sep 2005 23:44:55 +0200
Message-ID: <200509022144.j82LitTO031347@wscnet.wsc.cz>
References: <200509022122.j82LMMwV030426@wscnet.wsc.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from wscnet.wsc.cz (wscnet.wsc.cz [212.80.64.118])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C236A172
	for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2005 23:44:55 +0200 (MEST)
In-reply-to: <200509022122.j82LMMwV030426@wscnet.wsc.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org



Generated in 2.6.13-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 include/sound/cs46xx.h        |    1 -
 sound/pci/cs46xx/cs46xx_lib.c |   13 +++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/sound/cs46xx.h b/include/sound/cs46xx.h
--- a/include/sound/cs46xx.h
+++ b/include/sound/cs46xx.h
@@ -1715,7 +1715,6 @@ struct _snd_cs46xx {
 	void (*active_ctrl)(cs46xx_t *, int);
   	void (*mixer_init)(cs46xx_t *);
 
-	struct pci_dev *acpi_dev;
 	int acpi_port;
 	snd_kcontrol_t *eapd_switch; /* for amplifier hack */
 	int accept_valid;	/* accept mmap valid (for OSS) */
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -3548,7 +3548,7 @@ static void clkrun_hack(cs46xx_t *chip, 
 {
 	u16 control, nval;
 	
-	if (chip->acpi_dev == NULL)
+	if (!chip->acpi_port)
 		return;
 
 	chip->amplifier += change;
@@ -3571,15 +3571,20 @@ static void clkrun_hack(cs46xx_t *chip, 
  */
 static void clkrun_init(cs46xx_t *chip)
 {
+	struct pci_dev *pdev;
 	u8 pp;
 
-	chip->acpi_dev = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3, NULL);
-	if (chip->acpi_dev == NULL)
+	chip->acpi_port = 0;
+	
+	pdev = pci_get_device(PCI_VENDOR_ID_INTEL,
+		PCI_DEVICE_ID_INTEL_82371AB_3, NULL);
+	if (pdev == NULL)
 		return;		/* Not a thinkpad thats for sure */
 
 	/* Find the control port */		
-	pci_read_config_byte(chip->acpi_dev, 0x41, &pp);
+	pci_read_config_byte(pdev, 0x41, &pp);
 	chip->acpi_port = pp << 8;
+	pci_dev_put(pdev);
 }
 
 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
