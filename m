From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: pcm: Drop incorrect double/extra frees
Date: Sat, 22 Mar 2014 18:34:36 +0000
Message-ID: <1395513276-1305-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 210CB261718
 for <alsa-devel@alsa-project.org>; Sat, 22 Mar 2014 19:34:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The changes in "ASoC: pcm: free path list before exiting from error
conditions" actually introduced both double frees (in case where the
path list was allocated but empty) and frees of unallocated memory (in
cases where the error being handled was -ENOMEM.  Drop the commit for
now.

Fixes: e4ad1accb (ASoC: pcm: free path list before exiting from error conditions)
Reported-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/soc-pcm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 28522bd03b8e..47e1ce771e65 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1989,7 +1989,6 @@ int soc_dpcm_runtime_update(struct snd_soc_card *card)
 
 		paths = dpcm_path_get(fe, SNDRV_PCM_STREAM_PLAYBACK, &list);
 		if (paths < 0) {
-			dpcm_path_put(&list);
 			dev_warn(fe->dev, "ASoC: %s no valid %s path\n",
 					fe->dai_link->name,  "playback");
 			mutex_unlock(&card->mutex);
@@ -2019,7 +2018,6 @@ capture:
 
 		paths = dpcm_path_get(fe, SNDRV_PCM_STREAM_CAPTURE, &list);
 		if (paths < 0) {
-			dpcm_path_put(&list);
 			dev_warn(fe->dev, "ASoC: %s no valid %s path\n",
 					fe->dai_link->name,  "capture");
 			mutex_unlock(&card->mutex);
@@ -2084,7 +2082,6 @@ static int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
 	fe->dpcm[stream].runtime = fe_substream->runtime;
 
 	if (dpcm_path_get(fe, stream, &list) <= 0) {
-		dpcm_path_put(&list);
 		dev_dbg(fe->dev, "ASoC: %s no valid %s route\n",
 			fe->dai_link->name, stream ? "capture" : "playback");
 	}
-- 
1.9.1
