From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: add ADC STO2 ASRC support" to
	the asoc tree
Date: Mon, 15 May 2017 17:01:59 +0900
Message-ID: <E1dAAx5-0002Ji-0j@finisterre>
References: <1493694039-7816-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DE6B26727C
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 10:02:26 +0200 (CEST)
In-Reply-To: <1493694039-7816-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: add ADC STO2 ASRC support

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

>From 30b7d88de034a2b5c4f20c0cd05c792d9b619d70 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Tue, 2 May 2017 11:00:39 +0800
Subject: [PATCH] ASoC: rt5665: add ADC STO2 ASRC support

"ADC Stereo2 Filter" is with ASRC supported.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 14b0cf89edf5..26bf157ca293 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -2684,6 +2684,8 @@ static const struct snd_soc_dapm_widget rt5665_dapm_widgets[] = {
 		RT5665_DAC_MONO_R_ASRC_SFT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("ADC STO1 ASRC", 1, RT5665_ASRC_1,
 		RT5665_ADC_STO1_ASRC_SFT, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("ADC STO2 ASRC", 1, RT5665_ASRC_1,
+		RT5665_ADC_STO2_ASRC_SFT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("ADC Mono L ASRC", 1, RT5665_ASRC_1,
 		RT5665_ADC_MONO_L_ASRC_SFT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY_S("ADC Mono R ASRC", 1, RT5665_ASRC_1,
@@ -3227,6 +3229,7 @@ static const struct snd_soc_dapm_route rt5665_dapm_routes[] = {
 
 	/*ASRC*/
 	{"ADC Stereo1 Filter", NULL, "ADC STO1 ASRC", is_using_asrc},
+	{"ADC Stereo2 Filter", NULL, "ADC STO2 ASRC", is_using_asrc},
 	{"ADC Mono Left Filter", NULL, "ADC Mono L ASRC", is_using_asrc},
 	{"ADC Mono Right Filter", NULL, "ADC Mono R ASRC", is_using_asrc},
 	{"DAC Mono Left Filter", NULL, "DAC Mono L ASRC", is_using_asrc},
-- 
2.11.0
