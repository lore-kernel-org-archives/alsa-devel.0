From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH v2] ASoC: au1x: PSC-AC97 bugfixes
Date: Tue,  8 Sep 2009 19:45:17 +0200
Message-ID: <1252431917-870-1-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 07D36103825
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Sep 2009 19:45:28 +0200 (CEST)
Received: by fxm3 with SMTP id 3so2915431fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 08 Sep 2009 10:45:28 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch fixes the following bugs:

- only reprogram bitdepth if it has changed since last call to hw_params.
- add locking inside ac97_read/write functions:
  When reprogramming sample depth, the ac97 unit has to be disabled,
  which should not be done in the middle of codec register accesses.

- retry timed-out codec register accesses.

- wait for status bits to set/clear when starting/stopping various
  functional blocks; very important after reenabling AC97 unit else
  sound may be distorted (e.g. high-pitch noise in 1kHz sine wave).

- clear fifos before/after starting/stopping RX/TX.

- longer timeouts waiting for PSC/AC97 ready after cold reset
  with certain codecs this can take ridiculous amounts of time.

Run-tested on various Au1200 platforms with various codecs.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
The previous patch missed a git add for psc.h, sorry!

 sound/soc/au1x/psc-ac97.c |  129 +++++++++++++++++++++++++++++++++------------
 sound/soc/au1x/psc.h      |    1 +
 2 files changed, 97 insertions(+), 33 deletions(-)

diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index 479d7bd..a521aa9 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -1,8 +1,8 @@
 /*
  * Au12x0/Au1550 PSC ALSA ASoC audio support.
  *
- * (c) 2007-2008 MSC Vertriebsges.m.b.H.,
- *	Manuel Lauss <mano@roarinelk.homelinux.net>
+ * (c) 2007-2009 MSC Vertriebsges.m.b.H.,
+ *	Manuel Lauss <manuel.lauss@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/mutex.h>
 #include <linux/suspend.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -29,6 +30,9 @@
 
 #include "psc.h"
 
+/* how often to retry failed codec register reads/writes */
+#define AC97_RW_RETRIES	5
+
 #define AC97_DIR	\
 	(SND_SOC_DAIDIR_PLAYBACK | SND_SOC_DAIDIR_CAPTURE)
 
@@ -45,6 +49,9 @@
 #define AC97PCR_CLRFIFO(stype)	\
 	((stype) == PCM_TX ? PSC_AC97PCR_TC : PSC_AC97PCR_RC)
 
+#define AC97STAT_BUSY(stype)	\
+	((stype) == PCM_TX ? PSC_AC97STAT_TB : PSC_AC97STAT_RB)
+
 /* instance data. There can be only one, MacLeod!!!! */
 static struct au1xpsc_audio_data *au1xpsc_ac97_workdata;
 
@@ -54,24 +61,33 @@ static unsigned short au1xpsc_ac97_read(struct snd_ac97 *ac97,
 {
 	/* FIXME */
 	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
-	unsigned short data, tmo;
+	unsigned short data, retry, tmo;
 
-	au_writel(PSC_AC97CDC_RD | PSC_AC97CDC_INDX(reg), AC97_CDC(pscdata));
+	au_writel(PSC_AC97EVNT_CD, AC97_EVNT(pscdata));
 	au_sync();
 
-	tmo = 1000;
-	while ((!(au_readl(AC97_EVNT(pscdata)) & PSC_AC97EVNT_CD)) && --tmo)
-		udelay(2);
+	retry = AC97_RW_RETRIES;
+	do {
+		mutex_lock(&pscdata->lock);
+
+		au_writel(PSC_AC97CDC_RD | PSC_AC97CDC_INDX(reg),
+			  AC97_CDC(pscdata));
+		au_sync();
+
+		tmo = 2000;
+		while ((!(au_readl(AC97_EVNT(pscdata)) & PSC_AC97EVNT_CD))
+			&& --tmo)
+			udelay(2);
 
-	if (!tmo)
-		data = 0xffff;
-	else
 		data = au_readl(AC97_CDC(pscdata)) & 0xffff;
 
-	au_writel(PSC_AC97EVNT_CD, AC97_EVNT(pscdata));
-	au_sync();
+		au_writel(PSC_AC97EVNT_CD, AC97_EVNT(pscdata));
+		au_sync();
+
+		mutex_unlock(&pscdata->lock);
+	} while (--retry && !tmo);
 
-	return data;
+	return retry ? data : 0xffff;
 }
 
 /* AC97 controller writes to codec register */
@@ -80,16 +96,29 @@ static void au1xpsc_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 {
 	/* FIXME */
 	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
-	unsigned int tmo;
+	unsigned int tmo, retry;
 
-	au_writel(PSC_AC97CDC_INDX(reg) | (val & 0xffff), AC97_CDC(pscdata));
+	au_writel(PSC_AC97EVNT_CD, AC97_EVNT(pscdata));
 	au_sync();
-	tmo = 1000;
-	while ((!(au_readl(AC97_EVNT(pscdata)) & PSC_AC97EVNT_CD)) && --tmo)
+
+	retry = AC97_RW_RETRIES;
+	do {
+		mutex_lock(&pscdata->lock);
+
+		au_writel(PSC_AC97CDC_INDX(reg) | (val & 0xffff),
+			  AC97_CDC(pscdata));
 		au_sync();
 
-	au_writel(PSC_AC97EVNT_CD, AC97_EVNT(pscdata));
-	au_sync();
+		tmo = 2000;
+		while ((!(au_readl(AC97_EVNT(pscdata)) & PSC_AC97EVNT_CD))
+		       && --tmo)
+			udelay(2);
+
+		au_writel(PSC_AC97EVNT_CD, AC97_EVNT(pscdata));
+		au_sync();
+
+		mutex_unlock(&pscdata->lock);
+	} while (--retry && !tmo);
 }
 
 /* AC97 controller asserts a warm reset */
@@ -129,9 +158,9 @@ static void au1xpsc_ac97_cold_reset(struct snd_ac97 *ac97)
 	au_sync();
 
 	/* wait for PSC to indicate it's ready */
-	i = 100000;
+	i = 1000;
 	while (!((au_readl(AC97_STAT(pscdata)) & PSC_AC97STAT_SR)) && (--i))
-		au_sync();
+		msleep(1);
 
 	if (i == 0) {
 		printk(KERN_ERR "au1xpsc-ac97: PSC not ready!\n");
@@ -143,9 +172,9 @@ static void au1xpsc_ac97_cold_reset(struct snd_ac97 *ac97)
 	au_sync();
 
 	/* wait for AC97 core to become ready */
-	i = 100000;
+	i = 1000;
 	while (!((au_readl(AC97_STAT(pscdata)) & PSC_AC97STAT_DR)) && (--i))
-		au_sync();
+		msleep(1);
 	if (i == 0)
 		printk(KERN_ERR "au1xpsc-ac97: AC97 ctrl not ready\n");
 }
@@ -165,12 +194,12 @@ static int au1xpsc_ac97_hw_params(struct snd_pcm_substream *substream,
 {
 	/* FIXME */
 	struct au1xpsc_audio_data *pscdata = au1xpsc_ac97_workdata;
-	unsigned long r, stat;
+	unsigned long r, ro, stat;
 	int chans, stype = SUBSTREAM_TYPE(substream);
 
 	chans = params_channels(params);
 
-	r = au_readl(AC97_CFG(pscdata));
+	r = ro = au_readl(AC97_CFG(pscdata));
 	stat = au_readl(AC97_STAT(pscdata));
 
 	/* already active? */
@@ -180,9 +209,6 @@ static int au1xpsc_ac97_hw_params(struct snd_pcm_substream *substream,
 		    (pscdata->rate != params_rate(params)))
 			return -EINVAL;
 	} else {
-		/* disable AC97 device controller first */
-		au_writel(r & ~PSC_AC97CFG_DE_ENABLE, AC97_CFG(pscdata));
-		au_sync();
 
 		/* set sample bitdepth: REG[24:21]=(BITS-2)/2 */
 		r &= ~PSC_AC97CFG_LEN_MASK;
@@ -199,14 +225,40 @@ static int au1xpsc_ac97_hw_params(struct snd_pcm_substream *substream,
 			r |= PSC_AC97CFG_RXSLOT_ENA(4);
 		}
 
-		/* finally enable the AC97 controller again */
+		/* do we need to poke the hardware? */
+		if (!(r ^ ro))
+			goto out;
+
+		/* ac97 engine is about to be disabled */
+		mutex_lock(&pscdata->lock);
+
+		/* disable AC97 device controller first... */
+		au_writel(r & ~PSC_AC97CFG_DE_ENABLE, AC97_CFG(pscdata));
+		au_sync();
+
+		/* ...wait for it... */
+		while (au_readl(AC97_STAT(pscdata)) & PSC_AC97STAT_DR)
+			asm volatile ("nop");
+
+		/* ...write config... */
+		au_writel(r, AC97_CFG(pscdata));
+		au_sync();
+
+		/* ...enable the AC97 controller again... */
 		au_writel(r | PSC_AC97CFG_DE_ENABLE, AC97_CFG(pscdata));
 		au_sync();
 
+		/* ...and wait for ready bit */
+		while (!(au_readl(AC97_STAT(pscdata)) & PSC_AC97STAT_DR))
+			asm volatile ("nop");
+
+		mutex_unlock(&pscdata->lock);
+
 		pscdata->cfg = r;
 		pscdata->rate = params_rate(params);
 	}
 
+out:
 	return 0;
 }
 
@@ -222,6 +274,8 @@ static int au1xpsc_ac97_trigger(struct snd_pcm_substream *substream,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
+		au_writel(AC97PCR_CLRFIFO(stype), AC97_PCR(pscdata));
+		au_sync();
 		au_writel(AC97PCR_START(stype), AC97_PCR(pscdata));
 		au_sync();
 		break;
@@ -229,6 +283,13 @@ static int au1xpsc_ac97_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		au_writel(AC97PCR_STOP(stype), AC97_PCR(pscdata));
 		au_sync();
+
+		while (au_readl(AC97_STAT(pscdata)) & AC97STAT_BUSY(stype))
+			asm volatile ("nop");
+
+		au_writel(AC97PCR_CLRFIFO(stype), AC97_PCR(pscdata));
+		au_sync();
+
 		break;
 	default:
 		ret = -EINVAL;
@@ -251,6 +312,8 @@ static int au1xpsc_ac97_probe(struct platform_device *pdev,
 	if (!au1xpsc_ac97_workdata)
 		return -ENOMEM;
 
+	mutex_init(&au1xpsc_ac97_workdata->lock);
+
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
 		ret = -ENODEV;
@@ -269,9 +332,9 @@ static int au1xpsc_ac97_probe(struct platform_device *pdev,
 		goto out1;
 
 	/* configuration: max dma trigger threshold, enable ac97 */
-	 au1xpsc_ac97_workdata->cfg = PSC_AC97CFG_RT_FIFO8 |
-				      PSC_AC97CFG_TT_FIFO8 |
-				      PSC_AC97CFG_DE_ENABLE;
+	au1xpsc_ac97_workdata->cfg = PSC_AC97CFG_RT_FIFO8 |
+				     PSC_AC97CFG_TT_FIFO8 |
+				     PSC_AC97CFG_DE_ENABLE;
 
 	/* preserve PSC clock source set up by platform (dev.platform_data
 	 * is already occupied by soc layer)
@@ -386,4 +449,4 @@ module_exit(au1xpsc_ac97_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Au12x0/Au1550 PSC AC97 ALSA ASoC audio driver");
-MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
+MODULE_AUTHOR("Manuel Lauss <manuel.lauss@gmail.com>");
diff --git a/sound/soc/au1x/psc.h b/sound/soc/au1x/psc.h
index 8fdb1a0..3f474e8 100644
--- a/sound/soc/au1x/psc.h
+++ b/sound/soc/au1x/psc.h
@@ -29,6 +29,7 @@ struct au1xpsc_audio_data {
 
 	unsigned long pm[2];
 	struct resource *ioarea;
+	struct mutex lock;
 };
 
 #define PCM_TX	0
-- 
1.6.4.2
