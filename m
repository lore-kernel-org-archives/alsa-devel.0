From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 10/11] ASoC: wm9081: Mark expected switch fall-through
Date: Wed, 1 Aug 2018 14:55:26 -0500
Message-ID: <f60c2b307101015543b66b271e1124e3d0df6d22.1533151956.git.gustavo@embeddedor.com>
References: <cover.1533151956.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1533151956.git.gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, patches@opensource.cirrus.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1357430 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/wm9081.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 5a0ea7b..399255d1 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -933,6 +933,7 @@ static int wm9081_set_dai_fmt(struct snd_soc_dai *dai,
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_B:
 		aif2 |= WM9081_AIF_LRCLK_INV;
+		/* fall through */
 	case SND_SOC_DAIFMT_DSP_A:
 		aif2 |= 0x3;
 		break;
-- 
2.7.4
