From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: arizona: Provide simple DAI ops for
	autoconfiguring interfaces
Date: Fri, 17 May 2013 13:29:03 +0100
Message-ID: <1368793745-30887-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DBFBB260786
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2013 14:39:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    7 +++++++
 sound/soc/codecs/arizona.h |    1 +
 2 files changed, 8 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 90c3db1..4a42041 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1198,6 +1198,13 @@ const struct snd_soc_dai_ops arizona_dai_ops = {
 };
 EXPORT_SYMBOL_GPL(arizona_dai_ops);
 
+const struct snd_soc_dai_ops arizona_simple_dai_ops = {
+	.startup = arizona_startup,
+	.hw_params = arizona_hw_params_rate,
+	.set_sysclk = arizona_dai_set_sysclk,
+};
+EXPORT_SYMBOL_GPL(arizona_simple_dai_ops);
+
 int arizona_init_dai(struct arizona_priv *priv, int id)
 {
 	struct arizona_dai_priv *dai_priv = &priv->dai[id];
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index af39f10..a1a5dad 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -213,6 +213,7 @@ extern int arizona_set_sysclk(struct snd_soc_codec *codec, int clk_id,
 			      int source, unsigned int freq, int dir);
 
 extern const struct snd_soc_dai_ops arizona_dai_ops;
+extern const struct snd_soc_dai_ops arizona_simple_dai_ops;
 
 #define ARIZONA_FLL_NAME_LEN 20
 
-- 
1.7.10.4
