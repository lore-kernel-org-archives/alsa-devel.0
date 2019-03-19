From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Don't export wm_adsp2_lock" to
	the asoc tree
Date: Tue, 19 Mar 2019 13:13:15 +0000 (GMT)
Message-ID: <20190319131315.5A63A11288DF@debutante.sirena.org.uk>
References: <20190319115215.22960-6-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AAC04F89712
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 14:13:16 +0100 (CET)
In-Reply-To: <20190319115215.22960-6-ckeepax@opensource.cirrus.com>
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, david.rhodes@cirrus.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Don't export wm_adsp2_lock

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

>From 2b0ee49f129cf3e9885f8d83439024e8116b865c Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 19 Mar 2019 11:52:08 +0000
Subject: [PATCH] ASoC: wm_adsp: Don't export wm_adsp2_lock

This function is not presently called from outside the adsp code and nor
should it be, as such stop exporting it.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 61 +++++++++++++++++++-------------------
 sound/soc/codecs/wm_adsp.h |  1 -
 2 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 5608ed5decca..a9542a56b19e 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2622,6 +2622,36 @@ static int wm_adsp2_ena(struct wm_adsp *dsp)
 	return 0;
 }
 
+static int wm_adsp2_lock(struct wm_adsp *dsp, unsigned int lock_regions)
+{
+	struct regmap *regmap = dsp->regmap;
+	unsigned int code0, code1, lock_reg;
+
+	if (!(lock_regions & WM_ADSP2_REGION_ALL))
+		return 0;
+
+	lock_regions &= WM_ADSP2_REGION_ALL;
+	lock_reg = dsp->base + ADSP2_LOCK_REGION_1_LOCK_REGION_0;
+
+	while (lock_regions) {
+		code0 = code1 = 0;
+		if (lock_regions & BIT(0)) {
+			code0 = ADSP2_LOCK_CODE_0;
+			code1 = ADSP2_LOCK_CODE_1;
+		}
+		if (lock_regions & BIT(1)) {
+			code0 |= ADSP2_LOCK_CODE_0 << ADSP2_LOCK_REGION_SHIFT;
+			code1 |= ADSP2_LOCK_CODE_1 << ADSP2_LOCK_REGION_SHIFT;
+		}
+		regmap_write(regmap, lock_reg, code0);
+		regmap_write(regmap, lock_reg, code1);
+		lock_regions >>= 2;
+		lock_reg += 2;
+	}
+
+	return 0;
+}
+
 static void wm_adsp2_boot_work(struct work_struct *work)
 {
 	struct wm_adsp *dsp = container_of(work,
@@ -3890,37 +3920,6 @@ int wm_adsp_compr_copy(struct snd_compr_stream *stream, char __user *buf,
 }
 EXPORT_SYMBOL_GPL(wm_adsp_compr_copy);
 
-int wm_adsp2_lock(struct wm_adsp *dsp, unsigned int lock_regions)
-{
-	struct regmap *regmap = dsp->regmap;
-	unsigned int code0, code1, lock_reg;
-
-	if (!(lock_regions & WM_ADSP2_REGION_ALL))
-		return 0;
-
-	lock_regions &= WM_ADSP2_REGION_ALL;
-	lock_reg = dsp->base + ADSP2_LOCK_REGION_1_LOCK_REGION_0;
-
-	while (lock_regions) {
-		code0 = code1 = 0;
-		if (lock_regions & BIT(0)) {
-			code0 = ADSP2_LOCK_CODE_0;
-			code1 = ADSP2_LOCK_CODE_1;
-		}
-		if (lock_regions & BIT(1)) {
-			code0 |= ADSP2_LOCK_CODE_0 << ADSP2_LOCK_REGION_SHIFT;
-			code1 |= ADSP2_LOCK_CODE_1 << ADSP2_LOCK_REGION_SHIFT;
-		}
-		regmap_write(regmap, lock_reg, code0);
-		regmap_write(regmap, lock_reg, code1);
-		lock_regions >>= 2;
-		lock_reg += 2;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(wm_adsp2_lock);
-
 static void wm_adsp_fatal_error(struct wm_adsp *dsp)
 {
 	struct wm_adsp_compr *compr;
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 8f09b4419a91..65ccf120dd5b 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -141,7 +141,6 @@ int wm_adsp2_early_event(struct snd_soc_dapm_widget *w,
 			 struct snd_kcontrol *kcontrol, int event,
 			 unsigned int freq);
 
-int wm_adsp2_lock(struct wm_adsp *adsp, unsigned int regions);
 irqreturn_t wm_adsp2_bus_error(struct wm_adsp *adsp);
 
 int wm_adsp2_event(struct snd_soc_dapm_widget *w,
-- 
2.20.1
