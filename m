From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: i2s: compatible with
	different chips" to the asoc tree
Date: Mon, 16 Nov 2015 17:51:50 +0000
Message-ID: <E1ZyNwU-0006p5-Ix@debutante>
References: <1447140729-18267-2-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CB3252604F4
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2015 18:51:55 +0100 (CET)
In-Reply-To: <1447140729-18267-2-git-send-email-sugar.zhang@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: i2s: compatible with different chips

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

>From c4f9374ddc461ed76be30f4d354a6d1ecb94dfa5 Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Tue, 10 Nov 2015 15:32:07 +0800
Subject: [PATCH] ASoC: rockchip: i2s: compatible with different chips

there maybe more than one i2s module inside chip, and these i2s modules
have different channels features.

for example: there are 3 i2s in rk3066, one support 8 channels playback
and 2 channels capture, but the others only support 2 channels playback
and 2 channels capture.

in order to compatible with these various chips, we add playback and
capture property to specify these values.

there are default channels configuration in driver: 8 channels playback
and 2 channels capture. if not add property, we use the default values.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index ce880f3bccc7..83b1b9c9e017 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -474,6 +474,7 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct rk_i2s_dev *i2s;
+	struct snd_soc_dai_driver *soc_dai;
 	struct resource *res;
 	void __iomem *regs;
 	int ret;
@@ -534,17 +535,26 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
-	/* refine capture channels */
+	soc_dai = devm_kzalloc(&pdev->dev,
+			       sizeof(*soc_dai), GFP_KERNEL);
+	if (!soc_dai)
+		return -ENOMEM;
+
+	memcpy(soc_dai, &rockchip_i2s_dai, sizeof(*soc_dai));
+	if (!of_property_read_u32(node, "rockchip,playback-channels", &val)) {
+		if (val >= 2 && val <= 8)
+			soc_dai->playback.channels_max = val;
+	}
+
 	if (!of_property_read_u32(node, "rockchip,capture-channels", &val)) {
 		if (val >= 2 && val <= 8)
-			rockchip_i2s_dai.capture.channels_max = val;
-		else
-			rockchip_i2s_dai.capture.channels_max = 2;
+			soc_dai->capture.channels_max = val;
 	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &rockchip_i2s_component,
-					      &rockchip_i2s_dai, 1);
+					      soc_dai, 1);
+
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register DAI\n");
 		goto err_suspend;
-- 
2.6.2
