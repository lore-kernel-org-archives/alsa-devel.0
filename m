From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: mt2701: fix some error handling in probe" to the asoc tree
Date: Thu, 07 Jul 2016 12:01:08 +0200
Message-ID: <E1bL67I-0000ii-Ks@finisterre>
References: <20160707081404.GB16645@mwanda>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20160707081404.GB16645@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Garlic Tseng <garlic.tseng@mediatek.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Garlic Tseng <garlic.tseng@mediatek.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: mt2701: fix some error handling in probe

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

>From b02c5cc7239b8f58ba5da24092288dd7a9a56acc Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 7 Jul 2016 11:14:04 +0300
Subject: [PATCH] ASoC: mediatek: mt2701: fix some error handling in probe

The check for if the "afe" allocation failed was too late and there
wasn't a check for "afe->platform_priv".

Fixes: 43a6a7e71063 ('ASoC: mediatek: add mt2701 platform driver implementation.')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Garlic Tseng <garlic.tseng@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 6c14d686bfa1..15522c08a967 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1489,11 +1489,13 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	ret = 0;
 	afe = devm_kzalloc(&pdev->dev, sizeof(*afe), GFP_KERNEL);
+	if (!afe)
+		return -ENOMEM;
 	afe->platform_priv = devm_kzalloc(&pdev->dev, sizeof(*afe_priv),
 					  GFP_KERNEL);
-	afe_priv = afe->platform_priv;
-	if (!afe)
+	if (!afe->platform_priv)
 		return -ENOMEM;
+	afe_priv = afe->platform_priv;
 
 	afe->dev = &pdev->dev;
 	dev = afe->dev;
-- 
2.8.1

