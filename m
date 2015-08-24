From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 4/5] ASoC: rt5645: Remove the incorrect setting
	of the JD mode
Date: Mon, 24 Aug 2015 20:32:58 +0800
Message-ID: <1440419579-9970-4-git-send-email-oder_chiou@realtek.com>
References: <1440419579-9970-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D3602606DD
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 14:33:10 +0200 (CEST)
In-Reply-To: <1440419579-9970-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, john.lin@realtek.com, woojoo.lee@samsung.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch removes the incorrect setting of the JD mode. It will cause pop
sound in the booting time.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 2c1b56b..53d5894 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3375,8 +3375,6 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL3,
 				   RT5645_IRQ_CLK_GATE_CTRL,
 				   RT5645_IRQ_CLK_GATE_CTRL);
-		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1,
-				   RT5645_CBJ_BST1_EN, RT5645_CBJ_BST1_EN);
 		regmap_update_bits(rt5645->regmap, RT5645_MICBIAS,
 				   RT5645_IRQ_CLK_INT, RT5645_IRQ_CLK_INT);
 		regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
-- 
1.8.1.1.439.g50a6b54
