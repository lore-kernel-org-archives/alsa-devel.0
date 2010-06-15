From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: Update on TLV320AIC3204 Driver [File 1/3]
Date: Wed, 16 Jun 2010 08:46:23 +1000
Message-ID: <20100615224622.GI7759@www.longlandclan.yi.org>
References: <20100611055512.GG23431@www.longlandclan.yi.org>
	<20100611101803.GB12436@sirena.org.uk>
	<20100615002913.GC7759@www.longlandclan.yi.org>
	<20100615142050.GH14510@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 8601B10382F
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 00:46:37 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OOeto-0004AC-K1
	for alsa-devel@alsa-project.org; Wed, 16 Jun 2010 08:46:29 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OOetk-00049X-81
	for alsa-devel@alsa-project.org; Wed, 16 Jun 2010 08:46:28 +1000
Content-Disposition: inline
In-Reply-To: <20100615142050.GH14510@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Eric B??nard <eric@eukrea.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 15, 2010 at 03:20:50PM +0100, Mark Brown wrote:
> On Tue, Jun 15, 2010 at 10:29:14AM +1000, Stuart Longland wrote:
> =

> > > Please post to the mailing list if you want review - the standard
> > > workflow is to provide comments by replying to the patch.
> =

> > Attached :- sound/soc/codecs/tlv320aic3204.c
> =

> Please post patches in the normal fashion, it's really much easier.
> =

> This looks mostly good, but a few comments below.
> =

> > #ifndef DEBUG
> > #define DEBUG
> > #endif
> =

> Hrm.

Yes, I know, it'll be gone in the patch.

> > 	if ( reg ) {
> > 		/* Refresh cache */
> =

> scripts/checkpatch.pl is your friend.

I take it this checks for coding style?  I'll have a look.

> > #if 0
> > 	dev_dbg( &codec->dev, "%s: pg %d reg %d[%04x] =3D> %02x\n",
> > 			__func__, reg >> 7, reg & 0xff, reg, value[0] );
> > #endif
> =

> Can probably just leave dev_dbg() unconditionally, it won't display in
> production builds.

Yep... at the moment I've got a couple of #ifdefs around that statement
now; basically so that certain types of debug message can be enabled.
In the initial phase when I was reading every register into cache,
having this uncommented lead to a _lot_ of data, but it was handy in the
beginning to check things were working as I expected.

I'll get rid of those now.

> > static inline int aic3204_mod( struct snd_soc_codec *codec, unsigned in=
t reg,
> > 			u8 and_mask, u8 or_mask )
> =

> snd_soc_update_bits().

Yep, I've done that in the latest revision.

> > 	 * This is a bit misleading; xshift refers to the bit one bit *past*
> > 	 * the most significant bit.  Or at least that's what it appears to be
> > 	 * doing the math.  Mask needs to select the last 6 bits; which is the
> > 	 * signed bitfield specifiying the gain in dB.
> =

> If that's the case it's buggy and should be fixed.

By the sounds of the comments made elsewhere in this thread, it could be
a case of round pegs in square holes.  My analysis of the functions
behaviour lead me to the above comment.

The dB scale comes out correct, but there is the funny overlap between
mute and volume level as per my earlier posts.

> > static const struct snd_soc_dapm_route intercon[] =3D {
> > 	/* Data Connections */
> > 	{"Left Data Out", NULL, "Left ADC"},
> > 	{"Right Data Out", NULL, "Right ADC"},
> > 	{"Left DAC", NULL, "Left Data In"},
> > 	{"Right DAC", NULL, "Right Data In"},
> > 	/* Line Output */
> =

> Some blanks in this table might not hurt.

All noted.

> > #ifndef ENABLE_PLL
> > 	/* If PLL is disabled; always bypass the PLL */
> > 	bypass_pll =3D 1;
> > #endif
> =

> If you've got the PLL working just drop the #defines, there shouldn't be
> build time configuration for things like this.  If configuration is
> needed make it an API call or platform data.

Indeed... it was used before I got the PLL working; and the PLL has been
working well lately, so I may just ditch those #ifdefs and make it the
default.

> > static int aic3204_set_bias_level(struct snd_soc_codec *codec,
> > 				enum snd_soc_bias_level level)
> > {
> > #if 0
> > 	switch (level) {
> > 		case SND_SOC_BIAS_ON:
> =

> If there's really nothing needed then no need to supply the function.

Yep, will get rid of it then.  I wasn't quite sure what it was doing, or
what was needed.  I'm undecided as to whether I should use this to power
the PLL down, or whether that'd be better done elsewhere.

I'm giving some thought to handling the bit and word clocks -- and think
since this is related, we can do something about the PLL in the same
place.

> > 	/* Reset the CODEC */
> > 	aic3204_write(codec, AIC3204_RESET, AIC3204_RESET_SOFT);
> > =

> > 	/* Read in the cache */
> > 	for( reg=3D0; reg < AIC3204_CACHEREGNUM; reg++ ) {
> > 		u8 temp;
> > 		aic3204_read( codec, reg, &temp );
> > 	}
> =

> You should be able to have a table of defaults.

Yep, I've done this in the latest version (although it's a big long
table).

Funny thing, one of the I=B2C devices on the same bus as the CODEC is a
PSoC-based sensor controller which had a polled-interrupt I=B2C slave
implementation that would stretch the clock when it was busy doing its
other tasks.  This caused the machine to appear to "lock up" at this
point -- later calculations revealed that the effective bitrate would
have meant this step would have taken about 10 minutes.  My test board
didn't have one of these devices onboard, hence the problem wasn't
noticed.

I've since used the above ifdef'd dev_dbg statement to capture the data
out of the registers after reset and did some vim voodoo to translate
that into C initialisation data in a static const array.

> > 	return aic3204_register(codec);
> > =

> > err_enable:
> > 	regulator_bulk_free(ARRAY_SIZE(aic3204->supplies), aic3204->supplies);
> =

> The split between the registration function and things like the
> regulators is a bit odd here - probably as well to just have one
> function unless you have both I2C and SPI options (in which case merge
> the GPIO and regulator stuff into register()).
> =

> > #else
> > static inline void aic3204_i2c_init(void) { }
> > static inline void aic3204_i2c_exit(void) { }
> > #endif
> =

> Not needed unless you have multiple buses.

The TLV320AIC3204 is a dual I=B2C/SPI device, if you tie one of its pins
to Vdd, it runs I=B2C, if you tie that pin to Vss, it runs SPI.

> > 	if (setup) {
> > 		struct aic3204_priv *aic3204 =3D snd_soc_codec_get_drvdata(codec);
> > =

> > 		/* Run setup script; if any */
> > 		if ( setup->init_reg_list ) {
> =

> This shouldn't be needed - if it were needed it should be part of the
> core.
> > 		/* Copy over channel information */
> > 		aic3204->channels =3D setup->channels;
> =

> Platform data?

This has all now been replaced; in the early days I had it there as a
means of setting up the CODEC, and had thought it'd be a useful way to
set custom parameters like GPIO pin functions, interrupts and filter
settings... but I knew full well that I'd have a difficult job getting
an ugly hack like that accepted into the kernel.

I've now condensed this down to what I need to get things working for
now, and made this into a platform data struct.  The channel
configuration is also obsolete now; this is set up through the mixer
interface (in the end it wasn't even being used).

Next time around there'll be a patch on its way, since it now looks as
if the driver is getting to the point where it's in viable shape to be
contributed to the Linux community proper. :-)
-- =

Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
