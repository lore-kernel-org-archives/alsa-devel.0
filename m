From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ASoC: mediatek: btcvsd: fix spelling
	mistake "offest" -> "offset"
Date: Mon,  4 Feb 2019 15:31:05 +0000
Message-ID: <20190204153105.20214-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B9D0726746F
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 16:31:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, KaiChieh Chuang <kaichieh.chuang@mediatek.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_warn message. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
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
