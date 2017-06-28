From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5670: fix wrong audio route" to the
	asoc tree
Date: Wed, 28 Jun 2017 20:23:45 +0100
Message-ID: <E1dQIYz-0004K0-2V@finisterre>
References: <1498635482-4970-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C0AE22671EA
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 21:24:08 +0200 (CEST)
In-Reply-To: <1498635482-4970-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5670: fix wrong audio route

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

>From 8e2d163b736e719ef850493ac7740a61d30b8f23 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 28 Jun 2017 15:38:00 +0800
Subject: [PATCH] ASoC: rt5670: fix wrong audio route

When we select "IF1_ADC4" for IF1 ADC Muxes, it is actually connected
to "TxDP_ADC" widget. This patch fixes the audio route and remove the
unexisting "IF1_ADC4" widget.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5670.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index e27c5a4a0a15..d95d2e693dc6 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -1717,7 +1717,6 @@ static const struct snd_soc_dapm_widget rt5670_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("IF1_ADC1", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1_ADC2", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_PGA("IF1_ADC3", SND_SOC_NOPM, 0, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("IF1_ADC4", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 	/* DSP */
 	SND_SOC_DAPM_PGA("TxDP_ADC", SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -2086,13 +2085,13 @@ static const struct snd_soc_dapm_route rt5670_dapm_routes[] = {
 	{ "IF1 ADC1 IN1 Mux", "IF1_ADC3", "IF1_ADC3" },
 
 	{ "IF1 ADC1 IN2 Mux", "IF1_ADC1_IN1", "IF1 ADC1 IN1 Mux" },
-	{ "IF1 ADC1 IN2 Mux", "IF1_ADC4", "IF1_ADC4" },
+	{ "IF1 ADC1 IN2 Mux", "IF1_ADC4", "TxDP_ADC" },
 
 	{ "IF1 ADC2 IN Mux", "IF_ADC2", "IF_ADC2" },
 	{ "IF1 ADC2 IN Mux", "VAD_ADC", "VAD_ADC" },
 
 	{ "IF1 ADC2 IN1 Mux", "IF1_ADC2_IN", "IF1 ADC2 IN Mux" },
-	{ "IF1 ADC2 IN1 Mux", "IF1_ADC4", "IF1_ADC4" },
+	{ "IF1 ADC2 IN1 Mux", "IF1_ADC4", "TxDP_ADC" },
 
 	{ "IF1_ADC1" , NULL, "IF1 ADC1 IN2 Mux" },
 	{ "IF1_ADC2" , NULL, "IF1 ADC2 IN1 Mux" },
-- 
2.13.2
