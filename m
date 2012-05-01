From: =?UTF-8?B?SsOpcsO0bWU=?= Carretero <cJ-ko@zougloub.eu>
Subject: davinci-mcasp - external MCLK,
 CPU generates WCLK and BCLK, slave codec(s), full duplex issues
Date: Tue, 1 May 2012 09:22:38 -0400
Message-ID: <20120501092238.628ebb4d@Malcolm.dom3.ad.sys>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/VlIaPWRz2HxnHRmr6p9_2sA"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zougloub.eu (zougloub.eu [188.165.233.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 53C701042CC
	for <alsa-devel@alsa-project.org>;
	Tue,  1 May 2012 15:24:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: Ben Gardiner <bengardiner@nanometrics.ca>, sebastien.paradis@transport.alstom.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--MP_/VlIaPWRz2HxnHRmr6p9_2sA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Note: I opened a thread on TI's E2E forums too, the thread is at:
   http://e2e.ti.com/support/dsp/omap_applications_processors/f/42/t/185810.aspx
Linux is v3.3.

Repeating what I have put there:

- As we will be using multiple codecs on McASP, we have put the codecs as slaves.
  We are also using a 8.192MHz external master clock.
- We have patched davinci-mcasp.c to handle this mode ("SND_SOC_DAIFMT_EM_CBS_CFS"),
  and refer to it for the CPU DAI configuration in the machine driver.
- Our setup currently has an AIC3X codec, connected to the TX clocks of McASP.
  The RX clocks are not used, they are left hanging, so we need to enable the TX clocks even when recording.
- We only plan to support 32kHz, so currently we have left an ugly hack in the code.
- It almost works, but we have a nasty problem:

  - When performing a capture alone, the sound is recorded as expected
  - When performing a playback alone, no problem
  - When starting a playback then a capture, no problem
  - When starting a capture then a playback, the playback will hang,
    the stream won't accept more data; no perturbation on the recording side.

A review of the McASP code WRT/ SPRUH77A (OMAP-L138 Technical Reference Manual)
does not really help.

Now, I performed some tracing:

- patched the davinci-mcasp.c code, to trace register accesses
  See attached file.
  The patch also contains the differences explained on the e2e forum post.
- produced the "yes" file by running the "playback then capture" scenario:
   dmesg -c
   cat /dev/urandom | pv -B 3200 | aplay -f S16 -r 32000
   aplay -B 20000 -f S16 -r 32000 -C -V mono /dev/null
   dmesg -c | gzip > yes.gz
- produced the "no" file by running the "capture then playback" scenario:
   dmesg -c
   aplay -B 20000 -f S16 -r 32000 -C -V mono /dev/null
   cat /dev/urandom | pv -B 3200 | aplay -f S16 -r 32000
   dmesg -c | gzip > no.gz

And I still have issues seing what could be wrong.

Could you somehow help me ?

Best regards,

-- 
cJ

PS: sorry for the resend, the initial message exceeded the allowed mailing list message size.

--MP_/VlIaPWRz2HxnHRmr6p9_2sA
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=mcasp-test.patch

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 95441bf..63eac69 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -13,6 +13,9 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * Ref: spruh77a, chapter "Multichannel Audio Serial Port (McASP)"
+ *
  */
 
 #include <linux/init.h>
@@ -188,6 +191,7 @@
 /*
  * DAVINCI_MCASP_ACLKXCTL_REG - Transmit Clock Control Register Bits
  */
+#define ACLKXDIV_MASK	0b11111
 #define ACLKXDIV(val)	(val)
 #define ACLKXE		BIT(5)
 #define TX_ASYNC	BIT(6)
@@ -291,36 +295,73 @@
 
 #define DAVINCI_MCASP_NUM_SERIALIZER	16
 
-static inline void mcasp_set_bits(void __iomem *reg, u32 val)
+/* HACK: Whether we are playing or recording, to manage clock generation */
+static int playing = 0;
+static int recording = 0;
+static void * base = NULL;
+
+#define stringify(x)  #x
+
+#define mcasp_set_bits(b, x, v) { \
+	pr_debug("%s: setting %s to %s\n", __func__, #x, #v); \
+	mcasp_set_bits2(b + x, v); }
+
+#define mcasp_clr_bits(b, x, v) { \
+	pr_debug("%s: clring %s to %s\n", __func__, #x, #v); \
+	mcasp_clr_bits2(b + x, v); }
+
+#define mcasp_mod_bits(b, x, v, m) { \
+	pr_debug("%s: modding %s with %s mask %s\n", __func__, #x, #v, #m); \
+	mcasp_mod_bits2(b + x, v, m); }
+
+#define mcasp_set_reg(b, x, v) { \
+	pr_debug("%s: setting %s to %s\n", __func__, #x, #v); \
+	mcasp_set_reg2(b + x, v); }
+
+#define mcasp_set_ctl_reg(b, x, v) { \
+	pr_debug("%s: setting %s to %s\n", __func__, #x, #v); \
+	mcasp_set_ctl_reg2(b + x, v); }
+
+static inline void mcasp_set_bits2(void __iomem *reg, u32 val)
 {
-	__raw_writel(__raw_readl(reg) | val, reg);
+	u32 v = __raw_readl(reg);
+	if ((v & val) != val) { // bits to set
+		pr_debug("%s: %04x %x -> %x\n", __func__, (reg-base), v, v|val);
+		__raw_writel(v | val, reg);
+	}
 }
 
-static inline void mcasp_clr_bits(void __iomem *reg, u32 val)
+static inline void mcasp_clr_bits2(void __iomem *reg, u32 val)
 {
-	__raw_writel((__raw_readl(reg) & ~(val)), reg);
+	u32 v = __raw_readl(reg);
+	if ((val & v) != 0) { // bits to clear
+		pr_debug("%s: %04x %x -> %x\n", __func__, (reg-base), v, v&(~val));
+		__raw_writel((v & ~(val)), reg);
+	}
 }
 
-static inline void mcasp_mod_bits(void __iomem *reg, u32 val, u32 mask)
+static inline void mcasp_mod_bits2(void __iomem *reg, u32 val, u32 mask)
 {
 	__raw_writel((__raw_readl(reg) & ~mask) | val, reg);
 }
 
-static inline void mcasp_set_reg(void __iomem *reg, u32 val)
+static inline void mcasp_set_reg2(void __iomem *reg, u32 val)
 {
 	__raw_writel(val, reg);
 }
 
 static inline u32 mcasp_get_reg(void __iomem *reg)
 {
-	return (unsigned int)__raw_readl(reg);
+	u32 v = __raw_readl(reg);
+	pr_debug("%s: %04x = %x\n", __func__, (reg-base), v);
+	return v;
 }
 
-static inline void mcasp_set_ctl_reg(void __iomem *regs, u32 val)
+static inline void mcasp_set_ctl_reg2(void __iomem *regs, u32 val)
 {
 	int i = 0;
 
-	mcasp_set_bits(regs, val);
+	mcasp_set_bits2(regs, val);
 
 	/* programming GBLCTL needs to read back from GBLCTL and verfiy */
 	/* loop count is to avoid the lock-up */
@@ -333,19 +374,94 @@ static inline void mcasp_set_ctl_reg(void __iomem *regs, u32 val)
 		printk(KERN_ERR "GBLCTL write error\n");
 }
 
-static void mcasp_start_rx(struct davinci_audio_dev *dev)
+
+static ssize_t mcasp_sysfs_report(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
 {
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXHCLKRST);
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXCLKRST);
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXSERCLR);
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_RXBUF_REG, 0);
+	char const * cmd;
+
+	struct davinci_audio_dev *adev;
+	adev = dev_get_drvdata(dev);
 
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXSMRST);
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXFSRST);
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_RXBUF_REG, 0);
+	cmd = "reg rxstat";
+	if (count >= strlen(cmd) && strcmp(buf, cmd) == 0) {
+		pr_info("%s: %s is %x\n",
+		 __func__,
+		 stringify(DAVINCI_MCASP_RXSTAT_REG),
+		 mcasp_get_reg(adev->base + DAVINCI_MCASP_RXSTAT_REG));
+	}
+	cmd = "reg txstat";
+	if (count >= strlen(cmd) && strcmp(buf, cmd) == 0) {
+		pr_info("%s: %s is %x\n",
+		 __func__,
+		 stringify(DAVINCI_MCASP_TXSTAT_REG),
+		 mcasp_get_reg(adev->base + DAVINCI_MCASP_TXSTAT_REG));
+	}
 
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXSMRST);
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, RXFSRST);
+	return count;
+}
+
+static DEVICE_ATTR(read, S_IWUSR, NULL, mcasp_sysfs_report);
+
+static struct attribute *mcasp_drv_attributes[] = {
+	&dev_attr_read.attr,
+	NULL
+};
+
+static const struct attribute_group mcasp_drv_attr_group = {
+	.attrs = mcasp_drv_attributes,
+};
+
+/* Transmit/Receive Section Initialization
+ *
+ * Done according to "Transmit/Receive Section Initialization"
+ * and "Register Bit Restrictions" in SPRUH77A.
+ *
+ */
+
+static void mcasp_start_tx(struct davinci_audio_dev *dev);
+
+static void mcasp_start_rx(struct davinci_audio_dev *dev)
+{
+	pr_debug("%s: starting rx\n", __func__);
+	
+	if (!playing) {
+		pr_debug("%s: also starting tx\n", __func__);
+		mcasp_start_tx(dev);
+	}
+
+	// 1)
+	mcasp_set_reg(dev->base, DAVINCI_MCASP_GBLCTLR_REG, 0);
+	
+	// 2b)
+	if (dev->rxnumevt)	/* enable FIFO */
+		mcasp_set_bits(dev->base, DAVINCI_MCASP_RFIFOCTL,
+							FIFO_ENABLE);
+	
+	// 4)
+	mcasp_set_ctl_reg(dev->base, DAVINCI_MCASP_GBLCTLR_REG, RXHCLKRST);
+
+	// 5)
+	mcasp_set_ctl_reg(dev->base, DAVINCI_MCASP_GBLCTLR_REG, RXCLKRST);
+
+	// 7)
+	mcasp_set_reg(dev->base, DAVINCI_MCASP_RXSTAT_REG, 0xFFFF);
+	mcasp_set_ctl_reg(dev->base, DAVINCI_MCASP_GBLCTLR_REG, RXSERCLR);
+
+	// TODO understand
+	mcasp_set_reg(dev->base, DAVINCI_MCASP_RXBUF_REG, 0);
+
+	// 9)
+	mcasp_set_ctl_reg(dev->base, DAVINCI_MCASP_GBLCTLR_REG, RXSMRST);
+
+	// 10)
+	mcasp_set_ctl_reg(dev->base, DAVINCI_MCASP_GBLCTLR_REG, RXFSRST);
+
+	// TODO why a second time ?
+	mcasp_set_reg(dev->base, DAVINCI_MCASP_RXBUF_REG, 0);
+	mcasp_set_ctl_reg(dev->base, DAVINCI_MCASP_GBLCTLR_REG, RXSMRST);
+	mcasp_set_ctl_reg(dev->base, DAVINCI_MCASP_GBLCTLR_REG, RXFSRST);
 }
 
 static void mcasp_start_tx(struct davinci_audio_dev *dev)
@@ -353,14 +469,40 @@ static void mcasp_start_tx(struct davinci_audio_dev *dev)
 	u8 offset = 0, i;
 	u32 cnt;
 
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXHCLKRST);
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXCLKRST);
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXSERCLR);
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXBUF_REG, 0);
+	if (recording) {
+		pr_debug("%s: recording already in progress, not performing\n",
+		 __func__);
+		//return;
+	}
+	pr_debug("%s: starting tx\n", __func__);
+	
+	// 1)
+	mcasp_set_reg(dev->base, DAVINCI_MCASP_GBLCTLX_REG, 0);
+	
+	// 2a)
+	if (dev->txnumevt)	/* enable FIFO */
+		mcasp_set_bits(dev->base, DAVINCI_MCASP_WFIFOCTL,
+							FIFO_ENABLE);
+
+	// 4)
+	mcasp_set_ctl_reg(dev->base, DAVINCI_MCASP_GBLCTLX_REG, TXHCLKRST);
+
+	// 5)
+	mcasp_set_ctl_reg(dev->base, DAVINCI_MCASP_GBLCTLX_REG, TXCLKRST);
+
+	// 7)
+	mcasp_set_reg(dev->base, DAVINCI_MCASP_TXSTAT_REG, 0xFFFF);
+	mcasp_set_ctl_reg(dev->base, DAVINCI_MCASP_GBLCTLX_REG, TXSERCLR);
+
+	mcasp_set_reg(dev->base, DAVINCI_MCASP_TXBUF_REG, 0);
 
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXSMRST);
-	mcasp_set_ctl_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, TXFSRST);
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXBUF_REG, 0);
+	// 9)
+	mcasp_set_ctl_reg(dev->base, DAVINCI_MCASP_GBLCTLX_REG, TXSMRST);
+
+	// 10)
+	mcasp_set_ctl_reg(dev->base, DAVINCI_MCASP_GBLCTLX_REG, TXFSRST);
+
+	mcasp_set_reg(dev->base, DAVINCI_MCASP_TXBUF_REG, 0);
 	for (i = 0; i < dev->num_serializer; i++) {
 		if (dev->serial_dir[i] == TX_MODE) {
 			offset = i;
@@ -373,48 +515,59 @@ static void mcasp_start_tx(struct davinci_audio_dev *dev)
 	while (!(mcasp_get_reg(dev->base + DAVINCI_MCASP_XRSRCTL_REG(offset)) &
 		 TXSTATE) && (cnt < 100000))
 		cnt++;
+	
+	if (cnt == 100000) {
+		pr_err("%s: tx not ready!\n", __func__);
+	}
 
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXBUF_REG, 0);
+	mcasp_set_reg(dev->base, DAVINCI_MCASP_TXBUF_REG, 0);
 }
 
 static void davinci_mcasp_start(struct davinci_audio_dev *dev, int stream)
 {
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (dev->txnumevt)	/* enable FIFO */
-			mcasp_set_bits(dev->base + DAVINCI_MCASP_WFIFOCTL,
-								FIFO_ENABLE);
 		mcasp_start_tx(dev);
+		playing = 1;
 	} else {
-		if (dev->rxnumevt)	/* enable FIFO */
-			mcasp_set_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
-								FIFO_ENABLE);
 		mcasp_start_rx(dev);
+		recording = 1;
 	}
 }
 
 static void mcasp_stop_rx(struct davinci_audio_dev *dev)
 {
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_GBLCTLR_REG, 0);
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_RXSTAT_REG, 0xFFFFFFFF);
+	recording = 0;
+	pr_debug("%s\n", __func__);
+	if (dev->rxnumevt)	/* disable FIFO */
+		mcasp_clr_bits(dev->base, DAVINCI_MCASP_RFIFOCTL,
+							FIFO_ENABLE);
+	mcasp_set_reg(dev->base, DAVINCI_MCASP_GBLCTLR_REG, 0);
+	mcasp_set_reg(dev->base, DAVINCI_MCASP_RXSTAT_REG, 0xFFFF);
+	if (!playing) {
+		pr_debug("%s: not playing, shutting down tx too\n", __func__);
+		mcasp_set_reg(dev->base, DAVINCI_MCASP_GBLCTLX_REG, 0);
+	}
 }
 
 static void mcasp_stop_tx(struct davinci_audio_dev *dev)
 {
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_GBLCTLX_REG, 0);
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
+	playing = 0;
+	pr_debug("%s\n", __func__);
+	if (dev->txnumevt)	/* disable FIFO */
+		mcasp_clr_bits(dev->base, DAVINCI_MCASP_WFIFOCTL,
+							FIFO_ENABLE);
+	if (!recording) {
+		pr_debug("%s: not recording, shutting down\n", __func__);
+		mcasp_set_reg(dev->base, DAVINCI_MCASP_GBLCTLX_REG, 0);
+	}
+	mcasp_set_reg(dev->base, DAVINCI_MCASP_TXSTAT_REG, 0xFFFF);
 }
 
 static void davinci_mcasp_stop(struct davinci_audio_dev *dev, int stream)
 {
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (dev->txnumevt)	/* disable FIFO */
-			mcasp_clr_bits(dev->base + DAVINCI_MCASP_WFIFOCTL,
-								FIFO_ENABLE);
 		mcasp_stop_tx(dev);
 	} else {
-		if (dev->rxnumevt)	/* disable FIFO */
-			mcasp_clr_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
-								FIFO_ENABLE);
 		mcasp_stop_rx(dev);
 	}
 }
@@ -428,39 +581,54 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
 		/* codec is clock and frame slave */
-		mcasp_set_bits(base + DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
-		mcasp_set_bits(base + DAVINCI_MCASP_TXFMCTL_REG, AFSXE);
+		mcasp_set_bits(base, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
+		mcasp_set_bits(base, DAVINCI_MCASP_TXFMCTL_REG, AFSXE);
 
-		mcasp_set_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
-		mcasp_set_bits(base + DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
+		mcasp_set_bits(base, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
+		mcasp_set_bits(base, DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
 
-		mcasp_set_bits(base + DAVINCI_MCASP_PDIR_REG,
+		mcasp_set_bits(base, DAVINCI_MCASP_PDIR_REG,
 				ACLKX | AHCLKX | AFSX);
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
 		/* codec is clock master and frame slave */
-		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
-		mcasp_set_bits(base + DAVINCI_MCASP_TXFMCTL_REG, AFSXE);
+		mcasp_clr_bits(base, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
+		mcasp_set_bits(base, DAVINCI_MCASP_TXFMCTL_REG, AFSXE);
 
-		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
-		mcasp_set_bits(base + DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
+		mcasp_clr_bits(base, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
+		mcasp_set_bits(base, DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
 
-		mcasp_clr_bits(base + DAVINCI_MCASP_PDIR_REG,
+		mcasp_clr_bits(base, DAVINCI_MCASP_PDIR_REG,
 				ACLKX | ACLKR);
-		mcasp_set_bits(base + DAVINCI_MCASP_PDIR_REG,
+		mcasp_set_bits(base, DAVINCI_MCASP_PDIR_REG,
 				AFSX | AFSR);
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		/* codec is clock and frame master */
-		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
-		mcasp_clr_bits(base + DAVINCI_MCASP_TXFMCTL_REG, AFSXE);
+		mcasp_clr_bits(base, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
+		mcasp_clr_bits(base, DAVINCI_MCASP_TXFMCTL_REG, AFSXE);
 
-		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
-		mcasp_clr_bits(base + DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
+		mcasp_clr_bits(base, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
+		mcasp_clr_bits(base, DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
 
-		mcasp_clr_bits(base + DAVINCI_MCASP_PDIR_REG,
+		mcasp_clr_bits(base, DAVINCI_MCASP_PDIR_REG,
 				ACLKX | AHCLKX | AFSX | ACLKR | AHCLKR | AFSR);
 		break;
+	
+	case SND_SOC_DAIFMT_EM_CBS_CFS:
+		/* external master clock, cpu generates bit and frame clocks */
+		mcasp_clr_bits(base, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
+		mcasp_set_bits(base, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
+		mcasp_set_bits(base, DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
+		
+		mcasp_clr_bits(base, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
+		mcasp_set_bits(base, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXE);
+		mcasp_set_bits(base, DAVINCI_MCASP_TXFMCTL_REG, AFSXE);
+
+		mcasp_clr_bits(base, DAVINCI_MCASP_PDIR_REG, AHCLKX | AHCLKR);
+		mcasp_set_bits(base, DAVINCI_MCASP_PDIR_REG, ACLKX | ACLKR);
+		mcasp_set_bits(base, DAVINCI_MCASP_PDIR_REG, AFSX | AFSR);
+		break;
 
 	default:
 		return -EINVAL;
@@ -468,35 +636,35 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_IB_NF:
-		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
-		mcasp_clr_bits(base + DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
+		mcasp_clr_bits(base, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
+		mcasp_clr_bits(base, DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
 
-		mcasp_set_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
-		mcasp_clr_bits(base + DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
+		mcasp_set_bits(base, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
+		mcasp_clr_bits(base, DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
 		break;
 
 	case SND_SOC_DAIFMT_NB_IF:
-		mcasp_set_bits(base + DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
-		mcasp_set_bits(base + DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
+		mcasp_set_bits(base, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
+		mcasp_set_bits(base, DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
 
-		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
-		mcasp_set_bits(base + DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
+		mcasp_clr_bits(base, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
+		mcasp_set_bits(base, DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
 		break;
 
 	case SND_SOC_DAIFMT_IB_IF:
-		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
-		mcasp_set_bits(base + DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
+		mcasp_clr_bits(base, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
+		mcasp_set_bits(base, DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
 
-		mcasp_set_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
-		mcasp_set_bits(base + DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
+		mcasp_set_bits(base, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
+		mcasp_set_bits(base, DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
 		break;
 
 	case SND_SOC_DAIFMT_NB_NF:
-		mcasp_set_bits(base + DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
-		mcasp_clr_bits(base + DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
+		mcasp_set_bits(base, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXPOL);
+		mcasp_clr_bits(base, DAVINCI_MCASP_TXFMCTL_REG, FSXPOL);
 
-		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
-		mcasp_clr_bits(base + DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
+		mcasp_clr_bits(base, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRPOL);
+		mcasp_clr_bits(base, DAVINCI_MCASP_RXFMCTL_REG, FSRPOL);
 		break;
 
 	default:
@@ -559,16 +727,16 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
 		return -EINVAL;
 	}
 
-	mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG,
+	mcasp_mod_bits(dev->base, DAVINCI_MCASP_RXFMT_REG,
 					RXSSZ(fmt), RXSSZ(0x0F));
-	mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
+	mcasp_mod_bits(dev->base, DAVINCI_MCASP_TXFMT_REG,
 					TXSSZ(fmt), TXSSZ(0x0F));
-	mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG, TXROT(rotate),
+	mcasp_mod_bits(dev->base, DAVINCI_MCASP_TXFMT_REG, TXROT(rotate),
 							TXROT(7));
-	mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG, RXROT(rotate),
+	mcasp_mod_bits(dev->base, DAVINCI_MCASP_RXFMT_REG, RXROT(rotate),
 							RXROT(7));
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, mask);
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_RXMASK_REG, mask);
+	mcasp_set_reg(dev->base, DAVINCI_MCASP_TXMASK_REG, mask);
+	mcasp_set_reg(dev->base, DAVINCI_MCASP_RXMASK_REG, mask);
 
 	return 0;
 }
@@ -580,30 +748,30 @@ static void davinci_hw_common_param(struct davinci_audio_dev *dev, int stream)
 	u8 rx_ser = 0;
 
 	/* Default configuration */
-	mcasp_set_bits(dev->base + DAVINCI_MCASP_PWREMUMGT_REG, MCASP_SOFT);
+	mcasp_set_bits(dev->base, DAVINCI_MCASP_PWREMUMGT_REG, MCASP_SOFT);
 
 	/* All PINS as McASP */
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_PFUNC_REG, 0x00000000);
+	mcasp_set_reg(dev->base, DAVINCI_MCASP_PFUNC_REG, 0x00000000);
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		mcasp_set_reg(dev->base + DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
-		mcasp_clr_bits(dev->base + DAVINCI_MCASP_XEVTCTL_REG,
+		mcasp_set_reg(dev->base, DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
+		mcasp_clr_bits(dev->base, DAVINCI_MCASP_XEVTCTL_REG,
 				TXDATADMADIS);
 	} else {
-		mcasp_set_reg(dev->base + DAVINCI_MCASP_RXSTAT_REG, 0xFFFFFFFF);
-		mcasp_clr_bits(dev->base + DAVINCI_MCASP_REVTCTL_REG,
+		mcasp_set_reg(dev->base, DAVINCI_MCASP_RXSTAT_REG, 0xFFFFFFFF);
+		mcasp_clr_bits(dev->base, DAVINCI_MCASP_REVTCTL_REG,
 				RXDATADMADIS);
 	}
 
 	for (i = 0; i < dev->num_serializer; i++) {
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_XRSRCTL_REG(i),
+		mcasp_set_bits(dev->base, DAVINCI_MCASP_XRSRCTL_REG(i),
 					dev->serial_dir[i]);
 		if (dev->serial_dir[i] == TX_MODE) {
-			mcasp_set_bits(dev->base + DAVINCI_MCASP_PDIR_REG,
+			mcasp_set_bits(dev->base, DAVINCI_MCASP_PDIR_REG,
 					AXR(i));
 			tx_ser++;
 		} else if (dev->serial_dir[i] == RX_MODE) {
-			mcasp_clr_bits(dev->base + DAVINCI_MCASP_PDIR_REG,
+			mcasp_clr_bits(dev->base, DAVINCI_MCASP_PDIR_REG,
 					AXR(i));
 			rx_ser++;
 		}
@@ -613,9 +781,9 @@ static void davinci_hw_common_param(struct davinci_audio_dev *dev, int stream)
 		if (dev->txnumevt * tx_ser > 64)
 			dev->txnumevt = 1;
 
-		mcasp_mod_bits(dev->base + DAVINCI_MCASP_WFIFOCTL, tx_ser,
+		mcasp_mod_bits(dev->base, DAVINCI_MCASP_WFIFOCTL, tx_ser,
 								NUMDMA_MASK);
-		mcasp_mod_bits(dev->base + DAVINCI_MCASP_WFIFOCTL,
+		mcasp_mod_bits(dev->base, DAVINCI_MCASP_WFIFOCTL,
 				((dev->txnumevt * tx_ser) << 8), NUMEVT_MASK);
 	}
 
@@ -623,9 +791,9 @@ static void davinci_hw_common_param(struct davinci_audio_dev *dev, int stream)
 		if (dev->rxnumevt * rx_ser > 64)
 			dev->rxnumevt = 1;
 
-		mcasp_mod_bits(dev->base + DAVINCI_MCASP_RFIFOCTL, rx_ser,
+		mcasp_mod_bits(dev->base, DAVINCI_MCASP_RFIFOCTL, rx_ser,
 								NUMDMA_MASK);
-		mcasp_mod_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
+		mcasp_mod_bits(dev->base, DAVINCI_MCASP_RFIFOCTL,
 				((dev->rxnumevt * rx_ser) << 8), NUMEVT_MASK);
 	}
 }
@@ -639,40 +807,59 @@ static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
 	for (i = 0; i < active_slots; i++)
 		mask |= (1 << i);
 
-	mcasp_clr_bits(dev->base + DAVINCI_MCASP_ACLKXCTL_REG, TX_ASYNC);
+	/* Synchronous Transmit and Receive Operation */
+	mcasp_clr_bits(dev->base, DAVINCI_MCASP_ACLKXCTL_REG, TX_ASYNC);
+
+	/* HACK: set clock divider, no support for frequencies != 32k
+	 *
+	 * We want 32kHz FCLK with 32bits (left, right) transferred for
+	 * every frame, so it makes a 1.024MHz BCLK (/8).
+	 */
+	mcasp_mod_bits(dev->base, DAVINCI_MCASP_ACLKXCTL_REG, ACLKXDIV(8-1),
+	 ACLKXDIV_MASK);
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		/* bit stream is MSB first  with no delay */
+		/* bit stream is MSB first with no delay */
 		/* DSP_B mode */
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_AHCLKXCTL_REG,
+		/* HACK: disable master transmit clock generation
+		mcasp_set_bits(dev->base, DAVINCI_MCASP_AHCLKXCTL_REG,
 				AHCLKXE);
-		mcasp_set_reg(dev->base + DAVINCI_MCASP_TXTDM_REG, mask);
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_TXFMT_REG, TXORD);
+		*/
+		mcasp_set_reg(dev->base, DAVINCI_MCASP_TXTDM_REG, mask);
+		mcasp_set_bits(dev->base, DAVINCI_MCASP_TXFMT_REG, TXORD);
 
-		if ((dev->tdm_slots >= 2) && (dev->tdm_slots <= 32))
-			mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMCTL_REG,
+		if ((dev->tdm_slots >= 2) && (dev->tdm_slots <= 32)) {
+			mcasp_mod_bits(dev->base, DAVINCI_MCASP_TXFMCTL_REG,
 					FSXMOD(dev->tdm_slots), FSXMOD(0x1FF));
-		else
+		}
+		else {
 			printk(KERN_ERR "playback tdm slot %d not supported\n",
 				dev->tdm_slots);
+		}
+
+		mcasp_clr_bits(dev->base, DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
 
-		mcasp_clr_bits(dev->base + DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
 	} else {
 		/* bit stream is MSB first with no delay */
 		/* DSP_B mode */
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_RXFMT_REG, RXORD);
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_AHCLKRCTL_REG,
+		/* HACK: disable master receive clock generation
+		mcasp_set_bits(dev->base, DAVINCI_MCASP_AHCLKRCTL_REG,
 				AHCLKRE);
-		mcasp_set_reg(dev->base + DAVINCI_MCASP_RXTDM_REG, mask);
+		*/
+		mcasp_set_reg(dev->base, DAVINCI_MCASP_RXTDM_REG, mask);
+		mcasp_set_bits(dev->base, DAVINCI_MCASP_RXFMT_REG, RXORD);
 
-		if ((dev->tdm_slots >= 2) && (dev->tdm_slots <= 32))
-			mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMCTL_REG,
+		if ((dev->tdm_slots >= 2) && (dev->tdm_slots <= 32)) {
+			mcasp_mod_bits(dev->base, DAVINCI_MCASP_RXFMCTL_REG,
 					FSRMOD(dev->tdm_slots), FSRMOD(0x1FF));
-		else
+		}
+		else {
 			printk(KERN_ERR "capture tdm slot %d not supported\n",
 				dev->tdm_slots);
+		}
+
+		mcasp_clr_bits(dev->base, DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
 
-		mcasp_clr_bits(dev->base + DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
 	}
 }
 
@@ -680,34 +867,34 @@ static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
 static void davinci_hw_dit_param(struct davinci_audio_dev *dev)
 {
 	/* Set the PDIR for Serialiser as output */
-	mcasp_set_bits(dev->base + DAVINCI_MCASP_PDIR_REG, AFSX);
+	mcasp_set_bits(dev->base, DAVINCI_MCASP_PDIR_REG, AFSX);
 
 	/* TXMASK for 24 bits */
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, 0x00FFFFFF);
+	mcasp_set_reg(dev->base, DAVINCI_MCASP_TXMASK_REG, 0x00FFFFFF);
 
 	/* Set the TX format : 24 bit right rotation, 32 bit slot, Pad 0
 	   and LSB first */
-	mcasp_set_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
+	mcasp_set_bits(dev->base, DAVINCI_MCASP_TXFMT_REG,
 						TXROT(6) | TXSSZ(15));
 
 	/* Set TX frame synch : DIT Mode, 1 bit width, internal, rising edge */
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXFMCTL_REG,
+	mcasp_set_reg(dev->base, DAVINCI_MCASP_TXFMCTL_REG,
 						AFSXE | FSXMOD(0x180));
 
 	/* Set the TX tdm : for all the slots */
-	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXTDM_REG, 0xFFFFFFFF);
+	mcasp_set_reg(dev->base, DAVINCI_MCASP_TXTDM_REG, 0xFFFFFFFF);
 
 	/* Set the TX clock controls : div = 1 and internal */
-	mcasp_set_bits(dev->base + DAVINCI_MCASP_ACLKXCTL_REG,
+	mcasp_set_bits(dev->base, DAVINCI_MCASP_ACLKXCTL_REG,
 						ACLKXE | TX_ASYNC);
 
-	mcasp_clr_bits(dev->base + DAVINCI_MCASP_XEVTCTL_REG, TXDATADMADIS);
+	mcasp_clr_bits(dev->base, DAVINCI_MCASP_XEVTCTL_REG, TXDATADMADIS);
 
 	/* Only 44100 and 48000 are valid, both have the same setting */
-	mcasp_set_bits(dev->base + DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXDIV(3));
+	mcasp_set_bits(dev->base, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXDIV(3));
 
 	/* Enable the DIT */
-	mcasp_set_bits(dev->base + DAVINCI_MCASP_TXDITCTL_REG, DITEN);
+	mcasp_set_bits(dev->base, DAVINCI_MCASP_TXDITCTL_REG, DITEN);
 }
 
 static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
@@ -719,8 +906,14 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 					&dev->dma_params[substream->stream];
 	int word_length;
 	u8 fifo_level;
+	
+	pr_debug("-> %s %p %s(%d)\n", __func__, substream,
+	 current->comm, current->pid);
 
 	davinci_hw_common_param(dev, substream->stream);
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE && !playing)
+		davinci_hw_common_param(dev, SNDRV_PCM_STREAM_PLAYBACK);
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		fifo_level = dev->txnumevt;
 	else
@@ -728,8 +921,11 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 
 	if (dev->op_mode == DAVINCI_MCASP_DIT_MODE)
 		davinci_hw_dit_param(dev);
-	else
+	else {
 		davinci_hw_param(dev, substream->stream);
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE && !playing)
+			davinci_hw_param(dev, SNDRV_PCM_STREAM_PLAYBACK);
+	}
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_U8:
@@ -763,6 +959,9 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	dma_params->fifo_level = fifo_level;
 	davinci_config_channel_size(dev, word_length);
 
+	pr_debug("<- %s %p %s(%d)\n", __func__, substream,
+	 current->comm, current->pid);
+
 	return 0;
 }
 
@@ -772,6 +971,9 @@ static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
 	struct davinci_audio_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
 	int ret = 0;
 
+	pr_debug("-> %s %p %d %s(%d)\n", __func__, substream, cmd,
+	 current->comm, current->pid);
+
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_START:
@@ -800,6 +1002,9 @@ static int davinci_mcasp_trigger(struct snd_pcm_substream *substream,
 	default:
 		ret = -EINVAL;
 	}
+	
+	pr_debug("<- %s %p %d %s(%d) %d\n", __func__, substream, cmd,
+	 current->comm, current->pid, ret);
 
 	return ret;
 }
@@ -808,8 +1013,15 @@ static int davinci_mcasp_startup(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct davinci_audio_dev *dev = snd_soc_dai_get_drvdata(dai);
+	
+	pr_debug("-> %s %p %s(%d)\n", __func__, substream,
+	 current->comm, current->pid);
 
 	snd_soc_dai_set_dma_data(dai, substream, dev->dma_params);
+	
+	pr_debug("<- %s %p %s(%d) %d\n", __func__, substream,
+	 current->comm, current->pid, 0);
+
 	return 0;
 }
 
@@ -899,6 +1111,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_release_clk;
 	}
+	base = dev->base;
 
 	dev->op_mode = pdata->op_mode;
 	dev->tdm_slots = pdata->tdm_slots;
@@ -943,6 +1156,8 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	dma_data->channel = res->start;
 	dev_set_drvdata(&pdev->dev, dev);
 	ret = snd_soc_register_dai(&pdev->dev, &davinci_mcasp_dai[pdata->op_mode]);
+	
+	ret = sysfs_create_group(&pdev->dev.kobj, &mcasp_drv_attr_group);
 
 	if (ret != 0)
 		goto err_release_clk;
@@ -958,6 +1173,8 @@ static int davinci_mcasp_remove(struct platform_device *pdev)
 {
 	struct davinci_audio_dev *dev = dev_get_drvdata(&pdev->dev);
 
+	sysfs_remove_group(&pdev->dev.kobj, &mcasp_drv_attr_group);
+
 	snd_soc_unregister_dai(&pdev->dev);
 	clk_disable(dev->clk);
 	clk_put(dev->clk);

--MP_/VlIaPWRz2HxnHRmr6p9_2sA
Content-Type: application/x-gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=no.gz

H4sICJ/8nk8AA25vAO1abW+rNhT+fn+FP6bTrQThqmRX3ZXSJHTRDU1l3JZtmhBLSIoWQmTcNnfa
j595SULABkyzu64yH6IA9nOec47tg8/x+Rcwd5/99cx3gpkbbZyIuJg8bcBM+1HtaV0FuJuV+62j
dy/OPlyeN28MlA+Fth5x5q7vLALyGcxW2F8vwbB/P74ZjB1z0Ldunf7Pg8lXOEATB46uAQlB+mBU
BURvCAOpCNQSB9qGmYcxrGoUvlp2US27pVp2Qa02OKikVjUKU63b4RgeawT+zjwmzugIbId1Aiiq
WYxE/SbuNpaxb6cTYaCCtSmlGhSBMd2GDyzySVDodV5cCx5fnI2L3SBirga7trTVLAyCcJ025vrl
AY7MO/Ma7QSnj62pgT4cqP/hk6j7GSiK8gkogDLqCssx7m4GOxnKVskuURhoW6iPDjhGdvFx2MYe
3aOcsaE97KP+0OwPx5YoIxtaO/93/LMYbe49n3+JPOy7K2fu49/83wXZHc0VG1LY70uqwQx+M6wk
psSUmBKzGWYQzueMaGCMjSkFBS8+eQR4S0MeBoEb/Qlu7kwaFRyzb319HWink9DE2/VT4D0T8EMm
5gxcXoLe2V4ajUs10t5FGEenCeP2cRhHMozLMC4xJabEfN+Y7Ij7cBRxyWnC+AMrjJNDGCeNw3hV
qChmNZDt9K1fbgaM/myaRwAJ1eTJcHzf6Z2rGbHdIx413pYbDc0dsRhHoKdh7oM8tKdw2FiffDYk
UcewoDkdZuafB060CkmU6ZW9U7aqYZw1NXk53zK8g+/BX6i1v1DeX0jIX6jsL7vCX7a4v8r5ury/
ZuF64S+d2aO7XnsrJ/L/8qqGFjoQhbZl/dpZBCQjl97TT9scNQF0dIyOCujoxOhwijo4JC7x9gLi
R3or9JJlSuiwETpvdMXDmDkwBVBgGaVU/6hOkLJSqgT7yyWNFvv2ar5Hrqri4C1lFv+LqeFt6Z27
isJDA3LcgOQ7s94xVb6+mtCBb+93Sw277SNXPFvoX2d007+ajMrbQVVRlfgn3hDG/9V2vJCdVBks
5obTVbINp7Kjv6SvsbfMXv6UeyMst1IsxY0Fa1zBWmPBrF1rW87WCA4mkMNZSznrXM66AOerO0N0
6JTZmnwD6ynZBZfsor1naVTmyl2kclW+YLW5ZKaZDnhq71OM13RmVBgd1ygPRbtBgWne40/zxrxg
1TS/UBKjZ37plv1ykfml21Z4nexuJlvjy9aaWrZuugvQ5k/3lLaW0db5tPXGtF8/+CB/xqd89Yzv
gs930VY0d9KnohepaJUvWm0q+vSmegWZSjswcUsfPpWfMVRB1qdP/rCI3vP2n0qaUnOypNA4hZeH
S+ThEnm45H9yuKTmZElxNZAlKVmSkiUpiSkxJabElCUpWeKQJQ5Z4ngLJY7il3pdiSNpr+Z7FPOa
2JuFOLGfu8KeO/8G/DXY4HCJvSj6CNYhARsPL0Ic0DZvtsZx2gKGmmSeuqzEU1rBKKR6TlbBSAVr
XMFaY8Hfr4KRcta5nHUBzv96BSMly0wpphWM9p6trGCoFblMl5k+/I8qGJWZxtJqEqcC60usCqvE
Gm6cXFE1ueOlNCqnPu1SrHvsKx9FeMFyTGUvZs2gPk+r1OdpSxZXWOs3JUe2x3cc+1Uvncf2U7j2
i+HjYLCPFx9B9PiUWmYevqyLbQVX/8pezMWsfqQWktb/AJSi6i5rOQAA

--MP_/VlIaPWRz2HxnHRmr6p9_2sA
Content-Type: application/x-gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=yes.gz

H4sICJ78nk8AA3llcwDtWm1vqkgY/d5fMR91szaDGmFvuk2oSNdc0WbAXnY3G0IVLVkVA7T1bvbH
7/Aqwgxv2o25gQ+NwMw5Z54ZHp45tHMPlvq7uVuY2nahO3vNcXXbfduDRe8XhuUMCPT9Rv/eYiHb
vrnrlG8M4E2qreFqS93UVlv3C1hsbHO3BgL/PJ4Ox5o05OUnjf9tOPmKhspEQ6NH4FoguDC6CQBw
H+3FdJ3uFwAh2wcchBB07vOJ8IlLYEoTBTyVcZAqSkkYUY7Ver1jtYMF8KV268VETcdEJcbk5eyY
qKmYqDViomRiohJjoteOyZMwRqfhAP+Ga6W63BOwCMuHImhm+qHmPvSPM+lwaDw2vGooZBGPx/lS
gpO8hEgT+zSbVAZKzSxWX4BS4eHzkAgxYCHo+qPXq48bpeX6JPjopHPe64e212196xCzXtQWt1pY
2621CxpTZ/gbGklz6VGJiIPL8kxUSCOE/fRjUJZHnE+HEQc8QJhaHiVhFFVWeOWII4YHHYcYbHX0
rCSCragCr/CCxAtjuaoiFcnR8miZbQ9tabx37h3DNvWNtjTtP82/CJFkOFgYyeJ0oiLM+b8pDuee
qTz3WcnkBPKSTSCVF1qp0TWYDWaD2WB+CubWWi6zmN/EsTjDoODDdF+Be8DJzwZb3fkbTOcSfvVo
Ei9/PQ+01fJluofd29Z4d8FPIU0b3N0Brh2z4Zdfhi3vlZMuyRRV4+Xfp0NiVQ/BIHivQQI8eRQn
+P5I/CvC+LnFdZhQd3SJppxWLyiCFOn2cCr0FCXlOOIZEojbAi54J3KpWiZ3vMnK1B8urk2lmRDO
3nKrORvLdcJxh/fggRHFdtkZy9a+wvy421hYu5W51hav+m5nbDTH/MegSUVxFHyhSJXlP1q4iA3F
Bee4nEtIq4CunKIrKXTlwuhoprRsy9VdIybwLrG10DORyaCjUui01ectc+LCrYCCsigZUyR/N0Ha
f7i2uV7j5BW3Z5I9ElaL5h6wMu+XJ809ZO8RVT8+TPDaVeMiv2S3OBd6Cx7/1EZT/mFC2MwzkIHe
H7+Wxb+ZeroU1d/Dy8R9kh5V9zCSv8a3bWMd3vw1cacyby5tNyife1TiXmli0marrmZ5hIYTonGA
RfUCzSxVM1tB88NcrLp0smoleoDZQOyKKnZVf2bxrp/Kuwp4GToxU56ZGKYjnrfXw3jg9vaWdq/s
U5NiyuSf3GyCO5AyUNLI5XrdOGMxXIHrm2ocwF/M+L0uY/di3u11ebNXar9ezFr9Yf3SyxiiBW5o
Ohv82G4ouowbik7dUPTZbuhVGp7ne5pXoKrBbDAbzAbzHKMSnXiK9mWMSkQyKu2jUWl/rlF5BU4k
qu1EoqQTiWhO5IADbD+wItl+6QGjrBWJcqxIVN2KzJZxjRXZWJElrMh0KV9kRfrtmWSPpEFhJ61I
+5C9l2PQxIUeLNkNVbAiOboVWVoXyrMiB9A3hkLvqJv1jgahd9StS17E3Q25e3TuXtnIFlmSFWTT
LclAdi+UzdJls6VlU13JKoJprmSglw31ruh6V3WpqcZkQL0KqBk6NVOW+vKhOkNMbhyIuLn+ZiZF
eQZkcVKDpKRm7bVEGvPPaG/g3GyU+HobZaM4H6XhKybJ3F7EJ7k4eln7tvj7FCR9n8Li3MPpGSV+
+R+WTuMHqfHz4HeWC2xjYdneS/xn4Ly+BZFZWh+7dNuK38ZyexE/5BQ78al/kP4PeUX2J30tAAA=

--MP_/VlIaPWRz2HxnHRmr6p9_2sA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--MP_/VlIaPWRz2HxnHRmr6p9_2sA--
