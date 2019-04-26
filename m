From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: mediatek: btcvsd fix irq mask" to the asoc tree
Date: Fri, 26 Apr 2019 11:03:12 +0100 (BST)
Message-ID: <20190426100313.0F38B441D3B@finisterre.ee.mobilebroadband>
References: <1556244583-18084-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1556244583-18084-1-git-send-email-kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, stephen.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, tina.tsai-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: btcvsd fix irq mask

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.1

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

>From 780f202f2bf48aaa09282efc4dd6c39a146cc1f3 Mon Sep 17 00:00:00 2001
From: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Fri, 26 Apr 2019 10:09:43 +0800
Subject: [PATCH] ASoC: mediatek: btcvsd fix irq mask

disable = 1
enable = 0
prevent AP wake up, when not AP BTSCO scenario

Signed-off-by: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 sound/soc/mediatek/common/mtk-btcvsd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-btcvsd.c b/sound/soc/mediatek/common/mtk-btcvsd.c
index 9a163d7064d1..bd55c546e790 100644
--- a/sound/soc/mediatek/common/mtk-btcvsd.c
+++ b/sound/soc/mediatek/common/mtk-btcvsd.c
@@ -193,13 +193,13 @@ static const u8 table_msbc_silence[SCO_PACKET_180] = {
 static void mtk_btcvsd_snd_irq_enable(struct mtk_btcvsd_snd *bt)
 {
 	regmap_update_bits(bt->infra, bt->infra_misc_offset,
-			   bt->conn_bt_cvsd_mask, bt->conn_bt_cvsd_mask);
+			   bt->conn_bt_cvsd_mask, 0);
 }
 
 static void mtk_btcvsd_snd_irq_disable(struct mtk_btcvsd_snd *bt)
 {
 	regmap_update_bits(bt->infra, bt->infra_misc_offset,
-			   bt->conn_bt_cvsd_mask, 0);
+			   bt->conn_bt_cvsd_mask, bt->conn_bt_cvsd_mask);
 }
 
 static void mtk_btcvsd_snd_set_state(struct mtk_btcvsd_snd *bt,
-- 
2.20.1
