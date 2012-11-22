From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/8] ALSA: hdsp: improve firmware caching
Date: Thu, 22 Nov 2012 17:54:58 +0100
Message-ID: <1353603300-3217-7-git-send-email-tiwai@suse.de>
References: <1353603300-3217-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 48D6D261570
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 17:55:09 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 1CDE8A51FE
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 17:55:09 +0100 (CET)
In-Reply-To: <1353603300-3217-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

As the recent firmware code tries to reread and cache the firmware by
itself, it's even better to keep the struct firmware data instead of
keeping a local copy.  Also, it makes little sense to disable the fw
loader for this driver, so added the explicit dependency, too.

Last, but not least, allocate the firmware data loaded via ioctl in
vmalloc'ed buffer instead, as the firmware size isn't that small.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/Kconfig        |  1 +
 sound/pci/rme9652/hdsp.c | 62 ++++++++++++++++++++++++++----------------------
 2 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 59dbb70..947cfb4 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -572,6 +572,7 @@ source "sound/pci/hda/Kconfig"
 
 config SND_HDSP
 	tristate "RME Hammerfall DSP Audio"
+	select FW_LOADER
 	select SND_HWDEP
 	select SND_RAWMIDI
 	select SND_PCM
diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 0d6930c..b8ddbb1 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -59,13 +59,11 @@ MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{RME Hammerfall-DSP},"
 	        "{RME HDSP-9652},"
 		"{RME HDSP-9632}}");
-#ifdef HDSP_FW_LOADER
 MODULE_FIRMWARE("rpm_firmware.bin");
 MODULE_FIRMWARE("multiface_firmware.bin");
 MODULE_FIRMWARE("multiface_firmware_rev11.bin");
 MODULE_FIRMWARE("digiface_firmware.bin");
 MODULE_FIRMWARE("digiface_firmware_rev11.bin");
-#endif
 
 #define HDSP_MAX_CHANNELS        26
 #define HDSP_MAX_DS_CHANNELS     14
@@ -423,12 +421,7 @@ MODULE_FIRMWARE("digiface_firmware_rev11.bin");
 #define HDSP_DMA_AREA_BYTES ((HDSP_MAX_CHANNELS+1) * HDSP_CHANNEL_BUFFER_BYTES)
 #define HDSP_DMA_AREA_KILOBYTES (HDSP_DMA_AREA_BYTES/1024)
 
-/* use hotplug firmware loader? */
-#if defined(CONFIG_FW_LOADER) || defined(CONFIG_FW_LOADER_MODULE)
-#if !defined(HDSP_USE_HWDEP_LOADER)
-#define HDSP_FW_LOADER
-#endif
-#endif
+#define HDSP_FIRMWARE_SIZE	(24413 * 4)
 
 struct hdsp_9632_meters {
     u32 input_peak[16];
@@ -475,7 +468,8 @@ struct hdsp {
 	enum HDSP_IO_Type     io_type;               /* ditto, but for code use */
         unsigned short        firmware_rev;
 	unsigned short	      state;		     /* stores state bits */
-	u32		      firmware_cache[24413]; /* this helps recover from accidental iobox power failure */
+	const struct firmware *firmware;
+	u32                  *fw_uploaded;
 	size_t                period_bytes; 	     /* guess what this is */
 	unsigned char	      max_channels;
 	unsigned char	      qs_in_channels;	     /* quad speed mode for H9632 */
@@ -712,6 +706,17 @@ static int snd_hdsp_load_firmware_from_cache(struct hdsp *hdsp) {
 
 	int i;
 	unsigned long flags;
+	const u32 *cache;
+
+	if (hdsp->fw_uploaded)
+		cache = hdsp->fw_uploaded;
+	else {
+		if (!hdsp->firmware)
+			return -ENODEV;
+		cache = (u32 *)hdsp->firmware->data;
+		if (!cache)
+			return -ENODEV;
+	}
 
 	if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
 
@@ -727,8 +732,8 @@ static int snd_hdsp_load_firmware_from_cache(struct hdsp *hdsp) {
 
 		hdsp_write (hdsp, HDSP_control2Reg, HDSP_S_LOAD);
 
-		for (i = 0; i < 24413; ++i) {
-			hdsp_write(hdsp, HDSP_fifoData, hdsp->firmware_cache[i]);
+		for (i = 0; i < HDSP_FIRMWARE_SIZE / 4; ++i) {
+			hdsp_write(hdsp, HDSP_fifoData, cache[i]);
 			if (hdsp_fifo_wait (hdsp, 127, HDSP_LONG_WAIT)) {
 				snd_printk ("Hammerfall-DSP: timeout during firmware loading\n");
 				return -EIO;
@@ -798,9 +803,7 @@ static int hdsp_get_iobox_version (struct hdsp *hdsp)
 }
 
 
-#ifdef HDSP_FW_LOADER
 static int hdsp_request_fw_loader(struct hdsp *hdsp);
-#endif
 
 static int hdsp_check_for_firmware (struct hdsp *hdsp, int load_on_demand)
 {
@@ -813,10 +816,8 @@ static int hdsp_check_for_firmware (struct hdsp *hdsp, int load_on_demand)
 		snd_printk(KERN_ERR "Hammerfall-DSP: firmware not present.\n");
 		/* try to load firmware */
 		if (! (hdsp->state & HDSP_FirmwareCached)) {
-#ifdef HDSP_FW_LOADER
 			if (! hdsp_request_fw_loader(hdsp))
 				return 0;
-#endif
 			snd_printk(KERN_ERR
 				   "Hammerfall-DSP: No firmware loaded nor "
 				   "cached, please upload firmware.\n");
@@ -3673,9 +3674,7 @@ snd_hdsp_proc_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 			}
 		} else {
 			int err = -EINVAL;
-#ifdef HDSP_FW_LOADER
 			err = hdsp_request_fw_loader(hdsp);
-#endif
 			if (err < 0) {
 				snd_iprintf(buffer,
 					    "No firmware loaded nor cached, "
@@ -5100,8 +5099,18 @@ static int snd_hdsp_hwdep_ioctl(struct snd_hwdep *hw, struct file *file, unsigne
 		if (hdsp_check_for_iobox (hdsp))
 			return -EIO;
 
-		if (copy_from_user(hdsp->firmware_cache, firmware_data, sizeof(hdsp->firmware_cache)) != 0)
+		if (!hdsp->fw_uploaded) {
+			hdsp->fw_uploaded = vmalloc(HDSP_FIRMWARE_SIZE);
+			if (!hdsp->fw_uploaded)
+				return -ENOMEM;
+		}
+
+		if (copy_from_user(hdsp->fw_uploaded, firmware_data,
+				   HDSP_FIRMWARE_SIZE)) {
+			vfree(hdsp->fw_uploaded);
+			hdsp->fw_uploaded = NULL;
 			return -EFAULT;
+		}
 
 		hdsp->state |= HDSP_FirmwareCached;
 
@@ -5330,7 +5339,6 @@ static int snd_hdsp_create_alsa_devices(struct snd_card *card, struct hdsp *hdsp
 	return 0;
 }
 
-#ifdef HDSP_FW_LOADER
 /* load firmware via hotplug fw loader */
 static int hdsp_request_fw_loader(struct hdsp *hdsp)
 {
@@ -5373,16 +5381,13 @@ static int hdsp_request_fw_loader(struct hdsp *hdsp)
 		snd_printk(KERN_ERR "Hammerfall-DSP: cannot load firmware %s\n", fwfile);
 		return -ENOENT;
 	}
-	if (fw->size < sizeof(hdsp->firmware_cache)) {
+	if (fw->size < HDSP_FIRMWARE_SIZE) {
 		snd_printk(KERN_ERR "Hammerfall-DSP: too short firmware size %d (expected %d)\n",
-			   (int)fw->size, (int)sizeof(hdsp->firmware_cache));
-		release_firmware(fw);
+			   (int)fw->size, HDSP_FIRMWARE_SIZE);
 		return -EINVAL;
 	}
 
-	memcpy(hdsp->firmware_cache, fw->data, sizeof(hdsp->firmware_cache));
-
-	release_firmware(fw);
+	hdsp->firmware = fw;
 
 	hdsp->state |= HDSP_FirmwareCached;
 
@@ -5406,7 +5411,6 @@ static int hdsp_request_fw_loader(struct hdsp *hdsp)
 	}
 	return 0;
 }
-#endif
 
 static int __devinit snd_hdsp_create(struct snd_card *card,
 				     struct hdsp *hdsp)
@@ -5504,7 +5508,6 @@ static int __devinit snd_hdsp_create(struct snd_card *card,
 			return err;
 
 		if ((hdsp_read (hdsp, HDSP_statusRegister) & HDSP_DllError) != 0) {
-#ifdef HDSP_FW_LOADER
 			if ((err = hdsp_request_fw_loader(hdsp)) < 0)
 				/* we don't fail as this can happen
 				   if userspace is not ready for
@@ -5514,7 +5517,6 @@ static int __devinit snd_hdsp_create(struct snd_card *card,
 			else
 				/* init is complete, we return */
 				return 0;
-#endif
 			/* we defer initialization */
 			snd_printk(KERN_INFO "Hammerfall-DSP: card initialization pending : waiting for firmware\n");
 			if ((err = snd_hdsp_create_hwdep(card, hdsp)) < 0)
@@ -5568,6 +5570,10 @@ static int snd_hdsp_free(struct hdsp *hdsp)
 
 	snd_hdsp_free_buffers(hdsp);
 
+	if (hdsp->firmware)
+		release_firmware(hdsp->firmware);
+	vfree(hdsp->fw_uploaded);
+
 	if (hdsp->iobase)
 		iounmap(hdsp->iobase);
 
-- 
1.8.0
