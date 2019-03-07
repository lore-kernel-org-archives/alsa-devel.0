From: Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH] ASoC: mediatek: mt8183: skip for i2s5 in
	mck_disable
Date: Thu,  7 Mar 2019 10:35:58 +0800
Message-ID: <20190307023558.5148-1-tzungbi@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vs1-xe4a.google.com (mail-vs1-xe4a.google.com
 [IPv6:2607:f8b0:4864:20::e4a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BE16AF806F7
 for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2019 03:36:14 +0100 (CET)
Received: by mail-vs1-xe4a.google.com with SMTP id s71so1612052vss.14
 for <alsa-devel@alsa-project.org>; Wed, 06 Mar 2019 18:36:14 -0800 (PST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: tzungbi@google.com, alsa-devel@alsa-project.org, dgreid@google.com, shunli.wang@mediatek.com, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

Skip for i2s5 in mck_disable which is also bypassed in mck_enable.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
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
2.21.0.352.gf09ad66450-goog
