From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: wm_adsp: Fixup some odd line wrapping
Date: Fri, 19 Feb 2016 14:44:43 +0000
Message-ID: <1455893084-4556-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1455893084-4556-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id B8834266AEC
 for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2016 15:44:44 +0100 (CET)
In-Reply-To: <1455893084-4556-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index c97b3a1..1c6d5fb 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -882,15 +882,13 @@ static int wmfw_add_ctl(struct wm_adsp *dsp, struct wm_coeff_ctl *ctl)
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
 
@@ -910,9 +908,7 @@ static int wm_coeff_init_control_caches(struct wm_adsp *dsp)
 		if (ctl->flags & WMFW_CTL_FLAG_VOLATILE)
 			continue;
 
-		ret = wm_coeff_read_control(ctl,
-					    ctl->cache,
-					    ctl->len);
+		ret = wm_coeff_read_control(ctl, ctl->cache, ctl->len);
 		if (ret < 0)
 			return ret;
 	}
@@ -929,9 +925,7 @@ static int wm_coeff_sync_controls(struct wm_adsp *dsp)
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
@@ -1527,8 +1521,7 @@ static void *wm_adsp_read_algs(struct wm_adsp *dsp, size_t n_algs,
 
 	ret = regmap_raw_read(dsp->regmap, pos, alg, len * 2);
 	if (ret != 0) {
-		adsp_err(dsp, "Failed to read algorithm list: %d\n",
-			ret);
+		adsp_err(dsp, "Failed to read algorithm list: %d\n", ret);
 		kfree(alg);
 		return ERR_PTR(ret);
 	}
@@ -2027,8 +2020,7 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 				goto err_mutex;
 			}
 
-			val = (val & dsp->sysclk_mask)
-				>> dsp->sysclk_shift;
+			val = (val & dsp->sysclk_mask) >> dsp->sysclk_shift;
 
 			ret = regmap_update_bits(dsp->regmap,
 						 dsp->base + ADSP1_CONTROL_31,
@@ -2121,8 +2113,7 @@ static int wm_adsp2_ena(struct wm_adsp *dsp)
 
 	/* Wait for the RAM to start, should be near instantaneous */
 	for (count = 0; count < 10; ++count) {
-		ret = regmap_read(dsp->regmap, dsp->base + ADSP2_STATUS1,
-				  &val);
+		ret = regmap_read(dsp->regmap, dsp->base + ADSP2_STATUS1, &val);
 		if (ret != 0)
 			return ret;
 
-- 
2.1.4
