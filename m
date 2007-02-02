From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH 9/19] ASoC 0.13 AT91xxxx I2S
Date: Fri, 02 Feb 2007 14:44:55 +0000
Message-ID: <1170427495.18082.139.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-tusrN+ZDSxGfaw756i/k"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--=-tusrN+ZDSxGfaw756i/k
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch updates the AT91xxxx I2S driver to the new API in ASoC 0.13.

Changes:-

o Removed DAI capabilities matching code in favour of manual matching in
the machine drivers.

o Added DAI operations for codec and CPU interfaces.

o Removed config_sysclk() function and struct snd_soc_clock_info. No
longer needed as clocking is now configured manually in the machine
drivers. Also removed other clocking data from structures.

Signed-off-by: Frank Mandarino <fmandarino@endrelia.com>
Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>

Privacy & Confidentiality Notice
-------------------------------------------------
This message and any attachments contain privileged and confidential information that is intended solely for the person(s) to whom it is addressed. If you are not an intended recipient you must not: read; copy; distribute; discuss; take any action in or make any reliance upon the contents of this message; nor open or read any attachment. If you have received this message in error, please notify us as soon as possible on the following telephone number and destroy this message including any attachments. Thank you.
-------------------------------------------------
Wolfson Microelectronics plc
Tel: +44 (0)131 272 7000
Fax: +44 (0)131 272 7001
Web: www.wolfsonmicro.com

Registered in Scotland

Company number SC089839

Registered office: 

Westfield House, 26 Westfield Road, Edinburgh, EH11 2QB, UK


--=-tusrN+ZDSxGfaw756i/k
Content-Disposition: attachment; filename="asoc13-at91-i2s.patch"
Content-Type: text/x-patch; name="asoc13-at91-i2s.patch"; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r fc216dd0eb92 soc/at91/at91-i2s.c
--- a/soc/at91/at91-i2s.c	Thu Feb 01 16:52:06 2007 +0100
+++ b/soc/at91/at91-i2s.c	Wed Jan 31 16:43:17 2007 +0000
@@ -12,8 +12,6 @@
  *  Free Software Foundation;  either version 2 of the  License, or (at your
  *  option) any later version.
  *
- *  Revision history
- *     3rd Mar 2006   Initial version.
  */
 
 #include <linux/init.h>
@@ -34,6 +32,7 @@
 #include <asm/arch/at91_pdc.h>
 
 #include "at91-pcm.h"
+#include "at91-i2s.h"
 
 #if 0
 #define	DBG(x...)	printk(KERN_DEBUG "at91-i2s:" x)
@@ -46,65 +45,6 @@
 #else
 #define NUM_SSC_DEVICES		3
 #endif
-
-
-#define AT91_I2S_DAIFMT \
-	(SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_NB_NF)
-
-#define AT91_I2S_DIR \
-	(SND_SOC_DAIDIR_PLAYBACK | SND_SOC_DAIDIR_CAPTURE)
-
-/* priv is (SSC_CMR.DIV << 16 | SSC_TCMR.PERIOD ) */
-static struct snd_soc_dai_mode at91_i2s[] = {
-
-	/* 8k: BCLK = (MCLK/10) = (60MHz/50) = 1.2MHz */
-	{
-		.fmt = AT91_I2S_DAIFMT,
-		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE,
-		.pcmrate = SNDRV_PCM_RATE_8000,
-		.pcmdir = AT91_I2S_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 1500,
-		.bfs = SND_SOC_FSBD(10),
-		.priv = (25 << 16 | 74),
-	},
-
-	/* 16k: BCLK = (MCLK/3) ~= (60MHz/14) = 4.285714MHz */
-	{
-		.fmt = AT91_I2S_DAIFMT,
-		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE,
-		.pcmrate = SNDRV_PCM_RATE_16000,
-		.pcmdir = AT91_I2S_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 750,
-		.bfs = SND_SOC_FSBD(3),
-		.priv = (7 << 16 | 133),
-	},
-
-	/* 32k: BCLK = (MCLK/3) ~= (60MHz/14) = 4.285714MHz */
-	{
-		.fmt = AT91_I2S_DAIFMT,
-		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE,
-		.pcmrate = SNDRV_PCM_RATE_32000,
-		.pcmdir = AT91_I2S_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 375,
-		.bfs = SND_SOC_FSBD(3),
-		.priv = (7 << 16 | 66),
-	},
-
-	/* 48k: BCLK = (MCLK/5) ~= (60MHz/26) = 2.3076923MHz */
-	{
-		.fmt = AT91_I2S_DAIFMT,
-		.pcmfmt = SNDRV_PCM_FMTBIT_S16_LE,
-		.pcmrate = SNDRV_PCM_RATE_48000,
-		.pcmdir = AT91_I2S_DIR,
-		.flags = SND_SOC_DAI_BFS_DIV,
-		.fs = 250,
-		.bfs = SND_SOC_FSBD(5),
-		.priv = (13 << 16 | 23),
-	},
-};
 
 
 /*
@@ -184,21 +124,6 @@ static struct at91_pcm_dma_params ssc_dm
 #endif
 };
 
-
-/*
- * A MUTEX is used to protect an SSC initialzed flag which allows
- * the substream hw_params() call to initialize the SSC only if
- * there are no other substreams open.  If there are other
- * substreams open, the hw_param() call can only check that
- * it is using the same format and rate.
- */
-static DECLARE_MUTEX(ssc0_mutex);
-#if NUM_SSC_DEVICES == 3
-static DECLARE_MUTEX(ssc1_mutex);
-static DECLARE_MUTEX(ssc2_mutex);
-#endif
-
-
 struct at91_ssc_state {
 	u32	ssc_cmr;
 	u32	ssc_rcmr;
@@ -209,16 +134,16 @@ struct at91_ssc_state {
 	u32	ssc_imr;
 };
 
-
 static struct at91_ssc_info {
 	char		*name;
 	struct at91_ssc_periph ssc;
 	spinlock_t 	lock;		/* lock for dir_mask */
-	int		dir_mask;	/* 0=unused, 1=playback, 2=capture */
-	struct semaphore *mutex;
-	int		initialized;
-	int		pcmfmt;
-	int		rate;
+	unsigned short	dir_mask;	/* 0=unused, 1=playback, 2=capture */
+	unsigned short	initialized;	/* 1=SSC has been initialized */
+	unsigned short	daifmt;
+	unsigned short	cmr_div;
+	unsigned short	tcmr_period;
+	unsigned short	rcmr_period;
 	struct at91_pcm_dma_params *dma_params[2];
 	struct at91_ssc_state ssc_state;
 
@@ -227,7 +152,6 @@ static struct at91_ssc_info {
 	.name		= "ssc0",
 	.lock		= SPIN_LOCK_UNLOCKED,
 	.dir_mask	= 0,
-	.mutex		= &ssc0_mutex,
 	.initialized	= 0,
 	},
 #if NUM_SSC_DEVICES == 3
@@ -235,20 +159,23 @@ static struct at91_ssc_info {
 	.name		= "ssc1",
 	.lock		= SPIN_LOCK_UNLOCKED,
 	.dir_mask	= 0,
-	.mutex		= &ssc1_mutex,
 	.initialized	= 0,
 	},
 	{
 	.name		= "ssc2",
 	.lock		= SPIN_LOCK_UNLOCKED,
 	.dir_mask	= 0,
-	.mutex		= &ssc2_mutex,
 	.initialized	= 0,
 	},
 #endif
 };
 
-
+static unsigned int at91_i2s_sysclk;
+
+/*
+ * SSC interrupt handler.  Passes PDC interrupts to the DMA
+ * interrupt handler in the PCM driver.
+ */
 static irqreturn_t at91_i2s_interrupt(int irq, void *dev_id)
 {
 	struct at91_ssc_info *ssc_p = dev_id;
@@ -278,10 +205,13 @@ static irqreturn_t at91_i2s_interrupt(in
 	return IRQ_HANDLED;
 }
 
+/*
+ * Startup.  Only that one substream allowed in each direction.
+ */
 static int at91_i2s_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct at91_ssc_info *ssc_p = &ssc_info[rtd->cpu_dai->id];
+	struct at91_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
 	int dir_mask;
 
 	DBG("i2s_startup: SSC_SR=0x%08lx\n",
@@ -296,24 +226,22 @@ static int at91_i2s_startup(struct snd_p
 	ssc_p->dir_mask |= dir_mask;
 	spin_unlock_irq(&ssc_p->lock);
 
-	/*
-	 * dma_data is not set until hw_params() is called and
-	 * shutdown() depends on this value being NULL if hw_params()
-	 * was not called.
-	 */
-	rtd->cpu_dai->dma_data = NULL;
-
-	return 0;
-}
-
+	return 0;
+}
+
+/*
+ * Shutdown.  Clear DMA parameters and shutdown the SSC if there
+ * are no other substreams open.
+ */
 static void at91_i2s_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct at91_ssc_info *ssc_p = &ssc_info[rtd->cpu_dai->id];
-	struct at91_pcm_dma_params *dma_params = rtd->cpu_dai->dma_data;
+	struct at91_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
+	struct at91_pcm_dma_params *dma_params;
 	int dir, dir_mask;
 
 	dir = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
+	dma_params = ssc_p->dma_params[dir];
 
 	if (dma_params != NULL) {
 		at91_ssc_write(dma_params->ssc_base + AT91_SSC_CR,
@@ -335,99 +263,107 @@ static void at91_i2s_shutdown(struct snd
 		DBG("Stopping pid %d clock\n", ssc_p->ssc.pid);
 		at91_sys_write(AT91_PMC_PCDR, 1<<ssc_p->ssc.pid);
 
-		if (ssc_p->initialized)
+		if (ssc_p->initialized) {
 			free_irq(ssc_p->ssc.pid, ssc_p);
+			ssc_p->initialized = 0;
+		}
 
 		/* Reset the SSC */
 		at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CR, AT91_SSC_SWRST);
 
-		/* Force a re-init on the next hw_params() call. */
-		ssc_p->initialized = 0;
+		/* Clear the SSC dividers */
+		ssc_p->cmr_div = ssc_p->tcmr_period = ssc_p->rcmr_period = 0;
 	}
 	spin_unlock_irq(&ssc_p->lock);
 }
 
-#ifdef CONFIG_PM
-static int at91_i2s_suspend(struct platform_device *pdev,
-	struct snd_soc_cpu_dai *dai)
-{
-	struct at91_ssc_info *ssc_p;
-
-	if(!dai->active)
-		return 0;
-
-	ssc_p = &ssc_info[dai->id];
-
-	/* Save the status register before disabling transmit and receive. */
-	ssc_p->ssc_state.ssc_sr = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_SR);
-	at91_ssc_write(ssc_p->ssc.base +
-		AT91_SSC_CR, AT91_SSC_TXDIS | AT91_SSC_RXDIS);
-
-	/* Save the current interrupt mask, then disable unmasked interrupts. */
-	ssc_p->ssc_state.ssc_imr = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_IMR);
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_IDR, ssc_p->ssc_state.ssc_imr);
-
-	ssc_p->ssc_state.ssc_cmr  = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_CMR);
-	ssc_p->ssc_state.ssc_rcmr = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RCMR);
-	ssc_p->ssc_state.ssc_rfmr = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RCMR);
-	ssc_p->ssc_state.ssc_tcmr = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RCMR);
-	ssc_p->ssc_state.ssc_tfmr = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RCMR);
-
-	return 0;
-}
-
-static int at91_i2s_resume(struct platform_device *pdev,
-	struct snd_soc_cpu_dai *dai)
-{
-	struct at91_ssc_info *ssc_p;
-	u32 cr_mask;
-
-	if(!dai->active)
-		return 0;
-
-	ssc_p = &ssc_info[dai->id];
-
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->ssc_state.ssc_tfmr);
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->ssc_state.ssc_tcmr);
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->ssc_state.ssc_rfmr);
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->ssc_state.ssc_rcmr);
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CMR,  ssc_p->ssc_state.ssc_cmr);
-
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_IER,  ssc_p->ssc_state.ssc_imr);
-
-	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CR,
-		((ssc_p->ssc_state.ssc_sr & AT91_SSC_RXENA) ? AT91_SSC_RXEN : 0) |
-		((ssc_p->ssc_state.ssc_sr & AT91_SSC_TXENA) ? AT91_SSC_TXEN : 0));
-
-	return 0;
-}
-
-#else
-#define at91_i2s_suspend	NULL
-#define at91_i2s_resume	NULL
-#endif
-
-static unsigned int at91_i2s_config_sysclk(
-	struct snd_soc_cpu_dai *iface, struct snd_soc_clock_info *info,
-	unsigned int clk)
-{
-	/* Currently, there is only support for USB (12Mhz) mode */
-	if (clk != 12000000)
-		return 0;
-	return 12000000;
-}
-
+/*
+ * Record the SSC system clock rate.
+ */
+static int at91_i2s_set_dai_sysclk(struct snd_soc_cpu_dai *cpu_dai,
+		int clk_id, unsigned int freq, int dir)
+{
+	/*
+	 * The only clock supplied to the SSC is the AT91 master clock,
+	 * which is only used if the SSC is generating BCLK and/or
+	 * LRC clocks.
+	 */
+	switch (clk_id) {
+	case AT91_SYSCLK_MCK:
+		at91_i2s_sysclk = freq;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Record the DAI format for use in hw_params().
+ */
+static int at91_i2s_set_dai_fmt(struct snd_soc_cpu_dai *cpu_dai,
+		unsigned int fmt)
+{
+	struct at91_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
+
+	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_I2S)
+		return -EINVAL;
+
+	ssc_p->daifmt = fmt;
+	return 0;
+}
+
+/*
+ * Record SSC clock dividers for use in hw_params().
+ */
+static int at91_i2s_set_dai_clkdiv(struct snd_soc_cpu_dai *cpu_dai,
+	int div_id, int div)
+{
+	struct at91_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
+
+	switch (div_id) {
+	case AT91SSC_CMR_DIV:
+		/*
+		 * The same master clock divider is used for both
+		 * transmit and receive, so if a value has already
+		 * been set, it must match this value.
+		 */
+		if (ssc_p->cmr_div == 0)
+			ssc_p->cmr_div = div;
+		else
+			if (div != ssc_p->cmr_div)
+				return -EBUSY;
+		break;
+
+	case AT91SSC_TCMR_PERIOD:
+		ssc_p->tcmr_period = div;
+		break;
+
+	case AT91SSC_RCMR_PERIOD:
+		ssc_p->rcmr_period = div;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Configure the SSC.
+ */
 static int at91_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	int id = rtd->cpu_dai->id;
+	int id = rtd->dai->cpu_dai->id;
 	struct at91_ssc_info *ssc_p = &ssc_info[id];
 	struct at91_pcm_dma_params *dma_params;
-	unsigned int pcmfmt, rate;
 	int dir, channels, bits;
-	struct clk *mck_clk;
-	u32 div, period, tfmr, rfmr, tcmr, rcmr;
+	u32 tfmr, rfmr, tcmr, rcmr;
+	int start_event;
 	int ret;
 
 	/*
@@ -442,44 +378,134 @@ static int at91_i2s_hw_params(struct snd
 	dma_params->substream = substream;
 
 	ssc_p->dma_params[dir] = dma_params;
-	rtd->cpu_dai->dma_data = dma_params;
-
-	rate = params_rate(params);
+
+	/*
+	 * The cpu_dai->dma_data field is only used to communicate the
+	 * appropriate DMA parameters to the pcm driver hw_params()
+	 * function.  It should not be used for other purposes
+	 * as it is common to all substreams.
+	 */
+	rtd->dai->cpu_dai->dma_data = dma_params;
+
 	channels = params_channels(params);
 
-	pcmfmt = rtd->cpu_dai->dai_runtime.pcmfmt;
-	switch (pcmfmt) {
-		case SNDRV_PCM_FMTBIT_S16_LE:
-			/* likely this is all we'll ever support, but ... */
-			bits = 16;
-			dma_params->pdc_xfer_size = 2;
-			break;
-		default:
-			printk(KERN_WARNING "at91-i2s: unsupported format %x\n",
-				pcmfmt);
-			return -EINVAL;
-	}
-
-	/* Don't allow both SSC substreams to initialize at the same time. */
-	down(ssc_p->mutex);
-
 	/*
-	 * If this SSC is alreadly initialized, then this substream must use
-	 * the same format and rate.
+	 * The SSC only supports up to 16-bit samples in I2S format, due
+	 * to the size of the Frame Mode Register FSLEN field.  Also, I2S
+	 * implies signed data.
 	 */
-	if (ssc_p->initialized) {
-		if (pcmfmt != ssc_p->pcmfmt || rate != ssc_p->rate) {
-			printk(KERN_WARNING "at91-i2s: "
-				"incompatible substream in other direction\n");
-			up(ssc_p->mutex);
-			return -EINVAL;
-		}
-	} else {
+	bits = 16;
+	dma_params->pdc_xfer_size = 2;
+
+	/*
+	 * Compute SSC register settings.
+	 */
+	switch (ssc_p->daifmt) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		/*
+		 * SSC provides BCLK and LRC clocks.
+		 *
+		 * The SSC transmit and receive clocks are generated from the
+		 * MCK divider, and the BCLK signal is output on the SSC TK line.
+		 */
+		rcmr =	  (( ssc_p->rcmr_period		<< 24) & AT91_SSC_PERIOD)
+			| (( 1				<< 16) & AT91_SSC_STTDLY)
+			| (( AT91_SSC_START_FALLING_RF	     ) & AT91_SSC_START)
+			| (( AT91_SSC_CK_RISING		     ) & AT91_SSC_CKI)
+			| (( AT91_SSC_CKO_NONE		     ) & AT91_SSC_CKO)
+			| (( AT91_SSC_CKS_DIV		     ) & AT91_SSC_CKS);
+
+		rfmr =	  (( AT91_SSC_FSEDGE_POSITIVE	     ) & AT91_SSC_FSEDGE)
+			| (( AT91_SSC_FSOS_NEGATIVE	     ) & AT91_SSC_FSOS)
+			| (((bits - 1)			<< 16) & AT91_SSC_FSLEN)
+			| (((channels - 1)		<<  8) & AT91_SSC_DATNB)
+			| (( 1				<<  7) & AT91_SSC_MSBF)
+			| (( 0				<<  5) & AT91_SSC_LOOP)
+			| (((bits - 1)			<<  0) & AT91_SSC_DATALEN);
+
+		tcmr =	  (( ssc_p->tcmr_period		<< 24) & AT91_SSC_PERIOD)
+			| (( 1				<< 16) & AT91_SSC_STTDLY)
+			| (( AT91_SSC_START_FALLING_RF       ) & AT91_SSC_START)
+			| (( AT91_SSC_CKI_FALLING	     ) & AT91_SSC_CKI)
+			| (( AT91_SSC_CKO_CONTINUOUS	     ) & AT91_SSC_CKO)
+			| (( AT91_SSC_CKS_DIV		     ) & AT91_SSC_CKS);
+
+		tfmr =	  (( AT91_SSC_FSEDGE_POSITIVE	     ) & AT91_SSC_FSEDGE)
+			| (( 0				<< 23) & AT91_SSC_FSDEN)
+			| (( AT91_SSC_FSOS_NEGATIVE	     ) & AT91_SSC_FSOS)
+			| (((bits - 1)			<< 16) & AT91_SSC_FSLEN)
+			| (((channels - 1)		<<  8) & AT91_SSC_DATNB)
+			| (( 1				<<  7) & AT91_SSC_MSBF)
+			| (( 0				<<  5) & AT91_SSC_DATDEF)
+			| (((bits - 1)			<<  0) & AT91_SSC_DATALEN);
+		break;
+
+	case SND_SOC_DAIFMT_CBM_CFM:
+
+		/*
+		 * CODEC supplies BCLK and LRC clocks.
+		 *
+		 * The SSC transmit clock is obtained from the BCLK signal on
+		 * on the TK line, and the SSC receive clock is generated from the
+		 * transmit clock.
+		 *
+		 * For single channel data, one sample is transferred on the falling
+		 * edge of the LRC clock.  For two channel data, one sample is
+		 * transferred on both edges of the LRC clock.
+		 */
+		start_event = channels == 1
+				? AT91_SSC_START_FALLING_RF
+				: AT91_SSC_START_EDGE_RF;
+
+		rcmr =	  (( 0				<< 24) & AT91_SSC_PERIOD)
+			| (( 1				<< 16) & AT91_SSC_STTDLY)
+			| (( start_event		     ) & AT91_SSC_START)
+			| (( AT91_SSC_CK_RISING		     ) & AT91_SSC_CKI)
+			| (( AT91_SSC_CKO_NONE		     ) & AT91_SSC_CKO)
+			| (( AT91_SSC_CKS_CLOCK		     ) & AT91_SSC_CKS);
+
+		rfmr =	  (( AT91_SSC_FSEDGE_POSITIVE	     ) & AT91_SSC_FSEDGE)
+			| (( AT91_SSC_FSOS_NONE		     ) & AT91_SSC_FSOS)
+			| (( 0				<< 16) & AT91_SSC_FSLEN)
+			| (( 0				<<  8) & AT91_SSC_DATNB)
+			| (( 1				<<  7) & AT91_SSC_MSBF)
+			| (( 0				<<  5) & AT91_SSC_LOOP)
+			| (((bits - 1)			<<  0) & AT91_SSC_DATALEN);
+
+		tcmr =	  (( 0				<< 24) & AT91_SSC_PERIOD)
+			| (( 1				<< 16) & AT91_SSC_STTDLY)
+			| (( start_event		     ) & AT91_SSC_START)
+			| (( AT91_SSC_CKI_FALLING	     ) & AT91_SSC_CKI)
+			| (( AT91_SSC_CKO_NONE		     ) & AT91_SSC_CKO)
+			| (( AT91_SSC_CKS_PIN		     ) & AT91_SSC_CKS);
+
+		tfmr =	  (( AT91_SSC_FSEDGE_POSITIVE	     ) & AT91_SSC_FSEDGE)
+			| (( 0				<< 23) & AT91_SSC_FSDEN)
+			| (( AT91_SSC_FSOS_NONE		     ) & AT91_SSC_FSOS)
+			| (( 0				<< 16) & AT91_SSC_FSLEN)
+			| (( 0				<<  8) & AT91_SSC_DATNB)
+			| (( 1				<<  7) & AT91_SSC_MSBF)
+			| (( 0				<<  5) & AT91_SSC_DATDEF)
+			| (((bits - 1)			<<  0) & AT91_SSC_DATALEN);
+		break;
+
+	case SND_SOC_DAIFMT_CBS_CFM:
+	case SND_SOC_DAIFMT_CBM_CFS:
+	default:
+		printk(KERN_WARNING "at91-i2s: unsupported DAI format 0x%x.\n",
+			ssc_p->daifmt);
+		return -EINVAL;
+		break;
+	}
+	DBG("RCMR=%08x RFMR=%08x TCMR=%08x TFMR=%08x\n", rcmr, rfmr, tcmr, tfmr);
+
+	if (!ssc_p->initialized) {
+
 		/* Enable PMC peripheral clock for this SSC */
 		DBG("Starting pid %d clock\n", ssc_p->ssc.pid);
 		at91_sys_write(AT91_PMC_PCER, 1<<ssc_p->ssc.pid);
 
-		/* Reset the SSC */
+		/* Reset the SSC and its PDC registers */
 		at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CR, AT91_SSC_SWRST);
 
 		at91_ssc_write(ssc_p->ssc.base + AT91_PDC_RPR, 0);
@@ -491,97 +517,30 @@ static int at91_i2s_hw_params(struct snd
 		at91_ssc_write(ssc_p->ssc.base + AT91_PDC_TNPR, 0);
 		at91_ssc_write(ssc_p->ssc.base + AT91_PDC_TNCR, 0);
 
-		div = rtd->cpu_dai->dai_runtime.priv >> 16;
-		period = rtd->cpu_dai->dai_runtime.priv & 0xffff;
-
-		mck_clk = clk_get(NULL, "mck");
-
-		DBG("mck %lu fsbd %u bfs %llu bfs_real %u bclk %lu div %u period %u\n",
-			clk_get_rate(mck_clk),
-			SND_SOC_FSBD(6),
-			rtd->cpu_dai->dai_runtime.bfs,
-			SND_SOC_FSBD_REAL(rtd->cpu_dai->dai_runtime.bfs),
-			clk_get_rate(mck_clk) / (2 * div),
-			div,
-			period);
-
-		clk_put(mck_clk);
-
-		at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CMR, div);
-
-		/*
-		 * Setup the TFMR and RFMR for the proper data format.
-		 */
-		tfmr =
-		  (( AT91_SSC_FSEDGE_POSITIVE	     ) & AT91_SSC_FSEDGE)
-		| (( 0				<< 23) & AT91_SSC_FSDEN)
-		| (( AT91_SSC_FSOS_NEGATIVE	     ) & AT91_SSC_FSOS)
-		| (((bits - 1)			<< 16) & AT91_SSC_FSLEN)
-		| (((channels - 1)		<<  8) & AT91_SSC_DATNB)
-		| (( 1				<<  7) & AT91_SSC_MSBF)
-		| (( 0				<<  5) & AT91_SSC_DATDEF)
-		| (((bits - 1)			<<  0) & AT91_SSC_DATALEN);
-		DBG("SSC_TFMR=0x%08x\n", tfmr);
-		at91_ssc_write(ssc_p->ssc.base + AT91_SSC_TFMR, tfmr);
-
-		rfmr =
-		  (( AT91_SSC_FSEDGE_POSITIVE	     ) & AT91_SSC_FSEDGE)
-		| (( AT91_SSC_FSOS_NONE		     ) & AT91_SSC_FSOS)
-		| (( 0				<< 16) & AT91_SSC_FSLEN)
-		| (((channels - 1)		<<  8) & AT91_SSC_DATNB)
-		| (( 1				<<  7) & AT91_SSC_MSBF)
-		| (( 0				<<  5) & AT91_SSC_LOOP)
-		| (((bits - 1)			<<  0) & AT91_SSC_DATALEN);
-
-		DBG("SSC_RFMR=0x%08x\n", rfmr);
-		at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RFMR, rfmr);
-
-		/*
-		 * Setup the TCMR and RCMR to generate the proper BCLK
-		 * and LRC signals.
-		 */
-		tcmr =
-		  (( period			<< 24) & AT91_SSC_PERIOD)
-		| (( 1				<< 16) & AT91_SSC_STTDLY)
-		| (( AT91_SSC_START_FALLING_RF       ) & AT91_SSC_START)
-		| (( AT91_SSC_CKI_FALLING	     ) & AT91_SSC_CKI)
-		| (( AT91_SSC_CKO_CONTINUOUS	     ) & AT91_SSC_CKO)
-		| (( AT91_SSC_CKS_DIV		     ) & AT91_SSC_CKS);
-
-		DBG("SSC_TCMR=0x%08x\n", tcmr);
-		at91_ssc_write(ssc_p->ssc.base + AT91_SSC_TCMR, tcmr);
-
-		rcmr =
-		  (( 0				<< 24) & AT91_SSC_PERIOD)
-		| (( 1				<< 16) & AT91_SSC_STTDLY)
-		| (( AT91_SSC_START_TX_RX	     ) & AT91_SSC_START)
-		| (( AT91_SSC_CK_RISING		     ) & AT91_SSC_CKI)
-		| (( AT91_SSC_CKO_NONE		     ) & AT91_SSC_CKO)
-		| (( AT91_SSC_CKS_CLOCK		     ) & AT91_SSC_CKS);
-
-		DBG("SSC_RCMR=0x%08x\n", rcmr);
-		at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, rcmr);
-
 		if ((ret = request_irq(ssc_p->ssc.pid, at91_i2s_interrupt,
 					0, ssc_p->name, ssc_p)) < 0) {
 			printk(KERN_WARNING "at91-i2s: request_irq failure\n");
+
+			DBG("Stopping pid %d clock\n", ssc_p->ssc.pid);
+			at91_sys_write(AT91_PMC_PCER, 1<<ssc_p->ssc.pid);
 			return ret;
 		}
 
-		/*
-		 * Save the current substream parameters in order to check
-		 * that the substream in the opposite direction uses the
-		 * same parameters.
-		 */
-		ssc_p->pcmfmt = pcmfmt;
-		ssc_p->rate = rate;
 		ssc_p->initialized = 1;
-
-		DBG("hw_params: SSC initialized\n");
-	}
-
-	up(ssc_p->mutex);
-
+	}
+
+	/* set SSC clock mode register */
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CMR, ssc_p->cmr_div);
+
+	/* set receive clock mode and format */
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, rcmr);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RFMR, rfmr);
+
+	/* set transmit clock mode and format */
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_TCMR, tcmr);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_TFMR, tfmr);
+
+	DBG("hw_params: SSC initialized\n");
 	return 0;
 }
 
@@ -589,17 +548,86 @@ static int at91_i2s_prepare(struct snd_p
 static int at91_i2s_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct at91_pcm_dma_params *dma_params = rtd->cpu_dai->dma_data;
+	struct at91_ssc_info *ssc_p = &ssc_info[rtd->dai->cpu_dai->id];
+	struct at91_pcm_dma_params *dma_params;
+	int dir;
+
+	dir = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
+	dma_params = ssc_p->dma_params[dir];
 
 	at91_ssc_write(dma_params->ssc_base + AT91_SSC_CR,
 			dma_params->mask->ssc_enable);
 
-	DBG("%s enabled SSC_SR=0x%08lx\n",
-	substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? "transmit" : "receive",
-	at91_ssc_read(ssc_info[rtd->cpu_dai->id].ssc.base + AT91_SSC_SR));
-	return 0;
-}
-
+	DBG("%s enabled SSC_SR=0x%08lx\n", dir ? "receive" : "transmit",
+		at91_ssc_read(dma_params->ssc_base + AT91_SSC_SR));
+	return 0;
+}
+
+
+#ifdef CONFIG_PM
+static int at91_i2s_suspend(struct platform_device *pdev,
+	struct snd_soc_cpu_dai *cpu_dai)
+{
+	struct at91_ssc_info *ssc_p;
+
+	if(!cpu_dai->active)
+		return 0;
+
+	ssc_p = &ssc_info[cpu_dai->id];
+
+	/* Save the status register before disabling transmit and receive. */
+	ssc_p->ssc_state.ssc_sr = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_SR);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CR,
+			AT91_SSC_TXDIS | AT91_SSC_RXDIS);
+
+	/* Save the current interrupt mask, then disable unmasked interrupts. */
+	ssc_p->ssc_state.ssc_imr = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_IMR);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_IDR, ssc_p->ssc_state.ssc_imr);
+
+	ssc_p->ssc_state.ssc_cmr  = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_CMR);
+	ssc_p->ssc_state.ssc_rcmr = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RCMR);
+	ssc_p->ssc_state.ssc_rfmr = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_RFMR);
+	ssc_p->ssc_state.ssc_tcmr = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_TCMR);
+	ssc_p->ssc_state.ssc_tfmr = at91_ssc_read(ssc_p->ssc.base + AT91_SSC_TFMR);
+
+	return 0;
+}
+
+static int at91_i2s_resume(struct platform_device *pdev,
+	struct snd_soc_cpu_dai *cpu_dai)
+{
+	struct at91_ssc_info *ssc_p;
+
+	if(!cpu_dai->active)
+		return 0;
+
+	ssc_p = &ssc_info[cpu_dai->id];
+
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_TFMR, ssc_p->ssc_state.ssc_tfmr);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_TCMR, ssc_p->ssc_state.ssc_tcmr);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RFMR, ssc_p->ssc_state.ssc_rfmr);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_RCMR, ssc_p->ssc_state.ssc_rcmr);
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CMR,  ssc_p->ssc_state.ssc_cmr);
+
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_IER,  ssc_p->ssc_state.ssc_imr);
+
+	at91_ssc_write(ssc_p->ssc.base + AT91_SSC_CR,
+		((ssc_p->ssc_state.ssc_sr & AT91_SSC_RXENA) ? AT91_SSC_RXEN : 0) |
+		((ssc_p->ssc_state.ssc_sr & AT91_SSC_TXENA) ? AT91_SSC_TXEN : 0));
+
+	return 0;
+}
+
+#else
+#define at91_i2s_suspend	NULL
+#define at91_i2s_resume		NULL
+#endif
+
+#define AT91_I2S_RATES (SNDRV_PCM_RATE_8000  | SNDRV_PCM_RATE_11025 |\
+			SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
+			SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
+			SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
+			SNDRV_PCM_RATE_96000)
 
 struct snd_soc_cpu_dai at91_i2s_dai[NUM_SSC_DEVICES] = {
 	{	.name = "at91_ssc0/i2s",
@@ -607,21 +635,25 @@ struct snd_soc_cpu_dai at91_i2s_dai[NUM_
 		.type = SND_SOC_DAI_I2S,
 		.suspend = at91_i2s_suspend,
 		.resume = at91_i2s_resume,
-		.config_sysclk = at91_i2s_config_sysclk,
 		.playback = {
 			.channels_min = 1,
-			.channels_max = 2,},
+			.channels_max = 2,
+			.rates = AT91_I2S_RATES,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 		.capture = {
 			.channels_min = 1,
-			.channels_max = 2,},
+			.channels_max = 2,
+			.rates = AT91_I2S_RATES,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 		.ops = {
 			.startup = at91_i2s_startup,
 			.shutdown = at91_i2s_shutdown,
 			.prepare = at91_i2s_prepare,
 			.hw_params = at91_i2s_hw_params,},
-		.caps = {
-			.mode = &at91_i2s[0],
-			.num_modes = ARRAY_SIZE(at91_i2s),},
+		.dai_ops = {
+			.set_sysclk = at91_i2s_set_dai_sysclk,
+			.set_fmt = at91_i2s_set_dai_fmt,
+			.set_clkdiv = at91_i2s_set_dai_clkdiv,},
 		.private_data = &ssc_info[0].ssc,
 	},
 #if NUM_SSC_DEVICES == 3
@@ -630,21 +662,25 @@ struct snd_soc_cpu_dai at91_i2s_dai[NUM_
 		.type = SND_SOC_DAI_I2S,
 		.suspend = at91_i2s_suspend,
 		.resume = at91_i2s_resume,
-		.config_sysclk = at91_i2s_config_sysclk,
 		.playback = {
 			.channels_min = 1,
-			.channels_max = 2,},
+			.channels_max = 2,
+			.rates = AT91_I2S_RATES,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 		.capture = {
 			.channels_min = 1,
-			.channels_max = 2,},
+			.channels_max = 2,
+			.rates = AT91_I2S_RATES,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 		.ops = {
 			.startup = at91_i2s_startup,
 			.shutdown = at91_i2s_shutdown,
 			.prepare = at91_i2s_prepare,
 			.hw_params = at91_i2s_hw_params,},
-		.caps = {
-			.mode = &at91_i2s[0],
-			.num_modes = ARRAY_SIZE(at91_i2s),},
+		.dai_ops = {
+			.set_sysclk = at91_i2s_set_dai_sysclk,
+			.set_fmt = at91_i2s_set_dai_fmt,
+			.set_clkdiv = at91_i2s_set_dai_clkdiv,},
 		.private_data = &ssc_info[1].ssc,
 	},
 	{	.name = "at91_ssc2/i2s",
@@ -652,21 +688,25 @@ struct snd_soc_cpu_dai at91_i2s_dai[NUM_
 		.type = SND_SOC_DAI_I2S,
 		.suspend = at91_i2s_suspend,
 		.resume = at91_i2s_resume,
-		.config_sysclk = at91_i2s_config_sysclk,
 		.playback = {
 			.channels_min = 1,
-			.channels_max = 2,},
+			.channels_max = 2,
+			.rates = AT91_I2S_RATES,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 		.capture = {
 			.channels_min = 1,
-			.channels_max = 2,},
+			.channels_max = 2,
+			.rates = AT91_I2S_RATES,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,},
 		.ops = {
 			.startup = at91_i2s_startup,
 			.shutdown = at91_i2s_shutdown,
 			.prepare = at91_i2s_prepare,
 			.hw_params = at91_i2s_hw_params,},
-		.caps = {
-			.mode = &at91_i2s[0],
-			.num_modes = ARRAY_SIZE(at91_i2s),},
+		.dai_ops = {
+			.set_sysclk = at91_i2s_set_dai_sysclk,
+			.set_fmt = at91_i2s_set_dai_fmt,
+			.set_clkdiv = at91_i2s_set_dai_clkdiv,},
 		.private_data = &ssc_info[2].ssc,
 	},
 #endif
diff -r fc216dd0eb92 soc/at91/at91-i2s.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/soc/at91/at91-i2s.h	Wed Jan 31 16:43:17 2007 +0000
@@ -0,0 +1,27 @@
+/*
+ * at91-i2s.h - ALSA I2S interface for the Atmel AT91 SoC
+ *
+ * Author:	Frank Mandarino <fmandarino@endrelia.com>
+ *		Endrelia Technologies Inc.
+ * Created:	Jan 9, 2007
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _AT91_I2S_H
+#define _AT91_I2S_H
+
+/* I2S system clock ids */
+#define AT91_SYSCLK_MCK		0 /* SSC uses AT91 MCK as system clock */
+
+/* I2S divider ids */
+#define AT91SSC_CMR_DIV		0 /* MCK divider for BCLK */
+#define AT91SSC_TCMR_PERIOD	1 /* BCLK divider for transmit FS */
+#define AT91SSC_RCMR_PERIOD	2 /* BCLK divider for receive FS */
+
+extern struct snd_soc_cpu_dai at91_i2s_dai[];
+
+#endif /* _AT91_I2S_H */
+

--=-tusrN+ZDSxGfaw756i/k
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-tusrN+ZDSxGfaw756i/k
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-tusrN+ZDSxGfaw756i/k--
