From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 5/5] ASoC: Intel: Use acpi_dev_present
Date: Mon, 23 Nov 2015 15:34:55 +0100
Message-ID: <b7bd5f48fd254fb743b99d5c3e63f95ea8dfd8a7.1448282995.git.lukas@wunner.de>
References: <cover.1448282995.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net
 [176.9.242.54]) by alsa0.perex.cz (Postfix) with ESMTP id 1D10D2654E8
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 15:37:02 +0100 (CET)
In-Reply-To: <cover.1448282995.git.lukas@wunner.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-acpi@vger.kernel.org, devel@acpica.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Use shiny new acpi_dev_present and remove all the boilerplate to search
for a particular ACPI device. No functional change.

Cc: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 sound/soc/intel/atom/sst/sst_acpi.c          | 12 +-----------
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 17 ++---------------
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 13 +------------
 sound/soc/intel/common/sst-acpi.c            | 12 +-----------
 4 files changed, 5 insertions(+), 49 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index bb19b58..ca12aa5 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -223,23 +223,13 @@ static int sst_platform_get_resources(struct intel_sst_drv *ctx)
 	return 0;
 }
 
-static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
-				       void *context, void **ret)
-{
-	*(bool *)context = true;
-	return AE_OK;
-}
-
 static struct sst_machines *sst_acpi_find_machine(
 	struct sst_machines *machines)
 {
 	struct sst_machines *mach;
-	bool found = false;
 
 	for (mach = machines; mach->codec_id; mach++)
-		if (ACPI_SUCCESS(acpi_get_devices(mach->codec_id,
-						  sst_acpi_mach_match,
-						  &found, NULL)) && found)
+		if (acpi_dev_present(mach->codec_id))
 			return mach;
 
 	return NULL;
diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 4e2fcf1..4036f01 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -278,33 +278,20 @@ static struct snd_soc_card snd_soc_card_cht = {
 	.num_controls = ARRAY_SIZE(cht_mc_controls),
 };
 
-static acpi_status snd_acpi_codec_match(acpi_handle handle, u32 level,
-						void *context, void **ret)
-{
-	*(bool *)context = true;
-	return AE_OK;
-}
-
 static int snd_cht_mc_probe(struct platform_device *pdev)
 {
 	int ret_val = 0;
-	bool found = false;
 	struct cht_mc_private *drv;
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
 	if (!drv)
 		return -ENOMEM;
 
-	if (ACPI_SUCCESS(acpi_get_devices(
-					"104C227E",
-					snd_acpi_codec_match,
-					&found, NULL)) && found) {
-		drv->ts3a227e_present = true;
-	} else {
+	drv->ts3a227e_present = acpi_dev_present("104C227E");
+	if (!drv->ts3a227e_present) {
 		/* no need probe TI jack detection chip */
 		snd_soc_card_cht.aux_dev = NULL;
 		snd_soc_card_cht.num_aux_devs = 0;
-		drv->ts3a227e_present = false;
 	}
 
 	/* register the soc card */
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 38d65a3..5e539cd 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -324,20 +324,12 @@ static struct cht_acpi_card snd_soc_cards[] = {
 	{"10EC5650", CODEC_TYPE_RT5650, &snd_soc_card_chtrt5650},
 };
 
-static acpi_status snd_acpi_codec_match(acpi_handle handle, u32 level,
-				       void *context, void **ret)
-{
-	*(bool *)context = true;
-	return AE_OK;
-}
-
 static int snd_cht_mc_probe(struct platform_device *pdev)
 {
 	int ret_val = 0;
 	int i;
 	struct cht_mc_private *drv;
 	struct snd_soc_card *card = snd_soc_cards[0].soc_card;
-	bool found = false;
 	char codec_name[16];
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
@@ -345,10 +337,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(snd_soc_cards); i++) {
-		if (ACPI_SUCCESS(acpi_get_devices(
-						snd_soc_cards[i].codec_id,
-						snd_acpi_codec_match,
-						&found, NULL)) && found) {
+		if (acpi_dev_present(snd_soc_cards[i].codec_id)) {
 			dev_dbg(&pdev->dev,
 				"found codec %s\n", snd_soc_cards[i].codec_id);
 			card = snd_soc_cards[i].soc_card;
diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index 67b6d3d..bc14826 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -88,23 +88,13 @@ static void sst_acpi_fw_cb(const struct firmware *fw, void *context)
 	return;
 }
 
-static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
-				       void *context, void **ret)
-{
-	*(bool *)context = true;
-	return AE_OK;
-}
-
 static struct sst_acpi_mach *sst_acpi_find_machine(
 	struct sst_acpi_mach *machines)
 {
 	struct sst_acpi_mach *mach;
-	bool found = false;
 
 	for (mach = machines; mach->id[0]; mach++)
-		if (ACPI_SUCCESS(acpi_get_devices(mach->id,
-						  sst_acpi_mach_match,
-						  &found, NULL)) && found)
+		if (acpi_dev_present(mach->id))
 			return mach;
 
 	return NULL;
-- 
1.8.5.2 (Apple Git-48)
