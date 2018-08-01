From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 07/11] ASoC: wm8996: Mark expected switch fall-through
Date: Wed, 1 Aug 2018 14:53:19 -0500
Message-ID: <845b1d02cd1f37097d485988c60bc3958faec3e3.1533151956.git.gustavo@embeddedor.com>
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

Addresses-Coverity-ID: 146354 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/codecs/wm8996.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index d9d2060..78a4082 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -1858,6 +1858,7 @@ static int wm8996_set_sysclk(struct snd_soc_dai *dai,
 	case 24576000:
 		ratediv = WM8996_SYSCLK_DIV;
 		wm8996->sysclk /= 2;
+		/* fall through */
 	case 11289600:
 	case 12288000:
 		snd_soc_component_update_bits(component, WM8996_AIF_RATE,
-- 
2.7.4
