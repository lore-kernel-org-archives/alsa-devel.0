From: Patrick Lai <plai@codeaurora.org>
Subject: [PATCH] ASoC: pcm: free path list before exiting from
	error conditions
Date: Sun,  2 Mar 2014 11:52:57 -0800
Message-ID: <1393789977-29091-1-git-send-email-plai@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.11.231])
 by alsa0.perex.cz (Postfix) with ESMTP id 63B2E265482
 for <alsa-devel@alsa-project.org>; Sun,  2 Mar 2014 20:53:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, liam.r.girdwood@linux.intel.com
Cc: alsa-devel@alsa-project.org, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

dpcm_path_get() allocates dynamic memory to hold path list.
Corresponding dpcm_path_put() must be called to free the memory.
dpcm_path_put() is not called under several error conditions.
This leads to memory leak.

Signed-off-by: Patrick Lai <plai@codeaurora.org>
---
 sound/soc/soc-pcm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 47e1ce7..28522bd 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1989,6 +1989,7 @@ int soc_dpcm_runtime_update(struct snd_soc_card *card)
 
 		paths = dpcm_path_get(fe, SNDRV_PCM_STREAM_PLAYBACK, &list);
 		if (paths < 0) {
+			dpcm_path_put(&list);
 			dev_warn(fe->dev, "ASoC: %s no valid %s path\n",
 					fe->dai_link->name,  "playback");
 			mutex_unlock(&card->mutex);
@@ -2018,6 +2019,7 @@ capture:
 
 		paths = dpcm_path_get(fe, SNDRV_PCM_STREAM_CAPTURE, &list);
 		if (paths < 0) {
+			dpcm_path_put(&list);
 			dev_warn(fe->dev, "ASoC: %s no valid %s path\n",
 					fe->dai_link->name,  "capture");
 			mutex_unlock(&card->mutex);
@@ -2082,6 +2084,7 @@ static int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
 	fe->dpcm[stream].runtime = fe_substream->runtime;
 
 	if (dpcm_path_get(fe, stream, &list) <= 0) {
+		dpcm_path_put(&list);
 		dev_dbg(fe->dev, "ASoC: %s no valid %s route\n",
 			fe->dai_link->name, stream ? "capture" : "playback");
 	}
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
hosted by The Linux Foundation
