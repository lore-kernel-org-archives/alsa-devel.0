From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/6] ASoC: Add context parameter to card DAPM
	callbacks
Date: Mon,  6 Jun 2011 19:18:31 +0100
Message-ID: <1307384313-23559-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1307384313-23559-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 65C6524435
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 20:18:37 +0200 (CEST)
In-Reply-To: <1307384313-23559-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The card callback will get called for each DAPM context in the card so it
can be useful for it to know which device is currently undergoing a
transition.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h              |    2 ++
 sound/soc/atmel/sam9g20_wm8731.c |    1 +
 sound/soc/omap/ams-delta.c       |    3 ++-
 sound/soc/samsung/speyside.c     |    4 ++++
 sound/soc/soc-dapm.c             |    4 ++--
 5 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0f29700..f55efc1 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -726,8 +726,10 @@ struct snd_soc_card {
 
 	/* callbacks */
 	int (*set_bias_level)(struct snd_soc_card *,
+			      struct snd_soc_dapm_context *dapm,
 			      enum snd_soc_bias_level level);
 	int (*set_bias_level_post)(struct snd_soc_card *,
+				   struct snd_soc_dapm_context *dapm,
 				   enum snd_soc_bias_level level);
 
 	long pmdown_time;
diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 95572d2..bad3aa1 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -92,6 +92,7 @@ static struct snd_soc_ops at91sam9g20ek_ops = {
 };
 
 static int at91sam9g20ek_set_bias_level(struct snd_soc_card *card,
+					struct snd_soc_dapm_context *dapm,
 					enum snd_soc_bias_level level)
 {
 	static int mclk_on;
diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index 462cbcb..b40095a 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -427,7 +427,8 @@ static struct snd_soc_ops ams_delta_ops = {
 
 /* Board specific codec bias level control */
 static int ams_delta_set_bias_level(struct snd_soc_card *card,
-					enum snd_soc_bias_level level)
+				    struct snd_soc_dapm_context *dapm,
+				    enum snd_soc_bias_level level)
 {
 	struct snd_soc_codec *codec = card->rtd->codec;
 
diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 93078b1..99fb033 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -20,11 +20,15 @@
 #define WM8915_HPSEL_GPIO 214
 
 static int speyside_set_bias_level(struct snd_soc_card *card,
+				   struct snd_soc_dapm_context *dapm,
 				   enum snd_soc_bias_level level)
 {
 	struct snd_soc_dai *codec_dai = card->rtd[0].codec_dai;
 	int ret;
 
+	if (dapm->dev != codec_dai->dev)
+		return 0;
+
 	switch (level) {
 	case SND_SOC_BIAS_STANDBY:
 		ret = snd_soc_dai_set_sysclk(codec_dai, WM8915_SYSCLK_MCLK2,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d989dd7..1682834 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -142,7 +142,7 @@ static int snd_soc_dapm_set_bias_level(struct snd_soc_dapm_context *dapm,
 	trace_snd_soc_bias_level_start(card, level);
 
 	if (card && card->set_bias_level)
-		ret = card->set_bias_level(card, level);
+		ret = card->set_bias_level(card, dapm, level);
 	if (ret != 0)
 		goto out;
 
@@ -154,7 +154,7 @@ static int snd_soc_dapm_set_bias_level(struct snd_soc_dapm_context *dapm,
 		goto out;
 
 	if (card && card->set_bias_level_post)
-		ret = card->set_bias_level_post(card, level);
+		ret = card->set_bias_level_post(card, dapm, level);
 out:
 	trace_snd_soc_bias_level_done(card, level);
 
-- 
1.7.5.3
