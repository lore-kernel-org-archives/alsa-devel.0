From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/5] soc - Support PXA3xx AC97
Date: Tue, 22 Apr 2008 14:14:35 +0100
Message-ID: <1208870079-5325-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0AC77245B3
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Apr 2008 15:14:41 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The PXA3xx does not support the use of interrupts during reset and access
to the GPIO status requires similar handling to that for PXA27x.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/pxa2xx-ac97.c |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 815c153..95ae509 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -55,7 +55,7 @@ static unsigned short pxa2xx_ac97_read(struct snd_ac97 *ac97,
 	mutex_lock(&car_mutex);
 
 	/* set up primary or secondary codec/modem space */
-#ifdef CONFIG_PXA27x
+#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
 	reg_addr = ac97->num ? &SAC_REG_BASE : &PAC_REG_BASE;
 #else
 	if (reg == AC97_GPIO_STATUS)
@@ -105,7 +105,7 @@ static void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 	mutex_lock(&car_mutex);
 
 	/* set up primary or secondary codec/modem space */
-#ifdef CONFIG_PXA27x
+#if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
 	reg_addr = ac97->num ? &SAC_REG_BASE : &PAC_REG_BASE;
 #else
 	if (reg == AC97_GPIO_STATUS)
@@ -128,6 +128,9 @@ static void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg,
 
 static void pxa2xx_ac97_warm_reset(struct snd_ac97 *ac97)
 {
+#ifdef CONFIG_PXA3xx
+	int timeout = 100;
+#endif
 	gsr_bits = 0;
 
 #ifdef CONFIG_PXA27x
@@ -138,6 +141,11 @@ static void pxa2xx_ac97_warm_reset(struct snd_ac97 *ac97)
 	GCR |= GCR_WARM_RST;
 	pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
 	udelay(500);
+#elif defined(CONFIG_PXA3xx)
+	/* Can't use interrupts */
+	GCR |= GCR_WARM_RST;
+	while (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)) && timeout--)
+		mdelay(1);
 #else
 	GCR |= GCR_WARM_RST | GCR_PRIRDY_IEN | GCR_SECRDY_IEN;
 	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
@@ -153,6 +161,16 @@ static void pxa2xx_ac97_warm_reset(struct snd_ac97 *ac97)
 
 static void pxa2xx_ac97_cold_reset(struct snd_ac97 *ac97)
 {
+#ifdef CONFIG_PXA3xx
+	int timeout = 1000;
+
+	/* Hold CLKBPB for 100us */
+	GCR = 0;
+	GCR = GCR_CLKBPB;
+	udelay(100);
+	GCR = 0;
+#endif
+
 	GCR &=  GCR_COLD_RST;  /* clear everything but nCRST */
 	GCR &= ~GCR_COLD_RST;  /* then assert nCRST */
 
@@ -164,6 +182,13 @@ static void pxa2xx_ac97_cold_reset(struct snd_ac97 *ac97)
 	pxa_set_cken(CKEN_AC97CONF, 0);
 	GCR = GCR_COLD_RST;
 	udelay(50);
+#elif defined(CONFIG_PXA3xx)
+	/* Can't use interrupts on PXA3xx */
+	GCR &= ~(GCR_PRIRDY_IEN|GCR_SECRDY_IEN);
+
+	GCR = GCR_WARM_RST | GCR_COLD_RST;
+	while (!(GSR & (GSR_PCR | GSR_SCR)) && timeout--)
+		mdelay(10);
 #else
 	GCR = GCR_COLD_RST;
 	GCR |= GCR_CDONE_IE|GCR_SDONE_IE;
-- 
1.5.5
