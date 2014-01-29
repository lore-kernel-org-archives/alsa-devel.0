From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 43/52] oxfw: Change the way to name card
Date: Wed, 29 Jan 2014 22:44:50 +0900
Message-ID: <1391003099-7109-44-git-send-email-o-takashi@sakamocchi.jp>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
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

'struct snd_card' has 4 members for name. They're 'driver', 'shortname',
'longname' and 'mixername'. The 'driver' is used to detect card
Configuration file but the others are not used for important
functionality. So it's OK to name them with the information from config
ROM.

This commit adds 'name_card()' function and change the way to name card.
The 'driver' is still given by 'struct device_info'. The 'shortname' and
'mixername' is given by 'model' and the 'longname' is given by 'vendor'
and 'model'.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 59 +++++++++++++++++++++++++++++-----------------
 sound/firewire/oxfw/oxfw.h |  2 --
 2 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index fdb5d78..6d64364 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -25,14 +25,44 @@ MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("snd-firewire-speakers");
 
-static u32 oxfw_read_firmware_version(struct fw_unit *unit)
+static int name_card(struct snd_oxfw *oxfw)
 {
-	__be32 data;
+	struct fw_device *fw_dev = fw_parent_device(oxfw->unit);
+	char vendor[24] = {0};
+	char model[24] = {0};
+	u32 firmware;
 	int err;
 
-	err = snd_fw_transaction(unit, TCODE_READ_QUADLET_REQUEST,
-				 OXFORD_FIRMWARE_ID_ADDRESS, &data, 4, 0);
-	return err >= 0 ? be32_to_cpu(data) : 0;
+	/* get vendor name from root directory */
+	err = fw_csr_string(fw_dev->config_rom + 5, CSR_VENDOR,
+			    vendor, sizeof(vendor));
+	if (err < 0)
+		goto end;
+
+	/* get model name from unit directory */
+	err = fw_csr_string(oxfw->unit->directory, CSR_MODEL,
+			    model, sizeof(model));
+	if (err < 0)
+		goto end;
+
+	err = snd_fw_transaction(oxfw->unit, TCODE_READ_QUADLET_REQUEST,
+				 OXFORD_FIRMWARE_ID_ADDRESS, &firmware, 4, 0);
+	if (err < 0)
+		goto end;
+	be32_to_cpus(&firmware);
+
+	strcpy(oxfw->card->driver, oxfw->device_info->driver_name);
+	strcpy(oxfw->card->shortname, model);
+
+	snprintf(oxfw->card->longname, sizeof(oxfw->card->longname),
+		 "%s %s (OXFW%x %04x), GUID %08x%08x at %s, S%d",
+		 vendor, model, firmware >> 20, firmware & 0xffff,
+		 fw_dev->config_rom[3], fw_dev->config_rom[4],
+		 dev_name(&oxfw->unit->device), 100 << fw_dev->max_speed);
+
+	strcpy(oxfw->card->mixername, oxfw->card->shortname);
+end:
+	return err;
 }
 
 static void oxfw_card_free(struct snd_card *card)
@@ -45,10 +75,8 @@ static void oxfw_card_free(struct snd_card *card)
 static int oxfw_probe(struct fw_unit *unit,
 		       const struct ieee1394_device_id *id)
 {
-	struct fw_device *fw_dev = fw_parent_device(unit);
 	struct snd_card *card;
 	struct snd_oxfw *oxfw;
-	u32 firmware;
 	int err;
 
 	err = snd_card_create(-1, NULL, THIS_MODULE, sizeof(*oxfw), &card);
@@ -62,16 +90,9 @@ static int oxfw_probe(struct fw_unit *unit,
 	oxfw->device_info = (const struct device_info *)id->driver_data;
 	mutex_init(&oxfw->mutex);
 
-	strcpy(card->driver, oxfw->device_info->driver_name);
-	strcpy(card->shortname, oxfw->device_info->short_name);
-	firmware = oxfw_read_firmware_version(unit);
-	snprintf(card->longname, sizeof(card->longname),
-		 "%s (OXFW%x %04x), GUID %08x%08x at %s, S%d",
-		 oxfw->device_info->long_name,
-		 firmware >> 20, firmware & 0xffff,
-		 fw_dev->config_rom[3], fw_dev->config_rom[4],
-		 dev_name(&unit->device), 100 << fw_dev->max_speed);
-	strcpy(card->mixername, "OXFW970");
+	err = name_card(oxfw);
+	if (err < 0)
+		goto err_card;
 
 	err = snd_oxfw_stream_init(oxfw);
 	if (err < 0)
@@ -119,8 +140,6 @@ static void oxfw_remove(struct fw_unit *unit)
 
 static const struct device_info griffin_firewave = {
 	.driver_name = "FireWave",
-	.short_name  = "FireWave",
-	.long_name   = "Griffin FireWave Surround",
 	.pcm_constraints = firewave_constraints,
 	.mixer_channels = 6,
 	.mute_fb_id   = 0x01,
@@ -129,8 +148,6 @@ static const struct device_info griffin_firewave = {
 
 static const struct device_info lacie_speakers = {
 	.driver_name = "FWSpeakers",
-	.short_name  = "FireWire Speakers",
-	.long_name   = "LaCie FireWire Speakers",
 	.pcm_constraints = lacie_speakers_constraints,
 	.mixer_channels = 1,
 	.mute_fb_id   = 0x01,
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index b65c6bd..0a97592 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -28,8 +28,6 @@
 
 struct device_info {
 	const char *driver_name;
-	const char *short_name;
-	const char *long_name;
 	int (*pcm_constraints)(struct snd_pcm_runtime *runtime);
 	unsigned int mixer_channels;
 	u8 mute_fb_id;
-- 
1.8.3.2


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
