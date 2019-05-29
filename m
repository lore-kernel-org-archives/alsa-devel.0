From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: mediatek: Make some symbols static
Date: Wed, 29 May 2019 23:04:37 +0800
Message-ID: <20190529150437.19004-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com, kaichieh.chuang@mediatek.com
Cc: linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

Fix sparse warnings:

sound/soc/mediatek/common/mtk-btcvsd.c:410:5: warning: symbol 'mtk_btcvsd_write_to_bt' was not declared. Should it be static?
sound/soc/mediatek/common/mtk-btcvsd.c:698:9: warning: symbol 'mtk_btcvsd_snd_read' was not declared. Should it be static?
sound/soc/mediatek/common/mtk-btcvsd.c:779:9: warning: symbol 'mtk_btcvsd_snd_write' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/mediatek/common/mtk-btcvsd.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-btcvsd.c b/sound/soc/mediatek/common/mtk-btcvsd.c
index bd55c546e790..c7a81c4be068 100644
--- a/sound/soc/mediatek/common/mtk-btcvsd.c
+++ b/sound/soc/mediatek/common/mtk-btcvsd.c
@@ -407,11 +407,11 @@ static int mtk_btcvsd_read_from_bt(struct mtk_btcvsd_snd *bt,
 	return 0;
 }
 
-int mtk_btcvsd_write_to_bt(struct mtk_btcvsd_snd *bt,
-			   enum bt_sco_packet_len packet_type,
-			   unsigned int packet_length,
-			   unsigned int packet_num,
-			   unsigned int blk_size)
+static int mtk_btcvsd_write_to_bt(struct mtk_btcvsd_snd *bt,
+				  enum bt_sco_packet_len packet_type,
+				  unsigned int packet_length,
+				  unsigned int packet_num,
+				  unsigned int blk_size)
 {
 	unsigned int i;
 	unsigned long flags;
@@ -695,9 +695,9 @@ static int wait_for_bt_irq(struct mtk_btcvsd_snd *bt,
 	return 0;
 }
 
-ssize_t mtk_btcvsd_snd_read(struct mtk_btcvsd_snd *bt,
-			    char __user *buf,
-			    size_t count)
+static ssize_t mtk_btcvsd_snd_read(struct mtk_btcvsd_snd *bt,
+				   char __user *buf,
+				   size_t count)
 {
 	ssize_t read_size = 0, read_count = 0, cur_read_idx, cont;
 	unsigned int cur_buf_ofs = 0;
@@ -776,9 +776,9 @@ ssize_t mtk_btcvsd_snd_read(struct mtk_btcvsd_snd *bt,
 	return read_count;
 }
 
-ssize_t mtk_btcvsd_snd_write(struct mtk_btcvsd_snd *bt,
-			     char __user *buf,
-			     size_t count)
+static ssize_t mtk_btcvsd_snd_write(struct mtk_btcvsd_snd *bt,
+				    char __user *buf,
+				    size_t count)
 {
 	int written_size = count, avail = 0, cur_write_idx, write_size, cont;
 	unsigned int cur_buf_ofs = 0;
-- 
2.17.1
