From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: btcvsd fix rx stream assign"
	to the asoc tree
Date: Tue, 12 Feb 2019 14:21:51 +0000 (GMT)
Message-ID: <20190212142151.BDAAA1128114@debutante.sirena.org.uk>
References: <1549955927-18364-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BFA18267568
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 15:21:54 +0100 (CET)
In-Reply-To: <1549955927-18364-1-git-send-email-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, linux-mediatek@lists.infradead.org, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: btcvsd fix rx stream assign

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From fc23af99e47612042964ace44121872158ae834d Mon Sep 17 00:00:00 2001
From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Date: Tue, 12 Feb 2019 15:18:47 +0800
Subject: [PATCH] ASoC: mediatek: btcvsd fix rx stream assign

fix tx/rx stream assign wrong direction

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/common/mtk-btcvsd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/common/mtk-btcvsd.c b/sound/soc/mediatek/common/mtk-btcvsd.c
index 4b613d57e2d4..1b8bcdaf02d1 100644
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
2.20.1
