From: Jonathan Fether <jonf@mds.com>
Subject: [PATCH] ASoC: sun4i-i2s: Add 24-bit sample width
	support
Date: Wed, 29 Aug 2018 17:32:50 -0700
Message-ID: <20180830003250.14076-2-jonf@mds.com>
References: <20180830003250.14076-1-jonf@mds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E9F7267837
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2018 02:33:07 +0200 (CEST)
Received: by mail-pl1-f195.google.com with SMTP id j8-v6so3013132pll.12
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2018 17:33:06 -0700 (PDT)
In-Reply-To: <20180830003250.14076-1-jonf@mds.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Jonathan Fether <jonf@mds.com>
List-Id: alsa-devel@alsa-project.org

Add additional clock divider ratios for BCLK and MCLK, per the A20 datasheet.
Add support for 32-bit physical sample width.
Add support for 24-bit actual sample width.
Change third parameter of call to sun4i_i2s_set_clk_rate() from sun4i_i2s_hw_params() to use physical sample width, which is appropriate here.

Signed-off-by: Jonathan Fether <jonf@mds.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index a4aa931..ba1cfae 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -207,6 +207,8 @@ struct sun4i_i2s_clk_div {
 	{ .div = 8, .val = 3 },
 	{ .div = 12, .val = 4 },
 	{ .div = 16, .val = 5 },
+	{ .div = 32, .val = 6 },
+	{ .div = 64, .val = 7 },
 	/* TODO - extend divide ratio supported by newer SoCs */
 };
 
@@ -219,6 +221,9 @@ struct sun4i_i2s_clk_div {
 	{ .div = 12, .val = 5 },
 	{ .div = 16, .val = 6 },
 	{ .div = 24, .val = 7 },
+	{ .div = 32, .val = 8 },
+	{ .div = 48, .val = 9 },
+	{ .div = 64, .val = 10 },
 	/* TODO - extend divide ratio supported by newer SoCs */
 };
 
@@ -393,6 +398,9 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
+	case 32:
+		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
 	default:
 		dev_err(dai->dev, "Unsupported physical sample width: %d\n",
 			params_physical_width(params));
@@ -405,6 +413,10 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 		sr = 0;
 		wss = 0;
 		break;
+	case 24:
+		sr = 2;
+		wss = 3;
+		break;
 
 	default:
 		dev_err(dai->dev, "Unsupported sample width: %d\n",
@@ -418,7 +430,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 			   sr + i2s->variant->fmt_offset);
 
 	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
-				      params_width(params));
+				      params_physical_width(params));
 }
 
 static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
@@ -720,14 +732,14 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
 	},
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
 	},
 	.ops = &sun4i_i2s_dai_ops,
 	.symmetric_rates = 1,
-- 
1.9.1
