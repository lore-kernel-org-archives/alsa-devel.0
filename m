From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 01/12] ASoC: cs42l42: constify snd_soc_dai_ops structure
Date: Thu, 13 Jul 2017 15:37:26 -0500
Message-ID: <3e8b7afdf834c3c33726128ba5f6dac6b5bcea9c.1499974826.git.garsilva@embeddedor.com>
References: <cover.1499974826.git.garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1499974826.git.garsilva@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

This structure is only stored in the ops field of a snd_soc_dai_driver
structure. That field is declared const, so snd_soc_dai_ops structures
that have this property can be declared as const also.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 sound/soc/codecs/cs42l42.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 55e4520..9e860df 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -911,7 +911,7 @@ static int cs42l42_digital_mute(struct snd_soc_dai *dai, int mute)
 			SNDRV_PCM_FMTBIT_S32_LE)
 
 
-static struct snd_soc_dai_ops cs42l42_ops = {
+static const struct snd_soc_dai_ops cs42l42_ops = {
 	.hw_params	= cs42l42_pcm_hw_params,
 	.set_fmt	= cs42l42_set_dai_fmt,
 	.set_sysclk	= cs42l42_set_sysclk,
-- 
2.5.0
