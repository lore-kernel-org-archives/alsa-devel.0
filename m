From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH] ASoC: rt5514: Add the missing register in the
	readable table
Date: Fri, 30 Mar 2018 15:41:55 +0800
Message-ID: <1522395715-14870-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 41A51266F93
 for <alsa-devel@alsa-project.org>; Fri, 30 Mar 2018 09:42:03 +0200 (CEST)
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
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch adds the missing register in the readable table.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5514.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 2d79571..c33f8da 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -89,6 +89,7 @@ static const struct reg_default rt5514_reg[] = {
 	{RT5514_PLL3_CALIB_CTRL5,	0x40220012},
 	{RT5514_DELAY_BUF_CTRL1,	0x7fff006a},
 	{RT5514_DELAY_BUF_CTRL3,	0x00000000},
+	{RT5514_ASRC_IN_CTRL1,		0x00000003},
 	{RT5514_DOWNFILTER0_CTRL1,	0x00020c2f},
 	{RT5514_DOWNFILTER0_CTRL2,	0x00020c2f},
 	{RT5514_DOWNFILTER0_CTRL3,	0x10000362},
@@ -181,6 +182,7 @@ static bool rt5514_readable_register(struct device *dev, unsigned int reg)
 	case RT5514_PLL3_CALIB_CTRL5:
 	case RT5514_DELAY_BUF_CTRL1:
 	case RT5514_DELAY_BUF_CTRL3:
+	case RT5514_ASRC_IN_CTRL1:
 	case RT5514_DOWNFILTER0_CTRL1:
 	case RT5514_DOWNFILTER0_CTRL2:
 	case RT5514_DOWNFILTER0_CTRL3:
@@ -238,6 +240,7 @@ static bool rt5514_i2c_readable_register(struct device *dev,
 	case RT5514_DSP_MAPPING | RT5514_PLL3_CALIB_CTRL5:
 	case RT5514_DSP_MAPPING | RT5514_DELAY_BUF_CTRL1:
 	case RT5514_DSP_MAPPING | RT5514_DELAY_BUF_CTRL3:
+	case RT5514_DSP_MAPPING | RT5514_ASRC_IN_CTRL1:
 	case RT5514_DSP_MAPPING | RT5514_DOWNFILTER0_CTRL1:
 	case RT5514_DSP_MAPPING | RT5514_DOWNFILTER0_CTRL2:
 	case RT5514_DSP_MAPPING | RT5514_DOWNFILTER0_CTRL3:
-- 
2.7.4
