From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] tlv320aic3x: headset/button press support
Date: Tue, 2 Dec 2008 17:37:54 +0100
Message-ID: <20081202163754.GA29550@buzzloop.caiaq.de>
References: <20081126220742.GA24648@buzzloop.caiaq.de>
	<20081127114951.GA3933@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 665571037E3
	for <alsa-devel@alsa-project.org>; Tue,  2 Dec 2008 17:37:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081127114951.GA3933@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 27, 2008 at 11:50:21AM +0000, Mark Brown wrote:
> > +void aic3x_set_headset_detection(struct snd_soc_codec *codec, int val)
> > +{
> > +	u8 reg_a = val & 0xff;
> > +	if (reg_a & (3 << 5))
> > +		reg_a |= 0x80;
> 
> This is a little obscure...  Why are you munging the set value like
> this?  Replacing (3 << 5) with the constants from the header may help.
> Looking at the defines below I can't help but think that it'd be clearer
> to pass in three parameters - what to detect and the two debounce times.

Ok, done in the new patch. There is one bit (0x80) which needs to be set
if any of 0x60 is given, hence the bit banging.

> >  int aic3x_headset_detected(struct snd_soc_codec *codec)
> >  {
> >  	u8 val;
> > -	aic3x_read(codec, AIC3X_RT_IRQ_FLAGS_REG, &val);
> > -	return (val >> 2) & 1;
> > +	aic3x_read(codec, AIC3X_HEADSET_DETECT_CTRL_B, &val);
> > +	return (val >> 4) & 1;
> >  }
> >  EXPORT_SYMBOL_GPL(aic3x_headset_detected);
> 
> How is the interrupt deasserted?  Are you sure that the interrupt will
> be cleared if you don't read the interrupt flags register? 

Seems to be, as it works for our device here. The point is that headset
insertions/removals do not neccessarily cause an interrupt, so the bit
in the flags registers won't be set. One good example is the power-up
condition where no event will be triggered but you still want to know
whether there is anything in the jack.

> > +#define AIC3X_HEADSET_DETECT_OFF	(0 << 5)
> > +#define AIC3X_HEADSET_DETECT_STEREO	(1 << 5)
> > +#define AIC3X_HEADSET_DETECT_CELLULAR	(2 << 5)
> > +#define AIC3X_HEADSET_DETECT_BOTH	(3 << 5)
> 
> What exactly is CELLULAR?  A headset?

There is different types of headsets supported by this chip (see page 42
of the datasheet), and this bits define which types the detection should
be enabled for.

Best regards,
Daniel

---

- Add aic3x_set_headset_detection() function to define the headset detection
  mode for tlv32aic3x chips
- added aic3x_button_pressed()
- Read from the real-time registers in aic3x_headset_detected() to query
  headset presence without an occured interrupt

Signed-off-by: Daniel Mack <daniel@caiaq.de>

 tlv320aic3x.c |   31 +++++++++++++++++++++++++++++--
 tlv320aic3x.h |   40 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 3 deletions(-)


diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 2047c66..537bbbf 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1017,14 +1017,41 @@ int aic3x_get_gpio(struct snd_soc_codec *codec, int gpio)
 }
 EXPORT_SYMBOL_GPL(aic3x_get_gpio);
 
+void aic3x_set_headset_detection(struct snd_soc_codec *codec, int detect,
+				 int headset_debounce, int button_debounce)
+{
+	u8 val;
+
+	val = ((detect & AIC3X_HEADSET_DETECT_MASK)
+		<< AIC3X_HEADSET_DETECT_SHIFT) |
+	      ((headset_debounce & AIC3X_HEADSET_DEBOUNCE_MASK)
+		<< AIC3X_HEADSET_DEBOUNCE_SHIFT) |
+	      ((button_debounce & AIC3X_BUTTON_DEBOUNCE_MASK)
+		<< AIC3X_BUTTON_DEBOUNCE_SHIFT);
+
+	if (detect & AIC3X_HEADSET_DETECT_MASK)
+		val |= AIC3X_HEADSET_DETECT_ENABLED;
+
+	aic3x_write(codec, AIC3X_HEADSET_DETECT_CTRL_A, val);
+}
+EXPORT_SYMBOL_GPL(aic3x_set_headset_detection);
+
 int aic3x_headset_detected(struct snd_soc_codec *codec)
 {
 	u8 val;
-	aic3x_read(codec, AIC3X_RT_IRQ_FLAGS_REG, &val);
-	return (val >> 2) & 1;
+	aic3x_read(codec, AIC3X_HEADSET_DETECT_CTRL_B, &val);
+	return (val >> 4) & 1;
 }
 EXPORT_SYMBOL_GPL(aic3x_headset_detected);
 
+int aic3x_button_pressed(struct snd_soc_codec *codec)
+{
+	u8 val;
+	aic3x_read(codec, AIC3X_HEADSET_DETECT_CTRL_B, &val);
+	return (val >> 5) & 1;
+}
+EXPORT_SYMBOL_GPL(aic3x_button_pressed);
+
 #define AIC3X_RATES	SNDRV_PCM_RATE_8000_96000
 #define AIC3X_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index 7e982ac..d6736c0 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -39,7 +39,9 @@
 #define AIC3X_OVRF_STATUS_AND_PLLR_REG	11
 /* Audio codec digital filter control register */
 #define AIC3X_CODEC_DFILT_CTRL		12
-
+/* Headset/button press detection register */
+#define AIC3X_HEADSET_DETECT_CTRL_A	13
+#define AIC3X_HEADSET_DETECT_CTRL_B	14
 /* ADC PGA Gain control registers */
 #define LADC_VOL			15
 #define RADC_VOL			16
@@ -233,7 +235,43 @@ enum {
 
 void aic3x_set_gpio(struct snd_soc_codec *codec, int gpio, int state);
 int aic3x_get_gpio(struct snd_soc_codec *codec, int gpio);
+
+/* headset detection / button API */
+enum {
+	AIC3X_HEADSET_DETECT_OFF	= 0,
+	AIC3X_HEADSET_DETECT_STEREO	= 1,
+	AIC3X_HEADSET_DETECT_CELLULAR   = 2,
+	AIC3X_HEADSET_DETECT_BOTH	= 3
+};
+
+enum {
+	AIC3X_HEADSET_DEBOUNCE_16MS	= 0,
+	AIC3X_HEADSET_DEBOUNCE_32MS	= 1,
+	AIC3X_HEADSET_DEBOUNCE_64MS	= 2,
+	AIC3X_HEADSET_DEBOUNCE_128MS	= 3,
+	AIC3X_HEADSET_DEBOUNCE_256MS	= 4,
+	AIC3X_HEADSET_DEBOUNCE_512MS	= 5
+};
+
+enum {
+	AIC3X_BUTTON_DEBOUNCE_0MS	= 0,
+	AIC3X_BUTTON_DEBOUNCE_8MS	= 1,
+	AIC3X_BUTTON_DEBOUNCE_16MS	= 2,
+	AIC3X_BUTTON_DEBOUNCE_32MS	= 3
+};
+
+#define AIC3X_HEADSET_DETECT_ENABLED	0x80
+#define AIC3X_HEADSET_DETECT_SHIFT	5
+#define AIC3X_HEADSET_DETECT_MASK	3
+#define AIC3X_HEADSET_DEBOUNCE_SHIFT	2
+#define AIC3X_HEADSET_DEBOUNCE_MASK	7
+#define AIC3X_BUTTON_DEBOUNCE_SHIFT 	0
+#define AIC3X_BUTTON_DEBOUNCE_MASK	3
+
+void aic3x_set_headset_detection(struct snd_soc_codec *codec, int detect,
+				 int headset_debounce, int button_debounce);
 int aic3x_headset_detected(struct snd_soc_codec *codec);
+int aic3x_button_pressed(struct snd_soc_codec *codec);
 
 struct aic3x_setup_data {
 	int i2c_bus;
