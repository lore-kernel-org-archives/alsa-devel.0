From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: jz4740-i2s: Use
	clk_prepare_enable/clk_disable_unprepare
Date: Sun, 12 May 2013 20:07:39 +0200
Message-ID: <1368382059-4175-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-236.synserver.de (smtp-out-237.synserver.de
 [212.40.185.237])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F76B261AAC
 for <alsa-devel@alsa-project.org>; Sun, 12 May 2013 20:05:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

In preparation to switching the jz4740 clk driver to the common clk framework
update the clk enable/disable calls to clk_prepare_enable/clk_disable_unprepare.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/jz4740/jz4740-i2s.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 9a12644..12c21bd 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -118,7 +118,7 @@ static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
 	ctrl |= JZ_AIC_CTRL_FLUSH;
 	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
 
-	clk_enable(i2s->clk_i2s);
+	clk_prepare_enable(i2s->clk_i2s);
 
 	conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
 	conf |= JZ_AIC_CONF_ENABLE;
@@ -140,7 +140,7 @@ static void jz4740_i2s_shutdown(struct snd_pcm_substream *substream,
 	conf &= ~JZ_AIC_CONF_ENABLE;
 	jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
 
-	clk_disable(i2s->clk_i2s);
+	clk_disable_unprepare(i2s->clk_i2s);
 }
 
 static int jz4740_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
@@ -314,10 +314,10 @@ static int jz4740_i2s_suspend(struct snd_soc_dai *dai)
 		conf &= ~JZ_AIC_CONF_ENABLE;
 		jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
 
-		clk_disable(i2s->clk_i2s);
+		clk_disable_unprepare(i2s->clk_i2s);
 	}
 
-	clk_disable(i2s->clk_aic);
+	clk_disable_unprepare(i2s->clk_aic);
 
 	return 0;
 }
@@ -327,10 +327,10 @@ static int jz4740_i2s_resume(struct snd_soc_dai *dai)
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	uint32_t conf;
 
-	clk_enable(i2s->clk_aic);
+	clk_prepare_enable(i2s->clk_aic);
 
 	if (dai->active) {
-		clk_enable(i2s->clk_i2s);
+		clk_prepare_enable(i2s->clk_i2s);
 
 		conf = jz4740_i2s_read(i2s, JZ_REG_AIC_CONF);
 		conf |= JZ_AIC_CONF_ENABLE;
@@ -368,7 +368,7 @@ static int jz4740_i2s_dai_probe(struct snd_soc_dai *dai)
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	uint32_t conf;
 
-	clk_enable(i2s->clk_aic);
+	clk_prepare_enable(i2s->clk_aic);
 
 	jz4740_i2c_init_pcm_config(i2s);
 
@@ -388,7 +388,7 @@ static int jz4740_i2s_dai_remove(struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 
-	clk_disable(i2s->clk_aic);
+	clk_disable_unprepare(i2s->clk_aic);
 	return 0;
 }
 
-- 
1.8.2.1
