From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/15] ALSA: oxfw: Change the way to name card
Date: Tue,  9 Dec 2014 00:10:40 +0900
Message-ID: <1418051449-18371-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1418051449-18371-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 2921226053B
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 16:11:01 +0100 (CET)
In-Reply-To: <1418051449-18371-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a preparation for more models. In following commit, members
of 'struct snd_card' related to name becomes to consists of vendor and
model strings in device's config-rom.

Current supported devices also has strings in their config rom, but the
strings are too long to name sound card, thus this driver still keep
hard-coded vendor and model names for them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 53 ++++++++++++++++++++++++++++------------------
 sound/firewire/oxfw/oxfw.h |  4 ++--
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 951d9a4..dd576bf 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -25,14 +25,34 @@ MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("snd-firewire-speakers");
 
-static u32 oxfw_read_firmware_version(struct fw_unit *unit)
+static int name_card(struct snd_oxfw *oxfw)
 {
-	__be32 data;
+	struct fw_device *fw_dev = fw_parent_device(oxfw->unit);
+	const char *d, *v, *m;
+	u32 firmware;
 	int err;
 
-	err = snd_fw_transaction(unit, TCODE_READ_QUADLET_REQUEST,
-				 OXFORD_FIRMWARE_ID_ADDRESS, &data, 4, 0);
-	return err >= 0 ? be32_to_cpu(data) : 0;
+	err = snd_fw_transaction(oxfw->unit, TCODE_READ_QUADLET_REQUEST,
+				 OXFORD_FIRMWARE_ID_ADDRESS, &firmware, 4, 0);
+	if (err < 0)
+		goto end;
+	be32_to_cpus(&firmware);
+
+	d = oxfw->device_info->driver_name;
+	v = oxfw->device_info->vendor_name;
+	m = oxfw->device_info->model_name;
+
+	strcpy(oxfw->card->driver, d);
+	strcpy(oxfw->card->mixername, m);
+	strcpy(oxfw->card->shortname, m);
+
+	snprintf(oxfw->card->longname, sizeof(oxfw->card->longname),
+		 "%s %s (OXFW%x %04x), GUID %08x%08x at %s, S%d",
+		 v, m, firmware >> 20, firmware & 0xffff,
+		 fw_dev->config_rom[3], fw_dev->config_rom[4],
+		 dev_name(&oxfw->unit->device), 100 << fw_dev->max_speed);
+end:
+	return err;
 }
 
 static void oxfw_card_free(struct snd_card *card)
@@ -45,10 +65,8 @@ static void oxfw_card_free(struct snd_card *card)
 static int oxfw_probe(struct fw_unit *unit,
 		       const struct ieee1394_device_id *id)
 {
-	struct fw_device *fw_dev = fw_parent_device(unit);
 	struct snd_card *card;
 	struct snd_oxfw *oxfw;
-	u32 firmware;
 	int err;
 
 	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
@@ -63,16 +81,9 @@ static int oxfw_probe(struct fw_unit *unit,
 	oxfw->unit = unit;
 	oxfw->device_info = (const struct device_info *)id->driver_data;
 
-	strcpy(card->driver, oxfw->device_info->driver_name);
-	strcpy(card->shortname, oxfw->device_info->short_name);
-	firmware = oxfw_read_firmware_version(unit);
-	snprintf(card->longname, sizeof(card->longname),
-		 "%s (OXFW%x %04x), GUID %08x%08x at %s, S%d",
-		 oxfw->device_info->long_name,
-		 firmware >> 20, firmware & 0xffff,
-		 fw_dev->config_rom[3], fw_dev->config_rom[4],
-		 dev_name(&unit->device), 100 << fw_dev->max_speed);
-	strcpy(card->mixername, "OXFW");
+	err = name_card(oxfw);
+	if (err < 0)
+		goto error;
 
 	err = snd_oxfw_create_pcm(oxfw);
 	if (err < 0)
@@ -123,8 +134,8 @@ static void oxfw_remove(struct fw_unit *unit)
 
 static const struct device_info griffin_firewave = {
 	.driver_name = "FireWave",
-	.short_name  = "FireWave",
-	.long_name   = "Griffin FireWave Surround",
+	.vendor_name = "Griffin",
+	.model_name = "FireWave",
 	.pcm_constraints = firewave_constraints,
 	.mixer_channels = 6,
 	.mute_fb_id   = 0x01,
@@ -133,8 +144,8 @@ static const struct device_info griffin_firewave = {
 
 static const struct device_info lacie_speakers = {
 	.driver_name = "FWSpeakers",
-	.short_name  = "FireWire Speakers",
-	.long_name   = "LaCie FireWire Speakers",
+	.vendor_name = "LaCie",
+	.model_name = "FireWire Speakers",
 	.pcm_constraints = lacie_speakers_constraints,
 	.mixer_channels = 1,
 	.mute_fb_id   = 0x01,
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 6164bf3..a61c75c 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -28,8 +28,8 @@
 
 struct device_info {
 	const char *driver_name;
-	const char *short_name;
-	const char *long_name;
+	const char *vendor_name;
+	const char *model_name;
 	int (*pcm_constraints)(struct snd_pcm_runtime *runtime);
 	unsigned int mixer_channels;
 	u8 mute_fb_id;
-- 
2.1.0
