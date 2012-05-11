From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 3/3] ASoC: mxs: add device tree support for
	mxs-sgtl5000
Date: Fri, 11 May 2012 22:24:18 +0800
Message-ID: <1336746258-23970-4-git-send-email-shawn.guo@linaro.org>
References: <1336746258-23970-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C354910471A
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 16:25:19 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so4466074pbb.38
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2012 07:25:18 -0700 (PDT)
In-Reply-To: <1336746258-23970-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org, Dong Aisheng <dong.aisheng@linaro.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add device tree probe for mxs-sgtl5000 machine driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/sound/mxs-audio-sgtl5000.txt          |   17 +++++++
 sound/soc/mxs/mxs-sgtl5000.c                       |   46 ++++++++++++++++++++
 2 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mxs-audio-sgtl5000.txt

diff --git a/Documentation/devicetree/bindings/sound/mxs-audio-sgtl5000.txt b/Documentation/devicetree/bindings/sound/mxs-audio-sgtl5000.txt
new file mode 100644
index 0000000..601c518
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mxs-audio-sgtl5000.txt
@@ -0,0 +1,17 @@
+* Freescale MXS audio complex with SGTL5000 codec
+
+Required properties:
+- compatible: "fsl,mxs-audio-sgtl5000"
+- model: The user-visible name of this sound complex
+- saif-controllers: The phandle list of the MXS SAIF controller
+- audio-codec: The phandle of the SGTL5000 audio codec
+
+Example:
+
+sound {
+	compatible = "fsl,imx28-evk-sgtl5000",
+		     "fsl,mxs-audio-sgtl5000";
+	model = "imx28-evk-sgtl5000";
+	saif-controllers = <&saif0 &saif1>;
+	audio-codec = <&sgtl5000>;
+};
diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index e9e6112..3e6e876 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -18,6 +18,8 @@
 
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
@@ -110,11 +112,48 @@ static struct snd_soc_card mxs_sgtl5000 = {
 	.num_links	= ARRAY_SIZE(mxs_sgtl5000_dai),
 };
 
+static int __devinit mxs_sgtl5000_probe_dt(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *saif_np[2], *codec_np;
+	int i, ret = 0;
+
+	if (!np)
+		return 1; /* no device tree */
+
+	saif_np[0] = of_parse_phandle(np, "saif-controllers", 0);
+	saif_np[1] = of_parse_phandle(np, "saif-controllers", 1);
+	codec_np = of_parse_phandle(np, "audio-codec", 0);
+	if (!saif_np[0] || !saif_np[1] || !codec_np) {
+		dev_err(&pdev->dev, "phandle missing or invalid\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < 2; i++) {
+		mxs_sgtl5000_dai[i].codec_name = NULL;
+		mxs_sgtl5000_dai[i].codec_of_node = codec_np;
+		mxs_sgtl5000_dai[i].cpu_dai_name = NULL;
+		mxs_sgtl5000_dai[i].cpu_dai_of_node = saif_np[i];
+		mxs_sgtl5000_dai[i].platform_name = NULL;
+		mxs_sgtl5000_dai[i].platform_of_node = saif_np[i];
+	}
+
+	of_node_put(codec_np);
+	of_node_put(saif_np[0]);
+	of_node_put(saif_np[1]);
+
+	return ret;
+}
+
 static int __devinit mxs_sgtl5000_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &mxs_sgtl5000;
 	int ret;
 
+	ret = mxs_sgtl5000_probe_dt(pdev);
+	if (ret < 0)
+		return ret;
+
 	/*
 	 * Set an init clock(11.28Mhz) for sgtl5000 initialization(i2c r/w).
 	 * The Sgtl5000 sysclk is derived from saif0 mclk and it's range
@@ -148,10 +187,17 @@ static int __devexit mxs_sgtl5000_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id mxs_sgtl5000_dt_ids[] = {
+	{ .compatible = "fsl,mxs-audio-sgtl5000", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mxs_sgtl5000_dt_ids);
+
 static struct platform_driver mxs_sgtl5000_audio_driver = {
 	.driver = {
 		.name = "mxs-sgtl5000",
 		.owner = THIS_MODULE,
+		.of_match_table = mxs_sgtl5000_dt_ids,
 	},
 	.probe = mxs_sgtl5000_probe,
 	.remove = __devexit_p(mxs_sgtl5000_remove),
-- 
1.7.5.4
