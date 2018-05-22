From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: [PATCH 1/2] ASoC: dpcm: fix BE dai not hw_free and
	shutdown
Date: Tue, 22 May 2018 17:13:27 +0800
Message-ID: <1526980408-1935-2-git-send-email-kaichieh.chuang@mediatek.com>
References: <1526980408-1935-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DF8D267651
 for <alsa-devel@alsa-project.org>; Tue, 22 May 2018 11:13:36 +0200 (CEST)
In-Reply-To: <1526980408-1935-1-git-send-email-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

In case, one BE is used by two FE1/FE2
FE1--->BE-->
FE2--->

When FE1/FE2 call dpcm_be_dai_hw_free() together
the BE users will be 2 (> 1), hence cannot be hw_free.
The be state will leave at, ex. SND_SOC_DPCM_STATE_STOP

Later FE1/FE2 call dpcm_be_dai_shutdown(),
will be skip due to wrong state.
Leaving the BE not being hw_free and shutdown.

This patch add a flag in snd_soc_dpcm to denote
the hw_free cannot be excute for this fe->be dpcm.
The BE dai will be hw_free later when calling
dpcm_be_dai_shutdown() if still in invalid state.

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
---
 include/sound/soc-dpcm.h |  2 ++
 sound/soc/soc-pcm.c      | 17 ++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index 8060590..52d9b5d 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -86,6 +86,8 @@ struct snd_soc_dpcm {
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_state;
 #endif
+
+	bool be_hw_free_deferred;
 };
 
 /*
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 87c9af2..481604a 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1866,8 +1866,16 @@ int dpcm_be_dai_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
 			continue;
 
 		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE) &&
-		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN))
-			continue;
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN)) {
+			if (dpcm->be_hw_free_deferred) {
+				soc_pcm_hw_free(be_substream);
+				be->dpcm[stream].state =
+					SND_SOC_DPCM_STATE_HW_FREE;
+				dpcm->be_hw_free_deferred = false;
+			} else {
+				continue;
+			}
+		}
 
 		dev_dbg(be->dev, "ASoC: close BE %s\n",
 			be->dai_link->name);
@@ -1924,8 +1932,10 @@ int dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
 				continue;
 
 		/* do not free hw if this BE is used by other FE */
-		if (be->dpcm[stream].users > 1)
+		if (be->dpcm[stream].users > 1) {
+			dpcm->be_hw_free_deferred = true;
 			continue;
+		}
 
 		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
@@ -1941,6 +1951,7 @@ int dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
 		soc_pcm_hw_free(be_substream);
 
 		be->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_FREE;
+		dpcm->be_hw_free_deferred = false;
 	}
 
 	return 0;
-- 
1.9.1
