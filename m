From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 2/2] ASoC: rt5670: Check sysclk source by
	private data
Date: Mon, 9 Mar 2015 16:55:23 +0800
Message-ID: <1425891323-21445-2-git-send-email-bardliao@realtek.com>
References: <1425891323-21445-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D65002605CC
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 09:55:57 +0100 (CET)
In-Reply-To: <1425891323-21445-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Currently, is_sys_clk_from_pll check sysclk source by reading codec
register value. And it will be invoked before updating dapm widget
power. In some machine driver, snd_soc_dai_set_sysclk is called in
dapm event to switch codec sysclk to RC clock in idle mode. And in
some use cases (such as syspend/resume) hw_params will not be called
when the dapm widget is powered up. As a result, is_sys_clk_from_pll
will return 0 although it is supposed to be 1.
To solve this, we let is_sys_clk_from_pll check sysclk sysclk_src
which is stored in private data and don't change the value of sysclk_src
when codec sysclk is switched to internal clock. The internal clock
can only be used in idle mode, so it sould be fine if we don't set
sysclk_src to internal clock.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 sound/soc/codecs/rt5670.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 32cd266..9e3bc43 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -517,11 +517,10 @@ static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 static int is_sys_clk_from_pll(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink)
 {
-	unsigned int val;
+	struct snd_soc_codec *codec = source->codec;
+	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
 
-	val = snd_soc_read(source->codec, RT5670_GLB_CLK);
-	val &= RT5670_SCLK_SRC_MASK;
-	if (val == RT5670_SCLK_SRC_PLL1)
+	if (rt5670->sysclk_src == RT5670_SCLK_S_PLL1)
 		return 1;
 	else
 		return 0;
@@ -2270,9 +2269,6 @@ static int rt5670_set_dai_sysclk(struct snd_soc_dai *dai,
 	struct rt5670_priv *rt5670 = snd_soc_codec_get_drvdata(codec);
 	unsigned int reg_val = 0;
 
-	if (freq == rt5670->sysclk && clk_id == rt5670->sysclk_src)
-		return 0;
-
 	switch (clk_id) {
 	case RT5670_SCLK_S_MCLK:
 		reg_val |= RT5670_SCLK_SRC_MCLK;
@@ -2290,7 +2286,8 @@ static int rt5670_set_dai_sysclk(struct snd_soc_dai *dai,
 	snd_soc_update_bits(codec, RT5670_GLB_CLK,
 		RT5670_SCLK_SRC_MASK, reg_val);
 	rt5670->sysclk = freq;
-	rt5670->sysclk_src = clk_id;
+	if (clk_id != RT5670_SCLK_S_RCCLK)
+		rt5670->sysclk_src = clk_id;
 
 	dev_dbg(dai->dev, "Sysclk is %dHz and clock id is %d\n", freq, clk_id);
 
-- 
1.8.1.1.439.g50a6b54
