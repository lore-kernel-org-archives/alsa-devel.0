From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 3/7] ASoC: tlv320dac31xx: mark expected switch fall-through
Date: Wed, 8 Nov 2017 14:04:17 -0600
Message-ID: <a06a3f6e8dc2be1a56205c095f3146bfdf019d66.1510170034.git.garsilva@embeddedor.com>
References: <cover.1510170034.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1510170034.git.garsilva@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1195220
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 54a87a9..e286237 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -929,7 +929,7 @@ static int aic31xx_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	case SND_SOC_DAIFMT_I2S:
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-		dsp_a_val = 0x1;
+		dsp_a_val = 0x1; /* fall through */
 	case SND_SOC_DAIFMT_DSP_B:
 		/* NOTE: BCLKINV bit value 1 equas NB and 0 equals IB */
 		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-- 
2.7.4
