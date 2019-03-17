From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-motu: use 'version' field of
	unit directory to identify model
Date: Sun, 17 Mar 2019 15:49:29 +0900
Message-ID: <20190317064929.13959-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CABBCF8968A
 for <alsa-devel@alsa-project.org>; Sun, 17 Mar 2019 07:49:38 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Current ALSA firewire-motu driver uses the value of 'model' field
of unit directory in configuration ROM for modalias for MOTU
FireWire models. However, as long as I checked, Pre8 and
828mk3(Hybrid) have the same value for the field (=0x100800).

unit            | version   | model
--------------- | --------- | ----------
828mkII         | 0x000003  | 0x101800
Traveler        | 0x000009  | 0x107800
Pre8            | 0x00000f  | 0x100800 <-
828mk3(FW)      | 0x000015  | 0x106800
AudioExpress    | 0x000033  | 0x104800
828mk3(Hybrid)  | 0x000035  | 0x100800 <-

When updating firmware for MOTU 8pre FireWire from v1.0.0 to v1.0.3,
I got change of the value from 0x100800 to 0x103800. On the other
hand, the value of 'version' field is fixed to 0x00000f. As a quick
glance, the higher 12 bits of the value of 'version' field represent
firmware version, while the lower 12 bits is unknown.

By induction, the value of 'version' field represents actual model.

This commit changes modalias to match the value of 'version' field,
instead of 'model' field. For degug, long name of added sound card
includes hexadecimal value of 'model' field.

Cc: <stable@vger.kernel.org> # v4.19+
Fixes: 6c5e1ac0e144 ("ALSA: firewire-motu: add support for Motu Traveler")

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index 220e61926ea4..513291ba0ab0 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -36,7 +36,7 @@ static void name_card(struct snd_motu *motu)
 	fw_csr_iterator_init(&it, motu->unit->directory);
 	while (fw_csr_iterator_next(&it, &key, &val)) {
 		switch (key) {
-		case CSR_VERSION:
+		case CSR_MODEL:
 			version = val;
 			break;
 		}
@@ -46,7 +46,7 @@ static void name_card(struct snd_motu *motu)
 	strcpy(motu->card->shortname, motu->spec->name);
 	strcpy(motu->card->mixername, motu->spec->name);
 	snprintf(motu->card->longname, sizeof(motu->card->longname),
-		 "MOTU %s (version:%d), GUID %08x%08x at %s, S%d",
+		 "MOTU %s (version:%06x), GUID %08x%08x at %s, S%d",
 		 motu->spec->name, version,
 		 fw_dev->config_rom[3], fw_dev->config_rom[4],
 		 dev_name(&motu->unit->device), 100 << fw_dev->max_speed);
@@ -237,20 +237,20 @@ static const struct snd_motu_spec motu_audio_express = {
 #define SND_MOTU_DEV_ENTRY(model, data)			\
 {							\
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID |	\
-			  IEEE1394_MATCH_MODEL_ID |	\
-			  IEEE1394_MATCH_SPECIFIER_ID,	\
+			  IEEE1394_MATCH_SPECIFIER_ID |	\
+			  IEEE1394_MATCH_VERSION,	\
 	.vendor_id	= OUI_MOTU,			\
-	.model_id	= model,			\
 	.specifier_id	= OUI_MOTU,			\
+	.version	= model,			\
 	.driver_data	= (kernel_ulong_t)data,		\
 }
 
 static const struct ieee1394_device_id motu_id_table[] = {
-	SND_MOTU_DEV_ENTRY(0x101800, &motu_828mk2),
-	SND_MOTU_DEV_ENTRY(0x107800, &snd_motu_spec_traveler),
-	SND_MOTU_DEV_ENTRY(0x106800, &motu_828mk3),	/* FireWire only. */
-	SND_MOTU_DEV_ENTRY(0x100800, &motu_828mk3),	/* Hybrid. */
-	SND_MOTU_DEV_ENTRY(0x104800, &motu_audio_express),
+	SND_MOTU_DEV_ENTRY(0x000003, &motu_828mk2),
+	SND_MOTU_DEV_ENTRY(0x000009, &snd_motu_spec_traveler),
+	SND_MOTU_DEV_ENTRY(0x000015, &motu_828mk3),	/* FireWire only. */
+	SND_MOTU_DEV_ENTRY(0x000035, &motu_828mk3),	/* Hybrid. */
+	SND_MOTU_DEV_ENTRY(0x000033, &motu_audio_express),
 	{ }
 };
 MODULE_DEVICE_TABLE(ieee1394, motu_id_table);
-- 
2.19.1
