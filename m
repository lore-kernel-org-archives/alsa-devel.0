From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 2/7] ASoC: tlv320aic23: mark expected switch fall-through
Date: Wed, 8 Nov 2017 14:04:12 -0600
Message-ID: <c72fc08548576887271e2f8b6a9e424cca4f271e.1510170034.git.garsilva@embeddedor.com>
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

Addresses-Coverity-ID: 146566
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/codecs/tlv320aic23.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 3d42138..7490921 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -454,6 +454,7 @@ static int tlv320aic23_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
 		iface_reg |= TLV320AIC23_LRP_ON;
+		/* fall through */
 	case SND_SOC_DAIFMT_DSP_B:
 		iface_reg |= TLV320AIC23_FOR_DSP;
 		break;
-- 
2.7.4
