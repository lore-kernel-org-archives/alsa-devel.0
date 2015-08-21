From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: Set missing card owner field
Date: Fri, 21 Aug 2015 20:59:21 +0800
Message-ID: <1440161961.17848.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FDA42604F0
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 14:59:28 +0200 (CEST)
Received: by padfo6 with SMTP id fo6so6942964pad.1
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 05:59:26 -0700 (PDT)
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
Cc: Koro Chen <koro.chen@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Heiko Stuebner <heiko@sntech.de>, alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, "Fang,
 Yang A" <yang.a.fang@intel.com>, Kukjin Kim <kgene@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Set the card owner field to prevent the module from being removed from
underneath its users.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/blackfin/bfin-eval-adau1x61.c      | 1 +
 sound/soc/intel/boards/byt-max98090.c        | 1 +
 sound/soc/intel/boards/byt-rt5640.c          | 1 +
 sound/soc/intel/boards/bytcr_rt5640.c        | 1 +
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 1 +
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 2 ++
 sound/soc/intel/boards/cht_bsw_rt5672.c      | 1 +
 sound/soc/mediatek/mt8173-max98090.c         | 1 +
 sound/soc/mediatek/mt8173-rt5650-rt5676.c    | 1 +
 sound/soc/rockchip/rockchip_max98090.c       | 1 +
 sound/soc/rockchip/rockchip_rt5645.c         | 1 +
 sound/soc/samsung/arndale_rt5631.c           | 1 +
 sound/soc/samsung/snow.c                     | 1 +
 13 files changed, 14 insertions(+)

diff --git a/sound/soc/blackfin/bfin-eval-adau1x61.c b/sound/soc/blackfin/bfin-eval-adau1x61.c
index 4229f76..fddfe00c 100644
--- a/sound/soc/blackfin/bfin-eval-adau1x61.c
+++ b/sound/soc/blackfin/bfin-eval-adau1x61.c
@@ -108,6 +108,7 @@ static struct snd_soc_dai_link bfin_eval_adau1x61_dai = {
 
 static struct snd_soc_card bfin_eval_adau1x61 = {
 	.name = "bfin-eval-adau1x61",
+	.owner = THIS_MODULE,
 	.driver_name = "eval-adau1x61",
 	.dai_link = &bfin_eval_adau1x61_dai,
 	.num_links = 1,
diff --git a/sound/soc/intel/boards/byt-max98090.c b/sound/soc/intel/boards/byt-max98090.c
index 7ab8cc9..d9f81b8 100644
--- a/sound/soc/intel/boards/byt-max98090.c
+++ b/sound/soc/intel/boards/byt-max98090.c
@@ -126,6 +126,7 @@ static struct snd_soc_dai_link byt_max98090_dais[] = {
 
 static struct snd_soc_card byt_max98090_card = {
 	.name = "byt-max98090",
+	.owner = THIS_MODULE,
 	.dai_link = byt_max98090_dais,
 	.num_links = ARRAY_SIZE(byt_max98090_dais),
 	.dapm_widgets = byt_max98090_widgets,
diff --git a/sound/soc/intel/boards/byt-rt5640.c b/sound/soc/intel/boards/byt-rt5640.c
index ae89b9b9..de9788a 100644
--- a/sound/soc/intel/boards/byt-rt5640.c
+++ b/sound/soc/intel/boards/byt-rt5640.c
@@ -197,6 +197,7 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 
 static struct snd_soc_card byt_rt5640_card = {
 	.name = "byt-rt5640",
+	.owner = THIS_MODULE,
 	.dai_link = byt_rt5640_dais,
 	.num_links = ARRAY_SIZE(byt_rt5640_dais),
 	.dapm_widgets = byt_rt5640_widgets,
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 7f55d59..c445312 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -185,6 +185,7 @@ static struct snd_soc_dai_link byt_dailink[] = {
 /* SoC card */
 static struct snd_soc_card snd_soc_card_byt = {
 	.name = "baytrailcraudio",
+	.owner = THIS_MODULE,
 	.dai_link = byt_dailink,
 	.num_links = ARRAY_SIZE(byt_dailink),
 	.dapm_widgets = byt_dapm_widgets,
diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 7810fc0..49f4869 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -275,6 +275,7 @@ static struct snd_soc_dai_link cht_dailink[] = {
 /* SoC card */
 static struct snd_soc_card snd_soc_card_cht = {
 	.name = "chtmax98090",
+	.owner = THIS_MODULE,
 	.dai_link = cht_dailink,
 	.num_links = ARRAY_SIZE(cht_dailink),
 	.aux_dev = &cht_max98090_headset_dev,
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index bdcaf46..7be8461 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -305,6 +305,7 @@ static struct snd_soc_dai_link cht_dailink[] = {
 /* SoC card */
 static struct snd_soc_card snd_soc_card_chtrt5645 = {
 	.name = "chtrt5645",
+	.owner = THIS_MODULE,
 	.dai_link = cht_dailink,
 	.num_links = ARRAY_SIZE(cht_dailink),
 	.dapm_widgets = cht_dapm_widgets,
@@ -317,6 +318,7 @@ static struct snd_soc_card snd_soc_card_chtrt5645 = {
 
 static struct snd_soc_card snd_soc_card_chtrt5650 = {
 	.name = "chtrt5650",
+	.owner = THIS_MODULE,
 	.dai_link = cht_dailink,
 	.num_links = ARRAY_SIZE(cht_dailink),
 	.dapm_widgets = cht_dapm_widgets,
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 2c9cc5b..23fe040 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -323,6 +323,7 @@ static int cht_resume_post(struct snd_soc_card *card)
 /* SoC card */
 static struct snd_soc_card snd_soc_card_cht = {
 	.name = "cherrytrailcraudio",
+	.owner = THIS_MODULE,
 	.dai_link = cht_dailink,
 	.num_links = ARRAY_SIZE(cht_dailink),
 	.dapm_widgets = cht_dapm_widgets,
diff --git a/sound/soc/mediatek/mt8173-max98090.c b/sound/soc/mediatek/mt8173-max98090.c
index 39e5660..684e8a7 100644
--- a/sound/soc/mediatek/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173-max98090.c
@@ -136,6 +136,7 @@ static struct snd_soc_dai_link mt8173_max98090_dais[] = {
 
 static struct snd_soc_card mt8173_max98090_card = {
 	.name = "mt8173-max98090",
+	.owner = THIS_MODULE,
 	.dai_link = mt8173_max98090_dais,
 	.num_links = ARRAY_SIZE(mt8173_max98090_dais),
 	.controls = mt8173_max98090_controls,
diff --git a/sound/soc/mediatek/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
index b722145..86cf975 100644
--- a/sound/soc/mediatek/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
@@ -191,6 +191,7 @@ static struct snd_soc_codec_conf mt8173_rt5650_rt5676_codec_conf[] = {
 
 static struct snd_soc_card mt8173_rt5650_rt5676_card = {
 	.name = "mtk-rt5650-rt5676",
+	.owner = THIS_MODULE,
 	.dai_link = mt8173_rt5650_rt5676_dais,
 	.num_links = ARRAY_SIZE(mt8173_rt5650_rt5676_dais),
 	.codec_conf = mt8173_rt5650_rt5676_codec_conf,
diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index acace20..cc26f81 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -147,6 +147,7 @@ static struct snd_soc_dai_link rk_dailink = {
 
 static struct snd_soc_card snd_soc_card_rk = {
 	.name = "ROCKCHIP-I2S",
+	.owner = THIS_MODULE,
 	.dai_link = &rk_dailink,
 	.num_links = 1,
 	.aux_dev = &rk_98090_headset_dev,
diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
index 3c6bb1e..0940279 100644
--- a/sound/soc/rockchip/rockchip_rt5645.c
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -146,6 +146,7 @@ static struct snd_soc_dai_link rk_dailink = {
 
 static struct snd_soc_card snd_soc_card_rk = {
 	.name = "I2S-RT5650",
+	.owner = THIS_MODULE,
 	.dai_link = &rk_dailink,
 	.num_links = 1,
 	.dapm_widgets = rk_dapm_widgets,
diff --git a/sound/soc/samsung/arndale_rt5631.c b/sound/soc/samsung/arndale_rt5631.c
index 9e371eb..ee1fda9 100644
--- a/sound/soc/samsung/arndale_rt5631.c
+++ b/sound/soc/samsung/arndale_rt5631.c
@@ -71,6 +71,7 @@ static struct snd_soc_dai_link arndale_rt5631_dai[] = {
 
 static struct snd_soc_card arndale_rt5631 = {
 	.name = "Arndale RT5631",
+	.owner = THIS_MODULE,
 	.dai_link = arndale_rt5631_dai,
 	.num_links = ARRAY_SIZE(arndale_rt5631_dai),
 };
diff --git a/sound/soc/samsung/snow.c b/sound/soc/samsung/snow.c
index 7651dc9..07ce2cf 100644
--- a/sound/soc/samsung/snow.c
+++ b/sound/soc/samsung/snow.c
@@ -56,6 +56,7 @@ static int snow_late_probe(struct snd_soc_card *card)
 
 static struct snd_soc_card snow_snd = {
 	.name = "Snow-I2S",
+	.owner = THIS_MODULE,
 	.dai_link = snow_dai,
 	.num_links = ARRAY_SIZE(snow_dai),
 
-- 
2.1.0
