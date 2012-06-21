From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH V2 7/9] sound:asoc: Add support for SPEAr ASoC
	machine driver.
Date: Thu, 21 Jun 2012 15:54:55 +0530
Message-ID: <6eb72cea276e7dc191713cff9e4a0ce8ed6b2faf.1340273261.git.rajeev-dlh.kumar@st.com>
References: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog116.obsmtp.com (eu1sys200aog116.obsmtp.com
	[207.126.144.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 6523810B9A9
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2012 11:04:30 +0200 (CEST)
In-Reply-To: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, perex@perex.cz
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

The patch add support for SPEAr ASoC machine driver.

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 sound/soc/spear/spear_evb.c |  206 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 206 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/spear/spear_evb.c

diff --git a/sound/soc/spear/spear_evb.c b/sound/soc/spear/spear_evb.c
new file mode 100644
index 0000000..fcde033
--- /dev/null
+++ b/sound/soc/spear/spear_evb.c
@@ -0,0 +1,206 @@
+/*
+ * ASoC machine driver for SPEAr evaluation boards
+ *
+ * sound/soc/spear/spear_evb.c
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Rajeev Kumar<rajeev-dlh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <mach/hardware.h>
+
+static int sta529_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret = 0;
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_CBS_CFM);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/* Audio machine driver for SPEAr evb */
+static struct snd_soc_ops sta529_ops = {
+	.hw_params	= sta529_hw_params,
+};
+
+/* SPEAr audio interface glue - connects codec <--> CPU <--> platform */
+static struct snd_soc_dai_link spear_evb_dai[] = {
+	{
+		.name		= "sta529-pcm",
+		.stream_name	= "pcm",
+		.cpu_dai_name	= "designware-i2s.0",
+		.platform_name	= "spear-pcm-audio",
+		.codec_dai_name	= "sta529-audio",
+		.codec_name	= "sta529-codec.0-001a",
+		.ops		= &sta529_ops,
+	},
+};
+
+/* SPEAr audio machine driver */
+static struct snd_soc_card spear_snd_card = {
+	.name		= "spear-evb",
+	.dai_link	= spear_evb_dai,
+	.num_links	= ARRAY_SIZE(spear_evb_dai),
+};
+
+/* SPEAr320s audio interface glue - connects codec <--> CPU <--> platform */
+static struct snd_soc_dai_link spear320s_evb_dai[] = {
+	{
+		.name		= "sta529-pcm",
+		.stream_name	= "pcm",
+		.cpu_dai_name	= "designware-i2s",
+		.platform_name	= "spear-pcm-audio",
+		.codec_dai_name	= "sta529-audio",
+		.codec_name	= "sta529-codec.0-001a",
+		.ops		= &sta529_ops,
+	},
+};
+
+/* SPEAr320s audio machine driver */
+static struct snd_soc_card spear320s_snd_card = {
+	.name		= "spear320s-evb",
+	.dai_link	= spear320s_evb_dai,
+	.num_links	= ARRAY_SIZE(spear320s_evb_dai),
+};
+
+/* LCAD audio interface glue - connects codec <--> CPU <--> platform */
+static struct snd_soc_dai_link lcad_evb_dai[] = {
+	{
+		.name		= "sta529-pcm0",
+		.stream_name	= "I2S Playback",
+		.cpu_dai_name	= "designware-i2s.0",
+		.platform_name	= "spear-pcm-audio",
+		.codec_dai_name	= "sta529-audio",
+		.codec_name	= "sta529-codec.0-001a",
+		.ops		= &sta529_ops,
+	}, {
+		.name		= "sta529-pcm1",
+		.stream_name	= "I2S Capture",
+		.cpu_dai_name	= "designware-i2s.1",
+		.platform_name	= "spear-pcm-audio",
+		.codec_dai_name	= "sta529-audio",
+		.codec_name	= "sta529-codec.0-001a",
+		.ops		= &sta529_ops,
+	},
+};
+
+static struct snd_soc_card lcad_snd_card = {
+	.name		= "lcad-evb",
+	.dai_link	= lcad_evb_dai,
+	.num_links	= ARRAY_SIZE(lcad_evb_dai),
+};
+
+/* Audio machine driver for SPEAr1340 evb */
+
+/* SPEAr1340 audio interface glue - connects codec <--> CPU <--> platform */
+static struct snd_soc_dai_link spear1340_evb_dai[] = {
+	{
+		.name		= "spdif-pcm0",
+		.stream_name	= "SPDIF Playback",
+		.cpu_dai_name	= "spdif-out",
+		.platform_name	= "spear-pcm-audio",
+		.codec_dai_name	= "dit-hifi",
+		.codec_name	= "spdif-dit",
+		.ops		= NULL,
+	}, {
+		.name		= "spdif-pcm1",
+		.stream_name	= "SPDIF Capture",
+		.cpu_dai_name	= "spdif-in",
+		.platform_name	= "spear-pcm-audio",
+		.codec_dai_name	= "dir-hifi",
+		.codec_name	= "spdif-dir",
+		.ops		= NULL,
+	}, {
+		.name		= "sta529-pcm0",
+		.stream_name	= "I2S Playback",
+		.cpu_dai_name	= "designware-i2s.0",
+		.platform_name	= "spear-pcm-audio",
+		.codec_dai_name	= "sta529-audio",
+		.codec_name	= "sta529-codec.0-001a",
+		.ops		= &sta529_ops,
+	}, {
+		.name		= "sta529-pcm1",
+		.stream_name	= "I2S Capture",
+		.cpu_dai_name	= "designware-i2s.1",
+		.platform_name	= "spear-pcm-audio",
+		.codec_dai_name	= "sta529-audio",
+		.codec_name	= "sta529-codec.0-001a",
+		.ops		= &sta529_ops,
+	},
+};
+
+static struct snd_soc_card spear1340_snd_card = {
+	.name		= "spear1340-evb",
+	.dai_link	= spear1340_evb_dai,
+	.num_links	= ARRAY_SIZE(spear1340_evb_dai),
+};
+
+static __devinit int spear_evb_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *spear_soc_card;
+	int ret;
+
+	if (of_machine_is_compatible("st,spear_lcad"))
+		spear_soc_card = &lcad_snd_card;
+	else if (of_machine_is_compatible("st,spear1340"))
+		spear_soc_card = &spear1340_snd_card;
+	else if (of_machine_is_compatible("st,spear320"))
+		spear_soc_card = &spear320s_snd_card;
+	else
+		spear_soc_card = &spear_snd_card;
+
+	spear_soc_card->dev = &pdev->dev;
+
+	ret = snd_soc_register_card(spear_soc_card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __devexit spear_evb_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *spear_soc_card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(spear_soc_card);
+
+	return 0;
+}
+
+static struct platform_driver spear_evb_driver = {
+	.driver = {
+		.name = "spear-evb",
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = spear_evb_probe,
+	.remove = __devexit_p(spear_evb_remove),
+};
+
+module_platform_driver(spear_evb_driver);
+
+MODULE_AUTHOR("Rajeev Kumar <rajeev-dlh.kumar@st.com>");
+MODULE_DESCRIPTION("ST SPEAr EVB ASoC driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:spear evb");
-- 
1.7.0.4
