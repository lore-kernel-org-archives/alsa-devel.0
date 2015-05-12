From: Zidan Wang <zidan.wang@freescale.com>
Subject: [alsa-devel][PATCH 2/4] ASoC: wm8960: add 32 bit word length support
Date: Tue, 12 May 2015 14:58:21 +0800
Message-ID: <a55117060a6a22b1c523f19d9f47bd65054259e9.1431413323.git.zidan.wang@freescale.com>
References: <c36ecb00aeb3115e208518c5e256f35f7b1308db.1431413323.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c36ecb00aeb3115e208518c5e256f35f7b1308db.1431413323.git.zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de
Cc: broonie@kernel.org, lgirdwood@gmail.com, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

According to referance manual, right justify mode can't
support 32 bit word length.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/codecs/wm8960.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index b072501..2559e31 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -655,6 +655,12 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
 	case 24:
 		iface |= 0x0008;
 		break;
+	case 32:
+		/* right justify mode does not support 32 word length */
+		if ((iface & 0x3) != 0) {
+			iface |= 0x000c;
+			break;
+		}
 	default:
 		dev_err(codec->dev, "unsupported width %d\n",
 			params_width(params));
@@ -1050,7 +1056,7 @@ static int wm8960_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 
 #define WM8960_FORMATS \
 	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
-	SNDRV_PCM_FMTBIT_S24_LE)
+	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 static const struct snd_soc_dai_ops wm8960_dai_ops = {
 	.hw_params = wm8960_hw_params,
-- 
1.9.1
