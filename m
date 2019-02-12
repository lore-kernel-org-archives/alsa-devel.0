From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: [PATCH] ASoC: mediatek: btcvsd fix rx stream assign
Date: Tue, 12 Feb 2019 15:18:47 +0800
Message-ID: <1549955927-18364-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BE38267418
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 08:18:56 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

fix tx/rx stream assign wrong direction

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
---
 sound/soc/mediatek/common/mtk-btcvsd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/common/mtk-btcvsd.c b/sound/soc/mediatek/common/mtk-btcvsd.c
index 4b613d5..1b8bcdaf 100644
--- a/sound/soc/mediatek/common/mtk-btcvsd.c
+++ b/sound/soc/mediatek/common/mtk-btcvsd.c
@@ -250,7 +250,7 @@ static int mtk_btcvsd_snd_rx_init(struct mtk_btcvsd_snd *bt)
 	bt->rx->buf_size = BTCVSD_RX_BUF_SIZE;
 	bt->rx->timeout = 0;
 	bt->rx->rw_cnt = 0;
-	bt->tx->stream = SNDRV_PCM_STREAM_CAPTURE;
+	bt->rx->stream = SNDRV_PCM_STREAM_CAPTURE;
 	return 0;
 }
 
-- 
1.9.1
