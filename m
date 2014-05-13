From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 06/15] oxfw: Change the way to name card
Date: Tue, 13 May 2014 23:27:43 +0900
Message-ID: <1399991272-5807-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, fenlason@redhat.com, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The 'struct snd_card' has 4 members for name. They're 'driver', 'shortname',
'longname' and 'mixername'. This commit names these 4 members according to
two members in model-specific structure and reduce rest of members in the
structure.

The reason that alias names are still used it that currently supported devices,
Griffin FireWave and LaCie Firewire Speaker have too long names for model and
vendor field in their config rom to be over allocated buffer for the names.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 51 +++++++++++++++++++++++++++-------------------
 sound/firewire/oxfw/oxfw.h |  3 +--
 2 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index 3d4df12..28e38cf 100644
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
+	m = oxfw->device_info->driver_name;
+
+	strcpy(oxfw->card->driver, d);
+	strcpy(oxfw->card->shortname, m);
+	strcpy(oxfw->card->mixername, m);
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
-	strcpy(card->mixername, "OXFW970");
+	err = name_card(oxfw);
+	if (err < 0)
+		goto error;
 
 	err = snd_oxfw_create_pcm(oxfw);
 	if (err < 0)
@@ -118,9 +129,8 @@ static void oxfw_remove(struct fw_unit *unit)
 }
 
 static const struct device_info griffin_firewave = {
+	.vendor_name = "Griffin",
 	.driver_name = "FireWave",
-	.short_name  = "FireWave",
-	.long_name   = "Griffin FireWave Surround",
 	.pcm_constraints = firewave_constraints,
 	.mixer_channels = 6,
 	.mute_fb_id   = 0x01,
@@ -128,9 +138,8 @@ static const struct device_info griffin_firewave = {
 };
 
 static const struct device_info lacie_speakers = {
+	.vendor_name = "LaCie",
 	.driver_name = "FWSpeakers",
-	.short_name  = "FireWire Speakers",
-	.long_name   = "LaCie FireWire Speakers",
 	.pcm_constraints = lacie_speakers_constraints,
 	.mixer_channels = 1,
 	.mute_fb_id   = 0x01,
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index 6164bf3..b60e91d 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -27,9 +27,8 @@
 #include "../cmp.h"
 
 struct device_info {
+	const char *vendor_name;
 	const char *driver_name;
-	const char *short_name;
-	const char *long_name;
 	int (*pcm_constraints)(struct snd_pcm_runtime *runtime);
 	unsigned int mixer_channels;
 	u8 mute_fb_id;
-- 
1.8.3.2


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
