From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: mediatek: Fix an error checking code
Date: Mon,  7 Aug 2017 02:23:15 +0200
Message-ID: <20170807002315.3512-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr
 [80.12.242.123])
 by alsa0.perex.cz (Postfix) with ESMTP id C9F60266CC9
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 07:36:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, matthias.bgg@gmail.com
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Check the value returned by 'devm_clk_get()' instead of the clock
identifier which can never be an ERR code.

Fixes: d6f3710a56e1 ("ASoC: mediatek: add structure define and clock control for 2701")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
index b815ecc6bbf6..affa7fb25dd9 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
@@ -75,7 +75,7 @@ int mt2701_init_clock(struct mtk_base_afe *afe)
 
 	for (i = 0; i < MT2701_CLOCK_NUM; i++) {
 		afe_priv->clocks[i] = devm_clk_get(afe->dev, aud_clks[i]);
-		if (IS_ERR(aud_clks[i])) {
+		if (IS_ERR(afe_priv->clocks[i])) {
 			dev_warn(afe->dev, "%s devm_clk_get %s fail\n",
 				 __func__, aud_clks[i]);
 			return PTR_ERR(aud_clks[i]);
-- 
2.11.0
