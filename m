From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH] ASoC: pxa-ssp: Don't use SSCR0_SerClkDiv and
	SSCR0_SCR
Date: Fri, 17 Apr 2009 11:39:38 +0200
Message-ID: <1239961178-19122-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 20A941037F1
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Apr 2009 11:39:18 +0200 (CEST)
Received: by fxm18 with SMTP id 18so886707fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2009 02:39:17 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Those macros are just screwed as soon as CONFIG_PXA25x is enabled.

This patch
- changes ssp_set_scr to take an ssp_dev pointer instead of ssp_device
- adds a corresponding ssp_get_scr function.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

---

To me, using ssp_dev seems to be cleaner, as all the places where
ssp_set_scr is called, we already have an ssp_dev *ssp = priv->dev.ssp
set up, which allows us to call ssp_set_scr(ssp, ...) instead of
ssp_set_scr(&priv->dev, ...). Same for ssp_get_scr.
---
 sound/soc/pxa/pxa-ssp.c |   36 ++++++++++++++++++++++++++++--------
 1 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 308a657..d979c5c 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -280,12 +280,33 @@ static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
  * ssp_set_clkdiv - set SSP clock divider
  * @div: serial clock rate divider
  */
-static void ssp_set_scr(struct ssp_dev *dev, u32 div)
+static void ssp_set_scr(struct ssp_device *ssp, u32 div)
 {
-	struct ssp_device *ssp = dev->ssp;
-	u32 sscr0 = ssp_read_reg(dev->ssp, SSCR0) & ~SSCR0_SCR;
+	u32 sscr0 = ssp_read_reg(ssp, SSCR0);
+
+	if (cpu_is_pxa25x() && ssp->type == PXA25x_SSP) {
+		sscr0 &= ~0x0000ff00;
+		sscr0 |= ((div - 2)/2) << 8; /* 2..512 */
+	} else {
+		sscr0 &= ~0x000fff00;
+		sscr0 |= (div - 1) << 8;     /* 1..4096 */
+	}
+	ssp_write_reg(ssp, SSCR0, sscr0);
+}
+
+/**
+ * ssp_get_clkdiv - get SSP clock divider
+ */
+static u32 ssp_get_scr(struct ssp_device *ssp)
+{
+	u32 sscr0 = ssp_read_reg(ssp, SSCR0);
+	u32 div;
 
-	ssp_write_reg(ssp, SSCR0, (sscr0 | SSCR0_SerClkDiv(div)));
+	if (cpu_is_pxa25x() && ssp->type == PXA25x_SSP)
+		div = ((sscr0 >> 8) & 0xff) * 2 + 2;
+	else
+		div = ((sscr0 >> 8) & 0xfff) + 1;
+	return div;
 }
 
 /*
@@ -326,7 +347,7 @@ static int pxa_ssp_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 		break;
 	case PXA_SSP_CLK_AUDIO:
 		priv->sysclk = 0;
-		ssp_set_scr(&priv->dev, 1);
+		ssp_set_scr(ssp, 1);
 		sscr0 |= SSCR0_ACS;
 		break;
 	default:
@@ -387,7 +408,7 @@ static int pxa_ssp_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
 		ssp_write_reg(ssp, SSACD, val);
 		break;
 	case PXA_SSP_DIV_SCR:
-		ssp_set_scr(&priv->dev, div);
+		ssp_set_scr(ssp, div);
 		break;
 	default:
 		return -ENODEV;
@@ -674,8 +695,7 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 	case SND_SOC_DAIFMT_I2S:
 	       sspsp = ssp_read_reg(ssp, SSPSP);
 
-		if (((sscr0 & SSCR0_SCR) == SSCR0_SerClkDiv(4)) &&
-		     (width == 16)) {
+		if ((ssp_get_scr(ssp) == 4) && (width == 16)) {
 			/* This is a special case where the bitclk is 64fs
 			* and we're not dealing with 2*32 bits of audio
 			* samples.
-- 
1.6.2.3
