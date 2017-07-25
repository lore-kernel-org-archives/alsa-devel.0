From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 07/11] ASoC: jz4740: Handle return value of clk_prepare_enable.
Date: Tue, 25 Jul 2017 15:44:34 +0530
Message-ID: <1500977674-27960-8-git-send-email-arvind.yadav.cs@gmail.com>
References: <1500977674-27960-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500977674-27960-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, krzk@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 794a349..99394c0 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -133,6 +133,7 @@ static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	uint32_t conf, ctrl;
+	int ret;
 
 	if (dai->active)
 		return 0;
@@ -141,7 +142,9 @@ static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
 	ctrl |= JZ_AIC_CTRL_FLUSH;
 	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
 
-	clk_prepare_enable(i2s->clk_i2s);
+	ret = clk_prepare_enable(i2s->clk_i2s);
+	if (ret)
+		return ret;
 
 	conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
 	conf |= JZ_AIC_CONF_ENABLE;
@@ -352,11 +355,18 @@ static int jz4740_i2s_resume(struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	uint32_t conf;
+	int ret;
 
-	clk_prepare_enable(i2s->clk_aic);
+	ret = clk_prepare_enable(i2s->clk_aic);
+	if (ret)
+		return ret;
 
 	if (dai->active) {
-		clk_prepare_enable(i2s->clk_i2s);
+		ret = clk_prepare_enable(i2s->clk_i2s);
+		if (ret) {
+			clk_disable_unprepare(i2s->clk_aic);
+			return ret;
+		}
 
 		conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
 		conf |= JZ_AIC_CONF_ENABLE;
@@ -387,8 +397,11 @@ static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	uint32_t conf;
+	int ret;
 
-	clk_prepare_enable(i2s->clk_aic);
+	ret = clk_prepare_enable(i2s->clk_aic);
+	if (ret)
+		return ret;
 
 	jz4740_i2c_init_pcm_config(i2s);
 	snd_soc_dai_init_dma_data(dai, &i2s->playback_dma_data,
-- 
1.9.1
