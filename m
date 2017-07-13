From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 08/12] ASoC: max9867: constify snd_soc_dai_ops structure
Date: Thu, 13 Jul 2017 15:38:26 -0500
Message-ID: <d32f4b33d6f8fe1a88c40331c76e0886ae59d6ad.1499974826.git.garsilva@embeddedor.com>
References: <cover.1499974826.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1499974826.git.garsilva@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

This structure is only stored in the ops field of a snd_soc_dai_driver
structure. That field is declared const, so snd_soc_dai_ops structures
that have this property can be declared as const also.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/codecs/max9867.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 2a40a69..3e421e9 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -350,7 +350,7 @@ static int max9867_dai_set_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-static struct snd_soc_dai_ops max9867_dai_ops = {
+static const struct snd_soc_dai_ops max9867_dai_ops = {
 	.set_fmt = max9867_dai_set_fmt,
 	.set_sysclk	= max9867_set_dai_sysclk,
 	.prepare	= max9867_prepare,
-- 
2.5.0
