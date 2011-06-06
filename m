From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH V4 2/5] sound: asoc: Adding support for
	SPEAr13XX ASoC platform driver
Date: Mon, 6 Jun 2011 11:27:33 +0530
Message-ID: <1307339856-30656-3-git-send-email-rajeev-dlh.kumar@st.com>
References: <1307339856-30656-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1307339856-30656-2-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog111.obsmtp.com (eu1sys200aog111.obsmtp.com
	[207.126.144.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 27A752413A
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 07:59:03 +0200 (CEST)
In-Reply-To: <1307339856-30656-2-git-send-email-rajeev-dlh.kumar@st.com>
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

This patch adds the support for the SPEAr13XX Platform Driver (I2S based)
as per the ASoC framework.

SPEAr13XX internally uses a Designware I2S IP and some glue logic on top
of the same.

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 sound/soc/spear/spear13xx-i2s.c |  524 +++++++++++++++++++++++++++++++++++++++
 sound/soc/spear/spear13xx-i2s.h |   19 ++
 sound/soc/spear/spear13xx-pcm.c |  500 +++++++++++++++++++++++++++++++++++++
 sound/soc/spear/spear13xx-pcm.h |   50 ++++
 4 files changed, 1093 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/spear/spear13xx-i2s.c
 create mode 100644 sound/soc/spear/spear13xx-i2s.h
 create mode 100644 sound/soc/spear/spear13xx-pcm.c
 create mode 100644 sound/soc/spear/spear13xx-pcm.h

diff --git a/sound/soc/spear/spear13xx-i2s.c b/sound/soc/spear/spear13xx-i2s.c
new file mode 100644
index 0000000..a551110
--- /dev/null
+++ b/sound/soc/spear/spear13xx-i2s.c
@@ -0,0 +1,524 @@
+/*
+ * ALSA SoC I2S Audio Layer for ST spear13xx processor
+ *
+ * sound/soc/spear/spear13xx-i2s.c
+ *
+ * Copyright (C) 2011 ST Microelectronics
+ * Rajeev Kumar <rajeev-dlh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <mach/misc_regs.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+#include "spear13xx-pcm.h"
+#include "spear13xx-i2s.h"
+
+/* common register for all channel */
+#define IER		0x000
+#define IRER		0x004
+#define ITER		0x008
+#define CER		0x00C
+#define CCR		0x010
+#define RXFFR		0x014
+#define TXFFR		0x018
+
+/* I2STxRxRegisters for channel 0 */
+#define LRBR0_LTHR0	0x020
+#define RRBR0_RTHR0	0x024
+#define RER0		0x028
+#define TER0		0x02C
+#define RCR0		0x030
+#define TCR0		0x034
+#define ISR0		0x038
+#define IMR0		0x03C
+#define ROR0		0x040
+#define TOR0		0x044
+#define RFCR0		0x048
+#define TFCR0		0x04C
+#define RFF0		0x050
+#define TFF0		0x054
+
+/* I2STxRxRegisters for channel 1 */
+#define LRBR1_LTHR1	0x060
+#define RRBR1_RTHR1	0x064
+#define RER1		0x068
+#define TER1		0x06C
+#define RCR1		0x070
+#define TCR1		0x074
+#define ISR1		0x078
+#define IMR1		0x07C
+#define ROR1		0x080
+#define TOR1		0x084
+#define RFCR1		0x088
+#define TFCR1		0x08C
+#define RFF1		0x090
+#define TFF1		0x094
+
+/* I2STxRxRegisters for channel 2 */
+#define LRBR2_LTHR2	0x0A0
+#define RRBR2_RTHR2	0x0A4
+#define RER2		0x0A8
+#define TER2		0x0AC
+#define RCR2		0x0B0
+#define TCR2		0x0B4
+#define ISR2		0x0B8
+#define IMR2		0x0BC
+#define ROR2		0x0C0
+#define TOR2		0x0C4
+#define RFCR2		0x0C8
+#define TFCR2		0x0CC
+#define RFF2		0x0D0
+#define TFF2		0x0D4
+
+/* I2STxRxRegisters for channel 3*/
+#define LRBR3_LTHR3	0x0E0
+#define RRBR3_RTHR3	0x0E4
+#define RER3		0x0E8
+#define TER3		0x0EC
+#define RCR3		0x0F0
+#define TCR3		0x0F4
+#define ISR3		0x0F8
+#define IMR3		0x0FC
+#define ROR3		0x100
+#define TOR3		0x104
+#define RFCR3		0x108
+#define TFCR3		0x10C
+#define RFF3		0x110
+#define TFF3		0x114
+
+/* I2SDMARegisters */
+#define RXDMA		0x01C0
+#define RRXDMA		0x01C4
+#define TXDMA		0x01C8
+#define RTXDMA		0x01CC
+
+/* I2SCOMPRegisters */
+#define I2S_COMP_PARAM_2	0x01F0
+#define I2S_COMP_PARAM_1	0x01F4
+#define I2S_COMP_VERSION	0x01F8
+#define I2S_COMP_TYPE		0x01FC
+
+#define SPEAR13XX_I2S_RATES	SNDRV_PCM_RATE_8000_96000
+#define SPEAR13XX_I2S_FORMAT	SNDRV_PCM_FMTBIT_S16_LE
+#define MAX_CHANNEL_NUM		2
+#define MIN_CHANNEL_NUM		2
+
+struct spear13xx_i2s_dev {
+	void __iomem *i2s_base;
+	struct resource *res;
+	struct clk *clk;
+	int play_irq;
+	int mode;
+	int active;
+	int capture_irq;
+	struct device *dev;
+	struct spear13xx_pcm_dma_params *dma_params[2];
+};
+
+void get_dma_start_addr(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct spear13xx_runtime_data *prtd = substream->runtime->private_data;
+	struct spear13xx_i2s_dev *dev = snd_soc_dai_get_drvdata(rtd->cpu_dai);
+
+	prtd->txdma = dev->res->start + TXDMA;
+	prtd->rxdma = dev->res->start + RXDMA;
+
+	substream->runtime->private_data = prtd;
+}
+
+static inline void i2s_write_reg(void *io_base, int reg, u32 val)
+{
+	writel(val, io_base + reg);
+}
+
+static inline u32 i2s_read_reg(void *io_base, int reg)
+{
+	return readl(io_base + reg);
+}
+
+static void i2s_start_play(struct spear13xx_i2s_dev *dev,
+		struct snd_pcm_substream *substream)
+{
+	u32 val; /*dma mode slection*/
+
+	val = readl(PERIP_CFG);
+	val &= ~0xFFFFFFFC;
+	i2s_write_reg(dev->i2s_base, TER0, 0);
+	i2s_write_reg(dev->i2s_base, TER1, 0);
+
+	/* for 2.0 audio*/
+	if (dev->mode <= 2) {
+		if (!val) {
+			i2s_write_reg(dev->i2s_base, TCR0, 0x2);
+			i2s_write_reg(dev->i2s_base, TFCR0, 0x07);
+			i2s_write_reg(dev->i2s_base, IMR0, 0x00);
+			i2s_write_reg(dev->i2s_base, TER0, 1);
+		} else {
+			i2s_write_reg(dev->i2s_base, TCR1, 0x2);
+			i2s_write_reg(dev->i2s_base, TFCR1, 0x07);
+			i2s_write_reg(dev->i2s_base, IMR1, 0x00);
+			i2s_write_reg(dev->i2s_base, TER1, 1);
+		}
+	} else { /*audio 2.0 onwards */
+		i2s_write_reg(dev->i2s_base, TCR0, 0x5);
+		i2s_write_reg(dev->i2s_base, TCR1, 0x5);
+
+		i2s_write_reg(dev->i2s_base, TFCR0, 0x07);
+		i2s_write_reg(dev->i2s_base, TFCR1, 0x07);
+		i2s_write_reg(dev->i2s_base, IMR0, 0x00);
+		i2s_write_reg(dev->i2s_base, IMR1, 0x00);
+		i2s_write_reg(dev->i2s_base, TER0, 1);
+		i2s_write_reg(dev->i2s_base, TER1, 1);
+	}
+
+	i2s_write_reg(dev->i2s_base, ITER, 1);
+}
+
+static void i2s_start_rec(struct spear13xx_i2s_dev *dev,
+		struct snd_pcm_substream *substream)
+{
+	u32 val; /*dma mode slection*/
+
+	val = readl(PERIP_CFG);
+	val &= ~0xFFFFFFFC;
+	i2s_write_reg(dev->i2s_base, RER0, 0);
+	i2s_write_reg(dev->i2s_base, RER1, 0);
+
+	/* for 2.0 audio*/
+	if (dev->mode <= 2) {
+		if (!val) {
+			i2s_write_reg(dev->i2s_base, RCR0, 0x2);
+			i2s_write_reg(dev->i2s_base, RFCR0, 0x07);
+			i2s_write_reg(dev->i2s_base, IMR0, 0x00);
+			i2s_write_reg(dev->i2s_base, RER0, 1);
+		} else {
+			i2s_write_reg(dev->i2s_base, RCR1, 0x2);
+			i2s_write_reg(dev->i2s_base, RFCR1, 0x07);
+			i2s_write_reg(dev->i2s_base, IMR1, 0x00);
+			i2s_write_reg(dev->i2s_base, TER1, 1);
+		}
+	} else { /*audio 2.0 onwards */
+		i2s_write_reg(dev->i2s_base, RCR0, 0x5);
+		i2s_write_reg(dev->i2s_base, RCR1, 0x5);
+
+		i2s_write_reg(dev->i2s_base, RFCR0, 0x07);
+		i2s_write_reg(dev->i2s_base, RFCR1, 0x07);
+		i2s_write_reg(dev->i2s_base, IMR0, 0x00);
+		i2s_write_reg(dev->i2s_base, IMR1, 0x00);
+		i2s_write_reg(dev->i2s_base, RER0, 1);
+		i2s_write_reg(dev->i2s_base, RER1, 1);
+	}
+
+	i2s_write_reg(dev->i2s_base, IRER, 1);
+}
+
+static void i2s_stop(struct spear13xx_i2s_dev *dev,
+		struct snd_pcm_substream *substream)
+{
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		i2s_write_reg(dev->i2s_base, ITER, 0);
+		i2s_write_reg(dev->i2s_base, ITER, 1);
+		i2s_write_reg(dev->i2s_base, IMR0, 0x30);
+		i2s_write_reg(dev->i2s_base, IMR1, 0x30);
+	} else {
+		i2s_write_reg(dev->i2s_base, IRER, 0);
+		i2s_write_reg(dev->i2s_base, IRER, 1);
+		i2s_write_reg(dev->i2s_base, IMR0, 0x03);
+		i2s_write_reg(dev->i2s_base, IMR1, 0x03);
+	}
+	if (!dev->active--) {
+		i2s_write_reg(dev->i2s_base, CER, 0);
+		i2s_write_reg(dev->i2s_base, IER, 0);
+	}
+
+}
+
+static irqreturn_t i2s_play_irq(int irq, void *_dev)
+{
+	struct spear13xx_i2s_dev *dev = (struct spear13xx_i2s_dev *)_dev;
+	u32 ch0, ch1;
+
+	/* check for the tx data overrun condition */
+	dev_info(dev->dev, "data overrun condition for TX channel\n");
+	ch0 = i2s_read_reg(dev->i2s_base, ISR0) & 0x20;
+	ch1 = i2s_read_reg(dev->i2s_base, ISR1) & 0x20;
+	if (ch0 || ch1) {
+
+		/* disable tx block */
+		i2s_write_reg(dev->i2s_base, ITER, 0);
+
+		/* flush all the tx fifo */
+		i2s_write_reg(dev->i2s_base, TXFFR, 1);
+
+		/* clear tx data overrun interrupt: channel 0 */
+		i2s_read_reg(dev->i2s_base, TOR0);
+
+		/* clear tx data overrun interrupt: channel 1 */
+		i2s_read_reg(dev->i2s_base, TOR1);
+
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t i2s_capture_irq(int irq, void *_dev)
+{
+	struct spear13xx_i2s_dev *dev = (struct spear13xx_i2s_dev *)_dev;
+	u32 ch0, ch1;
+
+	/* check for the rx data overrun condition */
+	dev_info(dev->dev, "data overrun condition for RX channel\n");
+	ch0 = i2s_read_reg(dev->i2s_base, ISR0) & 0x02;
+	ch1 = i2s_read_reg(dev->i2s_base, ISR1) & 0x02;
+	if (ch0 || ch1) {
+
+		/* disable rx block */
+		i2s_write_reg(dev->i2s_base, IRER, 0);
+
+		/* flush all the rx fifo */
+		i2s_write_reg(dev->i2s_base, RXFFR, 1);
+
+		/* clear rx data overrun interrupt: channel 0 */
+		i2s_read_reg(dev->i2s_base, ROR0);
+
+		/* clear rx data overrun interrupt: channel 1 */
+		i2s_read_reg(dev->i2s_base, ROR1);
+
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int spear13xx_i2s_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct spear13xx_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
+
+	dev->mode = params_channels(params);
+
+	if (dev->mode <= 2)
+		i2s_write_reg(dev->i2s_base, CCR, 0x00);
+	else
+		i2s_write_reg(dev->i2s_base, CCR, 0x10);
+
+	return 0;
+}
+
+static int
+spear13xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
+		struct snd_soc_dai *dai)
+{
+	struct spear13xx_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
+	int ret = 0;
+
+	i2s_write_reg(dev->i2s_base, IER, 1);
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		dev->active++;
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			i2s_start_play(dev, substream);
+		else
+			i2s_start_rec(dev, substream);
+		i2s_write_reg(dev->i2s_base, CER, 1);
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		i2s_stop(dev, substream);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static struct snd_soc_dai_ops spear13xx_i2s_dai_ops = {
+	.hw_params	= spear13xx_i2s_hw_params,
+	.trigger	= spear13xx_i2s_trigger,
+};
+
+struct snd_soc_dai_driver spear13xx_i2s_dai = {
+	.playback = {
+		.channels_min = MAX_CHANNEL_NUM,
+		.channels_max = MIN_CHANNEL_NUM,
+		.rates = SPEAR13XX_I2S_RATES,
+		.formats = SPEAR13XX_I2S_FORMAT,
+	},
+	.capture = {
+		.channels_min = MAX_CHANNEL_NUM,
+		.channels_max = MIN_CHANNEL_NUM,
+		.rates = SPEAR13XX_I2S_RATES,
+		.formats = SPEAR13XX_I2S_FORMAT,
+	},
+	.ops = &spear13xx_i2s_dai_ops,
+};
+
+static int spear13xx_i2s_probe(struct platform_device *pdev)
+{
+	struct spear13xx_i2s_dev *dev;
+	struct resource *res;
+	int ret;
+
+	if (!pdev) {
+		dev_err(&pdev->dev, "Invalid platform device\n");
+		return -EINVAL;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "no i2s resource defined\n");
+		return -ENODEV;
+	}
+
+	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
+		dev_err(&pdev->dev, "i2s region already claimed\n");
+		return -EBUSY;
+	}
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev) {
+		ret = -ENOMEM;
+		goto err_release_mem_region;
+	}
+
+	dev->res = res;
+
+	dev->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(dev->clk)) {
+		ret = PTR_ERR(dev->clk);
+		goto err_kfree;
+	}
+
+	ret = clk_enable(dev->clk);
+	if (ret < 0)
+		goto err_clk_put;
+
+	dev->i2s_base = ioremap(res->start, resource_size(res));
+	if (!dev->i2s_base) {
+		dev_err(&pdev->dev, "ioremap fail for i2s_region\n");
+		ret = -ENOMEM;
+		goto err_clk_disable;
+	}
+
+	dev->play_irq = platform_get_irq_byname(pdev, "play_irq");
+	if (!dev->play_irq) {
+		dev_err(&pdev->dev, "play irq not defined\n");
+		ret = -EBUSY;
+		goto err_iounmap_i2s;
+	}
+	ret = request_irq(dev->play_irq, i2s_play_irq, 0, "spear13xx-i2s", dev);
+	if (ret) {
+		dev_err(&pdev->dev, "play IRQ%d already claimed\n",
+				dev->play_irq);
+		goto err_iounmap_i2s;
+	}
+
+	dev->capture_irq = platform_get_irq_byname(pdev, "record_irq");
+
+	if (!dev->capture_irq) {
+		dev_err(&pdev->dev, "record irq not defined\n");
+		ret = -EBUSY;
+		goto err_free_play_irq;
+	}
+
+	ret = request_irq(dev->capture_irq, i2s_capture_irq, 0, "spear13xx-i2s",
+			dev);
+	if (ret) {
+		dev_err(&pdev->dev, "capture IRQ%d already claimed\n",
+				dev->capture_irq);
+		goto err_free_play_irq;
+	}
+
+	dev->dev = &pdev->dev;
+	dev_set_drvdata(&pdev->dev, dev);
+
+	ret = snd_soc_register_dai(&pdev->dev, &spear13xx_i2s_dai);
+	if (ret != 0)
+		goto err_free_capture_irq;
+
+	/* unmask i2s interrupt for channel 0 */
+	i2s_write_reg(dev->i2s_base, IMR0, 0x00);
+
+	/* unmask i2s interrupt for channel 1 */
+	i2s_write_reg(dev->i2s_base, IMR1, 0x00);
+
+	return 0;
+
+err_free_capture_irq:
+	dev_set_drvdata(&pdev->dev, NULL);
+	free_irq(dev->capture_irq, pdev);
+err_free_play_irq:
+	free_irq(dev->play_irq, pdev);
+err_iounmap_i2s:
+	iounmap(dev->i2s_base);
+err_clk_disable:
+	clk_disable(dev->clk);
+err_clk_put:
+	clk_put(dev->clk);
+err_kfree:
+	kfree(dev);
+err_release_mem_region:
+	release_mem_region(res->start, resource_size(res));
+	return ret;
+}
+
+static int spear13xx_i2s_remove(struct platform_device *pdev)
+{
+	struct spear13xx_i2s_dev *dev = dev_get_drvdata(&pdev->dev);
+
+	snd_soc_unregister_dai(&pdev->dev);
+	free_irq(dev->capture_irq, pdev);
+	free_irq(dev->play_irq, pdev);
+	iounmap(dev->i2s_base);
+	clk_disable(dev->clk);
+	clk_put(dev->clk);
+	kfree(dev);
+	release_mem_region(dev->res->start, resource_size(dev->res));
+
+	return 0;
+}
+
+static struct platform_driver spear13xx_i2s_driver = {
+	.probe		= spear13xx_i2s_probe,
+	.remove		= spear13xx_i2s_remove,
+	.driver		= {
+		.name	= "spear13xx-i2s",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init spear13xx_i2s_init(void)
+{
+	return platform_driver_register(&spear13xx_i2s_driver);
+}
+module_init(spear13xx_i2s_init);
+
+static void __exit spear13xx_i2s_exit(void)
+{
+	platform_driver_unregister(&spear13xx_i2s_driver);
+}
+module_exit(spear13xx_i2s_exit);
+
+MODULE_AUTHOR("Rajeev Kumar");
+MODULE_DESCRIPTION("SPEAr I2S SoC Interface");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:spear13xx-i2s");
diff --git a/sound/soc/spear/spear13xx-i2s.h b/sound/soc/spear/spear13xx-i2s.h
new file mode 100644
index 0000000..26e2ea2
--- /dev/null
+++ b/sound/soc/spear/spear13xx-i2s.h
@@ -0,0 +1,19 @@
+/*
+ * ALSA SoC I2S Audio Layer for ST spear13xx processor
+ *
+ * sound/soc/spear/spear13xx-i2s.h
+ *
+ * Copyright (C) 2011 ST Microelectronics
+ * Rajeev Kumar <rajeev-dlh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef SPEAR_I2S_H
+#define SPEAR_I2S_H
+
+void get_dma_start_addr(struct snd_pcm_substream *substream);
+
+#endif /*end if i2s header file */
diff --git a/sound/soc/spear/spear13xx-pcm.c b/sound/soc/spear/spear13xx-pcm.c
new file mode 100644
index 0000000..8746ef7
--- /dev/null
+++ b/sound/soc/spear/spear13xx-pcm.c
@@ -0,0 +1,500 @@
+/*
+ * ALSA PCM interface for ST spear Processor
+ *
+ * sound/soc/spear/spear13xx-pcm.c
+ *
+ * Copyright (C) 2011 ST Microelectronics
+ * Rajeev Kumar <rajeev-dlh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <mach/dma.h>
+#include "spear13xx-i2s.h"
+#include "spear13xx-pcm.h"
+
+static u64 spear13xx_pcm_dmamask = 0xffffffff;
+struct pcm_dma_data data;
+#define MAX_DMA_CHAIN		2
+
+struct snd_pcm_hardware spear13xx_pcm_hardware = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+			SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
+			SNDRV_PCM_INFO_PAUSE),
+	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
+	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
+			SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
+			SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+			SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
+			SNDRV_PCM_RATE_KNOT),
+	.rate_min = 8000,
+	.rate_max = 96000,
+	.channels_min = 2,
+	.channels_max = 2,
+	.buffer_bytes_max = 16 * 1024, /* max buffer size */
+	.period_bytes_min = 2 * 1024, /* 1 msec data minimum period size */
+	.period_bytes_max = 2 * 1024, /* maximum period size */
+	.periods_min = 1, /* min # periods */
+	.periods_max = 8, /* max # of periods */
+	.fifo_size = 0, /* fifo size in bytes */
+};
+
+void pcm_init(struct device *dma_dev)
+{
+
+	data.mem2i2s_slave.dma_dev = dma_dev;
+	data.i2s2mem_slave.dma_dev = dma_dev;
+	/* doing 16 bit audio transfer */
+	data.mem2i2s_slave.reg_width = DW_DMA_SLAVE_WIDTH_16BIT;
+	data.mem2i2s_slave.cfg_hi = DWC_CFGH_DST_PER(DMA_REQ_I2S_TX);
+	data.mem2i2s_slave.cfg_lo = 0;
+	data.mem2i2s_slave.src_master = 1;
+	data.mem2i2s_slave.dst_master = 1;
+	data.mem2i2s_slave.src_msize = DW_DMA_MSIZE_16;
+	/* threshold for i2s is 7 */
+	data.mem2i2s_slave.dst_msize = DW_DMA_MSIZE_16;
+	data.mem2i2s_slave.fc = DW_DMA_FC_D_M2P;
+
+	data.i2s2mem_slave.reg_width = DW_DMA_SLAVE_WIDTH_16BIT;
+	data.i2s2mem_slave.cfg_hi = DWC_CFGH_SRC_PER(DMA_REQ_I2S_RX);
+	data.i2s2mem_slave.src_master = 1;
+	data.i2s2mem_slave.dst_master = 1;
+	data.i2s2mem_slave.src_msize = DW_DMA_MSIZE_16;
+	data.i2s2mem_slave.dst_msize = DW_DMA_MSIZE_16;
+	data.i2s2mem_slave.fc = DW_DMA_FC_D_P2M;
+	data.i2s2mem_slave.cfg_lo = 0;
+
+}
+
+static int spear13xx_pcm_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct spear13xx_runtime_data *prtd = runtime->private_data;
+	int ret;
+
+	ret = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(params));
+	if (ret < 0)
+		return ret;
+
+	prtd->substream = substream;
+	prtd->pos = 0;
+	return 0;
+}
+
+static int spear13xx_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_lib_free_pages(substream);
+}
+
+static int spear13xx_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct spear13xx_runtime_data *prtd = runtime->private_data;
+
+	prtd->dma_addr = runtime->dma_addr;
+	prtd->buffer_bytes = snd_pcm_lib_buffer_bytes(substream);
+	prtd->period_bytes = snd_pcm_lib_period_bytes(substream);
+
+	if (prtd->buffer_bytes == prtd->period_bytes) {
+		prtd->frag_bytes = prtd->period_bytes >> 1;
+		prtd->frags = 2;
+	} else {
+		prtd->frag_bytes = prtd->period_bytes;
+		prtd->frags = prtd->buffer_bytes / prtd->period_bytes;
+	}
+	prtd->frag_count = 0;
+	prtd->pos = 0;
+	return 0;
+}
+
+static void spear13xx_dma_complete(void *arg)
+{
+	struct spear13xx_runtime_data *prtd = arg;
+	unsigned long flags;
+
+	/* dma completion handler cannot submit new operations */
+	spin_lock_irqsave(&prtd->lock, flags);
+	if (prtd->frag_count >= 0) {
+		prtd->dmacount--;
+		BUG_ON(prtd->dmacount < 0);
+		tasklet_schedule(&prtd->tasklet);
+	}
+	spin_unlock_irqrestore(&prtd->lock, flags);
+}
+
+static struct dma_async_tx_descriptor *
+spear13xx_dma_submit(struct spear13xx_runtime_data *prtd,
+		dma_addr_t buf_dma_addr)
+{
+	struct dma_chan *chan;
+	struct dma_async_tx_descriptor *desc;
+	struct scatterlist sg;
+	struct snd_pcm_substream *substream = prtd->substream;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		chan = prtd->dma_chan[0];
+	else
+		chan = prtd->dma_chan[1];
+	sg_init_table(&sg, 1);
+	sg_set_page(&sg, pfn_to_page(PFN_DOWN(buf_dma_addr)),
+			prtd->frag_bytes, buf_dma_addr & (PAGE_SIZE - 1));
+	sg_dma_address(&sg) = buf_dma_addr;
+	desc = chan->device->device_prep_slave_sg(chan, &sg, 1,
+			prtd->substream->stream == SNDRV_PCM_STREAM_PLAYBACK ?
+			DMA_TO_DEVICE : DMA_FROM_DEVICE,
+			DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(&chan->dev->device, "cannot prepare slave dma\n");
+		return NULL;
+	}
+	desc->callback = spear13xx_dma_complete;
+	desc->callback_param = prtd;
+	desc->tx_submit(desc);
+	return desc;
+}
+
+static void spear13xx_dma_tasklet(unsigned long data)
+{
+	struct spear13xx_runtime_data *prtd =
+		(struct spear13xx_runtime_data *)data;
+	struct dma_chan *chan;
+	struct dma_async_tx_descriptor *desc;
+	struct snd_pcm_substream *substream = prtd->substream;
+	int i;
+	unsigned long flags;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		chan = prtd->dma_chan[0];
+	else
+		chan = prtd->dma_chan[1];
+
+	spin_lock_irqsave(&prtd->lock, flags);
+
+	if (prtd->frag_count < 0) {
+		spin_unlock_irqrestore(&prtd->lock, flags);
+		chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
+		/* first time */
+		for (i = 0; i < MAX_DMA_CHAIN; i++) {
+			desc = spear13xx_dma_submit(prtd,
+					prtd->dma_addr + i * prtd->frag_bytes);
+			if (!desc)
+				return;
+		}
+		prtd->dmacount = MAX_DMA_CHAIN;
+		chan->device->device_issue_pending(chan);
+		spin_lock_irqsave(&prtd->lock, flags);
+		prtd->frag_count = MAX_DMA_CHAIN % prtd->frags;
+		spin_unlock_irqrestore(&prtd->lock, flags);
+		return;
+	}
+
+	while (prtd->dmacount < MAX_DMA_CHAIN) {
+		prtd->dmacount++;
+		spin_unlock_irqrestore(&prtd->lock, flags);
+		desc = spear13xx_dma_submit(prtd,
+				prtd->dma_addr +
+				prtd->frag_count * prtd->frag_bytes);
+		if (!desc)
+			return;
+		chan->device->device_issue_pending(chan);
+
+		spin_lock_irqsave(&prtd->lock, flags);
+		prtd->frag_count++;
+		prtd->frag_count %= prtd->frags;
+		prtd->pos += prtd->frag_bytes;
+		prtd->pos %= prtd->buffer_bytes;
+		if ((prtd->frag_count * prtd->frag_bytes) %
+				prtd->period_bytes == 0)
+			snd_pcm_period_elapsed(substream);
+	}
+	spin_unlock_irqrestore(&prtd->lock, flags);
+}
+
+static int spear13xx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct spear13xx_runtime_data *prtd = substream->runtime->private_data;
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		prtd->frag_count = -1;
+		tasklet_schedule(&prtd->tasklet);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		break;
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static snd_pcm_uframes_t
+spear13xx_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct spear13xx_runtime_data *prtd = substream->runtime->private_data;
+
+	return bytes_to_frames(substream->runtime, prtd->pos);
+}
+
+static void dma_configure(struct snd_pcm_substream *substream)
+{
+	struct spear13xx_runtime_data *prtd = substream->runtime->private_data;
+
+	dma_cap_zero(prtd->mask);
+	dma_cap_set(DMA_SLAVE, prtd->mask);
+
+	prtd->slaves = &data;
+	/* we need to pass physical address here */
+	prtd->slaves->mem2i2s_slave.tx_reg = (dma_addr_t)prtd->txdma;
+	prtd->slaves->mem2i2s_slave.rx_reg = 0;
+	prtd->slaves->i2s2mem_slave.tx_reg = 0;
+	prtd->slaves->i2s2mem_slave.rx_reg = (dma_addr_t)prtd->rxdma;
+
+	substream->runtime->private_data = prtd;
+}
+
+static bool filter(struct dma_chan *chan, void *slave)
+{
+	chan->private = slave;
+	return true;
+}
+
+static int spear13xx_pcm_dma_request(struct snd_pcm_substream *substream)
+{
+	struct spear13xx_runtime_data *prtd = substream->runtime->private_data;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		prtd->dma_chan[0] = dma_request_channel(prtd->mask, filter,
+				&prtd->slaves->mem2i2s_slave);
+		if (!prtd->dma_chan[0])
+			return -EAGAIN;
+	} else {
+		prtd->dma_chan[1] = dma_request_channel(prtd->mask, filter,
+				&prtd->slaves->i2s2mem_slave);
+		if (!prtd->dma_chan[1])
+			return -EAGAIN;
+
+	}
+	substream->runtime->private_data = prtd;
+
+	return 0;
+}
+
+static int spear13xx_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct spear13xx_runtime_data *prtd;
+	int ret;
+
+	ret = snd_soc_set_runtime_hwparams(substream, &spear13xx_pcm_hardware);
+	if (ret)
+		return ret;
+	/* ensure that buffer size is a multiple of period size */
+	ret = snd_pcm_hw_constraint_integer(substream->runtime,
+			SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		return ret;
+	prtd = kzalloc(sizeof(*prtd), GFP_KERNEL);
+	if (prtd == NULL)
+		return -ENOMEM;
+
+	spin_lock_init(&prtd->lock);
+
+	substream->runtime->private_data = prtd;
+
+	get_dma_start_addr(substream);
+	dma_configure(substream);
+	ret = spear13xx_pcm_dma_request(substream);
+	if (ret) {
+		dev_err(&prtd->dev, "pcm:Failed to get dma channels\n");
+		kfree(prtd);
+
+	}
+
+	tasklet_init(&prtd->tasklet, spear13xx_dma_tasklet,
+			(unsigned long)prtd);
+
+	return 0;
+}
+
+static void dma_stop(struct snd_pcm_substream *substream)
+{
+	struct spear13xx_runtime_data *prtd = substream->runtime->private_data;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dma_release_channel(prtd->dma_chan[0]);
+	else
+		dma_release_channel(prtd->dma_chan[1]);
+
+}
+
+static int spear13xx_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct spear13xx_runtime_data *prtd = substream->runtime->private_data;
+	struct dma_chan *chan;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		chan = prtd->dma_chan[0];
+	else
+		chan = prtd->dma_chan[1];
+
+	prtd->frag_count = -1;
+	chan->device->device_control(chan, DMA_TERMINATE_ALL, 0);
+	dma_stop(substream);
+	kfree(prtd);
+	return 0;
+}
+
+static int spear13xx_pcm_mmap(struct snd_pcm_substream *substream,
+		struct vm_area_struct *vma)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	return dma_mmap_writecombine(substream->pcm->card->dev, vma,
+			runtime->dma_area, runtime->dma_addr,
+			runtime->dma_bytes);
+}
+
+static struct snd_pcm_ops spear13xx_pcm_ops = {
+	.open		= spear13xx_pcm_open,
+	.close		= spear13xx_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= spear13xx_pcm_hw_params,
+	.hw_free	= spear13xx_pcm_hw_free,
+	.prepare	= spear13xx_pcm_prepare,
+	.trigger	= spear13xx_pcm_trigger,
+	.pointer	= spear13xx_pcm_pointer,
+	.mmap		= spear13xx_pcm_mmap,
+};
+
+static int
+spear13xx_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream,
+		size_t size)
+{
+	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+
+	buf->dev.type = SNDRV_DMA_TYPE_DEV;
+	buf->dev.dev = pcm->card->dev;
+	buf->private_data = NULL;
+	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
+			&buf->addr, GFP_KERNEL);
+	dev_dbg(buf->dev.dev,
+			" preallocate_dma_buffer: area=%p, addr=%p, size=%d\n",
+			(void *)buf->area, (void *)buf->addr, size);
+	if (!buf->area)
+		return -ENOMEM;
+	buf->bytes = size;
+	return 0;
+}
+
+static void spear13xx_pcm_free(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_dma_buffer *buf;
+	int stream;
+
+	for (stream = 0; stream < 2; stream++) {
+		substream = pcm->streams[stream].substream;
+		if (!substream)
+			continue;
+
+		buf = &substream->dma_buffer;
+		if (!buf->area)
+			continue;
+
+		dma_free_writecombine(pcm->card->dev, buf->bytes,
+				buf->area, buf->addr);
+		buf->area = NULL;
+	}
+}
+
+static int spear13xx_pcm_new(struct snd_card *card,
+		struct snd_soc_dai *dai, struct snd_pcm *pcm)
+{
+	int ret;
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &spear13xx_pcm_dmamask;
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = 0xffffffff;
+
+	if (dai->driver->playback.channels_min) {
+		ret = spear13xx_pcm_preallocate_dma_buffer(pcm,
+				SNDRV_PCM_STREAM_PLAYBACK,
+				spear13xx_pcm_hardware.buffer_bytes_max);
+		if (ret)
+			return ret;
+	}
+
+	if (dai->driver->capture.channels_min) {
+		ret = spear13xx_pcm_preallocate_dma_buffer(pcm,
+				SNDRV_PCM_STREAM_CAPTURE,
+				spear13xx_pcm_hardware.buffer_bytes_max);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+struct snd_soc_platform_driver spear13xx_soc_platform = {
+	.ops		=	&spear13xx_pcm_ops,
+	.pcm_new	=	spear13xx_pcm_new,
+	.pcm_free	=	spear13xx_pcm_free,
+};
+
+static int __devinit spear13xx_soc_platform_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_platform(&pdev->dev, &spear13xx_soc_platform);
+}
+
+static int __devexit spear13xx_soc_platform_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_platform(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver spear13xx_pcm_driver = {
+	.driver = {
+		.name = "spear-pcm-audio",
+		.owner = THIS_MODULE,
+	},
+
+	.probe = spear13xx_soc_platform_probe,
+	.remove = __devexit_p(spear13xx_soc_platform_remove),
+};
+
+static int __init snd_spear13xx_pcm_init(void)
+{
+	return platform_driver_register(&spear13xx_pcm_driver);
+}
+module_init(snd_spear13xx_pcm_init);
+
+static void __exit snd_spear13xx_pcm_exit(void)
+{
+	platform_driver_unregister(&spear13xx_pcm_driver);
+}
+module_exit(snd_spear13xx_pcm_exit);
+
+MODULE_AUTHOR("Rajeev Kumar");
+MODULE_DESCRIPTION("spear PCM DMA module");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:spear13xx-pcm");
diff --git a/sound/soc/spear/spear13xx-pcm.h b/sound/soc/spear/spear13xx-pcm.h
new file mode 100644
index 0000000..c5e0c74
--- /dev/null
+++ b/sound/soc/spear/spear13xx-pcm.h
@@ -0,0 +1,50 @@
+/*
+ * ALSA PCM interface for ST spear Processor
+ *
+ * sound/soc/spear/spear13xx-pcm.h
+ *
+ * Copyright (C) 2011 ST Microelectronics
+ * Rajeev Kumar <rajeev-dlh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef SPEAR_PCM_H
+#define SPEAR_PCM_H
+
+#include <linux/dw_dmac.h>
+
+struct pcm_dma_data {
+	struct dw_dma_slave mem2i2s_slave;
+	struct dw_dma_slave i2s2mem_slave;
+};
+
+struct spear13xx_pcm_dma_params {
+	char *name;		/* stream identifier */
+	dma_addr_t dma_addr;	/* device physical address for DMA */
+};
+
+struct spear13xx_runtime_data {
+	struct device dev;
+	struct pcm_dma_data *slaves;
+	struct dma_chan *dma_chan[2];
+	struct tasklet_struct tasklet;
+	spinlock_t lock;
+	dma_addr_t txdma;
+	struct spear13xx_pcm_dma_params *params;	/* DMA params */
+	dma_addr_t rxdma;
+	dma_cap_mask_t mask;
+	int stream;
+	struct snd_pcm_substream *substream;
+	unsigned long pos;
+	dma_addr_t dma_addr;
+	unsigned long buffer_bytes;
+	unsigned long period_bytes;
+	unsigned long frag_bytes;
+	int frags;
+	int frag_count;
+	int dmacount;
+};
+#endif /* end of pcm header file */
-- 
1.6.0.2
