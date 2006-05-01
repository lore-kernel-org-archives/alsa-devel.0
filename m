From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: au88x0 Init before create components
Date: Mon, 1 May 2006 22:17:48 +0100
Message-ID: <200605012217.48660.gineera@aspect135.co.uk>
References: <200604261414.52173.gineera@aspect135.co.uk> <s5h8xps5qcv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8rnVETImgVaX+2K"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8xps5qcv.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net, manuel.jander@gmail.com
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_8rnVETImgVaX+2K
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 26 April 2006 16:05, you wrote:
>
> Anyway, I'd suggest to move the definition of driver, shortname and
> longname there with a short comment that it's needed for mpu401
> instance, and keep the rest as it is.
>
> Also, I feel "Aureal au8810 MIDI 0" is more intuitive than
> "MIDI Aureal au8810 0".  It's a matter of taste, though...

Reduced patch is attached

Regards  Alan

Change the order in vortex_probe to set the card details before creating the 
components, meaning for example that card->shortname is available when 
registering the midi port.

I have also added extra to card->shortname, and a line to overwrite the midi 
name following snd_mpu401_uart_new.

au88x0-card-details-midi-name.patch

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>

--Boundary-00=_8rnVETImgVaX+2K
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="au88x0-card-details-midi-name.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="au88x0-card-details-midi-name.patch"

diff -ru alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0.c alsa-driver-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0.c
--- alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0.c	2006-01-13 17:16:29.000000000 +0000
+++ alsa-driver-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0.c	2006-04-24 08:12:16.000000000 +0100
@@ -261,6 +261,13 @@
 		return err;
 	}
 	snd_vortex_workaround(pci, pcifix[dev]);
+
+	// Card details needed in snd_vortex_midi
+	strcpy(card->driver, CARD_NAME_SHORT);
+	sprintf(card->shortname, "Aureal Vortex %s", CARD_NAME_SHORT);
+	sprintf(card->longname, "%s at 0x%lx irq %i",
+		card->shortname, chip->io, chip->irq);
+
	// (4) Alloc components.
 	// ADB pcm.
 	if ((err = snd_vortex_new_pcm(chip, VORTEX_PCM_ADB, NR_ADB)) < 0) {
@@ -323,11 +330,6 @@
 #endif

	// (5)
-	strcpy(card->driver, CARD_NAME_SHORT);
-	strcpy(card->shortname, CARD_NAME_SHORT);
-	sprintf(card->longname, "%s at 0x%lx irq %i",
-		card->shortname, chip->io, chip->irq);
-
	if ((err = pci_read_config_word(pci, PCI_DEVICE_ID,
				  &(chip->device))) < 0) {
		snd_card_free(card);
diff -ru alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0_mpu401.c alsa-driver-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0_mpu401.c
--- alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0_mpu401.c	2006-01-13 17:16:29.000000000 +0000
+++ alsa-driver-1.0.11rc3/alsa-kernel/pci/au88x0/au88x0_mpu401.c	2006-04-24 07:57:51.000000000 +0100
@@ -107,6 +107,9 @@
 	mpu = rmidi->private_data;
 	mpu->cport = (unsigned long)(vortex->mmio + VORTEX_MIDI_CMD);
 #endif
+	/* Overwrite MIDI name */
+	snprintf(rmidi->name, sizeof(rmidi->name), "%s MIDI %d", CARD_NAME_SHORT , vortex->card->number);
+
 	vortex->rmidi = rmidi;
 	return 0;
 }

--Boundary-00=_8rnVETImgVaX+2K--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
