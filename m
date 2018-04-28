From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: [PATCH] ASoC: mediatek: avoid using snd_soc_platform
Date: Sat, 28 Apr 2018 13:21:26 +0800
Message-ID: <1524892886-25343-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id C9AE02675C8
 for <alsa-devel@alsa-project.org>; Sat, 28 Apr 2018 07:21:36 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

avoid using snd_soc_platform, which is removed after 4.18

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
---
 .../soc/mediatek/common/mtk-afe-platform-driver.c  |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
index d046ea8..8966ee1 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
@@ -62,7 +62,7 @@ static int mtk_afe_pcm_new(struct snd_soc_pcm_runtime *rtd)
 
 	size = afe->mtk_afe_hardware->buffer_bytes_max;
 	return snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-						     rtd->platform->dev,
+						     afe->dev,
 						     size, size);
 }
 
-- 
1.7.9.5
