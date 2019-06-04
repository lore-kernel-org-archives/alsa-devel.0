From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: Make some symbols static" to the asoc tree
Date: Tue,  4 Jun 2019 15:59:00 +0100 (BST)
Message-ID: <20190604145900.5CA98440046@finisterre.sirena.org.uk>
References: <20190529150437.19004-1-yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190529150437.19004-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Hulk Robot <hulkci@huawei.com>, kaichieh.chuang@mediatek.com, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.orgMark Brown <broonie@kernel.org>, matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: Make some symbols static

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 52194513ba1388443a067cee9606d6fe27e7650e Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 29 May 2019 23:04:37 +0800
Subject: [PATCH] ASoC: mediatek: Make some symbols static

Fix sparse warnings:

sound/soc/mediatek/common/mtk-btcvsd.c:410:5: warning: symbol 'mtk_btcvsd_write_to_bt' was not declared. Should it be static?
sound/soc/mediatek/common/mtk-btcvsd.c:698:9: warning: symbol 'mtk_btcvsd_snd_read' was not declared. Should it be static?
sound/soc/mediatek/common/mtk-btcvsd.c:779:9: warning: symbol 'mtk_btcvsd_snd_write' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
