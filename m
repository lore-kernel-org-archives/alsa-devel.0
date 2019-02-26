From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 6/7] ASoC: stm32: i2s: fix race condition in irq handler
Date: Tue, 26 Feb 2019 14:51:09 +0100
Message-ID: <1551189070-15469-7-git-send-email-olivier.moysan@st.com>
References: <1551189070-15469-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551189070-15469-1-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

When snd_pcm_stop_xrun() is called in interrupt routine,
substream context may have already been released.
Add protection on substream context.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_i2s.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 9edb753ffa1b..42ce87a35104 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -201,6 +201,7 @@ enum i2s_datlen {
  * @base:  mmio register base virtual address
  * @phys_addr: I2S registers physical base address
  * @lock_fd: lock to manage race conditions in full duplex mode
+ * @irq_lock: prevent race condition with IRQ
  * @dais_name: DAI name
  * @mclk_rate: master clock frequency (Hz)
  * @fmt: DAI protocol
@@ -222,6 +223,7 @@ struct stm32_i2s_data {
 	void __iomem *base;
 	dma_addr_t phys_addr;
 	spinlock_t lock_fd; /* Manage race conditions for full duplex */
+	spinlock_t irq_lock; /* used to prevent race condition with IRQ */
 	char dais_name[STM32_I2S_DAI_NAME_SIZE];
 	unsigned int mclk_rate;
 	unsigned int fmt;
@@ -263,8 +265,10 @@ static irqreturn_t stm32_i2s_isr(int irq, void *devid)
 	if (flags & I2S_SR_TIFRE)
 		dev_dbg(&pdev->dev, "Frame error\n");
 
-	if (err)
+	spin_lock(&i2s->irq_lock);
+	if (err && i2s->substream)
 		snd_pcm_stop_xrun(i2s->substream);
+	spin_unlock(&i2s->irq_lock);
 
 	return IRQ_HANDLED;
 }
@@ -540,9 +544,12 @@ static int stm32_i2s_startup(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_i2s_data *i2s = snd_soc_dai_get_drvdata(cpu_dai);
+	unsigned long flags;
 	int ret;
 
+	spin_lock_irqsave(&i2s->irq_lock, flags);
 	i2s->substream = substream;
+	spin_unlock_irqrestore(&i2s->irq_lock, flags);
 
 	ret = clk_prepare_enable(i2s->i2sclk);
 	if (ret < 0) {
@@ -673,13 +680,16 @@ static void stm32_i2s_shutdown(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_i2s_data *i2s = snd_soc_dai_get_drvdata(cpu_dai);
-
-	i2s->substream = NULL;
+	unsigned long flags;
 
 	regmap_update_bits(i2s->regmap, STM32_I2S_CGFR_REG,
 			   I2S_CGFR_MCKOE, (unsigned int)~I2S_CGFR_MCKOE);
 
 	clk_disable_unprepare(i2s->i2sclk);
+
+	spin_lock_irqsave(&i2s->irq_lock, flags);
+	i2s->substream = NULL;
+	spin_unlock_irqrestore(&i2s->irq_lock, flags);
 }
 
 static int stm32_i2s_dai_probe(struct snd_soc_dai *cpu_dai)
@@ -874,6 +884,7 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 	i2s->pdev = pdev;
 	i2s->ms_flg = I2S_MS_NOT_SET;
 	spin_lock_init(&i2s->lock_fd);
+	spin_lock_init(&i2s->irq_lock);
 	platform_set_drvdata(pdev, i2s);
 
 	ret = stm32_i2s_dais_init(pdev, i2s);
-- 
2.7.4
