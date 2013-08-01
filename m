From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Sanitize parameter passing
Date: Thu,  1 Aug 2013 11:11:28 +0100
Message-ID: <1375351888-24877-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5F8CE2655B1
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 12:11:30 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

No need to hold on to the `codec' pointer.  We can use the `dsp'
pointer and grab all the information we need from there.  This
makes the parameters for the functions a bit more sane and idiomatic.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 31 ++++++++++++++++---------------
 sound/soc/codecs/wm_adsp.h |  1 +
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 3168224..b38f350 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -227,7 +227,6 @@ struct wm_coeff_ctl_ops {
 
 struct wm_coeff_ctl {
 	const char *name;
-	struct snd_soc_card *card;
 	struct wm_adsp_alg_region region;
 	struct wm_coeff_ctl_ops ops;
 	struct wm_adsp *adsp;
@@ -484,7 +483,7 @@ static int wmfw_add_ctl(struct wm_adsp *adsp, struct wm_coeff_ctl *ctl)
 	struct snd_kcontrol_new *kcontrol;
 	int ret;
 
-	if (!ctl || !ctl->name || !ctl->card)
+	if (!ctl || !ctl->name)
 		return -EINVAL;
 
 	kcontrol = kzalloc(sizeof(*kcontrol), GFP_KERNEL);
@@ -498,14 +497,14 @@ static int wmfw_add_ctl(struct wm_adsp *adsp, struct wm_coeff_ctl *ctl)
 	kcontrol->put = wm_coeff_put;
 	kcontrol->private_value = (unsigned long)ctl;
 
-	ret = snd_soc_add_card_controls(ctl->card,
+	ret = snd_soc_add_card_controls(adsp->card,
 					kcontrol, 1);
 	if (ret < 0)
 		goto err_kcontrol;
 
 	kfree(kcontrol);
 
-	ctl->kcontrol = snd_soc_card_get_kcontrol(ctl->card,
+	ctl->kcontrol = snd_soc_card_get_kcontrol(adsp->card,
 						  ctl->name);
 
 	list_add(&ctl->list, &adsp->ctl_list);
@@ -777,11 +776,10 @@ static void wm_adsp_ctl_work(struct work_struct *work)
 	kfree(ctl_work);
 }
 
-static int wm_adsp_create_control(struct snd_soc_codec *codec,
+static int wm_adsp_create_control(struct wm_adsp *dsp,
 				  const struct wm_adsp_alg_region *region)
 
 {
-	struct wm_adsp *dsp = snd_soc_codec_get_drvdata(codec);
 	struct wm_coeff_ctl *ctl;
 	struct wmfw_ctl_work *ctl_work;
 	char *name;
@@ -840,7 +838,6 @@ static int wm_adsp_create_control(struct snd_soc_codec *codec,
 	ctl->set = 0;
 	ctl->ops.xget = wm_coeff_get;
 	ctl->ops.xput = wm_coeff_put;
-	ctl->card = codec->card;
 	ctl->adsp = dsp;
 
 	ctl->len = region->len;
@@ -877,7 +874,7 @@ err_name:
 	return ret;
 }
 
-static int wm_adsp_setup_algs(struct wm_adsp *dsp, struct snd_soc_codec *codec)
+static int wm_adsp_setup_algs(struct wm_adsp *dsp)
 {
 	struct regmap *regmap = dsp->regmap;
 	struct wmfw_adsp1_id_hdr adsp1_id;
@@ -1065,7 +1062,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp, struct snd_soc_codec *codec)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp1_alg[i + 1].dm);
 				region->len -= be32_to_cpu(adsp1_alg[i].dm);
-				wm_adsp_create_control(codec, region);
+				wm_adsp_create_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region DM with ID %x\n",
 					  be32_to_cpu(adsp1_alg[i].alg.id));
@@ -1082,7 +1079,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp, struct snd_soc_codec *codec)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp1_alg[i + 1].zm);
 				region->len -= be32_to_cpu(adsp1_alg[i].zm);
-				wm_adsp_create_control(codec, region);
+				wm_adsp_create_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
 					  be32_to_cpu(adsp1_alg[i].alg.id));
@@ -1111,7 +1108,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp, struct snd_soc_codec *codec)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp2_alg[i + 1].xm);
 				region->len -= be32_to_cpu(adsp2_alg[i].xm);
-				wm_adsp_create_control(codec, region);
+				wm_adsp_create_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region XM with ID %x\n",
 					  be32_to_cpu(adsp2_alg[i].alg.id));
@@ -1128,7 +1125,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp, struct snd_soc_codec *codec)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp2_alg[i + 1].ym);
 				region->len -= be32_to_cpu(adsp2_alg[i].ym);
-				wm_adsp_create_control(codec, region);
+				wm_adsp_create_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region YM with ID %x\n",
 					  be32_to_cpu(adsp2_alg[i].alg.id));
@@ -1145,7 +1142,7 @@ static int wm_adsp_setup_algs(struct wm_adsp *dsp, struct snd_soc_codec *codec)
 			if (i + 1 < algs) {
 				region->len = be32_to_cpu(adsp2_alg[i + 1].zm);
 				region->len -= be32_to_cpu(adsp2_alg[i].zm);
-				wm_adsp_create_control(codec, region);
+				wm_adsp_create_control(dsp, region);
 			} else {
 				adsp_warn(dsp, "Missing length info for region ZM with ID %x\n",
 					  be32_to_cpu(adsp2_alg[i].alg.id));
@@ -1365,6 +1362,8 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 	int ret;
 	int val;
 
+	dsp->card = codec->card;
+
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP1_CONTROL_30,
@@ -1399,7 +1398,7 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 		if (ret != 0)
 			goto err;
 
-		ret = wm_adsp_setup_algs(dsp, codec);
+		ret = wm_adsp_setup_algs(dsp);
 		if (ret != 0)
 			goto err;
 
@@ -1492,6 +1491,8 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 	unsigned int val;
 	int ret;
 
+	dsp->card = codec->card;
+
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		/*
@@ -1554,7 +1555,7 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		if (ret != 0)
 			goto err;
 
-		ret = wm_adsp_setup_algs(dsp, codec);
+		ret = wm_adsp_setup_algs(dsp);
 		if (ret != 0)
 			goto err;
 
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 64087fb..d018dea 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -39,6 +39,7 @@ struct wm_adsp {
 	int type;
 	struct device *dev;
 	struct regmap *regmap;
+	struct snd_soc_card *card;
 
 	int base;
 	int sysclk_reg;
-- 
1.8.3.4
