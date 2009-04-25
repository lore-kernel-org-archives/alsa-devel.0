From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [RFC] SoC WM8940 Driver
Date: Sat, 25 Apr 2009 17:17:28 +0000
Message-ID: <49F345A8.1030901@cam.ac.uk>
References: <49F21310.4060009@cam.ac.uk> <20090425102100.GA4394@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ppsw-7.csi.cam.ac.uk (ppsw-7.csi.cam.ac.uk [131.111.8.137])
	by alsa0.perex.cz (Postfix) with ESMTP id C5144244DF
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Apr 2009 19:17:10 +0200 (CEST)
In-Reply-To: <20090425102100.GA4394@sirena.org.uk>
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

Hi Mark,

Thanks for your comments. The ones on naming are particularly helpful
as tracking down the standard choices can be tricky without reading
lots of data sheets!

I've cut the vast majority of your comments out of here as I agreed
with them (and wasn't much else to say!)

>> Initial support for the WM8940 Mono Codec with speaker driver
> 
> Overall this looks very good but there are a few things it'd be good to
> correct here.  A lot of this is due to copying from older drivers or the
> fact that you're working against an older kernel.
Not that old, (2.6.29.1) but things do seem to moving fast in here.
> 
>> + * VROI (resistance control for unused outputs.
> 
> This will be system dependant, the machine driver should configure this
> in the DAI init() function or you could let it be set by platform data.
Will do.
 
>> +static u16 wm8940_reg_defaults[] = {
>> +	[WM8940_SOFTRESET] =		0x8940,
>> +	[WM8940_POWER1] =		0x0000,
> 
> I'd really rather use the more standard ASoC style here with a simple
> table of values.  The driver relies on the fact that the register
> cache is fully specified for suspend and resume and having a straight
> table makes sure that there aren't any missing values in the cache.
Ok, though I'd place the alternate argument that it lead to rather
less readable code than this sort of syntax where it readily apparent
exactly what is in each register.

Big tables of 'magic' numbers are definitely not a good thing. If we
argue it's up to the driver writer to fill those tables in right,
then they have no inherent advantage over this syntax where it's also
up to the writer to not get it wrong.

>> +       SOC_SINGLE("Companding 8 bit", WM8940_COMPANDINGCTL, 5, 1, 0),
> 
> This should be controlled as part of the DAI format control rather than
> exposed to the user.
Ah, I'd miss understood the data sheet on this one. Didn't realize it overrides
the format.
> 
>> +	SOC_SINGLE("Digital Loopback Switch adc to dac", WM8940_COMPANDINGCTL,
>> +		   0, 1, 0),
> 
> This should be called Digital Sidetone Switch and probably ought to be a
> DAPM control - there's an ADC to DAC route.
I'll take your word for it!

> 
>> +	SOC_SINGLE_TLV("Speaker Playback Volume", WM8940_SPKVOL,
>> +		       0, 63, 0, wm8940_spk_vol_tlv),
>> +	SOC_SINGLE("Speaker Playback Mute", WM8940_SPKVOL,  6, 1, 0),
> 
> Speaker Playback Switch; this also means that the sense of the control
> needs to be inverted.  Look at the control in alsamixer and you'll see
> that it figures out that these both control the same thing and displays
> them as a single Speaker Playback control in the UI.
I wish, alsamixer isn't exactly playing ball with busy box for some reason
I haven't chased down.  Looking at this lot using amixer isn't much fun!

> 
>> +	SOC_SINGLE("Notch Filter 1 Update Switch", WM8940_NOTCH1, 15, 1, 0),
>> +	SOC_SINGLE("Notch Filter 2 Update Switch", WM8940_NOTCH3, 15, 1, 0),
>> +	SOC_SINGLE("Notch Filter 3 Update Switch", WM8940_NOTCH5, 15, 1, 0),
>> +	SOC_SINGLE("Notch Filter 4 Update Switch", WM8940_NOTCH7, 15, 1, 0),
> 
> The notch filter configuration is dependant on the sample rate so the
> driver probably ought to be exposing a control based on the cutoff
> frequency desired and then configuring the filter appropriately as the
> sample rate changes.
> 
> I'd remove the notch filter stuff for now if you're not actively using
> it.
Will do though they are something I want to have a play with down the line.
What you suggest makes sense but is going to be fiddly to get right.
 
e.
> 
>> +{
>> +	int err, i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(wm8940_snd_controls); i++) {
>> +		err = snd_ctl_add(codec->card,
>> +				snd_soc_cnew(&wm8940_snd_controls[i], codec,
>> +					NULL));
>> +		if (err < 0)
>> +			return err;
>> +	}
> 
> snd_soc_add_controls().
Ok, looks like I'm going to be moving to the topic branch you give below
anyway so this'll be available.  Might be a bit of a delay as I had a few
regressions issues with the board under 2.6.30 last time I tried it.


>> +static int wm8940_mute(struct snd_soc_dai *dai, int mute)
>> +{
>> +	struct snd_soc_codec *codec = dai->codec;
>> +	u16 mute_reg = wm8940_read_reg_cache(codec, WM8940_DAC) & 0xffbf;
>> +
>> +	return wm8940_write(codec,
>> +			    WM8940_DAC,
>> +			    mute ? mute_reg | 0x40 : mute_reg);
>> +
> 
> I'm really not a fan of the ternary operator :/
Fair enough, it seems to be an acquired taste ;)
> 
>> +	if (Ndiv > 12) {
>> +		/* FIXME: This will loose accuracy, how to deal? */
>> +		printk(KERN_WARNING "Incorrectly handled case\n");
> 
> Printing an error is fine; this all comes from the machine driver so
> it's not something we expect to ever happen at runtime except in
> development.
Sure though in this case it's in there to observe that my code is wrong
and I should fix it rather than machine driver has done something wrong ;)

I'll try and work out how to do it right before next posting! Need to lure
the board side of things into a configuration where this is relevant.
> 
>> +	case SND_SOC_BIAS_PREPARE:
>> +		/* ensure bufioen and biasen */
>> +		pwr_reg |= (1 << 2) | (1 << 3);
>> +		/* set vmid to 2.5k for fast start */
>> +		wm8940_write(codec, WM8940_POWER1, pwr_reg | 0x3);
>> +		break;
> 
> This isn't what the low resistance VMID setting is for;
I admit I didn't really understand what was going on here, so I think I cribbed
it from another driver.  What should the setting be? (and what is that setting
for?)

> 
>> +struct snd_soc_dai wm8940_dai = {
>> +	.name = "WM8940",
>> +	.playback = {
>> +		.stream_name = "Playback",
>> +		.channels_min = 1,
>> +		.channels_max = 2, /* lie - pxa-i2s has min of 2*/
> 
> What's going on here is that I2S is inhernantly stereo even if only one
> of the channels is actually being output - the CODEC is actually taking
> a stereo stream, it's just ignoring one of the channels.
Ah, fair enough.

> 
>> +	.ops = {
>> +		.hw_params = wm8940_i2s_hw_params,
>> +		.set_sysclk = wm8940_set_dai_sysclk,
>> +		.digital_mute = wm8940_mute,
>> +		.set_fmt = wm8940_set_dai_fmt,
>> +		.set_clkdiv = wm8940_set_dai_clkdiv,
>> +		.set_pll = wm8940_set_dai_pll,
>> +	},
> 
> This needs updating for current ASoC - see the topic/asoc branch of
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6
> 
> where this has been pulled out into a separate ops structure.
> 
>> +};
>> +EXPORT_SYMBOL_GPL(wm8940_dai);
> 
> You should also set the symmetric_rates flag here since the CODEC has a
> single LRCLK and therefore can't run the DAC and ADC at different rates.
> 
>> +	/* Enables the level shifters and non-vmid derived bias
>> +	 * current generator
>> +	 */
>> +	ret = wm8940_write(codec, WM8940_POWER1, 0x180);
>> +	if (ret < 0)
>> +		goto card_err;
> 
> set_bias_level() ought to be doing this.
> 
>> +static int __init wm8940_modinit(void)
>> +{
>> +	return snd_soc_register_dai(&wm8940_dai);
>> +}
>> +module_init(wm8940_modinit);
>> +
>> +static void __exit wm8940_exit(void)
>> +{
>> +	snd_soc_unregister_dai(&wm8940_dai);
>> +}
>> +module_exit(wm8940_exit);
> 
> Please take a look at the way in which drivers such as wm8988 and wm8960
> register themselves - they have been converted to use the standard
> device probing, registering the DAI once the I2C (or SPI) device has
> been probed based on normal I2C setup in the arch code.
> 
> Broadly speaking you should move everything in the startup path except
> the registration of the ALSA controls into the I2C device registration
> with the ASoC functions doing the ALSA bits once the rest of the sound
> card has registered with it.  You can see some conversions if you look
> in git history; cut'n'pasting the probe code for a converted driver will
> often get you a long way.
I'll have a go at the conversion.  I've done a fair bit of i2c stuff before
so glad to see you've moved over to this approach.

Thanks again for the comments,

Jonathan
