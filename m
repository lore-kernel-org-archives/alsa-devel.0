From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH V2 3/5] sound: asoc: Adding support for
	SPEAr13XX ASoC machine driver
Date: Tue, 29 Mar 2011 16:47:01 +0530
Message-ID: <1301397423-4693-4-git-send-email-rajeev-dlh.kumar@st.com>
References: <1301397423-4693-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-2-git-send-email-rajeev-dlh.kumar@st.com>
	<1301397423-4693-3-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog111.obsmtp.com (eu1sys200aog111.obsmtp.com
	[207.126.144.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 588C0243E3
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 13:18:16 +0200 (CEST)
In-Reply-To: <1301397423-4693-3-git-send-email-rajeev-dlh.kumar@st.com>
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
Cc: alsa-devel@alsa-project.org, rajeev-dlh.kumar@st.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

The patch adds support for SPEAr13XX machine driver.

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 sound/soc/spear/evb_sta529.c |  104 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 104 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/spear/evb_sta529.c

diff --git a/sound/soc/spear/evb_sta529.c b/sound/soc/spear/evb_sta529.c
new file mode 100644
index 0000000..4c8bfc3
--- /dev/null
+++ b/sound/soc/spear/evb_sta529.c
@@ -0,0 +1,104 @@
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
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int ret = 0;
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_CBS_CFM);
+
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
+	.name		= "sta529-codec",
+	.dai_link	= &evb_dai,
+	.num_links	= 1,
+};
+
+static struct platform_device *evb_snd_device;
+
+static int __init spear_init(void)
+{
+	int ret;
+
+	/* Create and register platform device */
+	evb_snd_device = platform_device_alloc("soc-audio", 0);
+	if (!evb_snd_device) {
+		printk(KERN_ERR "platform_device_alloc fails\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(evb_snd_device, &snd_soc_evb);
+	ret = platform_device_add(evb_snd_device);
+	if (ret) {
+		printk(KERN_ERR "Unable to add platform device\n");
+		platform_device_put(evb_snd_device);
+	}
+
+	return ret;
+}
+module_init(spear_init);
+
+static void __exit spear_exit(void)
+{
+	platform_device_unregister(evb_snd_device);
+}
+module_exit(spear_exit);
+
+MODULE_AUTHOR("Rajeev Kumar");
+MODULE_DESCRIPTION("ST SPEAR EVB ASoC driver");
+MODULE_LICENSE("GPL");
-- 
1.6.0.2
