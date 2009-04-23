From: Eric Miao <eric.y.miao@gmail.com>
Subject: [RFC PATCH 3/5] pxa: clean up the legacy SSP API
Date: Thu, 23 Apr 2009 13:06:12 +0800
Message-ID: <f17812d70904222206n73b3f7d1se18a2615c7aad2bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 2029C103801
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 07:06:14 +0200 (CEST)
Received: by qyk1 with SMTP id 1so730118qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2009 22:06:13 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Paul Shen <bshen9@marvell.com>, Mark Brown <broonie@sirena.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Actually, due to the number of possible SSP configurations, it's quite a
difficult job to maintain an API that can be well re-used. The guideline
here is to keep only a list of SSP devices and their basic information,
and it's up to the user driver (like SPI or Audio SSP) to configure the
SSP in a desired way.

Now that the legacy 'struct ssp_dev' based APIs are removed, and only the
functions below are kept, modified a little bit to make them aware of the
new 'struct ssp_device':

  ssp_enable()
  ssp_disable()
  ssp_save_state()
  ssp_restore_state()

And finally, ssp_{save,restore}_state() can be merged into the suspend()
and resume() interface of the SSP's platform_driver, thus saving the user
driver from doing some similar things in common.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 arch/arm/mach-pxa/include/mach/ssp.h |   32 +----
 arch/arm/mach-pxa/ssp.c              |  240 +---------------------------------
 sound/soc/pxa/pxa-ssp.c              |   65 +++++-----
 3 files changed, 45 insertions(+), 292 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/ssp.h
b/arch/arm/mach-pxa/include/mach/ssp.h
index cb5cb76..e431685 100644
--- a/arch/arm/mach-pxa/include/mach/ssp.h
+++ b/arch/arm/mach-pxa/include/mach/ssp.h
@@ -58,26 +58,10 @@ struct ssp_state {
 	u32 psp;
 };

-struct ssp_dev {
-	struct ssp_device *ssp;
-	u32 port;
-	u32 mode;
-	u32 flags;
-	u32 psp_flags;
-	u32 speed;
-	int irq;
-};
-
-int ssp_write_word(struct ssp_dev *dev, u32 data);
-int ssp_read_word(struct ssp_dev *dev, u32 *data);
-int ssp_flush(struct ssp_dev *dev);
-void ssp_enable(struct ssp_dev *dev);
-void ssp_disable(struct ssp_dev *dev);
-void ssp_save_state(struct ssp_dev *dev, struct ssp_state *ssp);
-void ssp_restore_state(struct ssp_dev *dev, struct ssp_state *ssp);
-int ssp_init(struct ssp_dev *dev, u32 port, u32 init_flags);
-int ssp_config(struct ssp_dev *dev, u32 mode, u32 flags, u32
psp_flags, u32 speed);
-void ssp_exit(struct ssp_dev *dev);
+void ssp_enable(struct ssp_device *ssp);
+void ssp_disable(struct ssp_device *ssp);
+void ssp_save_state(struct ssp_device *ssp, struct ssp_state *);
+void ssp_restore_state(struct ssp_device *ssp, struct ssp_state *);

 /**
  * ssp_write_reg - Write to a SSP register
@@ -86,9 +70,9 @@ void ssp_exit(struct ssp_dev *dev);
  * @reg: Register to write to
  * @val: Value to be written.
  */
-static inline void ssp_write_reg(struct ssp_device *dev, u32 reg, u32 val)
+static inline void ssp_write_reg(struct ssp_device *ssp, u32 reg, u32 val)
 {
-	__raw_writel(val, dev->mmio_base + reg);
+	__raw_writel(val, ssp->mmio_base + reg);
 }

 /**
@@ -97,9 +81,9 @@ static inline void ssp_write_reg(struct ssp_device
*dev, u32 reg, u32 val)
  * @dev: SSP device to access
  * @reg: Register to read from
  */
-static inline u32 ssp_read_reg(struct ssp_device *dev, u32 reg)
+static inline u32 ssp_read_reg(struct ssp_device *ssp, u32 reg)
 {
-	return __raw_readl(dev->mmio_base + reg);
+	return __raw_readl(ssp->mmio_base + reg);
 }

 struct ssp_device *ssp_request(int port, const char *label);
diff --git a/arch/arm/mach-pxa/ssp.c b/arch/arm/mach-pxa/ssp.c
index 965e38c..f48807a 100644
--- a/arch/arm/mach-pxa/ssp.c
+++ b/arch/arm/mach-pxa/ssp.c
@@ -35,153 +35,25 @@
 #include <mach/ssp.h>
 #include <mach/regs-ssp.h>

-#define TIMEOUT 100000
-
-static irqreturn_t ssp_interrupt(int irq, void *dev_id)
+void ssp_enable(struct ssp_device *ssp)
 {
-	struct ssp_dev *dev = dev_id;
-	struct ssp_device *ssp = dev->ssp;
-	unsigned int status;
-
-	status = __raw_readl(ssp->mmio_base + SSSR);
-	__raw_writel(status, ssp->mmio_base + SSSR);
-
-	if (status & SSSR_ROR)
-		printk(KERN_WARNING "SSP(%d): receiver overrun\n", dev->port);
-
-	if (status & SSSR_TUR)
-		printk(KERN_WARNING "SSP(%d): transmitter underrun\n", dev->port);
-
-	if (status & SSSR_BCE)
-		printk(KERN_WARNING "SSP(%d): bit count error\n", dev->port);
-
-	return IRQ_HANDLED;
-}
-
-/**
- * ssp_write_word - write a word to the SSP port
- * @data: 32-bit, MSB justified data to write.
- *
- * Wait for a free entry in the SSP transmit FIFO, and write a data
- * word to the SSP port.
- *
- * The caller is expected to perform the necessary locking.
- *
- * Returns:
- *   %-ETIMEDOUT	timeout occurred
- *   0			success
- */
-int ssp_write_word(struct ssp_dev *dev, u32 data)
-{
-	struct ssp_device *ssp = dev->ssp;
-	int timeout = TIMEOUT;
-
-	while (!(__raw_readl(ssp->mmio_base + SSSR) & SSSR_TNF)) {
-	        if (!--timeout)
-	        	return -ETIMEDOUT;
-		cpu_relax();
-	}
-
-	__raw_writel(data, ssp->mmio_base + SSDR);
-
-	return 0;
-}
-
-/**
- * ssp_read_word - read a word from the SSP port
- *
- * Wait for a data word in the SSP receive FIFO, and return the
- * received data.  Data is LSB justified.
- *
- * Note: Currently, if data is not expected to be received, this
- * function will wait for ever.
- *
- * The caller is expected to perform the necessary locking.
- *
- * Returns:
- *   %-ETIMEDOUT	timeout occurred
- *   32-bit data	success
- */
-int ssp_read_word(struct ssp_dev *dev, u32 *data)
-{
-	struct ssp_device *ssp = dev->ssp;
-	int timeout = TIMEOUT;
-
-	while (!(__raw_readl(ssp->mmio_base + SSSR) & SSSR_RNE)) {
-	        if (!--timeout)
-	        	return -ETIMEDOUT;
-		cpu_relax();
-	}
-
-	*data = __raw_readl(ssp->mmio_base + SSDR);
-	return 0;
-}
-
-/**
- * ssp_flush - flush the transmit and receive FIFOs
- *
- * Wait for the SSP to idle, and ensure that the receive FIFO
- * is empty.
- *
- * The caller is expected to perform the necessary locking.
- */
-int ssp_flush(struct ssp_dev *dev)
-{
-	struct ssp_device *ssp = dev->ssp;
-	int timeout = TIMEOUT * 2;
-
-	/* ensure TX FIFO is empty instead of not full */
-	if (cpu_is_pxa3xx()) {
-		while (__raw_readl(ssp->mmio_base + SSSR) & 0xf00) {
-			if (!--timeout)
-				return -ETIMEDOUT;
-			cpu_relax();
-		}
-		timeout = TIMEOUT * 2;
-	}
-
-	do {
-		while (__raw_readl(ssp->mmio_base + SSSR) & SSSR_RNE) {
-		        if (!--timeout)
-		        	return -ETIMEDOUT;
-			(void)__raw_readl(ssp->mmio_base + SSDR);
-		}
-	        if (!--timeout)
-	        	return -ETIMEDOUT;
-	} while (__raw_readl(ssp->mmio_base + SSSR) & SSSR_BSY);
-
-	return 0;
-}
-
-/**
- * ssp_enable - enable the SSP port
- *
- * Turn on the SSP port.
- */
-void ssp_enable(struct ssp_dev *dev)
-{
-	struct ssp_device *ssp = dev->ssp;
 	uint32_t sscr0;

 	sscr0 = __raw_readl(ssp->mmio_base + SSCR0);
 	sscr0 |= SSCR0_SSE;
 	__raw_writel(sscr0, ssp->mmio_base + SSCR0);
 }
+EXPORT_SYMBOL(ssp_enable);

-/**
- * ssp_disable - shut down the SSP port
- *
- * Turn off the SSP port, optionally powering it down.
- */
-void ssp_disable(struct ssp_dev *dev)
+void ssp_disable(struct ssp_device *ssp)
 {
-	struct ssp_device *ssp = dev->ssp;
 	uint32_t sscr0;

 	sscr0 = __raw_readl(ssp->mmio_base + SSCR0);
 	sscr0 &= ~SSCR0_SSE;
 	__raw_writel(sscr0, ssp->mmio_base + SSCR0);
 }
+EXPORT_SYMBOL(ssp_disable);

 /**
  * ssp_save_state - save the SSP configuration
@@ -189,16 +61,12 @@ void ssp_disable(struct ssp_dev *dev)
  *
  * Save the configured SSP state for suspend.
  */
-void ssp_save_state(struct ssp_dev *dev, struct ssp_state *state)
+void ssp_save_state(struct ssp_device *ssp, struct ssp_state *state)
 {
-	struct ssp_device *ssp = dev->ssp;
-
 	state->cr0 = __raw_readl(ssp->mmio_base + SSCR0);
 	state->cr1 = __raw_readl(ssp->mmio_base + SSCR1);
 	state->to  = __raw_readl(ssp->mmio_base + SSTO);
 	state->psp = __raw_readl(ssp->mmio_base + SSPSP);
-
-	ssp_disable(dev);
 }

 /**
@@ -207,9 +75,8 @@ void ssp_save_state(struct ssp_dev *dev, struct
ssp_state *state)
  *
  * Restore the SSP configuration saved previously by ssp_save_state.
  */
-void ssp_restore_state(struct ssp_dev *dev, struct ssp_state *state)
+void ssp_restore_state(struct ssp_device *ssp, struct ssp_state *state)
 {
-	struct ssp_device *ssp = dev->ssp;
 	uint32_t sssr = SSSR_ROR | SSSR_TUR | SSSR_BCE;

 	__raw_writel(sssr, ssp->mmio_base + SSSR);
@@ -221,89 +88,6 @@ void ssp_restore_state(struct ssp_dev *dev, struct
ssp_state *state)
 	__raw_writel(state->cr0, ssp->mmio_base + SSCR0);
 }

-/**
- * ssp_config - configure SSP port settings
- * @mode: port operating mode
- * @flags: port config flags
- * @psp_flags: port PSP config flags
- * @speed: port speed
- *
- * Port MUST be disabled by ssp_disable before making any config changes.
- */
-int ssp_config(struct ssp_dev *dev, u32 mode, u32 flags, u32
psp_flags, u32 speed)
-{
-	struct ssp_device *ssp = dev->ssp;
-
-	dev->mode = mode;
-	dev->flags = flags;
-	dev->psp_flags = psp_flags;
-	dev->speed = speed;
-
-	/* set up port type, speed, port settings */
-	__raw_writel((dev->speed | dev->mode), ssp->mmio_base + SSCR0);
-	__raw_writel(dev->flags, ssp->mmio_base + SSCR1);
-	__raw_writel(dev->psp_flags, ssp->mmio_base + SSPSP);
-
-	return 0;
-}
-
-/**
- * ssp_init - setup the SSP port
- *
- * initialise and claim resources for the SSP port.
- *
- * Returns:
- *   %-ENODEV	if the SSP port is unavailable
- *   %-EBUSY	if the resources are already in use
- *   %0		on success
- */
-int ssp_init(struct ssp_dev *dev, u32 port, u32 init_flags)
-{
-	struct ssp_device *ssp;
-	int ret;
-
-	ssp = ssp_request(port, "SSP");
-	if (ssp == NULL)
-		return -ENODEV;
-
-	dev->ssp = ssp;
-	dev->port = port;
-
-	/* do we need to get irq */
-	if (!(init_flags & SSP_NO_IRQ)) {
-		ret = request_irq(ssp->irq, ssp_interrupt,
-				0, "SSP", dev);
-	    	if (ret)
-			goto out_region;
-		dev->irq = ssp->irq;
-	} else
-		dev->irq = NO_IRQ;
-
-	/* turn on SSP port clock */
-	clk_enable(ssp->clk);
-	return 0;
-
-out_region:
-	ssp_free(ssp);
-	return ret;
-}
-
-/**
- * ssp_exit - undo the effects of ssp_init
- *
- * release and free resources for the SSP port.
- */
-void ssp_exit(struct ssp_dev *dev)
-{
-	struct ssp_device *ssp = dev->ssp;
-
-	ssp_disable(dev);
-	if (dev->irq != NO_IRQ)
-		free_irq(dev->irq, dev);
-	clk_disable(ssp->clk);
-	ssp_free(ssp);
-}
-
 static DEFINE_MUTEX(ssp_lock);
 static LIST_HEAD(ssp_list);

@@ -531,18 +315,6 @@ static void __exit pxa_ssp_exit(void)
 arch_initcall(pxa_ssp_init);
 module_exit(pxa_ssp_exit);

-EXPORT_SYMBOL(ssp_write_word);
-EXPORT_SYMBOL(ssp_read_word);
-EXPORT_SYMBOL(ssp_flush);
-EXPORT_SYMBOL(ssp_enable);
-EXPORT_SYMBOL(ssp_disable);
-EXPORT_SYMBOL(ssp_save_state);
-EXPORT_SYMBOL(ssp_restore_state);
-EXPORT_SYMBOL(ssp_init);
-EXPORT_SYMBOL(ssp_exit);
-EXPORT_SYMBOL(ssp_config);
-
 MODULE_DESCRIPTION("PXA SSP driver");
 MODULE_AUTHOR("Liam Girdwood");
 MODULE_LICENSE("GPL");
-
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 308a657..a65993c 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -42,7 +42,7 @@
  * SSP audio private data
  */
 struct ssp_priv {
-	struct ssp_dev dev;
+	struct ssp_device *ssp;
 	unsigned int sysclk;
 	int dai_fmt;
 #ifdef CONFIG_PM
@@ -222,10 +222,8 @@ static int pxa_ssp_startup(struct
snd_pcm_substream *substream,
 	int ret = 0;

 	if (!cpu_dai->active) {
-		priv->dev.port = cpu_dai->id + 1;
-		priv->dev.irq = NO_IRQ;
-		clk_enable(priv->dev.ssp->clk);
-		ssp_disable(&priv->dev);
+		clk_enable(priv->ssp->clk);
+		ssp_disable(priv->ssp);
 	}
 	return ret;
 }
@@ -238,8 +236,8 @@ static void pxa_ssp_shutdown(struct
snd_pcm_substream *substream,
 	struct ssp_priv *priv = cpu_dai->private_data;

 	if (!cpu_dai->active) {
-		ssp_disable(&priv->dev);
-		clk_disable(priv->dev.ssp->clk);
+		ssp_disable(priv->ssp);
+		clk_disable(priv->ssp->clk);
 	}
 }

@@ -252,8 +250,9 @@ static int pxa_ssp_suspend(struct snd_soc_dai *cpu_dai)
 	if (!cpu_dai->active)
 		return 0;

-	ssp_save_state(&priv->dev, &priv->state);
-	clk_disable(priv->dev.ssp->clk);
+	ssp_save_state(priv->ssp, &priv->state);
+	ssp_disable(priv->ssp);
+	clk_disable(priv->ssp->clk);
 	return 0;
 }

@@ -264,10 +263,9 @@ static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
 	if (!cpu_dai->active)
 		return 0;

-	clk_enable(priv->dev.ssp->clk);
-	ssp_restore_state(&priv->dev, &priv->state);
-	ssp_enable(&priv->dev);
-
+	clk_enable(priv->ssp->clk);
+	ssp_restore_state(priv->ssp, &priv->state);
+	ssp_enable(priv->ssp);
 	return 0;
 }

@@ -280,10 +278,9 @@ static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
  * ssp_set_clkdiv - set SSP clock divider
  * @div: serial clock rate divider
  */
-static void ssp_set_scr(struct ssp_dev *dev, u32 div)
+static void ssp_set_scr(struct ssp_device *ssp, u32 div)
 {
-	struct ssp_device *ssp = dev->ssp;
-	u32 sscr0 = ssp_read_reg(dev->ssp, SSCR0) & ~SSCR0_SCR;
+	u32 sscr0 = ssp_read_reg(ssp, SSCR0) & ~SSCR0_SCR;

 	ssp_write_reg(ssp, SSCR0, (sscr0 | SSCR0_SerClkDiv(div)));
 }
@@ -295,7 +292,7 @@ static int pxa_ssp_set_dai_sysclk(struct
snd_soc_dai *cpu_dai,
 	int clk_id, unsigned int freq, int dir)
 {
 	struct ssp_priv *priv = cpu_dai->private_data;
-	struct ssp_device *ssp = priv->dev.ssp;
+	struct ssp_device *ssp = priv->ssp;
 	int val;

 	u32 sscr0 = ssp_read_reg(ssp, SSCR0) &
@@ -326,7 +323,7 @@ static int pxa_ssp_set_dai_sysclk(struct
snd_soc_dai *cpu_dai,
 		break;
 	case PXA_SSP_CLK_AUDIO:
 		priv->sysclk = 0;
-		ssp_set_scr(&priv->dev, 1);
+		ssp_set_scr(priv->ssp, 1);
 		sscr0 |= SSCR0_ACS;
 		break;
 	default:
@@ -336,11 +333,11 @@ static int pxa_ssp_set_dai_sysclk(struct
snd_soc_dai *cpu_dai,
 	/* The SSP clock must be disabled when changing SSP clock mode
 	 * on PXA2xx.  On PXA3xx it must be enabled when doing so. */
 	if (!cpu_is_pxa3xx())
-		clk_disable(priv->dev.ssp->clk);
+		clk_disable(priv->ssp->clk);
 	val = ssp_read_reg(ssp, SSCR0) | sscr0;
 	ssp_write_reg(ssp, SSCR0, val);
 	if (!cpu_is_pxa3xx())
-		clk_enable(priv->dev.ssp->clk);
+		clk_enable(priv->ssp->clk);

 	return 0;
 }
@@ -352,7 +349,7 @@ static int pxa_ssp_set_dai_clkdiv(struct
snd_soc_dai *cpu_dai,
 	int div_id, int div)
 {
 	struct ssp_priv *priv = cpu_dai->private_data;
-	struct ssp_device *ssp = priv->dev.ssp;
+	struct ssp_device *ssp = priv->ssp;
 	int val;

 	switch (div_id) {
@@ -387,7 +384,7 @@ static int pxa_ssp_set_dai_clkdiv(struct
snd_soc_dai *cpu_dai,
 		ssp_write_reg(ssp, SSACD, val);
 		break;
 	case PXA_SSP_DIV_SCR:
-		ssp_set_scr(&priv->dev, div);
+		ssp_set_scr(ssp, div);
 		break;
 	default:
 		return -ENODEV;
@@ -403,7 +400,7 @@ static int pxa_ssp_set_dai_pll(struct snd_soc_dai *cpu_dai,
 	int pll_id, unsigned int freq_in, unsigned int freq_out)
 {
 	struct ssp_priv *priv = cpu_dai->private_data;
-	struct ssp_device *ssp = priv->dev.ssp;
+	struct ssp_device *ssp = priv->ssp;
 	u32 ssacd = ssp_read_reg(ssp, SSACD) & ~0x70;

 #if defined(CONFIG_PXA3xx)
@@ -472,7 +469,7 @@ static int pxa_ssp_set_dai_tdm_slot(struct
snd_soc_dai *cpu_dai,
 	unsigned int mask, int slots)
 {
 	struct ssp_priv *priv = cpu_dai->private_data;
-	struct ssp_device *ssp = priv->dev.ssp;
+	struct ssp_device *ssp = priv->ssp;
 	u32 sscr0;

 	sscr0 = ssp_read_reg(ssp, SSCR0) & ~SSCR0_SlotsPerFrm(7);
@@ -494,7 +491,7 @@ static int pxa_ssp_set_dai_tristate(struct
snd_soc_dai *cpu_dai,
 	int tristate)
 {
 	struct ssp_priv *priv = cpu_dai->private_data;
-	struct ssp_device *ssp = priv->dev.ssp;
+	struct ssp_device *ssp = priv->ssp;
 	u32 sscr1;

 	sscr1 = ssp_read_reg(ssp, SSCR1);
@@ -516,7 +513,7 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
 	struct ssp_priv *priv = cpu_dai->private_data;
-	struct ssp_device *ssp = priv->dev.ssp;
+	struct ssp_device *ssp = priv->ssp;
 	u32 sscr0;
 	u32 sscr1;
 	u32 sspsp;
@@ -622,7 +619,7 @@ static int pxa_ssp_hw_params(struct
snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	struct ssp_priv *priv = cpu_dai->private_data;
-	struct ssp_device *ssp = priv->dev.ssp;
+	struct ssp_device *ssp = priv->ssp;
 	int dma = 0, chn = params_channels(params);
 	u32 sscr0;
 	u32 sspsp;
@@ -735,12 +732,12 @@ static int pxa_ssp_trigger(struct
snd_pcm_substream *substream, int cmd,
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
 	int ret = 0;
 	struct ssp_priv *priv = cpu_dai->private_data;
-	struct ssp_device *ssp = priv->dev.ssp;
+	struct ssp_device *ssp = priv->ssp;
 	int val;

 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
-		ssp_enable(&priv->dev);
+		ssp_enable(ssp);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		val = ssp_read_reg(ssp, SSCR1);
@@ -759,7 +756,7 @@ static int pxa_ssp_trigger(struct
snd_pcm_substream *substream, int cmd,
 		else
 			val |= SSCR1_RSRE;
 		ssp_write_reg(ssp, SSCR1, val);
-		ssp_enable(&priv->dev);
+		ssp_enable(ssp);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 		val = ssp_read_reg(ssp, SSCR1);
@@ -770,7 +767,7 @@ static int pxa_ssp_trigger(struct
snd_pcm_substream *substream, int cmd,
 		ssp_write_reg(ssp, SSCR1, val);
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		ssp_disable(&priv->dev);
+		ssp_disable(ssp);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		val = ssp_read_reg(ssp, SSCR1);
@@ -800,8 +797,8 @@ static int pxa_ssp_probe(struct platform_device *pdev,
 	if (!priv)
 		return -ENOMEM;

-	priv->dev.ssp = ssp_request(dai->id + 1, "SoC audio");
-	if (priv->dev.ssp == NULL) {
+	priv->ssp = ssp_request(dai->id + 1, "SoC audio");
+	if (priv->ssp == NULL) {
 		ret = -ENODEV;
 		goto err_priv;
 	}
@@ -819,7 +816,7 @@ static void pxa_ssp_remove(struct platform_device *pdev,
 			      struct snd_soc_dai *dai)
 {
 	struct ssp_priv *priv = dai->private_data;
-	ssp_free(priv->dev.ssp);
+	ssp_free(priv->ssp);
 }

 #define PXA_SSP_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
-- 
1.6.0.4
