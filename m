From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: i2s: Fix multiple "IIS multi"
	devices initialization" to the asoc tree
Date: Tue, 19 Feb 2019 15:50:05 +0000 (GMT)
Message-ID: <20190219155005.DAAEB11284A9@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5DF78F80760
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 12:13:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: i2s: Fix multiple "IIS multi" devices initialization

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

>From c6bebefa2f0603fb21ae329521e15461b0486679 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Tue, 19 Feb 2019 16:19:41 +0100
Subject: [PATCH] ASoC: samsung: i2s: Fix multiple "IIS multi" devices
 initialization

On some SoCs (e.g. Exynos5433) there are multiple "IIS multi audio
interfaces" and the driver will try to register there multiple times
same platform device for the secondary FIFO, which of course fails
miserably.  To fix this we derive the secondary platform device name
from the primary device name. The secondary device name will now
be <primary_dev_name>-sec instead of fixed "samsung-i2s-sec".

The fixed platform_device_id table entry is removed as the secondary
device name is now dynamic and device/driver matching is done through
driver_override.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c    | 50 +++++++++++++++++++++++++-------------
 sound/soc/samsung/odroid.c |  2 +-
 2 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index cd92bb6e1da1..4231001226f4 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1339,20 +1339,35 @@ static int i2s_register_clock_provider(struct samsung_i2s_priv *priv)
 /* Create platform device for the secondary PCM */
 static int i2s_create_secondary_device(struct samsung_i2s_priv *priv)
 {
-	struct platform_device *pdev;
+	struct platform_device *pdev_sec;
+	const char *devname;
 	int ret;
 
-	pdev = platform_device_register_simple("samsung-i2s-sec", -1, NULL, 0);
-	if (!pdev)
+	devname = devm_kasprintf(&priv->pdev->dev, GFP_KERNEL, "%s-sec",
+				 dev_name(&priv->pdev->dev));
+	if (!devname)
 		return -ENOMEM;
 
-	ret = device_attach(&pdev->dev);
+	pdev_sec = platform_device_alloc(devname, -1);
+	if (!pdev_sec)
+		return -ENOMEM;
+
+	pdev_sec->driver_override = kstrdup("samsung-i2s", GFP_KERNEL);
+
+	ret = platform_device_add(pdev_sec);
 	if (ret < 0) {
-		dev_info(&pdev->dev, "device_attach() failed\n");
+		platform_device_put(pdev_sec);
 		return ret;
 	}
 
-	priv->pdev_sec = pdev;
+	ret = device_attach(&pdev_sec->dev);
+	if (ret <= 0) {
+		platform_device_unregister(priv->pdev_sec);
+		dev_info(&pdev_sec->dev, "device_attach() failed\n");
+		return ret;
+	}
+
+	priv->pdev_sec = pdev_sec;
 
 	return 0;
 }
@@ -1367,22 +1382,25 @@ static int samsung_i2s_probe(struct platform_device *pdev)
 {
 	struct i2s_dai *pri_dai, *sec_dai = NULL;
 	struct s3c_audio_pdata *i2s_pdata = pdev->dev.platform_data;
-	struct resource *res;
 	u32 regs_base, idma_addr = 0;
 	struct device_node *np = pdev->dev.of_node;
 	const struct samsung_i2s_dai_data *i2s_dai_data;
-	int num_dais, ret;
+	const struct platform_device_id *id;
 	struct samsung_i2s_priv *priv;
+	struct resource *res;
+	int num_dais, ret;
 
-	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node)
+	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
 		i2s_dai_data = of_device_get_match_data(&pdev->dev);
-	else
-		i2s_dai_data = (struct samsung_i2s_dai_data *)
-				platform_get_device_id(pdev)->driver_data;
+	} else {
+		id = platform_get_device_id(pdev);
 
-	/* Nothing to do if it is the secondary device probe */
-	if (!i2s_dai_data)
-		return 0;
+		/* Nothing to do if it is the secondary device probe */
+		if (!id)
+			return 0;
+
+		i2s_dai_data = (struct samsung_i2s_dai_data *)id->driver_data;
+	}
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -1637,8 +1655,6 @@ static const struct platform_device_id samsung_i2s_driver_ids[] = {
 	{
 		.name           = "samsung-i2s",
 		.driver_data	= (kernel_ulong_t)&i2sv3_dai_type,
-	}, {
-		.name           = "samsung-i2s-sec",
 	},
 	{},
 };
diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index 5b2bcd1d3450..bd2c5163dc7f 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -185,7 +185,7 @@ static struct snd_soc_dai_link odroid_card_dais[] = {
 		.ops = &odroid_card_fe_ops,
 		.name = "Secondary",
 		.stream_name = "Secondary",
-		.platform_name = "samsung-i2s-sec",
+		.platform_name = "3830000.i2s-sec",
 		.dynamic = 1,
 		.dpcm_playback = 1,
 	}
-- 
2.20.1
