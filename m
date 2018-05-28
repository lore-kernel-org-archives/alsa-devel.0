From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: [PATCH v2 1/2] ASoC: dpcm: fix BE dai not hw_free and
	shutdown
Date: Mon, 28 May 2018 10:18:18 +0800
Message-ID: <1527473899-23079-2-git-send-email-kaichieh.chuang@mediatek.com>
References: <1527473899-23079-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A0F7267255
 for <alsa-devel@alsa-project.org>; Mon, 28 May 2018 04:18:27 +0200 (CEST)
In-Reply-To: <1527473899-23079-1-git-send-email-kaichieh.chuang@mediatek.com>
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
       |
FE2----]
when FE1/FE2 call dpcm_be_dai_hw_free() together
the BE users will be 2 (> 1), hence cannot be hw_free
the be state will leave at, ex. SND_SOC_DPCM_STATE_STOP

later FE1/FE2 call dpcm_be_dai_shutdown(),
will be skip due to wrong state.
leaving the BE not being hw_free and shutdown.

The BE dai will be hw_free later when calling
dpcm_be_dai_shutdown() if still in invalid state.

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
---
 sound/soc/soc-pcm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 87c9af2..ffdbbd9 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1866,8 +1866,10 @@ int dpcm_be_dai_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
 			continue;
 
 		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE) &&
-		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN))
-			continue;
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN)) {
+			soc_pcm_hw_free(be_substream);
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_FREE;
+		}
 
 		dev_dbg(be->dev, "ASoC: close BE %s\n",
 			be->dai_link->name);
-- 
1.9.1
