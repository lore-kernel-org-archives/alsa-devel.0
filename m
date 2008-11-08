From: hugo.villeneuve@lyrtech.com
Subject: [PATCH] ARM DaVinci: Add Right-Justified mode and
	Codec clock master to davinci-i2s
Date: Sat,  8 Nov 2008 13:26:09 -0500
Message-ID: <1226168769-17776-1-git-send-email-hugo.villeneuve@lyrtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.hugovil.com (201-217-static-ppp.3menatwork.com
	[64.235.217.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 17850103815
	for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2008 19:26:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: davinci-linux-open-source@linux.davincidsp.com, Hugo Villeneuve <hugo.villeneuve@lyrtech.com>
List-Id: alsa-devel@alsa-project.org

From: Hugo Villeneuve <hugo.villeneuve@lyrtech.com>

ARM DaVinci: Add Right-Justified mode and Codec clock master to davinci-i2s

The TI DVEVM board uses the SND_SOC_DAIFMT_CBM_CFM & I2S formats, but the
Lyrtech SFFSDR board uses the SND_SOC_DAIFMT_CBM_CFS & RIGHT-JUSTIFIED formats.

Signed-off-by: Hugo Villeneuve <hugo.villeneuve@lyrtech.com>
---
 sound/soc/davinci/davinci-i2s.c |   40 ++++++++++++++++++++++++++++++++------
 1 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index abb5fed..d814ec8 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -59,6 +59,7 @@
 #define DAVINCI_MCBSP_PCR_CLKXP		(1 << 1)
 #define DAVINCI_MCBSP_PCR_FSRP		(1 << 2)
 #define DAVINCI_MCBSP_PCR_FSXP		(1 << 3)
+#define DAVINCI_MCBSP_PCR_SCLKME	(1 << 7)
 #define DAVINCI_MCBSP_PCR_CLKRM		(1 << 8)
 #define DAVINCI_MCBSP_PCR_CLKXM		(1 << 9)
 #define DAVINCI_MCBSP_PCR_FSRM		(1 << 10)
@@ -171,6 +172,16 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG,
 					DAVINCI_MCBSP_SRGR_FSGM);
 		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		/* McBSP CLKR pin is the input for the Sample Rate Generator.
+		 * McBSP FSR and FSX are driven by the Sample Rate Generator. */
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG,
+					DAVINCI_MCBSP_PCR_SCLKME |
+					DAVINCI_MCBSP_PCR_FSXM |
+					DAVINCI_MCBSP_PCR_FSRM);
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG,
+					DAVINCI_MCBSP_SRGR_FSGM);
+		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, 0);
 		break;
@@ -205,6 +216,28 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		return -EINVAL;
 	}
 
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_RIGHT_J:
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_RCR_REG,
+					DAVINCI_MCBSP_RCR_RFRLEN1(1) |
+					DAVINCI_MCBSP_RCR_RDATDLY(0));
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_XCR_REG,
+					DAVINCI_MCBSP_XCR_XFRLEN1(1) |
+					DAVINCI_MCBSP_XCR_XDATDLY(0) |
+					DAVINCI_MCBSP_XCR_XFIG);
+		break;
+	case SND_SOC_DAIFMT_I2S:
+	default:
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_RCR_REG,
+					DAVINCI_MCBSP_RCR_RFRLEN1(1) |
+					DAVINCI_MCBSP_RCR_RDATDLY(1));
+		davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_XCR_REG,
+					DAVINCI_MCBSP_XCR_XFRLEN1(1) |
+					DAVINCI_MCBSP_XCR_XDATDLY(1) |
+					DAVINCI_MCBSP_XCR_XFIG);
+		break;
+	}
+
 	return 0;
 }
 
@@ -223,13 +256,6 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 				DAVINCI_MCBSP_SPCR_RINTM(3) |
 				DAVINCI_MCBSP_SPCR_XINTM(3) |
 				DAVINCI_MCBSP_SPCR_FREE);
-	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_RCR_REG,
-				DAVINCI_MCBSP_RCR_RFRLEN1(1) |
-				DAVINCI_MCBSP_RCR_RDATDLY(1));
-	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_XCR_REG,
-				DAVINCI_MCBSP_XCR_XFRLEN1(1) |
-				DAVINCI_MCBSP_XCR_XDATDLY(1) |
-				DAVINCI_MCBSP_XCR_XFIG);
 
 	i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS);
 	w = davinci_mcbsp_read_reg(dev, DAVINCI_MCBSP_SRGR_REG);
