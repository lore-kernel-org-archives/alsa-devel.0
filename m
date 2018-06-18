From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: put device_node on remove" to the asoc tree
Date: Mon, 18 Jun 2018 13:00:22 +0100
Message-ID: <E1fUspa-0000EU-8H@debutante>
References: <1528582854-8402-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528582854-8402-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, ldv-project@linuxtesting.org, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, Julia Lawall <julia.lawall@lip6.fr>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, linux-rockchip@lists.infradead.org, sil2review@lists.osadl.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: put device_node on remove

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

>From a56df73ba5960848f60f609c68770d2638bf1dd5 Mon Sep 17 00:00:00 2001
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Sun, 10 Jun 2018 01:20:54 +0300
Subject: [PATCH] ASoC: rockchip: put device_node on remove

snd_rk_mc_probe() gets a couple of device nodes with of_parse_phandle(),
but there is no release of them.

The patch adds remove handler and proper error handling in the probe.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_rt5645.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_rt5645.c b/sound/soc/rockchip/rockchip_rt5645.c
index 4db4fd56db35..881c32498808 100644
--- a/sound/soc/rockchip/rockchip_rt5645.c
+++ b/sound/soc/rockchip/rockchip_rt5645.c
@@ -181,7 +181,8 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
 	if (!rk_dailink.cpu_of_node) {
 		dev_err(&pdev->dev,
 			"Property 'rockchip,i2s-controller' missing or invalid\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_codec_of_node;
 	}
 
 	rk_dailink.platform_of_node = rk_dailink.cpu_of_node;
@@ -190,17 +191,36 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Soc parse card name failed %d\n", ret);
-		return ret;
+		goto put_cpu_of_node;
 	}
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"Soc register card failed %d\n", ret);
-		return ret;
+		goto put_cpu_of_node;
 	}
 
 	return ret;
+
+put_cpu_of_node:
+	of_node_put(rk_dailink.cpu_of_node);
+	rk_dailink.cpu_of_node = NULL;
+put_codec_of_node:
+	of_node_put(rk_dailink.codec_of_node);
+	rk_dailink.codec_of_node = NULL;
+
+	return ret;
+}
+
+static int snd_rk_mc_remove(struct platform_device *pdev)
+{
+	of_node_put(rk_dailink.cpu_of_node);
+	rk_dailink.cpu_of_node = NULL;
+	of_node_put(rk_dailink.codec_of_node);
+	rk_dailink.codec_of_node = NULL;
+
+	return 0;
 }
 
 static const struct of_device_id rockchip_rt5645_of_match[] = {
@@ -212,6 +232,7 @@ MODULE_DEVICE_TABLE(of, rockchip_rt5645_of_match);
 
 static struct platform_driver snd_rk_mc_driver = {
 	.probe = snd_rk_mc_probe,
+	.remove = snd_rk_mc_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.pm = &snd_soc_pm_ops,
-- 
2.17.1
