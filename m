From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5670: Fix the speaker mono output
	issue
Date: Tue, 17 Feb 2015 13:59:27 +0800
Message-ID: <1424152767-29226-2-git-send-email-bardliao@realtek.com>
References: <1424152767-29226-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id ACA9026069F
 for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2015 06:59:40 +0100 (CET)
In-Reply-To: <1424152767-29226-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, mengdong.lin@intel.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

We need to set left/right control for the speaker amp to get stereo
output on speaker.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 04ca247..ba8cc14 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2700,6 +2700,12 @@ static int rt5670_i2c_probe(struct i2c_client *i2c,
 
 	regmap_write(rt5670->regmap, RT5670_RESET, 0);
 
+	regmap_read(rt5670->regmap, RT5670_VENDOR_ID, &val);
+	if (val >= 4)
+		regmap_write(rt5670->regmap, RT5670_GPIO_CTRL3, 0x0980);
+	else
+		regmap_write(rt5670->regmap, RT5670_GPIO_CTRL3, 0x0d00);
+
 	ret = regmap_register_patch(rt5670->regmap, init_list,
 				    ARRAY_SIZE(init_list));
 	if (ret != 0)
-- 
1.8.1.1.439.g50a6b54
