From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 1/3] ASoC: wm_adsp: Allow bus error handler to
	be called directly
Date: Thu, 25 Jul 2019 17:39:29 +0100
Message-ID: <20190725163931.24964-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B67F6F800F5
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 18:39:37 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

There is no need for end drivers to add helper functions to allow the
bus error handler to be called, simply update the prototype so it can be
called directly.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs47l90.c | 9 +--------
 sound/soc/codecs/wm_adsp.c | 6 ++++--
 sound/soc/codecs/wm_adsp.h | 4 ++--
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/cs47l90.c b/sound/soc/codecs/cs47l90.c
index c4ecb0e6911af..67cac60a859dd 100644
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
index f5fbadc5e7e25..ae28d9907c30f 100644
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
index 3b03d1eb986f0..aa634ef6c9f51 100644
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
2.11.0
