From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 1/2] ASoC: rt5645: set sel_i2s_pre_div1 to 2
Date: Tue, 27 Dec 2016 12:05:05 +0800
Message-ID: <1482811506-6447-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F2DE266713
 for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2016 05:05:21 +0100 (CET)
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, pierre-louis.bossart@linux.intel.com, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The i2s clock pre-divider 1 is used for both i2s1 and sysclk.
The i2s1 is usually used for the main i2s and the pre-divider
will be set in hw_params function.

However, if i2s2 is used, the pre-divider is not set in the hw_params
function and the default value of i2s clock pre-divider 1 is too high
for sysclk and DMIC usage. Fix by overriding default divider value to 2.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=95681
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5645.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 10c2a56..1ac96ef 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3833,6 +3833,9 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		}
 	}
 
+	regmap_update_bits(rt5645->regmap, RT5645_ADDA_CLK1,
+		RT5645_I2S_PD1_MASK, RT5645_I2S_PD1_2);
+
 	if (rt5645->pdata.jd_invert) {
 		regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
 			RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
-- 
1.8.1.1.439.g50a6b54
