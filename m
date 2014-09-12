From: Qiao Zhou <zhouqiao@marvell.com>
Subject: [PATCH] ASoC: soc-compress: fix double unlock of fe
	card mutex
Date: Fri, 12 Sep 2014 09:41:31 +0800
Message-ID: <1410486091-15293-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 09D562656D2
 for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2014 03:41:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, dan.carpenter@oracle.com, alsa-devel@alsa-project.org
Cc: Qiao Zhou <zhouqiao@marvell.com>
List-Id: alsa-devel@alsa-project.org

Fix double unlock of fe card mutex introduced by patch 8f70e515a8bb
"ASoC: soc-pcm: fix dpcm_path_get error handling"

The first unlock is at line 106, and the unlock is at line 149. we
should remove the first unlock.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
---
 sound/soc/soc-compress.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 3092b58..cecfab3 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -102,13 +102,11 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 	fe->dpcm[stream].runtime = fe_substream->runtime;
 
 	ret = dpcm_path_get(fe, stream, &list);
-	if (ret < 0) {
-		mutex_unlock(&fe->card->mutex);
+	if (ret < 0)
 		goto fe_err;
-	} else if (ret == 0) {
+	else if (ret == 0)
 		dev_dbg(fe->dev, "ASoC: %s no valid %s route\n",
 			fe->dai_link->name, stream ? "capture" : "playback");
-	}
 
 	/* calculate valid and active FE <-> BE dpcms */
 	dpcm_process_paths(fe, stream, &list, 1);
-- 
1.7.0.4
