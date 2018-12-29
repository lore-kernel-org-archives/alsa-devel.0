From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 6/7] ASoC: Intel: bytcr_rt5651: Add support
	for jack-detect using an external GPIO
Date: Sun, 30 Dec 2018 00:00:24 +0100
Message-ID: <20181229230025.21949-7-hdegoede@redhat.com>
References: <20181229230025.21949-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 28106267B4A
 for <alsa-devel@alsa-project.org>; Sun, 30 Dec 2018 00:00:42 +0100 (CET)
In-Reply-To: <20181229230025.21949-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, flove@realtek.com, shumingf@realtek.com, Oder Chiou <oder_chiou@realtek.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some board designs hook the jack-detect up to an external GPIO, rather
then to one of the codec pins, add support for this.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Also pass the gpio to snd_soc_component_set_jack from the resume handler
---
 sound/soc/intel/boards/bytcr_rt5651.c | 43 ++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 6d8ef9dd106e..9a2ee9080897 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -91,6 +91,7 @@ enum {
 struct byt_rt5651_private {
 	struct clk *mclk;
 	struct gpio_desc *ext_amp_gpio;
+	struct gpio_desc *hp_detect;
 	struct snd_soc_jack jack;
 };
 
@@ -499,6 +500,7 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 	struct byt_rt5651_private *priv = snd_soc_card_get_drvdata(card);
 	const struct snd_soc_dapm_route *custom_map;
 	int num_routes;
+	int report;
 	int ret;
 
 	card->dapm.idle_bias_off = true;
@@ -582,20 +584,27 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 			dev_err(card->dev, "unable to set MCLK rate\n");
 	}
 
-	if (BYT_RT5651_JDSRC(byt_rt5651_quirk)) {
+	report = 0;
+	if (BYT_RT5651_JDSRC(byt_rt5651_quirk))
+		report = SND_JACK_HEADSET | SND_JACK_BTN_0;
+	else if (priv->hp_detect)
+		report = SND_JACK_HEADSET;
+
+	if (report) {
 		ret = snd_soc_card_jack_new(runtime->card, "Headset",
-				    SND_JACK_HEADSET | SND_JACK_BTN_0,
-				    &priv->jack, bytcr_jack_pins,
+				    report, &priv->jack, bytcr_jack_pins,
 				    ARRAY_SIZE(bytcr_jack_pins));
 		if (ret) {
 			dev_err(runtime->dev, "jack creation failed %d\n", ret);
 			return ret;
 		}
 
-		snd_jack_set_key(priv->jack.jack, SND_JACK_BTN_0,
-				 KEY_PLAYPAUSE);
+		if (report & SND_JACK_BTN_0)
+			snd_jack_set_key(priv->jack.jack, SND_JACK_BTN_0,
+					 KEY_PLAYPAUSE);
 
-		ret = snd_soc_component_set_jack(codec, &priv->jack, NULL);
+		ret = snd_soc_component_set_jack(codec, &priv->jack,
+						 priv->hp_detect);
 		if (ret)
 			return ret;
 	}
@@ -767,7 +776,8 @@ static int byt_rt5651_resume(struct snd_soc_card *card)
 	for_each_card_components(card, component) {
 		if (!strcmp(component->name, byt_rt5651_codec_name)) {
 			dev_dbg(component->dev, "re-enabling jack detect after resume\n");
-			snd_soc_component_set_jack(component, &priv->jack, NULL);
+			snd_soc_component_set_jack(component, &priv->jack,
+						   priv->hp_detect);
 			break;
 		}
 	}
@@ -1012,6 +1022,25 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 				return ret_val;
 			}
 		}
+		priv->hp_detect = devm_fwnode_get_index_gpiod_from_child(
+						&pdev->dev, "hp-detect", 0,
+						codec_dev->fwnode,
+						GPIOD_IN, "hp-detect");
+		if (IS_ERR(priv->hp_detect)) {
+			ret_val = PTR_ERR(priv->hp_detect);
+			switch (ret_val) {
+			case -ENOENT:
+				priv->hp_detect = NULL;
+				break;
+			default:
+				dev_err(&pdev->dev, "Failed to get hp-detect GPIO: %d\n",
+					ret_val);
+				/* fall through */
+			case -EPROBE_DEFER:
+				put_device(codec_dev);
+				return ret_val;
+			}
+		}
 	}
 
 	put_device(codec_dev);
-- 
2.20.1
