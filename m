From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5670: remove duplicate route." to the
	asoc tree
Date: Wed, 28 Jun 2017 20:23:39 +0100
Message-ID: <E1dQIYt-0004Io-TL@finisterre>
References: <1498635482-4970-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F0B9266E10
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 21:23:59 +0200 (CEST)
In-Reply-To: <1498635482-4970-2-git-send-email-bardliao@realtek.com>
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

   ASoC: rt5670: remove duplicate route.

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

>From 90384fcc054f701e17e9cbbff5c14db5f877c614 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 28 Jun 2017 15:38:01 +0800
Subject: [PATCH] ASoC: rt5670: remove duplicate route.

{ "ADC Stereo1 Filter", NULL, "PLL1", is_sys_clk_from_pll }, and
{ "ADC Stereo2 Filter", NULL, "PLL1", is_sys_clk_from_pll }, are
defined twice in the driver.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5670.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index d95d2e693dc6..1146a968cb4d 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2022,7 +2022,6 @@ static const struct snd_soc_dapm_route rt5670_dapm_routes[] = {
 
 	{ "Stereo1 ADC MIXL", NULL, "Sto1 ADC MIXL" },
 	{ "Stereo1 ADC MIXL", NULL, "ADC Stereo1 Filter" },
-	{ "ADC Stereo1 Filter", NULL, "PLL1", is_sys_clk_from_pll },
 
 	{ "Stereo1 ADC MIXR", NULL, "Sto1 ADC MIXR" },
 	{ "Stereo1 ADC MIXR", NULL, "ADC Stereo1 Filter" },
@@ -2061,7 +2060,6 @@ static const struct snd_soc_dapm_route rt5670_dapm_routes[] = {
 
 	{ "Stereo2 ADC MIXL", NULL, "Stereo2 ADC LR Mux" },
 	{ "Stereo2 ADC MIXL", NULL, "ADC Stereo2 Filter" },
-	{ "ADC Stereo2 Filter", NULL, "PLL1", is_sys_clk_from_pll },
 
 	{ "Stereo2 ADC MIXR", NULL, "Sto2 ADC MIXR" },
 	{ "Stereo2 ADC MIXR", NULL, "ADC Stereo2 Filter" },
-- 
2.13.2
