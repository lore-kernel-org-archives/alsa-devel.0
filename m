From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Use acpi_dev_present()" to the
	asoc tree
Date: Wed, 27 Jan 2016 18:37:49 +0000
Message-ID: <E1aOUyT-000893-NC@debutante>
References: <04b22878b2fa0a00bad68e1570502fe64f94fb25.1452787340.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D6D612654F1
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 19:37:59 +0100 (CET)
In-Reply-To: <04b22878b2fa0a00bad68e1570502fe64f94fb25.1452787340.git.lukas@wunner.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lukas Wunner <lukas@wunner.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Use acpi_dev_present()

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6f08cbdaac5a3050ea1898aef8ce326030fd1117 Mon Sep 17 00:00:00 2001
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 14 Jan 2016 21:57:20 +0100
Subject: [PATCH] ASoC: Intel: Use acpi_dev_present()

Use shiny new acpi_dev_present() and remove all the boilerplate
to search for a particular ACPI device. No functional change.
Cf. 2d12b6b381ba ("ACPI / utils: Add acpi_dev_present()").

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 17 ++---------------
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 13 +------------
 sound/soc/intel/common/sst-match-acpi.c      | 16 +---------------
 3 files changed, 4 insertions(+), 42 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 90588d6e64fc..e609f089593a 100644
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
index 2d3afddb0a2e..e6cf800ab231 100644
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
index dd077e116d25..c429e2226d40 100644
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
2.7.0.rc3
