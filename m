From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] ASoC: rockchip: put device_node on remove
Date: Sun, 10 Jun 2018 01:20:54 +0300
Message-ID: <1528582854-8402-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>, alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org, Julia Lawall <julia.lawall@lip6.fr>, sil2review@lists.osadl.org
List-Id: alsa-devel@alsa-project.org

snd_rk_mc_probe() gets a couple of device nodes with of_parse_phandle(),
but there is no release of them.

The patch adds remove handler and proper error handling in the probe.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
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
2.7.4
