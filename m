From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mt8173: remove unnecessary micbias
	widget in route" to the asoc tree
Date: Wed, 10 Jan 2018 11:12:23 +0000
Message-ID: <E1eZEIx-0004mg-3Y@debutante>
References: <1515142851-11445-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 52419266DEC
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 12:12:38 +0100 (CET)
In-Reply-To: <1515142851-11445-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, koro.chen@mediatek.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mt8173: remove unnecessary micbias widget in route

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

>From 11aa2d9613c9523f8f78863bdfc7d79b37afcbbe Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Fri, 5 Jan 2018 17:00:51 +0800
Subject: [PATCH] ASoC: mt8173: remove unnecessary micbias widget in route

The micbias1/2 are connected to route as SUPPLY usage. It was not
take effect since they were MICBIAS type. To keep the same register
settings, we have to remove it once the micbias1/2 widget is converted
to SUPPLY type.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c | 2 --
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c | 2 --
 sound/soc/mediatek/mt8173/mt8173-rt5650.c        | 2 --
 3 files changed, 6 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
index 99c15219dbc8..5a9a5482976e 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
@@ -37,8 +37,6 @@ static const struct snd_soc_dapm_route mt8173_rt5650_rt5514_routes[] = {
 	{"Sub DMIC1R", NULL, "Int Mic"},
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
-	{"Headset Mic", NULL, "micbias1"},
-	{"Headset Mic", NULL, "micbias2"},
 	{"IN1P", NULL, "Headset Mic"},
 	{"IN1N", NULL, "Headset Mic"},
 };
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
index 42de84ca8c84..b7248085ca04 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
@@ -40,8 +40,6 @@ static const struct snd_soc_dapm_route mt8173_rt5650_rt5676_routes[] = {
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
 	{"Headphone", NULL, "Sub AIF2TX"}, /* IF2 ADC to 5650  */
-	{"Headset Mic", NULL, "micbias1"},
-	{"Headset Mic", NULL, "micbias2"},
 	{"IN1P", NULL, "Headset Mic"},
 	{"IN1N", NULL, "Headset Mic"},
 	{"Sub AIF2RX", NULL, "Headset Mic"}, /* IF2 DAC from 5650  */
diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index e69c141d8ed4..40ebefd625c1 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -51,8 +51,6 @@ static const struct snd_soc_dapm_route mt8173_rt5650_routes[] = {
 	{"DMIC R1", NULL, "Int Mic"},
 	{"Headphone", NULL, "HPOL"},
 	{"Headphone", NULL, "HPOR"},
-	{"Headset Mic", NULL, "micbias1"},
-	{"Headset Mic", NULL, "micbias2"},
 	{"IN1P", NULL, "Headset Mic"},
 	{"IN1N", NULL, "Headset Mic"},
 };
-- 
2.15.1
