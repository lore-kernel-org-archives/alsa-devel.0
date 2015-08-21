From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Set missing card owner field" to the
	asoc tree
Date: Fri, 21 Aug 2015 09:34:22 -0700
Message-ID: <E1ZSpGo-0001rQ-Ph@finisterre>
References: <1440161961.17848.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 14BF526581D
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2015 18:34:36 +0200 (CEST)
In-Reply-To: <1440161961.17848.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Set missing card owner field

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

>From 54d8697fa5036df0e27f8d62edb7ebc35c3f73d6 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 21 Aug 2015 20:59:21 +0800
Subject: [PATCH] ASoC: Set missing card owner field

Set the card owner field to prevent the module from being removed from
underneath its users.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
index d604ee8..cd25953 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -279,6 +279,7 @@ static struct snd_soc_dai_link cht_dailink[] = {
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
index 4d44b58..fb8f97e 100644
--- a/sound/soc/mediatek/mt8173-max98090.c
+++ b/sound/soc/mediatek/mt8173-max98090.c
@@ -139,6 +139,7 @@ static struct snd_soc_dai_link mt8173_max98090_dais[] = {
 
 static struct snd_soc_card mt8173_max98090_card = {
 	.name = "mt8173-max98090",
+	.owner = THIS_MODULE,
 	.dai_link = mt8173_max98090_dais,
 	.num_links = ARRAY_SIZE(mt8173_max98090_dais),
 	.controls = mt8173_max98090_controls,
diff --git a/sound/soc/mediatek/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
index 0940553..caf8c47 100644
--- a/sound/soc/mediatek/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173-rt5650-rt5676.c
@@ -194,6 +194,7 @@ static struct snd_soc_codec_conf mt8173_rt5650_rt5676_codec_conf[] = {
 
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
index 8bf2e2c..323aa0d 100644
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
2.5.0
