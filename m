From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/5] ALSA: ASoC: McASP: add support for clock
	dividers
Date: Thu,  4 Oct 2012 15:08:39 +0200
Message-ID: <1349356122-14794-3-git-send-email-zonque@gmail.com>
References: <1349356122-14794-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id EAE19261631
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2012 15:09:11 +0200 (CEST)
In-Reply-To: <1349356122-14794-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Matt Porter <mporter@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add support for the internal clock dividers of the McASP driver.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Hebbar, Gururaja <gururaja.hebbar@ti.com>
Cc: Matt Porter <mporter@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 98f440a..1252bad 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -199,6 +199,7 @@
 #define ACLKXE		BIT(5)
 #define TX_ASYNC	BIT(6)
 #define ACLKXPOL	BIT(7)
+#define ACLKXDIV_MASK	0x1f
 
 /*
  * DAVINCI_MCASP_ACLKRCTL_REG Receive Clock Control Register Bits
@@ -207,6 +208,7 @@
 #define ACLKRE		BIT(5)
 #define RX_ASYNC	BIT(6)
 #define ACLKRPOL	BIT(7)
+#define ACLKRDIV_MASK	0x1f
 
 /*
  * DAVINCI_MCASP_AHCLKXCTL_REG - High Frequency Transmit Clock Control
@@ -215,6 +217,7 @@
 #define AHCLKXDIV(val)	(val)
 #define AHCLKXPOL	BIT(14)
 #define AHCLKXE		BIT(15)
+#define AHCLKXDIV_MASK	0xfff
 
 /*
  * DAVINCI_MCASP_AHCLKRCTL_REG - High Frequency Receive Clock Control
@@ -223,6 +226,7 @@
 #define AHCLKRDIV(val)	(val)
 #define AHCLKRPOL	BIT(14)
 #define AHCLKRE		BIT(15)
+#define AHCLKRDIV_MASK	0xfff
 
 /*
  * DAVINCI_MCASP_XRSRCTL_BASE_REG -  Serializer Control Register Bits
@@ -554,6 +558,32 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	return 0;
 }
 
+static int davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
+{
+	struct davinci_audio_dev *dev = snd_soc_dai_get_drvdata(dai);
+
+	switch (div_id) {
+	case 0:		/* MCLK divider */
+		mcasp_mod_bits(dev->base + DAVINCI_MCASP_AHCLKXCTL_REG,
+			       AHCLKXDIV(div - 1), AHCLKXDIV_MASK);
+		mcasp_mod_bits(dev->base + DAVINCI_MCASP_AHCLKRCTL_REG,
+			       AHCLKRDIV(div - 1), AHCLKRDIV_MASK);
+		break;
+
+	case 1:		/* BCLK divider */
+		mcasp_mod_bits(dev->base + DAVINCI_MCASP_ACLKXCTL_REG,
+			       ACLKXDIV(div - 1), ACLKXDIV_MASK);
+		mcasp_mod_bits(dev->base + DAVINCI_MCASP_ACLKRCTL_REG,
+			       ACLKRDIV(div - 1), ACLKRDIV_MASK);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int davinci_config_channel_size(struct davinci_audio_dev *dev,
 				       int channel_size)
 {
@@ -880,7 +910,7 @@ static const struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
 	.trigger	= davinci_mcasp_trigger,
 	.hw_params	= davinci_mcasp_hw_params,
 	.set_fmt	= davinci_mcasp_set_dai_fmt,
-
+	.set_clkdiv	= davinci_mcasp_set_clkdiv,
 };
 
 #define DAVINCI_MCASP_PCM_FMTS (SNDRV_PCM_FMTBIT_S8 | \
-- 
1.7.11.4
