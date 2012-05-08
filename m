From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/4] ASoC: omap-abe-twl6040: Introduce driver
	data for runtime parameters
Date: Tue,  8 May 2012 15:15:13 +0300
Message-ID: <1336479314-27766-4-git-send-email-peter.ujfalusi@ti.com>
References: <1336479314-27766-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog124.obsmtp.com (na3sys009aog124.obsmtp.com
	[74.125.149.151])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BD94104303
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 14:15:19 +0200 (CEST)
Received: by lbbgg6 with SMTP id gg6so4947906lbb.8
	for <alsa-devel@alsa-project.org>; Tue, 08 May 2012 05:15:17 -0700 (PDT)
In-Reply-To: <1336479314-27766-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

In preparation to Device Tree support.
With DT booted kernel we can not rely on pdata which used to
hold information needed for the driver at runtime.
Use the card's driver data to hold these informations from now on.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-abe-twl6040.c |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index 4388de9..9d93793 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -40,6 +40,11 @@
 #include "omap-pcm.h"
 #include "../codecs/twl6040.h"
 
+struct abe_twl6040 {
+	int	jack_detection;	/* board can detect jack events */
+	int	mclk_freq;	/* MCLK frequency speed for twl6040 */
+};
+
 static int omap_abe_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
@@ -47,13 +52,13 @@ static int omap_abe_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_card *card = codec->card;
-	struct omap_abe_twl6040_data *pdata = dev_get_platdata(card->dev);
+	struct abe_twl6040 *priv = snd_soc_card_get_drvdata(card);
 	int clk_id, freq;
 	int ret;
 
 	clk_id = twl6040_get_clk_id(rtd->codec);
 	if (clk_id == TWL6040_SYSCLK_SEL_HPPLL)
-		freq = pdata->mclk_freq;
+		freq = priv->mclk_freq;
 	else if (clk_id == TWL6040_SYSCLK_SEL_LPPLL)
 		freq = 32768;
 	else
@@ -176,6 +181,7 @@ static int omap_abe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_card *card = codec->card;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct omap_abe_twl6040_data *pdata = dev_get_platdata(card->dev);
+	struct abe_twl6040 *priv = snd_soc_card_get_drvdata(card);
 	int hs_trim;
 	int ret = 0;
 
@@ -199,7 +205,7 @@ static int omap_abe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 					TWL6040_HSF_TRIM_RIGHT(hs_trim));
 
 	/* Headset jack detection only if it is supported */
-	if (pdata->jack_detection) {
+	if (priv->jack_detection) {
 		ret = snd_soc_jack_new(codec, "Headset Jack",
 					SND_JACK_HEADSET, &hs_jack);
 		if (ret)
@@ -265,6 +271,7 @@ static __devinit int omap_abe_probe(struct platform_device *pdev)
 {
 	struct omap_abe_twl6040_data *pdata = dev_get_platdata(&pdev->dev);
 	struct snd_soc_card *card = &omap_abe_card;
+	struct abe_twl6040 *priv;
 	int num_links = 0;
 	int ret;
 
@@ -275,6 +282,10 @@ static __devinit int omap_abe_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct abe_twl6040), GFP_KERNEL);
+	if (priv == NULL)
+		return -ENOMEM;
+
 	if (pdata->card_name) {
 		card->name = pdata->card_name;
 	} else {
@@ -282,7 +293,11 @@ static __devinit int omap_abe_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	if (!pdata->mclk_freq) {
+	priv->jack_detection = pdata->jack_detection;
+	priv->mclk_freq = pdata->mclk_freq;
+
+
+	if (!priv->mclk_freq) {
 		dev_err(&pdev->dev, "MCLK frequency missing\n");
 		return -ENODEV;
 	}
@@ -295,6 +310,8 @@ static __devinit int omap_abe_probe(struct platform_device *pdev)
 	card->dai_link = abe_twl6040_dai_links;
 	card->num_links = num_links;
 
+	snd_soc_card_set_drvdata(card, priv);
+
 	ret = snd_soc_register_card(card);
 	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
-- 
1.7.8.6
