From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 2/5] Echoaudio - add suspend/resume support
Date: Sun, 14 Feb 2010 18:15:51 +0100
Message-ID: <20100214181551.5c066021@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out30.alice.it (smtp-out30.alice.it [85.33.2.30])
	by alsa0.perex.cz (Postfix) with ESMTP id 541E8103812
	for <alsa-devel@alsa-project.org>; Sun, 14 Feb 2010 18:16:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

2/4 Add firmware cache #2:
	This patch changes get_firmware(), free_firmware() and adds
	free_firmware_cache(). The first two functions implement a very
	simple cache and the latter is used to actually release all the
	stored firmwares when the module is unloaded.
	When CONFIG_PM is not enabled those functions act as before, that
	is free_firmware() releases the firmware immediately and
	free_firmware_cache() does nothing.

Short description:

This patch implements a simple cache for the firmware files when CONFIG_PM is defined.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>


diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/echoaudio.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.c
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/echoaudio.c	2010-01-29 23:08:13.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.c	2010-01-29 23:09:09.000000000 +0100
@@ -43,12 +43,24 @@ static int get_firmware(const struct fir
 {
 	int err;
 	char name[30];
-	const struct firmware *frm = &card_fw[fw_index];
 
-	DE_ACT(("firmware requested: %s\n", frm->data));
-	snprintf(name, sizeof(name), "ea/%s", frm->data);
-	if ((err = request_firmware(fw_entry, name, pci_device(chip))) < 0)
+#ifdef CONFIG_PM
+	if (chip->fw_cache[fw_index]) {
+		DE_ACT(("firmware requested: %s is cached\n", card_fw[fw_index].data));
+		*fw_entry = chip->fw_cache[fw_index];
+		return 0;
+	}
+#endif
+
+	DE_ACT(("firmware requested: %s\n", card_fw[fw_index].data));
+	snprintf(name, sizeof(name), "ea/%s", card_fw[fw_index].data);
+	err = request_firmware(fw_entry, name, pci_device(chip));
+	if (err < 0)
 		snd_printk(KERN_ERR "get_firmware(): Firmware not available (%d)\n", err);
+#ifdef CONFIG_PM
+	else
+		chip->fw_cache[fw_index] = *fw_entry;
+#endif
 	return err;
 }
 
@@ -56,8 +68,29 @@ static int get_firmware(const struct fir
 
 static void free_firmware(const struct firmware *fw_entry)
 {
+#ifdef CONFIG_PM
+	DE_ACT(("firmware not released (kept in cache)\n"));
+#else
 	release_firmware(fw_entry);
 	DE_ACT(("firmware released\n"));
+#endif
+}
+
+
+
+static void free_firmware_cache(struct echoaudio *chip)
+{
+#ifdef CONFIG_PM
+	int i;
+
+	for (i = 0; i < 8 ; i++)
+		if (chip->fw_cache[i]) {
+			release_firmware(chip->fw_cache[i]);
+			DE_ACT(("release_firmware(%d)\n", i));
+		}
+
+	DE_ACT(("firmware_cache released\n"));
+#endif
 }
 
 
@@ -1880,6 +1913,7 @@ static int snd_echo_free(struct echoaudi
 	pci_disable_device(chip->pci);
 
 	/* release chip data */
+	free_firmware_cache(chip);
 	kfree(chip);
 	DE_INIT(("Chip freed.\n"));
 	return 0;
diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/echoaudio.h alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.h
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/echoaudio.h	2010-01-29 23:08:13.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.h	2010-01-29 23:08:36.000000000 +0100
@@ -449,6 +449,9 @@ struct echoaudio {
 	volatile u32 __iomem *dsp_registers;	/* DSP's register base */
 	u32 active_mask;			/* Chs. active mask or
 						 * punks out */
+#ifdef CONFIG_PM
+	const struct firmware *fw_cache[8];	/* Cached firmwares */
+#endif
 
 #ifdef ECHOCARD_HAS_MIDI
 	u16 mtc_state;				/* State for MIDI input parsing state machine */


-- 
Giuliano.
