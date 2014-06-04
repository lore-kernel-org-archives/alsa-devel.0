From: Qiao Zhou <zhouqiao@marvell.com>
Subject: [PATCH] ASoC: pcm: fix dpcm_path_put in dpcm runtime
	update
Date: Wed, 4 Jun 2014 19:42:06 +0800
Message-ID: <1401882126-26225-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 32269261A18
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 13:42:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org
Cc: Qiao Zhou <zhouqiao@marvell.com>
List-Id: alsa-devel@alsa-project.org

we need to release dapm widget list after dpcm_path_get in
soc_dpcm_runtime_update. otherwise, there will be potential memory
leak. add dpcm_path_put to fix it.

Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
---
 sound/soc/soc-pcm.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index a391de0..3bb8b80 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2072,6 +2072,7 @@ int soc_dpcm_runtime_update(struct snd_soc_card *card)
 			dpcm_be_disconnect(fe, SNDRV_PCM_STREAM_PLAYBACK);
 		}
 
+		dpcm_path_put(&list);
 capture:
 		/* skip if FE doesn't have capture capability */
 		if (!fe->cpu_dai->driver->capture.channels_min)
-- 
1.7.9.5
