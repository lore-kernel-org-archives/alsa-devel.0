From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 3/3] ASoC: tas5086: add suspend callback
Date: Tue,  1 Oct 2013 14:48:26 +0200
Message-ID: <1380631706-19365-3-git-send-email-zonque@gmail.com>
References: <1380631706-19365-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 536C7264EF1
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2013 14:48:32 +0200 (CEST)
In-Reply-To: <1380631706-19365-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, s.neumann@raumfeld.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

When going to suspend, shut down all channels and re-do the init
procedure at resume time.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/tas5086.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index 3a88c68..2996d2e 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -762,14 +762,39 @@ static struct snd_soc_dai_driver tas5086_dai = {
 };
 
 #ifdef CONFIG_PM
+static int tas5086_soc_suspend(struct snd_soc_codec *codec)
+{
+	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	/* Shut down all channels */
+	ret = regmap_write(priv->regmap, TAS5086_SYS_CONTROL_2, 0x60);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int tas5086_soc_resume(struct snd_soc_codec *codec)
 {
 	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
+	int ret;
 
-	/* Restore codec state */
-	return regcache_sync(priv->regmap);
+	tas5086_reset(priv);
+	regcache_mark_dirty(priv->regmap);
+
+	ret = tas5086_init(codec->dev, priv);
+	if (ret < 0)
+		return ret;
+
+	ret = regcache_sync(priv->regmap);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 #else
+#define tas5086_soc_suspend	NULL
 #define tas5086_soc_resume	NULL
 #endif /* CONFIG_PM */
 
@@ -832,6 +857,7 @@ static int tas5086_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_tas5086 = {
 	.probe			= tas5086_probe,
 	.remove			= tas5086_remove,
+	.suspend		= tas5086_soc_suspend,
 	.resume			= tas5086_soc_resume,
 	.controls		= tas5086_controls,
 	.num_controls		= ARRAY_SIZE(tas5086_controls),
-- 
1.8.3.1
