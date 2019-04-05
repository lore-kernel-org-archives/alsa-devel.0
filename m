From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH] ASoC: tlv320aic32x4: Fix spacing
Date: Fri,  5 Apr 2019 14:54:30 -0700
Message-ID: <20190405215430.27419-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp121.ord1d.emailsrvr.com (smtp121.ord1d.emailsrvr.com
 [184.106.54.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6916F80C1B
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2019 23:54:37 +0200 (CEST)
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

Fix some cosmetic spacing issues reported by Julia Lawall
<julia.lawall@lip6.fr>.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/tlv320aic32x4-clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4-clk.c b/sound/soc/codecs/tlv320aic32x4-clk.c
index 667ec2c03508..9e4899eb1d8e 100644
--- a/sound/soc/codecs/tlv320aic32x4-clk.c
+++ b/sound/soc/codecs/tlv320aic32x4-clk.c
@@ -165,8 +165,8 @@ static int clk_aic32x4_pll_calc_muldiv(struct clk_aic32x4_pll_muldiv *settings,
 	 * of the multiplier.	This is because we can't do floating point
 	 * math in the kernel.
 	 */
-	 multiplier = (u64) rate * settings->p * 10000;
-	 do_div(multiplier, parent_rate);
+	multiplier = (u64) rate * settings->p * 10000;
+	do_div(multiplier, parent_rate);
 
 	/*
 	 * J can't be over 64, so R can scale this.
-- 
2.19.1
