From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 05/11] ASoC: wm8960: Mark expected switch fall-through
Date: Wed, 1 Aug 2018 14:51:59 -0500
Message-ID: <b473ea056634ccb9316146590c7ed4d9efc14368.1533151956.git.gustavo@embeddedor.com>
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

Addresses-Coverity-ID: 115041 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/wm8960.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index c30f5aa..8dc1f3d 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -839,6 +839,7 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
 			iface |= 0x000c;
 			break;
 		}
+		/* fall through */
 	default:
 		dev_err(component->dev, "unsupported width %d\n",
 			params_width(params));
-- 
2.7.4
