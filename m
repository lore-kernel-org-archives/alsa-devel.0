From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH v2 2/2] ASoC: rt5670: Keep sysclk on if JD func
	is used
Date: Mon, 15 Dec 2014 15:42:34 +0800
Message-ID: <1418629354-26948-2-git-send-email-bardliao@realtek.com>
References: <1418629354-26948-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id DD5B226057E
 for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2014 08:43:16 +0100 (CET)
In-Reply-To: <1418629354-26948-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, Bard Liao <bardliao@realtek.com>, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

System clock is necessary for rt5670 JD function. We assume system
clock source will be set in machine driver. So there are two things
left we should do in codec driver.
1. Set sysclk to codec internal clock in probe since machine driver
   may not do that before JD function is registered.
2. Power up PLL once sysclk source is switched to PLL.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index a8a471b..6ff379c 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2190,6 +2190,13 @@ static int rt5670_set_dai_sysclk(struct snd_soc_dai *dai,
 	if (freq == rt5670->sysclk && clk_id == rt5670->sysclk_src)
 		return 0;
 
+	if (rt5670->pdata.jd_mode) {
+		if (clk_id == RT5670_SCLK_S_PLL1)
+			snd_soc_dapm_force_enable_pin(&codec->dapm, "PLL1");
+		else
+			snd_soc_dapm_disable_pin(&codec->dapm, "PLL1");
+		snd_soc_dapm_sync(&codec->dapm);
+	}
 	switch (clk_id) {
 	case RT5670_SCLK_S_MCLK:
 		reg_val |= RT5670_SCLK_SRC_MCLK;
@@ -2628,6 +2635,10 @@ static int rt5670_i2c_probe(struct i2c_client *i2c,
 	}
 
 	if (rt5670->pdata.jd_mode) {
+		regmap_update_bits(rt5670->regmap, RT5670_GLB_CLK,
+				   RT5670_SCLK_SRC_MASK, RT5670_SCLK_SRC_RCCLK);
+		rt5670->sysclk = 0;
+		rt5670->sysclk_src = RT5670_SCLK_S_RCCLK;
 		regmap_update_bits(rt5670->regmap, RT5670_PWR_ANLG1,
 				   RT5670_PWR_MB, RT5670_PWR_MB);
 		regmap_update_bits(rt5670->regmap, RT5670_PWR_ANLG2,
-- 
1.8.1.1.439.g50a6b54
