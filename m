From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: xlnx: Add i2s driver" to the asoc tree
Date: Thu, 13 Dec 2018 18:11:15 +0000 (GMT)
Message-ID: <20181213181116.017BE11254D1@debutante.sirena.org.uk>
References: <1544207558-72508-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1544207558-72508-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>, Michal Simek <michal.simek@xilinx.com>, Vishal Sagar <vsagar@xilinx.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: xlnx: Add i2s driver

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

>From 112a8900d4b0399f45d6ea025d3e1a4a1d6fa3f3 Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Date: Sat, 8 Dec 2018 00:02:37 +0530
Subject: [PATCH] ASoC: xlnx: Add i2s driver

I2S IP instance can work in transmitter/playback or receiver/capture mode
exclusively. The patch registers corresponding instance as ASoC component
with audio framework.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/xilinx/xlnx_i2s.c | 185 ++++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)
 create mode 100644 sound/soc/xilinx/xlnx_i2s.c

diff --git a/sound/soc/xilinx/xlnx_i2s.c b/sound/soc/xilinx/xlnx_i2s.c
new file mode 100644
index 000000000000..d4ae9eff41ce
--- /dev/null
+++ b/sound/soc/xilinx/xlnx_i2s.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx ASoC I2S audio support
+ *
+ * Copyright (C) 2018 Xilinx, Inc.
+ *
+ * Author: Praveen Vuppala <praveenv@xilinx.com>
+ * Author: Maruthi Srinivas Bayyavarapu <maruthis@xilinx.com>
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#define DRV_NAME "xlnx_i2s"
+
+#define I2S_CORE_CTRL_OFFSET		0x08
+#define I2S_I2STIM_OFFSET		0x20
+#define I2S_CH0_OFFSET			0x30
+#define I2S_I2STIM_VALID_MASK		GENMASK(7, 0)
+
+static int xlnx_i2s_set_sclkout_div(struct snd_soc_dai *cpu_dai,
+				    int div_id, int div)
+{
+	void __iomem *base = snd_soc_dai_get_drvdata(cpu_dai);
+
+	if (!div || (div & ~I2S_I2STIM_VALID_MASK))
+		return -EINVAL;
+
+	writel(div, base + I2S_I2STIM_OFFSET);
+
+	return 0;
+}
+
+static int xlnx_i2s_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params,
+			      struct snd_soc_dai *i2s_dai)
+{
+	u32 reg_off, chan_id;
+	void __iomem *base = snd_soc_dai_get_drvdata(i2s_dai);
+
+	chan_id = params_channels(params) / 2;
+
+	while (chan_id > 0) {
+		reg_off = I2S_CH0_OFFSET + ((chan_id - 1) * 4);
+		writel(chan_id, base + reg_off);
+		chan_id--;
+	}
+
+	return 0;
+}
+
+static int xlnx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+			    struct snd_soc_dai *i2s_dai)
+{
+	void __iomem *base = snd_soc_dai_get_drvdata(i2s_dai);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		writel(1, base + I2S_CORE_CTRL_OFFSET);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		writel(0, base + I2S_CORE_CTRL_OFFSET);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops xlnx_i2s_dai_ops = {
+	.trigger = xlnx_i2s_trigger,
+	.set_clkdiv = xlnx_i2s_set_sclkout_div,
+	.hw_params = xlnx_i2s_hw_params
+};
+
+static const struct snd_soc_component_driver xlnx_i2s_component = {
+	.name = DRV_NAME,
+};
+
+static const struct of_device_id xlnx_i2s_of_match[] = {
+	{ .compatible = "xlnx,i2s-transmitter-1.0", },
+	{ .compatible = "xlnx,i2s-receiver-1.0", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, xlnx_i2s_of_match);
+
+static int xlnx_i2s_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	void __iomem *base;
+	struct snd_soc_dai_driver *dai_drv;
+	int ret;
+	u32 ch, format, data_width;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+
+	dai_drv = devm_kzalloc(&pdev->dev, sizeof(*dai_drv), GFP_KERNEL);
+	if (!dai_drv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	ret = of_property_read_u32(node, "xlnx,num-channels", &ch);
+	if (ret < 0) {
+		dev_err(dev, "cannot get supported channels\n");
+		return ret;
+	}
+	ch = ch * 2;
+
+	ret = of_property_read_u32(node, "xlnx,dwidth", &data_width);
+	if (ret < 0) {
+		dev_err(dev, "cannot get data width\n");
+		return ret;
+	}
+	switch (data_width) {
+	case 16:
+		format = SNDRV_PCM_FMTBIT_S16_LE;
+		break;
+	case 24:
+		format = SNDRV_PCM_FMTBIT_S24_LE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (of_device_is_compatible(node, "xlnx,i2s-transmitter-1.0")) {
+		dai_drv->name = "xlnx_i2s_playback";
+		dai_drv->playback.stream_name = "Playback";
+		dai_drv->playback.formats = format;
+		dai_drv->playback.channels_min = ch;
+		dai_drv->playback.channels_max = ch;
+		dai_drv->playback.rates	= SNDRV_PCM_RATE_8000_192000;
+		dai_drv->ops = &xlnx_i2s_dai_ops;
+	} else if (of_device_is_compatible(node, "xlnx,i2s-receiver-1.0")) {
+		dai_drv->name = "xlnx_i2s_capture";
+		dai_drv->capture.stream_name = "Capture";
+		dai_drv->capture.formats = format;
+		dai_drv->capture.channels_min = ch;
+		dai_drv->capture.channels_max = ch;
+		dai_drv->capture.rates = SNDRV_PCM_RATE_8000_192000;
+		dai_drv->ops = &xlnx_i2s_dai_ops;
+	} else {
+		return -ENODEV;
+	}
+
+	dev_set_drvdata(&pdev->dev, base);
+
+	ret = devm_snd_soc_register_component(&pdev->dev, &xlnx_i2s_component,
+					      dai_drv, 1);
+	if (ret) {
+		dev_err(&pdev->dev, "i2s component registration failed\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "%s DAI registered\n", dai_drv->name);
+
+	return ret;
+}
+
+static struct platform_driver xlnx_i2s_aud_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = xlnx_i2s_of_match,
+	},
+	.probe = xlnx_i2s_probe,
+};
+
+module_platform_driver(xlnx_i2s_aud_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Praveen Vuppala  <praveenv@xilinx.com>");
+MODULE_AUTHOR("Maruthi Srinivas Bayyavarapu <maruthis@xilinx.com>");
-- 
2.19.0.rc2
