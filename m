From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] pxa2xx-ac97: Support PXA3xx AC97
Date: Mon, 14 Apr 2008 16:12:21 +0100
Message-ID: <1208185942-27637-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080414151128.GA23694@rakim.wolfsonmicro.main>
	<1208185942-27637-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EBBC42452B
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 17:12:23 +0200 (CEST)
In-Reply-To: <1208185942-27637-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: eric miao <eric.y.miao@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/arm/pxa2xx-ac97.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 8704e28..bf02e5f 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -112,6 +112,16 @@ static void pxa2xx_ac97_write(struct snd_ac97 *ac97, unsigned short reg, unsigne
 static void pxa2xx_ac97_reset(struct snd_ac97 *ac97)
 {
 	/* First, try cold reset */
+#ifdef CONFIG_PXA3xx
+	int timeout;
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
 
@@ -123,6 +133,14 @@ static void pxa2xx_ac97_reset(struct snd_ac97 *ac97)
 	clk_disable(ac97conf_clk);
 	GCR = GCR_COLD_RST;
 	udelay(50);
+#elif defined(CONFIG_PXA3xx)
+	timeout = 1000;
+	/* Can't use interrupts on PXA3xx */
+	GCR &= ~(GCR_PRIRDY_IEN|GCR_SECRDY_IEN);
+
+	GCR = GCR_WARM_RST | GCR_COLD_RST;
+	while (!(GSR & (GSR_PCR | GSR_SCR)) && timeout--)
+		mdelay(10);
 #else
 	GCR = GCR_COLD_RST;
 	GCR |= GCR_CDONE_IE|GCR_SDONE_IE;
@@ -143,6 +161,12 @@ static void pxa2xx_ac97_reset(struct snd_ac97 *ac97)
 		GCR |= GCR_WARM_RST;
 		pxa_gpio_mode(113 | GPIO_ALT_FN_2_OUT);
 		udelay(500);
+#elif defined(CONFIG_PXA3xx)
+		timeout = 100;
+		/* Can't use interrupts */
+		GCR |= GCR_WARM_RST;
+		while (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)) && timeout--)
+			mdelay(1);
 #else
 		GCR |= GCR_WARM_RST|GCR_PRIRDY_IEN|GCR_SECRDY_IEN;
 		wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
-- 
1.5.5
