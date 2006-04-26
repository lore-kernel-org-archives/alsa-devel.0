From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: au88x0 Init before create components
Date: Wed, 26 Apr 2006 14:14:52 +0100
Message-ID: <200604261414.52173.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MJ3TEskXo3OcLR1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, mjander@embedded.cl
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_MJ3TEskXo3OcLR1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Patch as suggested by Raymond in one of his copious bug-track notes.

Change the order in vortex_probe to init the card details before creating the 
components, meaning for example that card->shortname is available when 
registering the midi port.

I have also added extra to card->shortname, and a line to overwrite the midi 
name following snd_mpu401_uart_new, for consideration.

Do I have the correct address to cc mjander?

au88x0-init-before-comps-et-al.patch

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>

--Boundary-00=_MJ3TEskXo3OcLR1
Content-Type: text/x-diff;
  charset="us-ascii";
  name="au88x0-init-before-comps-et-al.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="au88x0-init-before-comps-et-al.patch"

diff -ru alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0.c alsa-driver-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0.c
--- alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0.c	2006-01-13 17:16:29.000000000 +0000
+++ alsa-driver-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0.c	2006-04-24 08:12:16.000000000 +0100
@@ -261,7 +261,28 @@
 		return err;
 	}
 	snd_vortex_workaround(pci, pcifix[dev]);
-	// (4) Alloc components.
+	// (4)
+	strcpy(card->driver, CARD_NAME_SHORT);
+	sprintf(card->shortname, "Aureal Vortex %s", CARD_NAME_SHORT);
+	sprintf(card->longname, "%s at 0x%lx irq %i",
+		card->shortname, chip->io, chip->irq);
+
+	if ((err = pci_read_config_word(pci, PCI_DEVICE_ID,
+				  &(chip->device))) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	if ((err = pci_read_config_word(pci, PCI_VENDOR_ID,
+				  &(chip->vendor))) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	if ((err = pci_read_config_byte(pci, PCI_REVISION_ID,
+				  &(chip->rev))) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	// (5) Alloc components.
 	// ADB pcm.
 	if ((err = snd_vortex_new_pcm(chip, VORTEX_PCM_ADB, NR_ADB)) < 0) {
 		snd_card_free(card);
@@ -322,27 +343,6 @@
 	}
 #endif
 
-	// (5)
-	strcpy(card->driver, CARD_NAME_SHORT);
-	strcpy(card->shortname, CARD_NAME_SHORT);
-	sprintf(card->longname, "%s at 0x%lx irq %i",
-		card->shortname, chip->io, chip->irq);
-
-	if ((err = pci_read_config_word(pci, PCI_DEVICE_ID,
-				  &(chip->device))) < 0) {
-		snd_card_free(card);
-		return err;
-	}	
-	if ((err = pci_read_config_word(pci, PCI_VENDOR_ID,
-				  &(chip->vendor))) < 0) {
-		snd_card_free(card);
-		return err;
-	}
-	if ((err = pci_read_config_byte(pci, PCI_REVISION_ID,
-				  &(chip->rev))) < 0) {
-		snd_card_free(card);
-		return err;
-	}
 #ifdef CHIP_AU8830
 	if ((chip->rev) != 0xfe && (chip->rev) != 0xfa) {
 		printk(KERN_ALERT
diff -ru alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0_mpu401.c alsa-driver-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0_mpu401.c
--- alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0_mpu401.c	2006-01-13 17:16:29.000000000 +0000
+++ alsa-driver-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0_mpu401.c	2006-04-24 07:57:51.000000000 +0100
@@ -107,6 +107,9 @@
 	mpu = rmidi->private_data;
 	mpu->cport = (unsigned long)(vortex->mmio + VORTEX_MIDI_CMD);
 #endif
+	/* Overwrite MIDI name */
+	snprintf(rmidi->name, sizeof(rmidi->name), "MIDI %s %d", CARD_NAME_SHORT , vortex->card->number);
+
 	vortex->rmidi = rmidi;
 	return 0;
 }

--Boundary-00=_MJ3TEskXo3OcLR1--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
