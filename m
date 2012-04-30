From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: wm8350: Don't use locally allocated
	codec struct
Date: Mon, 30 Apr 2012 22:53:12 +0100
Message-ID: <1335822795-4720-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CB0E41041E0
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Apr 2012 23:53:22 +0200 (CEST)
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

The core allocates the live copies, we shouldn't try to duplicate it and
were buggy trying to do so as we were using uninitialised data for the
control data.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8350.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 8c4c959..aa12c6b 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -60,7 +60,7 @@ struct wm8350_jack_data {
 };
 
 struct wm8350_data {
-	struct snd_soc_codec codec;
+	struct wm8350 *wm8350;
 	struct wm8350_output out1;
 	struct wm8350_output out2;
 	struct wm8350_jack_data hpl;
@@ -1309,7 +1309,7 @@ static void wm8350_hp_work(struct wm8350_data *priv,
 			   struct wm8350_jack_data *jack,
 			   u16 mask)
 {
-	struct wm8350 *wm8350 = priv->codec.control_data;
+	struct wm8350 *wm8350 = priv->wm8350;
 	u16 reg;
 	int report;
 
@@ -1342,7 +1342,7 @@ static void wm8350_hpr_work(struct work_struct *work)
 static irqreturn_t wm8350_hp_jack_handler(int irq, void *data)
 {
 	struct wm8350_data *priv = data;
-	struct wm8350 *wm8350 = priv->codec.control_data;
+	struct wm8350 *wm8350 = priv->wm8350;
 	struct wm8350_jack_data *jack = NULL;
 
 	switch (irq - wm8350->irq_base) {
@@ -1427,7 +1427,7 @@ EXPORT_SYMBOL_GPL(wm8350_hp_jack_detect);
 static irqreturn_t wm8350_mic_handler(int irq, void *data)
 {
 	struct wm8350_data *priv = data;
-	struct wm8350 *wm8350 = priv->codec.control_data;
+	struct wm8350 *wm8350 = priv->wm8350;
 	u16 reg;
 	int report = 0;
 
@@ -1536,6 +1536,8 @@ static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 		return -ENOMEM;
 	snd_soc_codec_set_drvdata(codec, priv);
 
+	priv->wm8350 = wm8350;
+
 	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
 		priv->supplies[i].supply = supply_names[i];
 
@@ -1544,7 +1546,6 @@ static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 	if (ret != 0)
 		return ret;
 
-	wm8350->codec.codec = codec;
 	codec->control_data = wm8350;
 
 	/* Put the codec into reset if it wasn't already */
-- 
1.7.10
