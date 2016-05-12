From: John Keeping <john@metanate.com>
Subject: Re: [PATCH 5/9] ASoC: es8328: Use more suitable definition for mic
 bias
Date: Thu, 12 May 2016 12:01:31 +0100
Message-ID: <20160512120131.30a91984.john@metanate.com>
References: <20160509112437.8924-1-john@metanate.com>
	<20160509112437.8924-6-john@metanate.com>
	<20160510175335.GC6261@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160510175335.GC6261@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 10 May 2016 18:53:35 +0100, Mark Brown wrote:

> On Mon, May 09, 2016 at 12:24:33PM +0100, John Keeping wrote:
> 
> > -	SND_SOC_DAPM_SUPPLY("Mic Bias", ES8328_ADCPOWER,
> > -			ES8328_ADCPOWER_MIC_BIAS_OFF, 1, NULL, 0),
> > +	SND_SOC_DAPM_MICBIAS("Mic Bias", ES8328_ADCPOWER,
> > +			ES8328_ADCPOWER_MIC_BIAS_OFF, 1),  
> 
> No, this is broken.  The specialist MICBIAS widget is legacy and should
> not be used.

OK, this can be dropped.  Would you consider doing something like the
patch below?

The only reference I can find to MICBIAS being legacy is in commit
086d7f804e26 ("ASoC: Convert WM8962 MICBIAS to a supply widget",
2011-09-23) and some following commits, there don't seem to be any
comments in the documentation indicating that it's not to be used.

-- >8 --
diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 97069466c38d..3101d53468aa 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -100,6 +100,7 @@ struct device;
 {       .id = snd_soc_dapm_mixer_named_ctl, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = wncontrols}
+/* DEPRECATED: use SND_SOC_DAPM_SUPPLY */
 #define SND_SOC_DAPM_MICBIAS(wname, wreg, wshift, winvert) \
 {	.id = snd_soc_dapm_micbias, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
@@ -473,7 +474,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_out_drv,			/* output driver */
 	snd_soc_dapm_adc,			/* analog to digital converter */
 	snd_soc_dapm_dac,			/* digital to analog converter */
-	snd_soc_dapm_micbias,		/* microphone bias (power) */
+	snd_soc_dapm_micbias,		/* microphone bias (power) - DEPRECATED: use snd_soc_dapm_supply */
 	snd_soc_dapm_mic,			/* microphone */
 	snd_soc_dapm_hp,			/* headphones */
 	snd_soc_dapm_spk,			/* speaker */
