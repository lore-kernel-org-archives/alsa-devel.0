From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH V4 3/5] sound: asoc: Adding support for
	SPEAr13XX ASoC machine driver
Date: Mon, 6 Jun 2011 11:27:34 +0530
Message-ID: <1307339856-30656-4-git-send-email-rajeev-dlh.kumar@st.com>
References: <1307339856-30656-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1307339856-30656-2-git-send-email-rajeev-dlh.kumar@st.com>
	<1307339856-30656-3-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog114.obsmtp.com (eu1sys200aog114.obsmtp.com
	[207.126.144.137])
	by alsa0.perex.cz (Postfix) with ESMTP id 2435324133
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 07:59:03 +0200 (CEST)
In-Reply-To: <1307339856-30656-3-git-send-email-rajeev-dlh.kumar@st.com>
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

The patch adds support for SPEAr13XX machine driver.

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 sound/soc/spear/evb_sta529.c |  121 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 121 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/spear/evb_sta529.c

diff --git a/sound/soc/spear/evb_sta529.c b/sound/soc/spear/evb_sta529.c
new file mode 100644
index 0000000..d43b433
--- /dev/null
+++ b/sound/soc/spear/evb_sta529.c
@@ -0,0 +1,121 @@
+/*
+ * ASoC machine driver for spear platform
+ *
+ * sound/soc/spear/evb_sta529.c
+ *
+ * Copyright (C) 2011 ST Microelectronics
+ * Rajeev Kumar <rajeev-dlh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/timer.h>
+
+#include <mach/generic.h>
+#include <mach/misc_regs.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+
+#include "spear13xx-i2s.h"
+#include "spear13xx-pcm.h"
+
+static int
+sta529_evb_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret = 0;
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_CBS_CFM);
+	return ret;
+
+}
+
+static struct snd_soc_ops sta529_evb_ops = {
+	.hw_params	= sta529_evb_hw_params,
+};
+
+/* spear digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link evb_dai = {
+	.name		= "SPEARSTA529",
+	.stream_name	= "I2S Audio",
+	.cpu_dai_name	= "spear13xx-i2s.0",
+	.platform_name	= "spear-pcm-audio",
+	.codec_dai_name	= "sta529-audio",
+	.codec_name	= "sta529.0-001a",
+	.ops		= &sta529_evb_ops,
+};
+
+/* spear audio machine driver */
+static struct snd_soc_card snd_soc_evb = {
+	.name		= "sta529",
+	.dai_link	= &evb_dai,
+	.num_links	= 1,
+};
+
+static __devinit int spear_evb_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &snd_soc_evb;
+	int ret;
+
+	card->dev = &pdev->dev;
+
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __devexit spear_evb_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+
+	return 0;
+}
+
+static struct platform_driver evb_driver = {
+	.driver = {
+		.name = "sta529",
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = spear_evb_probe,
+	.remove = __devexit_p(spear_evb_remove),
+};
+
+static int __init spear_audio_init(void)
+{
+	return platform_driver_register(&evb_driver);
+}
+module_init(spear_audio_init);
+
+static void __exit spear_audio_exit(void)
+{
+	platform_driver_unregister(&evb_driver);
+}
+module_exit(spear_audio_exit);
+
+MODULE_DESCRIPTION("ST SPEAR EVB ASoC driver");
+MODULE_AUTHOR("Rajeev Kumar<rajeev-dlh.kumar@st.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:sta529");
-- 
1.6.0.2
