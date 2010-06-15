From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Update on TLV320AIC3204 Driver [File 1/3]
Date: Tue, 15 Jun 2010 15:20:50 +0100
Message-ID: <20100615142050.GH14510@rakim.wolfsonmicro.main>
References: <20100611055512.GG23431@www.longlandclan.yi.org>
	<20100611101803.GB12436@sirena.org.uk>
	<20100615002913.GC7759@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 63C131038B3
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jun 2010 16:20:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100615002913.GC7759@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Eric B??nard <eric@eukrea.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 15, 2010 at 10:29:14AM +1000, Stuart Longland wrote:

> > Please post to the mailing list if you want review - the standard
> > workflow is to provide comments by replying to the patch.

> Attached :- sound/soc/codecs/tlv320aic3204.c

Please post patches in the normal fashion, it's really much easier.

This looks mostly good, but a few comments below.

> #ifndef DEBUG
> #define DEBUG
> #endif

Hrm.

> 	if ( reg ) {
> 		/* Refresh cache */

scripts/checkpatch.pl is your friend.

> #if 0
> 	dev_dbg( &codec->dev, "%s: pg %d reg %d[%04x] => %02x\n",
> 			__func__, reg >> 7, reg & 0xff, reg, value[0] );
> #endif

Can probably just leave dev_dbg() unconditionally, it won't display in
production builds.

> static inline int aic3204_mod( struct snd_soc_codec *codec, unsigned int reg,
> 			u8 and_mask, u8 or_mask )

snd_soc_update_bits().

> 	 * This is a bit misleading; xshift refers to the bit one bit *past*
> 	 * the most significant bit.  Or at least that's what it appears to be
> 	 * doing the math.  Mask needs to select the last 6 bits; which is the
> 	 * signed bitfield specifiying the gain in dB.

If that's the case it's buggy and should be fixed.

> static const struct snd_soc_dapm_route intercon[] = {
> 	/* Data Connections */
> 	{"Left Data Out", NULL, "Left ADC"},
> 	{"Right Data Out", NULL, "Right ADC"},
> 	{"Left DAC", NULL, "Left Data In"},
> 	{"Right DAC", NULL, "Right Data In"},
> 	/* Line Output */

Some blanks in this table might not hurt.

> #ifndef ENABLE_PLL
> 	/* If PLL is disabled; always bypass the PLL */
> 	bypass_pll = 1;
> #endif

If you've got the PLL working just drop the #defines, there shouldn't be
build time configuration for things like this.  If configuration is
needed make it an API call or platform data.


> static int aic3204_set_bias_level(struct snd_soc_codec *codec,
> 				enum snd_soc_bias_level level)
> {
> #if 0
> 	switch (level) {
> 		case SND_SOC_BIAS_ON:

If there's really nothing needed then no need to supply the function.

> 	/* Reset the CODEC */
> 	aic3204_write(codec, AIC3204_RESET, AIC3204_RESET_SOFT);
> 
> 	/* Read in the cache */
> 	for( reg=0; reg < AIC3204_CACHEREGNUM; reg++ ) {
> 		u8 temp;
> 		aic3204_read( codec, reg, &temp );
> 	}

You should be able to have a table of defaults.

> 	return aic3204_register(codec);
> 
> err_enable:
> 	regulator_bulk_free(ARRAY_SIZE(aic3204->supplies), aic3204->supplies);

The split between the registration function and things like the
regulators is a bit odd here - probably as well to just have one
function unless you have both I2C and SPI options (in which case merge
the GPIO and regulator stuff into register()).

> #else
> static inline void aic3204_i2c_init(void) { }
> static inline void aic3204_i2c_exit(void) { }
> #endif

Not needed unless you have multiple buses.

> 	if (setup) {
> 		struct aic3204_priv *aic3204 = snd_soc_codec_get_drvdata(codec);
> 
> 		/* Run setup script; if any */
> 		if ( setup->init_reg_list ) {

This shouldn't be needed - if it were needed it should be part of the
core.

> 		/* Copy over channel information */
> 		aic3204->channels = setup->channels;

Platform data?
