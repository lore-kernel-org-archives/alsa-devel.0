From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 11/12] ASoC: dwc: constify snd_soc_dai_ops structure
Date: Thu, 13 Jul 2017 15:38:43 -0500
Message-ID: <b46ec58b34081fa70e5087d392e939f08488eb9c.1499974826.git.garsilva@embeddedor.com>
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
 sound/soc/dwc/dwc-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 9160676..eebe9d3 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -381,7 +381,7 @@ static int dw_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 	return ret;
 }
 
-static struct snd_soc_dai_ops dw_i2s_dai_ops = {
+static const struct snd_soc_dai_ops dw_i2s_dai_ops = {
 	.startup	= dw_i2s_startup,
 	.shutdown	= dw_i2s_shutdown,
 	.hw_params	= dw_i2s_hw_params,
-- 
2.5.0
