From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Mediatek: MT8183: TS3A227: fix build error" to the asoc tree
Date: Wed,  3 Apr 2019 05:41:24 +0100 (BST)
Message-ID: <20190403044124.7744B440082@finisterre.ee.mobilebroadband>
References: <20190403030501.25140-1-anders.roxell@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403030501.25140-1-anders.roxell@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com, alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Mediatek: MT8183: TS3A227: fix build error

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

>From 2b7bcdad3af9fbd104d5f300dbb90f684c36aa09 Mon Sep 17 00:00:00 2001
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 3 Apr 2019 05:05:01 +0200
Subject: [PATCH] ASoC: Mediatek: MT8183: TS3A227: fix build error
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When building CONFIG_SND_SOC_MT8183_MT6358_TS3A227E_MAX98357A=m the
following error pops up:

../sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c: In function ‘mt8183_mt6358_ts3a227_max98357_dev_probe’:
../sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c:325:13: error: ‘struct snd_soc_dai_link’ has no member named ‘platform’; did you mean ‘platforms’?
   dai_link->platform = NULL;
             ^~~~~~~~
             platforms

Rework to use 'dai_link->platforms' instead of 'dai_link->platform'.

Fixes: 11c0269017b2 ("ASoC: Mediatek: MT8183: Add machine driver with TS3A227")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index 2da56232a9e1..a50c6af5c945 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -322,7 +322,7 @@ mt8183_mt6358_ts3a227_max98357_dev_probe(struct platform_device *pdev)
 		 * the "platform" will not null when probe is trying
 		 * again. It's not expected normally.
 		 */
-		dai_link->platform = NULL;
+		dai_link->platforms = NULL;
 
 		if (dai_link->platform_name)
 			continue;
-- 
2.20.1
