From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 05/13] speakers: Change the way to name card
Date: Sat, 11 Jan 2014 00:29:27 +0900
Message-ID: <1389367775-21360-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
 <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B5A5261A3B
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 16:29:53 +0100 (CET)
In-Reply-To: <1389367775-21360-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

'struct snd_card' has four members for name, 'driver', 'shortname',
'longname' and 'mixername'. The 'driver' is used to detect card configuration
file but the others are not used for important functionality. So I name them
with the information from config ROM.

This commit adds 'name_card()' function and change the way to name card.
The 'driver' is still given by 'struct device_info'. The 'shortname' and
'mixername' is given by 'model' and the 'longname' is given by 'vendor'
and 'model'.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/speakers/speakers.c | 59 ++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/sound/firewire/speakers/speakers.c b/sound/firewire/speakers/speakers.c
index 187377e..1b5556b 100644
--- a/sound/firewire/speakers/speakers.c
+++ b/sound/firewire/speakers/speakers.c
@@ -24,14 +24,44 @@ MODULE_DESCRIPTION("FireWire speakers driver");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_LICENSE("GPL v2");
 
-static u32 fwspk_read_firmware_version(struct fw_unit *unit)
+static int name_card(struct fwspk *fwspk)
 {
-	__be32 data;
+	struct fw_device *fw_dev = fw_parent_device(fwspk->unit);
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
+	err = fw_csr_string(fwspk->unit->directory, CSR_MODEL,
+			    model, sizeof(model));
+	if (err < 0)
+		goto end;
+
+	err = snd_fw_transaction(fwspk->unit, TCODE_READ_QUADLET_REQUEST,
+				 OXFORD_FIRMWARE_ID_ADDRESS, &firmware, 4, 0);
+	if (err < 0)
+		goto end;
+	be32_to_cpus(&firmware);
+
+	strcpy(fwspk->card->driver, fwspk->device_info->driver_name);
+	strcpy(fwspk->card->shortname, model);
+
+	snprintf(fwspk->card->longname, sizeof(fwspk->card->longname),
+		 "%s %s (OXFW%x %04x), GUID %08x%08x at %s, S%d",
+		 vendor, model, firmware >> 20, firmware & 0xffff,
+		 fw_dev->config_rom[3], fw_dev->config_rom[4],
+		 dev_name(&fwspk->unit->device), 100 << fw_dev->max_speed);
+
+	strcpy(fwspk->card->mixername, fwspk->card->shortname);
+end:
+	return err;
 }
 
 static void fwspk_card_free(struct snd_card *card)
@@ -49,10 +79,8 @@ static void fwspk_card_free(struct snd_card *card)
 static int fwspk_probe(struct fw_unit *unit,
 		       const struct ieee1394_device_id *id)
 {
-	struct fw_device *fw_dev = fw_parent_device(unit);
 	struct snd_card *card;
 	struct fwspk *fwspk;
-	u32 firmware;
 	int err;
 
 	err = snd_card_create(-1, NULL, THIS_MODULE, sizeof(*fwspk), &card);
@@ -66,16 +94,9 @@ static int fwspk_probe(struct fw_unit *unit,
 	fwspk->device_info = (const struct device_info *)id->driver_data;
 	mutex_init(&fwspk->mutex);
 
-	strcpy(card->driver, fwspk->device_info->driver_name);
-	strcpy(card->shortname, fwspk->device_info->short_name);
-	firmware = fwspk_read_firmware_version(unit);
-	snprintf(card->longname, sizeof(card->longname),
-		 "%s (OXFW%x %04x), GUID %08x%08x at %s, S%d",
-		 fwspk->device_info->long_name,
-		 firmware >> 20, firmware & 0xffff,
-		 fw_dev->config_rom[3], fw_dev->config_rom[4],
-		 dev_name(&unit->device), 100 << fw_dev->max_speed);
-	strcpy(card->mixername, "OXFW970");
+	err = name_card(fwspk);
+	if (err < 0)
+		goto err_card;
 
 	err = snd_fwspk_stream_init(fwspk);
 	if (err < 0)
@@ -124,8 +145,6 @@ static void fwspk_remove(struct fw_unit *unit)
 
 static const struct device_info griffin_firewave = {
 	.driver_name = "FireWave",
-	.short_name  = "FireWave",
-	.long_name   = "Griffin FireWave Surround",
 	.pcm_constraints = firewave_constraints,
 	.mixer_channels = 6,
 	.mute_fb_id   = 0x01,
@@ -134,8 +153,6 @@ static const struct device_info griffin_firewave = {
 
 static const struct device_info lacie_speakers = {
 	.driver_name = "FWSpeakers",
-	.short_name  = "FireWire Speakers",
-	.long_name   = "LaCie FireWire Speakers",
 	.pcm_constraints = lacie_speakers_constraints,
 	.mixer_channels = 1,
 	.mute_fb_id   = 0x01,
-- 
1.8.3.2
