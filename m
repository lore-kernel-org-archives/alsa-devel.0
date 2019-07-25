From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Allow bus error handler to be
	called directly" to the asoc tree
Date: Thu, 25 Jul 2019 18:43:40 +0100 (BST)
Message-ID: <20190725174340.C7EC92742BAE@ypsilon.sirena.org.uk>
References: <20190725163931.24964-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97BD5F803D0
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 19:43:42 +0200 (CEST)
In-Reply-To: <20190725163931.24964-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Allow bus error handler to be called directly

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 01ec57a4371e573bfcfa898307af098a8c6f9dcf Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 25 Jul 2019 17:39:29 +0100
Subject: [PATCH] ASoC: wm_adsp: Allow bus error handler to be called directly

There is no need for end drivers to add helper functions to allow the
bus error handler to be called, simply update the prototype so it can be
called directly.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20190725163931.24964-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs47l90.c | 9 +--------
 sound/soc/codecs/wm_adsp.c | 6 ++++--
 sound/soc/codecs/wm_adsp.h | 4 ++--
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/cs47l90.c b/sound/soc/codecs/cs47l90.c
index c4ecb0e6911a..67cac60a859d 100644
--- a/sound/soc/codecs/cs47l90.c
+++ b/sound/soc/codecs/cs47l90.c
@@ -2402,13 +2402,6 @@ static irqreturn_t cs47l90_adsp2_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t cs47l90_dsp_bus_error(int irq, void *data)
-{
-	struct wm_adsp *dsp = (struct wm_adsp *)data;
-
-	return wm_adsp2_bus_error(dsp);
-}
-
 static int cs47l90_component_probe(struct snd_soc_component *component)
 {
 	struct cs47l90 *cs47l90 = snd_soc_component_get_drvdata(component);
@@ -2558,7 +2551,7 @@ static int cs47l90_probe(struct platform_device *pdev)
 
 		if (ret == 0) {
 			ret = madera_init_bus_error_irq(&cs47l90->core, i,
-							cs47l90_dsp_bus_error);
+							wm_adsp2_bus_error);
 			if (ret != 0)
 				wm_adsp2_remove(&cs47l90->core.adsp[i]);
 		}
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f5fbadc5e7e2..ae28d9907c30 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -4242,8 +4242,9 @@ static void wm_adsp_fatal_error(struct wm_adsp *dsp)
 	}
 }
 
-irqreturn_t wm_adsp2_bus_error(struct wm_adsp *dsp)
+irqreturn_t wm_adsp2_bus_error(int irq, void *data)
 {
+	struct wm_adsp *dsp = (struct wm_adsp *)data;
 	unsigned int val;
 	struct regmap *regmap = dsp->regmap;
 	int ret = 0;
@@ -4307,8 +4308,9 @@ irqreturn_t wm_adsp2_bus_error(struct wm_adsp *dsp)
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_bus_error);
 
-irqreturn_t wm_halo_bus_error(struct wm_adsp *dsp)
+irqreturn_t wm_halo_bus_error(int irq, void *data)
 {
+	struct wm_adsp *dsp = (struct wm_adsp *)data;
 	struct regmap *regmap = dsp->regmap;
 	unsigned int fault[6];
 	struct reg_sequence clear[] = {
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 3b03d1eb986f..aa634ef6c9f5 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -171,8 +171,8 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 int wm_adsp_early_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *kcontrol, int event);
 
-irqreturn_t wm_adsp2_bus_error(struct wm_adsp *adsp);
-irqreturn_t wm_halo_bus_error(struct wm_adsp *dsp);
+irqreturn_t wm_adsp2_bus_error(int irq, void *data);
+irqreturn_t wm_halo_bus_error(int irq, void *data);
 irqreturn_t wm_halo_wdt_expire(int irq, void *data);
 
 int wm_adsp_event(struct snd_soc_dapm_widget *w,
-- 
2.20.1
