From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Implement tristate support
Date: Wed, 12 Dec 2012 16:22:53 +0900
Message-ID: <1355296973-29658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9A2D926030A
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 08:22:59 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 231fae0..a85a68f 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -859,11 +859,27 @@ static int arizona_dai_set_sysclk(struct snd_soc_dai *dai,
 	return snd_soc_dapm_sync(&codec->dapm);
 }
 
+static int arizona_set_tristate(struct snd_soc_dai *dai, int tristate)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	int base = dai->driver->base;
+	unsigned int reg;
+
+	if (tristate)
+		reg = ARIZONA_AIF1_TRI;
+	else
+		reg = 0;
+
+	return snd_soc_update_bits(codec, base + ARIZONA_AIF_RATE_CTRL,
+				   ARIZONA_AIF1_TRI, reg);
+}
+
 const struct snd_soc_dai_ops arizona_dai_ops = {
 	.startup = arizona_startup,
 	.set_fmt = arizona_set_fmt,
 	.hw_params = arizona_hw_params,
 	.set_sysclk = arizona_dai_set_sysclk,
+	.set_tristate = arizona_set_tristate,
 };
 EXPORT_SYMBOL_GPL(arizona_dai_ops);
 
-- 
1.7.10.4
