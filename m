From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: davinci-mcasp: off-by-one in 'davinci_mcasp_hw_rule_format'
Date: Thu,  1 Sep 2016 09:38:09 +0200
Message-ID: <1472715489-21424-1-git-send-email-christophe.jaillet@wanadoo.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, peter.ujfalusi@ti.com, jsarha@ti.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: alsa-devel@alsa-project.org

When calling 'snd_pcm_format_width', SNDRV_PCM_FORMAT_LAST is a
valid value, so don't skip it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Un-tested
---
 sound/soc/davinci/davinci-mcasp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 05c2d33aa74d..3c5a9804d3f5 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1218,7 +1218,7 @@ static int davinci_mcasp_hw_rule_format(struct snd_pcm_hw_params *params,
 
 	snd_mask_none(&nfmt);
 
-	for (i = 0; i < SNDRV_PCM_FORMAT_LAST; i++) {
+	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
 		if (snd_mask_test(fmt, i)) {
 			uint sbits = snd_pcm_format_width(i);
 			int ppm;
-- 
2.7.4

