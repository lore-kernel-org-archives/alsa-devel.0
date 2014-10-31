From: <bardliao@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5645: Add combo jack support
Date: Fri, 31 Oct 2014 15:37:56 +0800
Message-ID: <1414741076-26685-2-git-send-email-bardliao@realtek.com>
References: <1414741076-26685-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 5626E2606A4
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 08:38:40 +0100 (CET)
In-Reply-To: <1414741076-26685-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

This patch adds combo jack support of rt5645.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 3131e91..0e9c77f 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2573,6 +2573,12 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 
 	}
 
+	regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1,
+			   RT5645_CBJ_BST1_EN, RT5645_CBJ_BST1_EN);
+	regmap_update_bits(rt5645->regmap, RT5645_JD_CTRL3,
+			   RT5645_JD_CBJ_EN | RT5645_JD_CBJ_POL,
+			   RT5645_JD_CBJ_EN | RT5645_JD_CBJ_POL);
+
 	if (rt5645->i2c->irq) {
 		ret = request_threaded_irq(rt5645->i2c->irq, NULL, rt5645_irq,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
-- 
1.8.1.1.439.g50a6b54
