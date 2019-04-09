From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH] ASoC: tlv320aic32x4: Fix potential
	uninitialized variable
Date: Mon,  8 Apr 2019 21:41:59 -0700
Message-ID: <20190409044159.17202-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp89.iad3b.emailsrvr.com (smtp89.iad3b.emailsrvr.com
 [146.20.161.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 793DCF80C17
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 06:42:16 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: team@nwdigitalradio.com
List-Id: alsa-devel@alsa-project.org

Fix compiler warning about uninitialized variable reported by
Stephen Rothwell <sfr@canb.auug.org.au>.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index 9e4899eb1d8e..156c153c12ab 100644
--- a/sound/soc/codecs/tlv320aic32x4-clk.c
+++ b/sound/soc/codecs/tlv320aic32x4-clk.c
@@ -82,7 +82,7 @@ static int clk_aic32x4_pll_get_muldiv(struct clk_aic32x4 *pll,
 	int ret;
 
 	ret = regmap_read(pll->regmap, AIC32X4_PLLPR, &val);
-	if (ret)
+	if (ret < 0)
 		return ret;
 	settings->r = val & AIC32X4_PLL_R_MASK;
 	settings->p = (val & AIC32X4_PLL_P_MASK) >> AIC32X4_PLL_P_SHIFT;
-- 
2.19.1
