From: Qiao Zhou <zhouqiao@marvell.com>
Subject: [PATCH] ASoC: soc-pcm: fix dpcm_path_get error handling
Date: Wed, 10 Sep 2014 15:57:32 +0800
Message-ID: <1410335852-29957-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by alsa0.perex.cz (Postfix) with ESMTP id C72B9261685
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 09:57:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, zhouqiao@marvell.com
List-Id: alsa-devel@alsa-project.org

dpcm_path_get may return -ENOMEM when allocating memory for list
fails. We should not keep processing path or start up dpcm dai in
this case.

Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
---
 sound/soc/soc-compress.c |    7 +++++--
 sound/soc/soc-pcm.c      |    7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 27c06ac..b969a13 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -101,10 +101,13 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 
 	fe->dpcm[stream].runtime = fe_substream->runtime;
 
-	if (dpcm_path_get(fe, stream, &list) <= 0) {
+	ret = dpcm_path_get(fe, stream, &list);
+	if (ret < 0) {
+		mutex_unlock(&fe->card->mutex);
+		goto fe_err;
+	} else if (ret == 0)
 		dev_dbg(fe->dev, "ASoC: %s no valid %s route\n",
 			fe->dai_link->name, stream ? "capture" : "playback");
-	}
 
 	/* calculate valid and active FE <-> BE dpcms */
 	dpcm_process_paths(fe, stream, &list, 1);
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 731fdb5..d341777 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2352,10 +2352,13 @@ static int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
 	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
 	fe->dpcm[stream].runtime = fe_substream->runtime;
 
-	if (dpcm_path_get(fe, stream, &list) <= 0) {
+	ret = dpcm_path_get(fe, stream, &list);
+	if (ret < 0) {
+		mutex_unlock(&fe->card->mutex);
+		return ret;
+	} else if (ret == 0)
 		dev_dbg(fe->dev, "ASoC: %s no valid %s route\n",
 			fe->dai_link->name, stream ? "capture" : "playback");
-	}
 
 	/* calculate valid and active FE <-> BE dpcms */
 	dpcm_process_paths(fe, stream, &list, 1);
-- 
1.7.0.4
