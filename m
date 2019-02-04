From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: btcvsd: fix spelling mistake
	"offest" -> "offset"" to the asoc tree
Date: Mon,  4 Feb 2019 16:17:05 +0000 (GMT)
Message-ID: <20190204161705.9E221440083@finisterre.ee.mobilebroadband>
References: <20190204153105.20214-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BB592674D5
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 17:17:10 +0100 (CET)
In-Reply-To: <20190204153105.20214-1-colin.king@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin Ian King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, KaiChieh Chuang <kaichieh.chuang@mediatek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: btcvsd: fix spelling mistake "offest" -> "offset"

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

>From 766cc4965a3a2a8a62e70e9d98e1d946a71368d5 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Mon, 4 Feb 2019 15:31:05 +0000
Subject: [PATCH] ASoC: mediatek: btcvsd: fix spelling mistake "offest" ->
 "offset"

There is a spelling mistake in a dev_warn message. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/common/mtk-btcvsd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/common/mtk-btcvsd.c b/sound/soc/mediatek/common/mtk-btcvsd.c
index 349a9120a0dd..e408c1b270ab 100644
--- a/sound/soc/mediatek/common/mtk-btcvsd.c
+++ b/sound/soc/mediatek/common/mtk-btcvsd.c
@@ -1309,7 +1309,7 @@ static int mtk_btcvsd_snd_probe(struct platform_device *pdev)
 					 offset,
 					 ARRAY_SIZE(offset));
 	if (ret) {
-		dev_warn(dev, "%s(), get offest fail, ret %d\n", __func__, ret);
+		dev_warn(dev, "%s(), get offset fail, ret %d\n", __func__, ret);
 		return ret;
 	}
 	btcvsd->infra_misc_offset = offset[0];
-- 
2.20.1
