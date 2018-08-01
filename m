From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 01/11] ASoC: wm8961: Mark expected switch fall-through
Date: Wed, 1 Aug 2018 14:47:09 -0500
Message-ID: <37661a1d1e804ad57b02b8b01aafe45fed99864b.1533151956.git.gustavo@embeddedor.com>
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

Addresses-Coverity-ID: 1271173 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/wm8961.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm8961.c b/sound/soc/codecs/wm8961.c
index f70f563..68b4cad 100644
--- a/sound/soc/codecs/wm8961.c
+++ b/sound/soc/codecs/wm8961.c
@@ -653,6 +653,7 @@ static int wm8961_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	case SND_SOC_DAIFMT_DSP_B:
 		aif |= WM8961_LRP;
+		/* fall through */
 	case SND_SOC_DAIFMT_DSP_A:
 		aif |= 3;
 		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-- 
2.7.4
