From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 13/21] ASoC: Remove redundant rate constraint
	for WM8903
Date: Thu, 23 Apr 2009 20:55:47 +0100
Message-ID: <1240516555-22249-13-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090423195420.GA20863@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A9CAC1038AB
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 21:56:05 +0200 (CEST)
In-Reply-To: <20090423195420.GA20863@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This is now handled by symmetric_rates.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 0bab5c6..bec418a 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1289,14 +1289,8 @@ static int wm8903_startup(struct snd_pcm_substream *substream,
 	if (wm8903->master_substream) {
 		master_runtime = wm8903->master_substream->runtime;
 
-		dev_dbg(&i2c->dev, "Constraining to %d bits at %dHz\n",
-			master_runtime->sample_bits,
-			master_runtime->rate);
-
-		snd_pcm_hw_constraint_minmax(substream->runtime,
-					     SNDRV_PCM_HW_PARAM_RATE,
-					     master_runtime->rate,
-					     master_runtime->rate);
+		dev_dbg(&i2c->dev, "Constraining to %d bits\n",
+			master_runtime->sample_bits);
 
 		snd_pcm_hw_constraint_minmax(substream->runtime,
 					     SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
-- 
1.5.6.3
