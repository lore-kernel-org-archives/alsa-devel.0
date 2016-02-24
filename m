From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH RESEND 2/2] ASoC: rt298: Don't enable IRQ in
	i2c_probe
Date: Wed, 24 Feb 2016 15:51:27 +0800
Message-ID: <1456300287-10660-2-git-send-email-bardliao@realtek.com>
References: <1456300287-10660-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 49D4C266865
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 08:54:52 +0100 (CET)
In-Reply-To: <1456300287-10660-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, john.lin@realtek.com, ramesh.babu@intel.com, Bard Liao <bardliao@realtek.com>, senthilnathanx.veppur@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The IRQ function should not be enabled before irq handler is registered.
In fact, it is done in rt298_probe. So remove it from rt298_i2c_probe.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt298.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index e67ef5f..f0e6c06 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1224,7 +1224,6 @@ static int rt298_i2c_probe(struct i2c_client *i2c,
 	regmap_write(rt298->regmap, RT298_MISC_CTRL1, 0x0000);
 	regmap_update_bits(rt298->regmap,
 				RT298_WIND_FILTER_CTRL, 0x0082, 0x0082);
-	regmap_update_bits(rt298->regmap, RT298_IRQ_CTRL, 0x2, 0x2);
 
 	regmap_write(rt298->regmap, RT298_UNSOLICITED_INLINE_CMD, 0x81);
 	regmap_write(rt298->regmap, RT298_UNSOLICITED_HP_OUT, 0x82);
-- 
1.8.1.1.439.g50a6b54
