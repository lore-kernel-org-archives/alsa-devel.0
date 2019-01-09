From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Boards: move the codec PLL
	configuration to _init" to the asoc tree
Date: Wed,  9 Jan 2019 19:34:50 +0000 (GMT)
Message-ID: <20190109193450.B6F671127528@debutante.sirena.org.uk>
References: <1544004679-8122-1-git-send-email-mac.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 864AE267445
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 20:34:54 +0100 (CET)
In-Reply-To: <1544004679-8122-1-git-send-email-mac.chiang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com, mac.chiang@intel.com, broonie@kernel.org, Shuming Fan <shumingf@realtek.com>, naveen.m@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Boards: move the codec PLL configuration to _init

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

>From 239b8b34a856777e562373ae0de605536a7ccade Mon Sep 17 00:00:00 2001
From: Mac Chiang <mac.chiang@intel.com>
Date: Wed, 5 Dec 2018 18:11:19 +0800
Subject: [PATCH] ASoC: Intel: Boards: move the codec PLL configuration to
 _init

move the codec PLL to rt5682_codec_init, because codec only need to config the clock source/PLL once.
As the result, remove the platform_clock_controls since no need to control clock anymore.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mac Chiang <mac.chiang@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/glk_rt5682_max98357a.c | 45 +++----------------
 1 file changed, 7 insertions(+), 38 deletions(-)

diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index c74c4f17316f..8f83b182c4f9 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -55,39 +55,6 @@ enum {
 	GLK_DPCM_AUDIO_HDMI3_PB,
 };
 
-static int platform_clock_control(struct snd_soc_dapm_widget *w,
-					struct snd_kcontrol *k, int  event)
-{
-	struct snd_soc_dapm_context *dapm = w->dapm;
-	struct snd_soc_card *card = dapm->card;
-	struct snd_soc_dai *codec_dai;
-	int ret = 0;
-
-	codec_dai = snd_soc_card_get_codec_dai(card, GLK_REALTEK_CODEC_DAI);
-	if (!codec_dai) {
-		dev_err(card->dev, "Codec dai not found; Unable to set/unset codec pll\n");
-		return -EIO;
-	}
-
-	if (SND_SOC_DAPM_EVENT_OFF(event)) {
-		ret = snd_soc_dai_set_sysclk(codec_dai, 0, 0, 0);
-		if (ret)
-			dev_err(card->dev, "failed to stop sysclk: %d\n", ret);
-	} else if (SND_SOC_DAPM_EVENT_ON(event)) {
-		ret = snd_soc_dai_set_pll(codec_dai, 0, RT5682_PLL1_S_MCLK,
-					GLK_PLAT_CLK_FREQ, RT5682_PLL_FREQ);
-		if (ret < 0) {
-			dev_err(card->dev, "can't set codec pll: %d\n", ret);
-			return ret;
-		}
-	}
-
-	if (ret)
-		dev_err(card->dev, "failed to start internal clk: %d\n", ret);
-
-	return ret;
-}
-
 static const struct snd_kcontrol_new geminilake_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -102,14 +69,10 @@ static const struct snd_soc_dapm_widget geminilake_widgets[] = {
 	SND_SOC_DAPM_SPK("HDMI1", NULL),
 	SND_SOC_DAPM_SPK("HDMI2", NULL),
 	SND_SOC_DAPM_SPK("HDMI3", NULL),
-	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
-			platform_clock_control, SND_SOC_DAPM_PRE_PMU |
-			SND_SOC_DAPM_POST_PMD),
 };
 
 static const struct snd_soc_dapm_route geminilake_map[] = {
 	/* HP jack connectors - unknown if we have jack detection */
-	{ "Headphone Jack", NULL, "Platform Clock" },
 	{ "Headphone Jack", NULL, "HPOL" },
 	{ "Headphone Jack", NULL, "HPOR" },
 
@@ -117,7 +80,6 @@ static const struct snd_soc_dapm_route geminilake_map[] = {
 	{ "Spk", NULL, "Speaker" },
 
 	/* other jacks */
-	{ "Headset Mic", NULL, "Platform Clock" },
 	{ "IN1P", NULL, "Headset Mic" },
 
 	/* digital mics */
@@ -177,6 +139,13 @@ static int geminilake_rt5682_codec_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_jack *jack;
 	int ret;
 
+	ret = snd_soc_dai_set_pll(codec_dai, 0, RT5682_PLL1_S_MCLK,
+					GLK_PLAT_CLK_FREQ, RT5682_PLL_FREQ);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
+		return ret;
+	}
+
 	/* Configure sysclk for codec */
 	ret = snd_soc_dai_set_sysclk(codec_dai, RT5682_SCLK_S_PLL1,
 					RT5682_PLL_FREQ, SND_SOC_CLOCK_IN);
-- 
2.20.1
