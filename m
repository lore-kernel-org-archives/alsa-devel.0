From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 13/18] ASoC: pcm: Use
	snd_pcm_hw_constraint_single()
Date: Sun, 18 Oct 2015 15:39:28 +0200
Message-ID: <1445175573-11784-14-git-send-email-lars@metafoo.de>
References: <1445175573-11784-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-200.synserver.de (smtp-out-225.synserver.de
 [212.40.185.225])
 by alsa0.perex.cz (Postfix) with ESMTP id 532C62650F7
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 15:40:03 +0200 (CEST)
In-Reply-To: <1445175573-11784-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Yang A Fang <yang.a.fang@intel.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Use the new snd_pcm_hw_constraint_single() helper function instead of
calling snd_pcm_hw_constraint_minmax() with the same value for min and max
to install a constraint that limits the possible configuration values to a
single value. Using snd_pcm_hw_constraint_single() makes the indented
result clearer and is slightly shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-pcm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 3173958..c86dc96 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -200,9 +200,9 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream,
 		dev_dbg(soc_dai->dev, "ASoC: Symmetry forces %dHz rate\n",
 				soc_dai->rate);
 
-		ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+		ret = snd_pcm_hw_constraint_single(substream->runtime,
 						SNDRV_PCM_HW_PARAM_RATE,
-						soc_dai->rate, soc_dai->rate);
+						soc_dai->rate);
 		if (ret < 0) {
 			dev_err(soc_dai->dev,
 				"ASoC: Unable to apply rate constraint: %d\n",
@@ -216,9 +216,8 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream,
 		dev_dbg(soc_dai->dev, "ASoC: Symmetry forces %d channel(s)\n",
 				soc_dai->channels);
 
-		ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+		ret = snd_pcm_hw_constraint_single(substream->runtime,
 						SNDRV_PCM_HW_PARAM_CHANNELS,
-						soc_dai->channels,
 						soc_dai->channels);
 		if (ret < 0) {
 			dev_err(soc_dai->dev,
@@ -233,9 +232,8 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream,
 		dev_dbg(soc_dai->dev, "ASoC: Symmetry forces %d sample bits\n",
 				soc_dai->sample_bits);
 
-		ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+		ret = snd_pcm_hw_constraint_single(substream->runtime,
 						SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
-						soc_dai->sample_bits,
 						soc_dai->sample_bits);
 		if (ret < 0) {
 			dev_err(soc_dai->dev,
-- 
2.1.4
