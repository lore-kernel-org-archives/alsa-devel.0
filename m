From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: max98095: Staticise non-exported
	functions and export jack detect
Date: Thu, 31 May 2012 16:53:55 +0100
Message-ID: <1338479635-22766-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9F6CB1043DD
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2012 18:01:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Hsiang <peter.hsiang@maxim-ic.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/max98095.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 35179e2..7cd508e 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -2216,7 +2216,7 @@ static irqreturn_t max98095_report_jack(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-int max98095_jack_detect_enable(struct snd_soc_codec *codec)
+static int max98095_jack_detect_enable(struct snd_soc_codec *codec)
 {
 	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
@@ -2245,7 +2245,7 @@ int max98095_jack_detect_enable(struct snd_soc_codec *codec)
 	return ret;
 }
 
-int max98095_jack_detect_disable(struct snd_soc_codec *codec)
+static int max98095_jack_detect_disable(struct snd_soc_codec *codec)
 {
 	int ret = 0;
 
@@ -2286,6 +2286,7 @@ int max98095_jack_detect(struct snd_soc_codec *codec,
 	max98095_report_jack(client->irq, codec);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(max98095_jack_detect);
 
 #ifdef CONFIG_PM
 static int max98095_suspend(struct snd_soc_codec *codec)
-- 
1.7.10
