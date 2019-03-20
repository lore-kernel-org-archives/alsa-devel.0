From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH v2 09/12] ASoC: tlv320aic32x4: Restructure
	set_dai_sysclk
Date: Tue, 19 Mar 2019 21:51:26 -0700
Message-ID: <20190320045129.6859-10-nh6z@nh6z.net>
References: <20190320045129.6859-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp113.ord1c.emailsrvr.com (smtp113.ord1c.emailsrvr.com
 [108.166.43.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3FF08F89718
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2019 05:51:53 +0100 (CET)
In-Reply-To: <20190320045129.6859-1-nh6z@nh6z.net>
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
Cc: team@nwdigitalradio.com, Annaliese McDermond <nh6z@nh6z.net>
List-Id: alsa-devel@alsa-project.org

The sysclk is now managed by the CCF.  Change this function
to merely find the system clock and set it using
clk_set_rate.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/tlv320aic32x4.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index d8ebfc720bdd..00822749cb8b 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -49,7 +49,6 @@
 
 struct aic32x4_priv {
 	struct regmap *regmap;
-	u32 sysclk;
 	u32 power_cfg;
 	u32 micpga_routing;
 	bool swapdacs;
@@ -567,17 +566,13 @@ static int aic32x4_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 				  int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_component *component = codec_dai->component;
-	struct aic32x4_priv *aic32x4 = snd_soc_component_get_drvdata(component);
+	struct clk *mclk;
+	struct clk *pll;
 
-	switch (freq) {
-	case 12000000:
-	case 24000000:
-	case 25000000:
-		aic32x4->sysclk = freq;
-		return 0;
-	}
-	printk(KERN_ERR "aic32x4: invalid frequency to set DAI system clock\n");
-	return -EINVAL;
+	pll = devm_clk_get(component->dev, "pll");
+	mclk = clk_get_parent(pll);
+
+	return clk_set_rate(mclk, freq);
 }
 
 static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
-- 
2.19.1
