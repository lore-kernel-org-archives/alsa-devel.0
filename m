From: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Subject: [PATCH 6/8] ALSA: ASoC: DaVinci: davinci-i2s clean up
Date: Thu, 18 Dec 2008 12:36:44 -0700
Message-ID: <1229629006-4261-7-git-send-email-troy.kisky@boundarydevices.com>
References: <>
	<1229629006-4261-1-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-2-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-3-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-4-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-5-git-send-email-troy.kisky@boundarydevices.com>
	<1229629006-4261-6-git-send-email-troy.kisky@boundarydevices.com>
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1229629006-4261-6-git-send-email-troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Minor, just move a block of code to make next patch clearer.

Signed-off-by: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index c064348..c425c86 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -238,6 +238,21 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		return -EINVAL;
 	}
 
+	rcr = DAVINCI_MCBSP_RCR_RFRLEN1(1);
+	xcr = DAVINCI_MCBSP_XCR_XFIG | DAVINCI_MCBSP_XCR_XFRLEN1(1);
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_RIGHT_J:
+		break;
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_DSP_B:
+		rcr |= DAVINCI_MCBSP_RCR_RDATDLY(1);
+		xcr |= DAVINCI_MCBSP_XCR_XDATDLY(1);
+		break;
+	default:
+		printk(KERN_ERR "%s:bad format\n", __func__);
+		return -EINVAL;
+	}
+
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF:
 		/* CLKRP Receive clock polarity,
@@ -290,21 +305,6 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	default:
 		return -EINVAL;
 	}
-
-	rcr = DAVINCI_MCBSP_RCR_RFRLEN1(1);
-	xcr = DAVINCI_MCBSP_XCR_XFIG | DAVINCI_MCBSP_XCR_XFRLEN1(1);
-	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
-	case SND_SOC_DAIFMT_RIGHT_J:
-		break;
-	case SND_SOC_DAIFMT_I2S:
-	case SND_SOC_DAIFMT_DSP_B:
-		rcr |= DAVINCI_MCBSP_RCR_RDATDLY(1);
-		xcr |= DAVINCI_MCBSP_XCR_XDATDLY(1);
-		break;
-	default:
-		printk(KERN_ERR "%s:bad format\n", __func__);
-		return -EINVAL;
-	}
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG, srgr);
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, pcr);
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_RCR_REG, rcr);
-- 
1.5.4.3
