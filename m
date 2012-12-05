From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2 2/3] ALSA: ASoC: McASP: calculate values for
	channel size
Date: Wed,  5 Dec 2012 18:20:37 +0100
Message-ID: <1354728038-5506-2-git-send-email-zonque@gmail.com>
References: <1354728038-5506-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 61065261694
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2012 18:20:49 +0100 (CET)
In-Reply-To: <1354728038-5506-1-git-send-email-zonque@gmail.com>
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
Cc: mporter@ti.com, broonie@opensource.wolfsonmicro.com, nsekhar@ti.com, vaibhav.bedia@ti.com, Daniel Mack <zonque@gmail.com>, gururaja.hebbar@ti.com
List-Id: alsa-devel@alsa-project.org

Change davinci_config_channel_size() to derive the values for XSSZ and
XROT in DAVINCI_MCASP_[RT]XFMT_REG from the configured word length
rather than hard-coding them in a switch/case block.

Also, by directly passing the word length to
davinci_config_channel_size(), we can get rid of the
DAVINCI_AUDIO_WORD_* enum.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/davinci/davinci-mcasp.c | 63 +++++++--------------------------------
 sound/soc/davinci/davinci-mcasp.h | 10 -------
 2 files changed, 10 insertions(+), 63 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 023a70d..d940e01 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -619,57 +619,14 @@ static int davinci_mcasp_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 }
 
 static int davinci_config_channel_size(struct davinci_audio_dev *dev,
-				       int channel_size)
+				       int word_length)
 {
-	u32 fmt = 0;
-	u32 mask, rotate;
-
-	switch (channel_size) {
-	case DAVINCI_AUDIO_WORD_8:
-		fmt = 0x03;
-		rotate = 6;
-		mask = 0x000000ff;
-		break;
-
-	case DAVINCI_AUDIO_WORD_12:
-		fmt = 0x05;
-		rotate = 5;
-		mask = 0x00000fff;
-		break;
-
-	case DAVINCI_AUDIO_WORD_16:
-		fmt = 0x07;
-		rotate = 4;
-		mask = 0x0000ffff;
-		break;
-
-	case DAVINCI_AUDIO_WORD_20:
-		fmt = 0x09;
-		rotate = 3;
-		mask = 0x000fffff;
-		break;
-
-	case DAVINCI_AUDIO_WORD_24:
-		fmt = 0x0B;
-		rotate = 2;
-		mask = 0x00ffffff;
-		break;
-
-	case DAVINCI_AUDIO_WORD_28:
-		fmt = 0x0D;
-		rotate = 1;
-		mask = 0x0fffffff;
-		break;
-
-	case DAVINCI_AUDIO_WORD_32:
-		fmt = 0x0F;
-		rotate = 0;
-		mask = 0xffffffff;
-		break;
+	u32 fmt;
+	u32 rotate = (32 - word_length) / 4;
+	u32 mask = (1ULL << word_length) - 1;
 
-	default:
-		return -EINVAL;
-	}
+	/* mapping of the XSSZ bit-field as described in the datasheet */
+	fmt = (word_length >> 1) - 1;
 
 	mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG,
 					RXSSZ(fmt), RXSSZ(0x0F));
@@ -856,19 +813,19 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_U8:
 	case SNDRV_PCM_FORMAT_S8:
 		dma_params->data_type = 1;
-		word_length = DAVINCI_AUDIO_WORD_8;
+		word_length = 8;
 		break;
 
 	case SNDRV_PCM_FORMAT_U16_LE:
 	case SNDRV_PCM_FORMAT_S16_LE:
 		dma_params->data_type = 2;
-		word_length = DAVINCI_AUDIO_WORD_16;
+		word_length = 16;
 		break;
 
 	case SNDRV_PCM_FORMAT_U24_3LE:
 	case SNDRV_PCM_FORMAT_S24_3LE:
 		dma_params->data_type = 3;
-		word_length = DAVINCI_AUDIO_WORD_24;
+		word_length = 24;
 		break;
 
 	case SNDRV_PCM_FORMAT_U24_LE:
@@ -876,7 +833,7 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_U32_LE:
 	case SNDRV_PCM_FORMAT_S32_LE:
 		dma_params->data_type = 4;
-		word_length = DAVINCI_AUDIO_WORD_32;
+		word_length = 32;
 		break;
 
 	default:
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index a42b5d9..d2449a8 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -27,16 +27,6 @@
 #define DAVINCI_MCASP_I2S_DAI	0
 #define DAVINCI_MCASP_DIT_DAI	1
 
-enum {
-	DAVINCI_AUDIO_WORD_8 = 0,
-	DAVINCI_AUDIO_WORD_12,
-	DAVINCI_AUDIO_WORD_16,
-	DAVINCI_AUDIO_WORD_20,
-	DAVINCI_AUDIO_WORD_24,
-	DAVINCI_AUDIO_WORD_32,
-	DAVINCI_AUDIO_WORD_28,  /* This is only valid for McASP */
-};
-
 struct davinci_audio_dev {
 	struct davinci_pcm_dma_params dma_params[2];
 	void __iomem *base;
-- 
1.7.11.7
