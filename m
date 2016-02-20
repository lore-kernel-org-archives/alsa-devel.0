From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Fixup some odd line wrapping"
	to the asoc tree
Date: Sun, 21 Feb 2016 03:10:42 +0900
Message-ID: <E1aXBzO-0001lm-MD@finisterre>
References: <1455893084-4556-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 829EF261B03
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 19:10:48 +0100 (CET)
In-Reply-To: <1455893084-4556-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Fixup some odd line wrapping

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

>From 7d00cd975a52e637da19548c1cc7d87a0a32b49c Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Fri, 19 Feb 2016 14:44:43 +0000
Subject: [PATCH] ASoC: wm_adsp: Fixup some odd line wrapping

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index ff0ce6ba..0f6eeb1 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -862,15 +862,13 @@ static int wmfw_add_ctl(struct wm_adsp *dsp, struct wm_coeff_ctl *ctl)
 		kcontrol->access |= SNDRV_CTL_ELEM_ACCESS_VOLATILE;
 	}
 
-	ret = snd_soc_add_card_controls(dsp->card,
-					kcontrol, 1);
+	ret = snd_soc_add_card_controls(dsp->card, kcontrol, 1);
 	if (ret < 0)
 		goto err_kcontrol;
 
 	kfree(kcontrol);
 
-	ctl->kcontrol = snd_soc_card_get_kcontrol(dsp->card,
-						  ctl->name);
+	ctl->kcontrol = snd_soc_card_get_kcontrol(dsp->card, ctl->name);
 
 	return 0;
 
@@ -890,9 +888,7 @@ static int wm_coeff_init_control_caches(struct wm_adsp *dsp)
 		if (ctl->flags & WMFW_CTL_FLAG_VOLATILE)
 			continue;
 
-		ret = wm_coeff_read_control(ctl,
-					    ctl->cache,
-					    ctl->len);
+		ret = wm_coeff_read_control(ctl, ctl->cache, ctl->len);
 		if (ret < 0)
 			return ret;
 	}
@@ -909,9 +905,7 @@ static int wm_coeff_sync_controls(struct wm_adsp *dsp)
 		if (!ctl->enabled)
 			continue;
 		if (ctl->set && !(ctl->flags & WMFW_CTL_FLAG_VOLATILE)) {
-			ret = wm_coeff_write_control(ctl,
-						     ctl->cache,
-						     ctl->len);
+			ret = wm_coeff_write_control(ctl, ctl->cache, ctl->len);
 			if (ret < 0)
 				return ret;
 		}
@@ -1507,8 +1501,7 @@ static void *wm_adsp_read_algs(struct wm_adsp *dsp, size_t n_algs,
 
 	ret = regmap_raw_read(dsp->regmap, pos, alg, len * 2);
 	if (ret != 0) {
-		adsp_err(dsp, "Failed to read algorithm list: %d\n",
-			ret);
+		adsp_err(dsp, "Failed to read algorithm list: %d\n", ret);
 		kfree(alg);
 		return ERR_PTR(ret);
 	}
@@ -2007,8 +2000,7 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 				goto err_mutex;
 			}
 
-			val = (val & dsp->sysclk_mask)
-				>> dsp->sysclk_shift;
+			val = (val & dsp->sysclk_mask) >> dsp->sysclk_shift;
 
 			ret = regmap_update_bits(dsp->regmap,
 						 dsp->base + ADSP1_CONTROL_31,
@@ -2101,8 +2093,7 @@ static int wm_adsp2_ena(struct wm_adsp *dsp)
 
 	/* Wait for the RAM to start, should be near instantaneous */
 	for (count = 0; count < 10; ++count) {
-		ret = regmap_read(dsp->regmap, dsp->base + ADSP2_STATUS1,
-				  &val);
+		ret = regmap_read(dsp->regmap, dsp->base + ADSP2_STATUS1, &val);
 		if (ret != 0)
 			return ret;
 
-- 
2.7.0
