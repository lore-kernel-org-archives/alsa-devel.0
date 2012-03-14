From: Ola LILJA2 <ola.o.lilja@stericsson.com>
Subject: Re: [PATCH 13/16] ASoC: codecs: Add AB8500 codec-driver
Date: Wed, 14 Mar 2012 14:27:13 +0100
Message-ID: <AC3CA153830A24419D7BF22D87B39D0557F2F28251@EXDCVYMBSTM006.EQ1STM.local>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-14-git-send-email-ola.o.lilja@stericsson.com>
	<20120313224529.GL3177@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog116.obsmtp.com (eu1sys200aog116.obsmtp.com
	[207.126.144.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 005E2104274
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 14:27:31 +0100 (CET)
In-Reply-To: <20120313224529.GL3177@opensource.wolfsonmicro.com>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: den 13 mars 2012 23:45
> To: Ola LILJA2
> Cc: Liam Girdwood; alsa-devel@alsa-project.org; Linus Walleij
> Subject: Re: [PATCH 13/16] ASoC: codecs: Add AB8500 codec-driver
> 
> On Tue, Mar 13, 2012 at 04:11:40PM +0100, Ola Lilja wrote:
> 
> > +++ b/sound/soc/codecs/Kconfig
> > @@ -12,6 +12,7 @@ config SND_SOC_ALL_CODECS
> >  	tristate "Build all ASoC CODEC drivers"
> >  	select SND_SOC_88PM860X if MFD_88PM860X
> >  	select SND_SOC_L3
> > +	select SND_SOC_AB8500
> >  	select SND_SOC_AC97_CODEC if SND_SOC_AC97_BUS
> >  	select SND_SOC_AD1836 if SPI_MASTER
> >  	select SND_SOC_AD193X if SND_SOC_I2C_AND_SPI
> 
> This driver really has no dependencies?  That seems *extremely*
> surprising - have you tried building on x86?

I'll add dependencies, just missed that one.

> 
> > +
> > +ifdef CONFIG_SND_SOC_UX500_DEBUG
> > +CFLAGS_ab8500_audio.o := -DDEBUG
> > +endif
> 
> Once again if you're adding random custom stuff like this for your
> driver you shouldn't be.

I'll removed it for next patch-set.

> 
> > diff --git a/sound/soc/codecs/ab8500_audio.c
> > b/sound/soc/codecs/ab8500_audio.c
> 
> Everything else uses -codec.

Could just see one codec named with "-codec". The reason for appending _audio
Is that the AB8500 is not only audio and we already have files elsewhere named
ab8500.c but I probably could rename it to ab8500-codec.c.

> 
> > +/* AB8500 register cache */
> > +static const u8 ab8500_reg_cache[AB8500_CACHEREGNUM];
> 
> > +static enum sid_state sid_status = SID_UNCONFIGURED;
> 
> No static data or custom cache implementations.

OK, I'll move this into the private data-struct, too.

> 
> > +/* Read a register from the audio-bank of AB8500 */ static unsigned
> > +int ab8500_codec_read_reg(struct snd_soc_codec *codec, unsigned int
> > +reg) {
> > +	int status;
> > +	unsigned int value = 0;
> > +
> > +	if (reg < VIRT_REG_BASE) {
> 
> Why are you doing this virtual register stuff?  It's making the code a
> lot more complex and doesn't look at all driver specific.

There is a chain of events leading up to the decision of having it like this.
The HW is designed so that only one coefficient-register is present and when
we write a value to it the HW increases a HW-index so that the next time we write
to it the value will set the next coefficient and so on.
Also, we don't want to be able to first set all FIR/IIR-coefficients with the ALSA-controls
And when we are happy we write all the coefficients to the HW by committing them 
using the strobe-control.
Furthermore, we cannot read the coefficients from the HW, so to be able to provide this
to userspace we use the SOC_HWDEP_MULTIPLE_1R, and since these values actually is not exposed
as separate registers we use a set of virtual register. When we commit the coefficients
we then take the values from the virtual registers and write them down to the HW in a loop.

> 
> > +		} else {
> > +			dev_dbg(codec->dev, "%s: Read 0x%02x
> from register 0x%02x:0x%02x\n",
> > +				__func__, value8,
> (u8)AB8500_AUDIO, (u8)reg);
> 
> There's already *plenty* of trace for register I/O in the framework.
> 
> > +static const char * const enum_ena_dis[] = {"Enabled", "Disabled"};
> > +static const char * const enum_dis_ena[] = {"Disabled", "Enabled"};
> 
> Why are the controls using these enums and not Switch controls?  UIs
> know how to display switches.

We need to make the switches virtual, as we don't want them to actually set any bits,
just break or complete a DAPM-chain. That is why we made the as MUX:es.

> 
> > +/* Earpiece - Mute */
> > +static const struct snd_kcontrol_new dapm_ear_mute[] = {
> > +	SOC_DAPM_SINGLE("Playback Switch", REG_MUTECONF,
> > +REG_MUTECONF_MUTEAR, 1, 1), };
> 
> This looks like it's just a mute rather than a mixer input enable
> (there's only one control...) so should be a regular sound control;
> unless there's a very good reason mutes other than mixer inputs
> normally don't affect the audio path as you might get pops and you
> probably don't want to do things like stop clocking just because the
> output is silenced.  Similar thing applies in several other places.

Most of the mutes need to be apart of the DAPM-chain to actually prevent
click-n-pops. So it cannot be used by the user as a normal ALSA-control.
Muting can be done by setting certain gains to -inf.

> 
> > +/* Earpiece source selector */
> > +static const char * const enum_ear_lineout_source[] = {"Headset
> > +Left", "IHF Left"}; static
> SOC_ENUM_SINGLE_DECL(dapm_enum_ear_lineout_source, REG_DMICFILTCONF,
> > +			REG_DMICFILTCONF_DA3TOEAR,
> enum_ear_lineout_source); static const
> > +struct snd_kcontrol_new dapm_ear_lineout_source =
> > +	SOC_DAPM_ENUM("Earpiece or LineOut Mono Source",
> > +dapm_enum_ear_lineout_source);
> 
> This control can probably have a much better name...
> 
> > +/* IHF - Enable/Disable */
> > +static const struct soc_enum enum_ihf_left = SOC_ENUM_SINGLE(0, 0,
> 2,
> > +enum_dis_ena);
> 
> 80 columns please.

Ugh...

> 
> > +/* from -31 to 31 dB in 1 dB steps (mute instead of -32 dB) */
> static
> > +DECLARE_TLV_DB_SCALE(adx_dig_gain_tlv, -3200, 100, 1);
> 
> I'm really not a big fan of this sort of comment, adds greatly to the
> verbosity but just duplicates the code.

OK.

> 
> > +static const char * const enum_earselcm[] = {"0.95V", "1.10V",
> > +"1.27V", "1.58V"}; static SOC_ENUM_SINGLE_DECL(soc_enum_earselcm,
> > +	REG_ANACONF1, REG_ANACONF1_EARSELCM, enum_earselcm);
> 
> Should this really be configured by the application layer and not
> platform data?

We might be able to move this from user control.

> 
> > +/* Digital interface - DA from slot mapping */ static const char *
> > +const enum_da_from_slot_map[] = {"SLOT0",
> > +					"SLOT1",
> 
> Indentation.  Also are you sure that this isn't DAPM stuff?
> 
> > +	SOC_ENUM("Earpiece DAC Low Power Playback Switch",
> > +		soc_enum_eardaclowpow),
> 
> These aren't switches, they're enums.  Switches are strictly boolean
> things with values 0 and 1.

OK, I'll remove the Playback Switch postfix.

> 
> > +	snd_soc_update_bits(codec,
> > +			REG_DIGIFCONF3,
> > +			BMASK(REG_DIGIFCONF3_IF1MASTER),
> > +			BMASK(REG_DIGIFCONF3_IF1MASTER));
> 
> You're unconditionally setting these bits?

The IF1 is hardwired to a chip only running as slave, but I'll fix it so that
it actually reflect the fmt set from the machine-driver.

> 
> > +	snd_soc_update_bits(codec, REG_DIGIFCONF4, clr_mask,
> set_mask);
> 
> Either clr_mask and set_mask are misnamed or this doesn't do what you
> think it does.  The bits specified by the third argument are set to the
> values given in the fourth argument.  It looks like the code thinks
> that the bits in the third argument will be cleared and the bits in the
> fourth argument will be set.

When we removed the caching-functions from last patch-set, we replaced our
previous update-function with snd_soc_update_bits. Our function did exactly
one clear and then one set. In most of our cases this will result in the
same result as first masking the third argument, setting the fourth argument.
So, I will rename the variables to better match the arguments of snd_soc_update_bits.

> 
> > +static int ab8500_codec_set_word_length_if1(struct snd_soc_codec
> > +*codec, unsigned int wl) {
> 
> Just inline stuff like this.

OK.

> 
> > +static int ab8500_codec_set_bit_delay_if1(struct snd_soc_codec
> > +*codec, unsigned int delay)
> 
> This too.

OK.

> 
> > +/* Configures audio macrocell into the AB8500 Chip */ static int
> > +ab8500_codec_configure_audio_macrocell(struct snd_soc_codec *codec)
> {
> > +	u8 value8;
> > +	unsigned int value;
> > +	int status;
> > +
> > +	status = ab8500_sysctrl_write(AB8500_STW4500CTRL3,
> > +		AB8500_STW4500CTRL3_CLK32KOUT2DIS |
> AB8500_STW4500CTRL3_RESETAUDN,
> > +		AB8500_STW4500CTRL3_RESETAUDN);
> > +	if (status < 0)
> > +		return status;
> 
> You're just unconditionally setting these values - shouldn't they be
> platform data?
> 
> > +static int ab8500_codec_add_widgets(struct snd_soc_codec *codec) {
> > +	int status;
> > +
> > +	status = snd_soc_dapm_new_controls(&codec->dapm,
> ab8500_dapm_widgets,
> > +			ARRAY_SIZE(ab8500_dapm_widgets));
> 
> Just point at the tables from the snd_soc_codec and remove all this
> code.

OK.

> 
> > +static int ab8500_codec_pcm_hw_params(struct snd_pcm_substream
> *substream,
> > +		struct snd_pcm_hw_params *hw_params, struct
> snd_soc_dai *dai) {
> > +	dev_dbg(dai->codec->dev, "%s Enter.\n", __func__);
> > +
> > +	return 0;
> > +}
> 
> Remove all empty functions.

OK.

> > +
> > +struct snd_soc_dai_driver ab8500_codec_dai[] = {
> > +	{
> > +		.name = "ab8500-codec-dai.0",
> > +		.id = 0,
> > +		.playback = {
> > +			.stream_name = "ab8500_0p",
> 
> You should hook up the links to the widgets using DAPM routes,
> currently you're using the implicitly created routes from the stream
> name which is still supported but isn't best practice.
> 
> > +static int ab8500_codec_remove(struct snd_soc_codec *codec) {
> > +	dev_dbg(codec->dev, "%s Enter.\n", __func__);
> > +
> > +	snd_soc_dapm_free(&codec->dapm);
> 
> Why are you doing this?
> 
> > +	/* Create register cache */
> > +	ab8500_codec_driver.reg_cache_size = AB8500_LAST_REG -
> AB8500_FIRST_REG;
> > +	ab8500_codec_driver.reg_cache_default =
> > +		kzalloc(ab8500_codec_driver.reg_cache_size *
> sizeof(u8),
> > +GFP_KERNEL);
> 
> The driver struct should be constant, the stuff you're initialising it
> with here is compile time constant - why are you doing this dynamically
> at runtime/
> 
> > +
> > +	/* Create driver private-data struct */
> > +	drvdata = kzalloc(sizeof(struct ab8500_codec_drvdata),
> GFP_KERNEL);
> 
> Anything you do alloc should be devm_kzalloc().

OK.

> 
> > +	struct ab8500_codec_drvdata *drvdata =
> dev_get_drvdata(&pdev->dev);
> > +
> > +	dev_info(&pdev->dev, "%s Enter.\n", __func__);
> > +
> > +	kfree(ab8500_codec_driver.reg_cache_default);
> > +
> > +	kfree(drvdata->virt_reg_cache);
> > +	kfree(drvdata);
> > +
> > +	snd_soc_unregister_codec(&pdev->dev);
> 
> This would avoid issues like this where you free the data the device
> uses before you free the device.
> 
> > +static int __devinit ab8500_codec_platform_driver_init(void)
> 
> module_platform_driver.

OK.

> 
> > +/* Extended interface for codec-driver */
> > +
> > +int ab8500_audio_power_control(struct snd_soc_codec *codec, bool
> > +power_on); int ab8500_audio_set_word_length(struct snd_soc_dai *dai,
> > +unsigned int wl); int ab8500_audio_set_bit_delay(struct snd_soc_dai
> > +*dai, unsigned int delay); int ab8500_audio_setup_if1(struct
> snd_soc_codec *codec,
> > +			unsigned int fmt,
> > +			unsigned int wl,
> > +			unsigned int delay);
> > +void ab8500_audio_anc_configure(struct snd_soc_codec *codec,
> > +			bool apply_fir, bool apply_iir);
> 
> No, you shouldn't be exporting this stuff - it all looks like basic
> framework stuff.

Hmm.. ok... the power_control is needed for reasons explained before (vibra-driver and
Accessory-detection-magic), but I guess I have to remove these features for now and
I can then remove this export.

> 
> > +/* Virtual register base
> > + * This address should be located above any physical register used
> by ASoC.
> > + * It is used to map virtual registers needed by the codec-driver.
> > + */
> > +#define VIRT_REG_BASE				0x3000
> 
> Why are you doing this virtual register stuff?

See previous answer.

> 
> > +#define REG_DAPATHCONF_ENDACHSL			5
> 
> All these constants need to be driver local or namespaced (preferrably
> namespaced whatever).

OK, will add some suitable prefix instead of REG_.
