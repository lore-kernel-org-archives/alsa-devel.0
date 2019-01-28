From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: glk_rt5682_max98357a: platform
	name fixup support" to the asoc tree
Date: Mon, 28 Jan 2019 18:25:10 +0000 (GMT)
Message-ID: <20190128182510.106791127D29@debutante.sirena.org.uk>
References: <20190125203509.22994-16-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A1D3C26749A
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 19:25:11 +0100 (CET)
In-Reply-To: <20190125203509.22994-16-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: glk_rt5682_max98357a: platform name fixup support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 5b14aa718f5993b0ecee3bbd61557468ac2420bf Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 25 Jan 2019 14:35:09 -0600
Subject: [PATCH] ASoC: Intel: glk_rt5682_max98357a: platform name fixup
 support

Add helper to override dailink platform name, if passed as parameter

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/glk_rt5682_max98357a.c | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index f6597c216fa8..d17126f7757c 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -16,6 +16,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/soc-acpi.h>
 #include "../skylake/skl.h"
 #include "../../codecs/rt5682.h"
 #include "../../codecs/hdac_hdmi.h"
@@ -571,6 +572,10 @@ static struct snd_soc_card glk_audio_card_rt5682_m98357a = {
 static int geminilake_audio_probe(struct platform_device *pdev)
 {
 	struct glk_card_private *ctx;
+	struct snd_soc_acpi_mach *mach;
+	const char *platform_name;
+	struct snd_soc_card *card;
+	int ret;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -578,11 +583,19 @@ static int geminilake_audio_probe(struct platform_device *pdev)
 
 	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
 
-	glk_audio_card_rt5682_m98357a.dev = &pdev->dev;
-	snd_soc_card_set_drvdata(&glk_audio_card_rt5682_m98357a, ctx);
+	card = &glk_audio_card_rt5682_m98357a;
+	card->dev = &pdev->dev;
+	snd_soc_card_set_drvdata(card, ctx);
+
+	/* override plaform name, if required */
+	mach = (&pdev->dev)->platform_data;
+	platform_name = mach->mach_params.platform;
+
+	ret = snd_soc_fixup_dai_links_platform_name(card, platform_name);
+	if (ret)
+		return ret;
 
-	return devm_snd_soc_register_card(&pdev->dev,
-					&glk_audio_card_rt5682_m98357a);
+	return devm_snd_soc_register_card(&pdev->dev, card);
 }
 
 static const struct platform_device_id glk_board_ids[] = {
-- 
2.20.1
