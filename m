From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 38/38] bebob: Send a cue to load firmware for M-Audio Firewire
	series
Date: Fri, 20 Dec 2013 22:14:29 +0900
Message-ID: <1387545269-3875-39-git-send-email-o-takashi@sakamocchi.jp>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit is optional. The purpose of this commit is to help testers.

Just powering on, these devices below wait to download firmware.
 - Firewire Audiophile
 - Firewire 410
 - Firewire 1814
 - ProjectMix I/O

But firmware version 5058 or later, flash memory in the device stores the
firmware. So this driver can enable these devices by sending a certain cue to
load the firmware. To reading these codes, this cue is a kind of Bootloader
Commands. The role of this cue is to initialize configuration to factory
settings.

I think this functionality should be implemented in user-land. FFADO already
have 'ffado-bridgeco-downloader' to take the device to download firmware. To
read these codes, this cue is a kind of Bootloader Commands. The role of this
cue is to initialize configuration to factory settings

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob.c        | 23 ++++++++-----
 sound/firewire/bebob/bebob.h        |  2 ++
 sound/firewire/bebob/bebob_maudio.c | 69 +++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 9 deletions(-)

diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 65e856e..6952b80 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -179,18 +179,21 @@ bebob_probe(struct fw_unit *unit,
 	}
 
 	if ((entry->vendor_id == VEN_FOCUSRITE) &&
-	    (entry->model_id == MODEL_FOCUSRITE_SAFFIRE_BOTH)) {
+	    (entry->model_id == MODEL_FOCUSRITE_SAFFIRE_BOTH))
 		spec = get_saffire_spec(unit);
-	} else if ((entry->vendor_id == VEN_MAUDIO1) &&
-		   (entry->model_id == MODEL_MAUDIO_AUDIOPHILE_BOTH) &&
-		   !check_audiophile_booted(unit)) {
-			err = 0;
-			goto end;
-	} else {
+	else if ((entry->vendor_id == VEN_MAUDIO1) &&
+		 (entry->model_id == MODEL_MAUDIO_AUDIOPHILE_BOTH) &&
+		 !check_audiophile_booted(unit))
+		spec = NULL;
+	else
 		spec = (const struct snd_bebob_spec *)entry->driver_data;
-	}
+
 	if (spec == NULL) {
-		err = -ENOSYS;
+		if ((entry->vendor_id == VEN_MAUDIO1) ||
+		    (entry->vendor_id == VEN_MAUDIO2))
+			err = snd_bebob_maudio_load_firmware(unit);
+		else
+			err = -ENOSYS;
 		goto end;
 	}
 
@@ -367,6 +370,7 @@ static const struct ieee1394_device_id bebob_id_table[] = {
 	SND_BEBOB_DEV_ENTRY(VEN_FOCUSRITE, MODEL_FOCUSRITE_SAFFIRE_BOTH,
 			    &saffire_spec),
 	/* M-Audio, Firewire 410 */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO2, 0x00010058, NULL),	/* bootloader */
 	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO2, 0x00010046, &maudio_fw410_spec),
 	/* M-Audio, Firewire Audiophile */
 	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, MODEL_MAUDIO_AUDIOPHILE_BOTH,
@@ -380,6 +384,7 @@ static const struct ieee1394_device_id bebob_id_table[] = {
 	/* M-Audio, ProFireLightbridge */
 	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x000100a1, &spec_normal),
 	/* Firewire 1814 */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x00010070, NULL),	/* bootloader */
 	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, MODEL_MAUDIO_FW1814,
 			    &maudio_special_spec),
 	/* M-Audio ProjectMix */
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index c65e7b3..de7f398 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -254,6 +254,8 @@ extern struct snd_bebob_spec maudio_nrv10_spec;
 extern struct snd_bebob_spec maudio_special_spec;
 int snd_bebob_maudio_special_discover(struct snd_bebob *bebob, bool is1814);
 
+int snd_bebob_maudio_load_firmware(struct fw_unit *unit);
+
 #define SND_BEBOB_DEV_ENTRY(vendor, model, data) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index b941042..96e949f 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -16,6 +16,15 @@
  * settings when completing uploading. Then these devices generate bus reset
  * and are recognized as new devices with the firmware.
  *
+ * But with firmware version 5058 or later, the firmware is stored to flash
+ * memory in the device and drivers can tell DM1000 to load the firmware by
+ * sending a cue. This cue must be sent one time.
+ *
+ * If the firmware blobs are in alsa-firmware package, this driver can support
+ * these devices with any firmware versions. (Then this driver need codes to
+ * upload the firmware blob.) But for this, the license of firmware blob needs
+ * to be considered.
+ *
  * For streaming, both of output and input streams are needed for Firewire 410
  * and Ozonic. The single stream is OK for the other devices even if the clock
  * source is not SYT-Match (I note no devices use SYT-Match).
@@ -31,6 +40,20 @@
  * functionality is between 0xffc700700000 to 0xffc70070009c.
  */
 
+/* Offset from information register */
+#define INFO_OFFSET_SW_DATE	0x20
+
+/* Bootloader Protocol Version 1 */
+#define MAUDIO_BOOTLOADER_CUE1	0x00000001
+/*
+ * Initializing configuration to factory settings (= 0x1101), (swapped in line),
+ * Command code is zero (= 0x00),
+ * the number of operands is zero (= 0x00)(at least significant byte)
+ */
+#define MAUDIO_BOOTLOADER_CUE2	0x01110000
+/* padding */
+#define MAUDIO_BOOTLOADER_CUE3	0x00000000
+
 #define MAUDIO_SPECIFIC_ADDRESS	0xffc700000000
 
 #define METER_OFFSET		0x00600000
@@ -58,6 +81,52 @@
 /* for NRV */
 #define UNKNOWN_METER	"Unknown"
 
+/*
+ * For some M-Audio devices, this module just send cue to load firmware. After
+ * loading, the device generates bus reset and newly detected.
+ *
+ * If we make any transactions to load firmware, the operation may failed.
+ */
+int snd_bebob_maudio_load_firmware(struct fw_unit *unit)
+{
+	struct fw_device *device = fw_parent_device(unit);
+	int err, rcode;
+	u64 date;
+	__be32 cues[3] = {
+		MAUDIO_BOOTLOADER_CUE1,
+		MAUDIO_BOOTLOADER_CUE2,
+		MAUDIO_BOOTLOADER_CUE3
+	};
+
+	/* check date of software used to build */
+	err = snd_bebob_read_block(unit, INFO_OFFSET_SW_DATE,
+				   &date, sizeof(u64));
+	if (err < 0)
+		goto end;
+	/*
+	 * firmware version 5058 or later has date later than "20070401", but
+	 * 'date' is not null-terminated.
+	 */
+	if (date < 0x3230303730343031) {
+		dev_err(&unit->device,
+			"Use firmware version 5058 or later\n");
+		err = -ENOSYS;
+		goto end;
+	}
+
+	rcode = fw_run_transaction(device->card, TCODE_WRITE_BLOCK_REQUEST,
+				   device->node_id, device->generation,
+				   device->max_speed, BEBOB_ADDR_REG_REQ,
+				   cues, sizeof(cues));
+	if (rcode != RCODE_COMPLETE) {
+		dev_err(&unit->device,
+			"Failed to send a cue to load firmware\n");
+		err = -EIO;
+	}
+end:
+	return err;
+}
+
 static inline int
 get_meter(struct snd_bebob *bebob, void *buf, unsigned int size)
 {
-- 
1.8.3.2


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
