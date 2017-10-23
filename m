From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Convert rt5651 micbias1 to a supply widget" to the asoc tree
Date: Mon, 23 Oct 2017 10:43:45 +0100 (BST)
Message-ID: <20171023094345.AC13B440058@finisterre.ee.mobilebroadband>
References: <20171018170631.9189-1-carlo@caione.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171018170631.9189-1-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Carlo Caione <carlo@endlessm.com>
Cc: Mark Brown <broonie@kernel.org>, linux@endlessm.com, bardliao@realtek.com, oder_chiou@realtek.com, lgirdwood@gmail.combroonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: Convert rt5651 micbias1 to a supply widget

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

>From be96fc54d2ed8eae6683b71d2dc5d1a939a10a1e Mon Sep 17 00:00:00 2001
From: Carlo Caione <carlo@endlessm.com>
Date: Wed, 18 Oct 2017 18:06:31 +0100
Subject: [PATCH] ASoC: rt5651: Convert rt5651 micbias1 to a supply widget

MICBIAS widget type has been deprecated. Convert it to a SUPPLY widget.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index da60b28ba3df..28f7210cec91 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -883,8 +883,8 @@ static const struct snd_soc_dapm_widget rt5651_dapm_widgets[] = {
 	/* micbias */
 	SND_SOC_DAPM_SUPPLY("LDO", RT5651_PWR_ANLG1,
 			RT5651_PWR_LDO_BIT, 0, NULL, 0),
-	SND_SOC_DAPM_MICBIAS("micbias1", RT5651_PWR_ANLG2,
-			RT5651_PWR_MB1_BIT, 0),
+	SND_SOC_DAPM_SUPPLY("micbias1", RT5651_PWR_ANLG2,
+			RT5651_PWR_MB1_BIT, 0, NULL, 0),
 	/* Input Lines */
 	SND_SOC_DAPM_INPUT("MIC1"),
 	SND_SOC_DAPM_INPUT("MIC2"),
-- 
2.14.1
