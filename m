From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/3] ASoC: rt5677: Add the MICBIAS VDD setting
	in the platform data
Date: Thu, 8 Jan 2015 10:31:06 +0800
Message-ID: <1420684267-19211-2-git-send-email-oder_chiou@realtek.com>
References: <1420684267-19211-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id CA8542606CB
 for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2015 03:31:24 +0100 (CET)
In-Reply-To: <1420684267-19211-1-git-send-email-oder_chiou@realtek.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, yang.a.fang@intel.com, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch adds the MICBIAS VDD setting in the platform data. It can be set to
1V8 or 3V3 in the MICBIAS VDD.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 include/sound/rt5677.h    | 3 +++
 sound/soc/codecs/rt5677.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/include/sound/rt5677.h b/include/sound/rt5677.h
index d9eb7d8..a620704 100644
--- a/include/sound/rt5677.h
+++ b/include/sound/rt5677.h
@@ -37,6 +37,9 @@ struct rt5677_platform_data {
 		OFF, GPIO4, GPIO5 and GPIO6 respectively */
 	unsigned int jd2_gpio;
 	unsigned int jd3_gpio;
+
+	/* Set MICBIAS1 VDD 1v8 or 3v3 */
+	bool micbias1_vdd_3v3;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index d27630a..32c368c 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4923,6 +4923,11 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 					RT5677_GPIO5_DIR_OUT);
 	}
 
+	if (rt5677->pdata.micbias1_vdd_3v3)
+		regmap_update_bits(rt5677->regmap, RT5677_MICBIAS,
+			RT5677_MICBIAS1_CTRL_VDD_MASK,
+			RT5677_MICBIAS1_CTRL_VDD_3_3V);
+
 	rt5677_init_gpio(i2c);
 	rt5677_init_irq(i2c);
 
-- 
1.8.1.1.439.g50a6b54
