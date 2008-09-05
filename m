From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 11/14] ASoC: Blackfin: board driver for
	AD1980/1 audio codec
Date: Fri,  5 Sep 2008 15:35:19 +0100
Message-ID: <1220625322-27982-11-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080905143504.GA27793@rakim.wolfsonmicro.main>
	<1220625322-27982-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220625322-27982-10-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B4B1C10385D
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 16:35:26 +0200 (CEST)
In-Reply-To: <1220625322-27982-10-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/blackfin/bf5xx-ad1980.c |  113 +++++++++++++++++++++++++++++++++++++
 1 files changed, 113 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/blackfin/bf5xx-ad1980.c

diff --git a/sound/soc/blackfin/bf5xx-ad1980.c b/sound/soc/blackfin/bf5xx-ad1980.c
new file mode 100644
index 0000000..124425d
--- /dev/null
+++ b/sound/soc/blackfin/bf5xx-ad1980.c
@@ -0,0 +1,113 @@
+/*
+ * File:         sound/soc/blackfin/bf5xx-ad1980.c
+ * Author:       Cliff Cai <Cliff.Cai@analog.com>
+ *
+ * Created:      Tue June 06 2008
+ * Description:  Board driver for AD1980/1 audio codec
+ *
+ * Modified:
+ *               Copyright 2008 Analog Devices Inc.
+ *
+ * Bugs:         Enter bugs at http://blackfin.uclinux.org/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see the file COPYING, or write
+ * to the Free Software Foundation, Inc.,
+ * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <asm/dma.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+
+#include <linux/gpio.h>
+#include <asm/portmux.h>
+
+#include "../codecs/ad1980.h"
+#include "bf5xx-sport.h"
+#include "bf5xx-ac97-pcm.h"
+#include "bf5xx-ac97.h"
+
+static struct snd_soc_machine bf5xx_board;
+
+static int bf5xx_board_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+
+	pr_debug("%s enter\n", __func__);
+	cpu_dai->private_data = sport_handle;
+	return 0;
+}
+
+static struct snd_soc_ops bf5xx_board_ops = {
+	.startup = bf5xx_board_startup,
+};
+
+static struct snd_soc_dai_link bf5xx_board_dai = {
+	.name = "AC97",
+	.stream_name = "AC97 HiFi",
+	.cpu_dai = &bfin_ac97_dai,
+	.codec_dai = &ad1980_dai,
+	.ops = &bf5xx_board_ops,
+};
+
+static struct snd_soc_machine bf5xx_board = {
+	.name = "bf5xx-board",
+	.dai_link = &bf5xx_board_dai,
+	.num_links = 1,
+};
+
+static struct snd_soc_device bf5xx_board_snd_devdata = {
+	.machine = &bf5xx_board,
+	.platform = &bf5xx_ac97_soc_platform,
+	.codec_dev = &soc_codec_dev_ad1980,
+};
+
+static struct platform_device *bf5xx_board_snd_device;
+
+static int __init bf5xx_board_init(void)
+{
+	int ret;
+
+	bf5xx_board_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!bf5xx_board_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(bf5xx_board_snd_device, &bf5xx_board_snd_devdata);
+	bf5xx_board_snd_devdata.dev = &bf5xx_board_snd_device->dev;
+	ret = platform_device_add(bf5xx_board_snd_device);
+
+	if (ret)
+		platform_device_put(bf5xx_board_snd_device);
+
+	return ret;
+}
+
+static void __exit bf5xx_board_exit(void)
+{
+	platform_device_unregister(bf5xx_board_snd_device);
+}
+
+module_init(bf5xx_board_init);
+module_exit(bf5xx_board_exit);
+
+/* Module information */
+MODULE_AUTHOR("Cliff Cai");
+MODULE_DESCRIPTION("ALSA SoC AD1980/1 BF5xx board");
+MODULE_LICENSE("GPL");
-- 
1.5.6.5
