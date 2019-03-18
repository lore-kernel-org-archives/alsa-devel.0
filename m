From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: mt8183: skip for i2s5 in
	mck_disable" to the asoc tree
Date: Mon, 18 Mar 2019 14:51:09 +0000 (GMT)
Message-ID: <20190318145109.7E2861128874@debutante.sirena.org.uk>
References: <20190307023558.5148-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6AA5EF89727
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 15:51:16 +0100 (CET)
In-Reply-To: <20190307023558.5148-1-tzungbi@google.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Cc: alsa-devel@alsa-project.org, cychiang@google.com, tzungbi@google.com, broonie@kernel.org, shunli.wang@mediatek.com, dgreid@google.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: mt8183: skip for i2s5 in mck_disable

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

>From 9729e3b65a64dfe210972223624d8152ba502e98 Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Thu, 7 Mar 2019 10:35:58 +0800
Subject: [PATCH] ASoC: mediatek: mt8183: skip for i2s5 in mck_disable

Skip for i2s5 in mck_disable which is also bypassed in mck_enable.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8183/mt8183-afe-clk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-clk.c b/sound/soc/mediatek/mt8183/mt8183-afe-clk.c
index f523ad103acc..48e81c5d52fc 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-clk.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-clk.c
@@ -605,6 +605,10 @@ void mt8183_mck_disable(struct mtk_base_afe *afe, int mck_id)
 	int m_sel_id = mck_div[mck_id].m_sel_id;
 	int div_clk_id = mck_div[mck_id].div_clk_id;
 
+	/* i2s5 mck not support */
+	if (mck_id == MT8183_I2S5_MCK)
+		return;
+
 	clk_disable_unprepare(afe_priv->clk[div_clk_id]);
 	if (m_sel_id >= 0)
 		clk_disable_unprepare(afe_priv->clk[m_sel_id]);
-- 
2.20.1
