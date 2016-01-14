From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v2 1/1] ASoC: Intel: Use acpi_dev_present()
Date: Thu, 14 Jan 2016 21:57:20 +0100
Message-ID: <04b22878b2fa0a00bad68e1570502fe64f94fb25.1452787340.git.lukas@wunner.de>
References: <cover.1452787340.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net
 [83.223.90.233])
 by alsa0.perex.cz (Postfix) with ESMTP id 88B2026059B
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2016 21:57:44 +0100 (CET)
In-Reply-To: <cover.1452787340.git.lukas@wunner.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Vinod Koul <vinod.koul@intel.com>, "Fang, Yang A" <yang.a.fang@intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Use shiny new acpi_dev_present() and remove all the boilerplate
to search for a particular ACPI device. No functional change.
Cf. 2d12b6b381ba ("ACPI / utils: Add acpi_dev_present()").

v2: Rebase on commit 95f098014815 ("ASoC: Intel: Move apci find
    machine routines").

Cc: Mark Brown <broonie@kernel.org>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Fang, Yang A <yang.a.fang@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 17 ++---------------
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 13 +------------
 sound/soc/intel/common/sst-match-acpi.c      | 16 +---------------
 3 files changed, 4 insertions(+), 42 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 90588d6..e609f08 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -287,33 +287,20 @@ static struct snd_soc_card snd_soc_card_cht = {
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
index 2d3afdd..e6cf800 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -333,20 +333,12 @@ static struct cht_acpi_card snd_soc_cards[] = {
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
@@ -354,10 +346,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
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
diff --git a/sound/soc/intel/common/sst-match-acpi.c b/sound/soc/intel/common/sst-match-acpi.c
index dd077e1..c429e22 100644
--- a/sound/soc/intel/common/sst-match-acpi.c
+++ b/sound/soc/intel/common/sst-match-acpi.c
@@ -13,29 +13,15 @@
  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
  * more details.
  */
-#include <linux/acpi.h>
-#include <linux/device.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
 
 #include "sst-acpi.h"
 
-static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
-				       void *context, void **ret)
-{
-	*(bool *)context = true;
-	return AE_OK;
-}
-
 struct sst_acpi_mach *sst_acpi_find_machine(struct sst_acpi_mach *machines)
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
