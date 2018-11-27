From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH 2/5] ASoC: max9867: Fix power management
Date: Tue, 27 Nov 2018 18:37:27 +0100
Message-ID: <20181127173727.GA23636@lenoch>
References: <20181123142507.GA7347@lenoch> <20181123142729.GC7347@lenoch>
 <20181126125719.GB9715@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id CFF8626770D
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2018 18:37:29 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23993928AbeK0Rh2vNwRN (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Tue, 27 Nov 2018 18:37:28 +0100
Content-Disposition: inline
In-Reply-To: <20181126125719.GB9715@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 26, 2018 at 12:57:19PM +0000, Mark Brown wrote:
> On Fri, Nov 23, 2018 at 03:27:29PM +0100, Ladislav Michl wrote:
> 
> > Move device enable to probe function. Doing that from prepare
> > callback allows only DAC to be enabled.
> 
> This seems like it'll be a power consumption regression - instead of
> managing the power at runtime we'll just leave the power on all the
> time.  The normal place to do this would be either directly through DAPM
> or via set_bias_level() - the latter seems a better fit here.

Well, I was unable to measure any consumption difference as all chip
domains are powered down anyway. But see bellow.

> > While here move suspend and resume functions to more common place.
> 
> It would be better to split this out from the rest of the change as it's
> a fairly large bit of code motion relative to the rest of the patch.

So something like this is preffered solution? (untested)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 1cda54b59854..4510f98724c2 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -248,17 +248,6 @@ static int max9867_dai_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int max9867_prepare(struct snd_pcm_substream *substream,
-			 struct snd_soc_dai *dai)
-{
-	struct snd_soc_component *component = dai->component;
-	struct max9867_priv *max9867 = snd_soc_component_get_drvdata(component);
-
-	regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
-		MAX9867_SHTDOWN_MASK, MAX9867_SHTDOWN_MASK);
-	return 0;
-}
-
 static int max9867_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_component *component = dai->component;
@@ -361,7 +350,6 @@ static int max9867_dai_set_fmt(struct snd_soc_dai *codec_dai,
 static const struct snd_soc_dai_ops max9867_dai_ops = {
 	.set_fmt = max9867_dai_set_fmt,
 	.set_sysclk	= max9867_set_dai_sysclk,
-	.prepare	= max9867_prepare,
 	.digital_mute	= max9867_mute,
 	.hw_params = max9867_dai_hw_params,
 };
@@ -392,27 +380,59 @@ static struct snd_soc_dai_driver max9867_dai[] = {
 	}
 };
 
-#ifdef CONFIG_PM_SLEEP
-static int max9867_suspend(struct device *dev)
+#ifdef CONFIG_PM
+static int max9867_suspend(struct snd_soc_component *component)
 {
-	struct max9867_priv *max9867 = dev_get_drvdata(dev);
+	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
 
-	/* Drop down to power saving mode when system is suspended */
-	regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
-		MAX9867_SHTDOWN_MASK, ~MAX9867_SHTDOWN_MASK);
 	return 0;
 }
 
-static int max9867_resume(struct device *dev)
+static int max9867_resume(struct snd_soc_component *component)
 {
-	struct max9867_priv *max9867 = dev_get_drvdata(dev);
+	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_STANDBY);
 
-	regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
-		MAX9867_SHTDOWN_MASK, MAX9867_SHTDOWN_MASK);
 	return 0;
 }
+#else
+#define max9867_suspend	NULL
+#define max9867_resume	NULL
 #endif
 
+static int max9867_set_bias_level(struct snd_soc_component *component,
+				  enum snd_soc_bias_level level)
+{
+	int err;
+	struct max9867_priv *max9867 = snd_soc_component_get_drvdata(component);
+
+	switch (level) {
+	case SND_SOC_BIAS_STANDBY:
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
+			err = regcache_sync(max9867->regmap);
+			if (err)
+				return err;
+
+			err = regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
+						 MAX9867_SHTDOWN, MAX9867_SHTDOWN);
+			if (err)
+				return err;
+		}
+		break;
+	case SND_SOC_BIAS_OFF:
+		err = regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
+					 MAX9867_SHTDOWN, 0);
+		if (err)
+			return err;
+
+		regcache_mark_dirty(max9867->regmap);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_component_driver max9867_component = {
 	.controls		= max9867_snd_controls,
 	.num_controls		= ARRAY_SIZE(max9867_snd_controls),
@@ -420,6 +440,9 @@ static const struct snd_soc_component_driver max9867_component = {
 	.num_dapm_routes	= ARRAY_SIZE(max9867_audio_map),
 	.dapm_widgets		= max9867_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(max9867_dapm_widgets),
+	.suspend		= max9867_suspend,
+	.resume			= max9867_resume,
+	.set_bias_level		= max9867_set_bias_level,
 	.idle_bias_on		= 1,
 	.use_pmdown_time	= 1,
 	.endianness		= 1,
@@ -516,15 +539,10 @@ static const struct of_device_id max9867_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, max9867_of_match);
 
-static const struct dev_pm_ops max9867_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(max9867_suspend, max9867_resume)
-};
-
 static struct i2c_driver max9867_i2c_driver = {
 	.driver = {
 		.name = "max9867",
 		.of_match_table = of_match_ptr(max9867_of_match),
-		.pm = &max9867_pm_ops,
 	},
 	.probe  = max9867_i2c_probe,
 	.id_table = max9867_i2c_id,
diff --git a/sound/soc/codecs/max9867.h b/sound/soc/codecs/max9867.h
index 55cd9976ff47..d9170850c96e 100644
--- a/sound/soc/codecs/max9867.h
+++ b/sound/soc/codecs/max9867.h
@@ -67,7 +67,7 @@
 #define MAX9867_MICCONFIG    0x15
 #define MAX9867_MODECONFIG   0x16
 #define MAX9867_PWRMAN       0x17
-#define MAX9867_SHTDOWN_MASK (1<<7)
+#define MAX9867_SHTDOWN      0x80
 #define MAX9867_REVISION     0xff
 
 #define MAX9867_CACHEREGNUM 10

> > @@ -491,19 +458,40 @@ static int max9867_i2c_probe(struct i2c_client *i2c,
> >  	}
> >  	ret = regmap_read(max9867->regmap, MAX9867_REVISION, &reg);
> >  	if (ret < 0) {
> > -		dev_err(&i2c->dev, "Failed to read: %d\n", ret);
> > +		dev_err(&i2c->dev, "Failed to read revision: %d\n", ret);
> >  		return ret;
> >  	}
> 
> This is a cosmetic change unrelated to the rest of the patch, it should
> be sent separately.

I'll drop it completely, it is probably not worth sending separately.

Thank you,
	ladis
