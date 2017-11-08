From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 7/7] ASoC: wm8994: mark expected switch fall-throughs
Date: Wed, 8 Nov 2017 14:04:43 -0600
Message-ID: <94d7abf866dbcc4052a36ca14e53f1ff8aa30e83.1510170034.git.garsilva@embeddedor.com>
References: <cover.1510170034.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1510170034.git.garsilva@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 402005
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/codecs/wm8994.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 3896523..f91b49e 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -860,6 +860,7 @@ static void vmid_reference(struct snd_soc_codec *codec)
 		switch (wm8994->vmid_mode) {
 		default:
 			WARN_ON(NULL == "Invalid VMID mode");
+			/* fall through */
 		case WM8994_VMID_NORMAL:
 			/* Startup bias, VMID ramp & buffer */
 			snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
@@ -2654,6 +2655,7 @@ static int wm8994_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	case SND_SOC_DAIFMT_DSP_B:
 		aif1 |= WM8994_AIF1_LRCLK_INV;
 		lrclk |= WM8958_AIF1_LRCLK_INV;
+		/* fall through */
 	case SND_SOC_DAIFMT_DSP_A:
 		aif1 |= 0x18;
 		break;
-- 
2.7.4
