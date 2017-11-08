From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 6/7] ASoC: wm8993: mark expected switch fall-throughs
Date: Wed, 8 Nov 2017 14:04:38 -0600
Message-ID: <dac05bce4243a762dc7e987c33c4e2c89c1dd170.1510170034.git.garsilva@embeddedor.com>
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

Addresses-Coverity-ID: 115168
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/codecs/wm8993.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 195f7bf..830ffd80 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1076,6 +1076,7 @@ static int wm8993_set_sysclk(struct snd_soc_dai *codec_dai,
 	switch (clk_id) {
 	case WM8993_SYSCLK_MCLK:
 		wm8993->mclk_rate = freq;
+		/* fall through */
 	case WM8993_SYSCLK_FLL:
 		wm8993->sysclk_source = clk_id;
 		break;
@@ -1123,6 +1124,7 @@ static int wm8993_set_dai_fmt(struct snd_soc_dai *dai,
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_B:
 		aif1 |= WM8993_AIF_LRCLK_INV;
+		/* fall through */
 	case SND_SOC_DAIFMT_DSP_A:
 		aif1 |= 0x18;
 		break;
-- 
2.7.4
