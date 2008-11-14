From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH RESEND 0/2] ALSA SOC driver for uda134x
	codec
Date: Fri, 14 Nov 2008 10:55:21 +0000
Message-ID: <20081114105521.GD21573@sirena.org.uk>
References: <1226590890496-git-send-email-chripell@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B300210381B
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 11:55:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1226590890496-git-send-email-chripell@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christian Pellegrin <chripell@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk, Christian Pellegrin <chripell@fsfe.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 13, 2008 at 04:41:30PM +0100, Christian Pellegrin wrote:

> This patch adds support for the UDA1341 codec. It is *heavily* based
> on the one made by Zoltan Devai but:
> 
> since the UDA is the only use of the L3 protocol I can find I just
> embedded a stripped-down L3 bit-banging algorithm from the original
> RMK work. It is really small.
> 
> Generated on  20081113  against f7e1798a78a30bae1cf3ebc3e1b6f7c1bac57756

A couple of minor procedural points:
 - Normally the patches in a series are numbered starting from 1 with
   mail 0 being a cover letter ("This series does..." or similar).
 - Information like the "Generated on" should go after the --- with the
   diffstat so that it doesn't go in the commit message.

> +++ b/include/sound/uda134x.h

> +extern struct snd_soc_dai uda134x_dai;
> +extern struct snd_soc_codec_device soc_codec_dev_uda134x;

At least this should be in a header sound/soc/codecs - as I said
previously that is the idiom used by codec drivers.  However...

> +struct uda134x_platform_data {
> +	struct l3_pins l3;
> +	void (*power) (int);
> +	int model;
> +#define UDA134X_UDA1340 0
> +#define UDA134X_UDA1341 1
> +#define UDA134X_UDA1344 2
> +};

...putting this in a separate file in include/sound is a good idea.

Is having UDA1340 as zero a good idea - that'll mean that if someone
forgets to initialise the model it'll come out as UDA1340?  It might be
better to start the model numbers from 1 so that it'll be obvious if
that happens.  Might also be an idea to use an enum rather than the
series of #defines?

> +config SND_SOC_UDA134X
> +       tristate
> +       select SND_SOC_L3
> +

Note that the select here won't actually do any good but it's useful for
documentation.

> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index 3b9b58a..9af993e 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -8,6 +8,8 @@ snd-soc-tlv320aic23-objs := tlv320aic23.o
>  snd-soc-tlv320aic26-objs := tlv320aic26.o
>  snd-soc-tlv320aic3x-objs := tlv320aic3x.o
>  snd-soc-twl4030-objs := twl4030.o
> +snd-soc-l3-objs := l3.o
> +snd-soc-uda134x-objs := uda134x.o

Please keep this and the other build stuff sorted (it helps merges).

> +	if (reg >= UDA134X_REGS_NUM) {
> +		printk(KERN_ERR "%s unkown register: reg: %d",
> +		       __func__, reg);

Could use pr_error() here and elsewhere but doesn't make much difference
either way - up to you.

> +static int uda134x_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_device *socdev = rtd->socdev;
> +	struct snd_soc_codec *codec = socdev->codec;
> +	struct uda134x_priv *uda134x = codec->private_data;
> +	struct snd_pcm_runtime *master_runtime;
> +
> +	if (uda134x->master_substream) {
> +		master_runtime = uda134x->master_substream->runtime;
> +
> +		pr_debug("%s costrining to %d bits at %d\n", __func__,

constraining.

> +static int uda134x_set_bias_level(struct snd_soc_codec *codec,
> +				  enum snd_soc_bias_level level)
> +{
> +	u8 reg;
> +	struct uda134x_platform_data *pd = codec->control_data;
> +	int i;
> +	u8 *cache = codec->reg_cache;
> +
> +	pr_debug("%s bias level %d\n", __func__, level);
> +
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		/* power on */
> +		if (pd->power)
> +			pd->power(1);
> +		/* Sync reg_cache with the hardware */
> +		for (i = 0; i < ARRAY_SIZE(uda134x_reg); i++)
> +			codec->write(codec, i, *cache++);
> +		/* ADC, DAC on */
> +		reg = uda134x_read_reg_cache(codec, UDA134X_STATUS1);
> +		uda134x_write(codec, UDA134X_STATUS1, reg | 0x03);
> +		break;

This should probably be done when going into SND_SOC_BIAS_STANDBY or at
least _PREPARE.  The codec will be brought up to _ON whenever a playback
or record is active, spending most of the rest of the time at _STANDBY.
The result will be that you're syncing the register cache to the codec
every time playback starts, even if the codec is already on.  _ON is
expected to be very quick.

It might be worth implementing DAPM for the ADC and DAC power - the
savings are probably very small but it should be very straightforward to
implement.  Not essential, though - doing it in bias_level() is also OK.

> +EXPORT_SYMBOL(uda134x_dai);

Note that since ASoC core is all EXPORT_SYMBOL_GPL() it'll be difficult
for anyone to actually use this from non-GPLed code.

> +	pd = codec_setup_data;
> +	switch (pd->model) {
> +	case UDA134X_UDA1340:
> +	case UDA134X_UDA1341:
> +	case UDA134X_UDA1344:
> +		break;
> +	default:
> +		printk(KERN_ERR "UDA134X SoC codec: "
> +		       "unsupported model\n");
> +		return -EINVAL;

Probably worth printing out what the model was set to if it's not
recognised.

> +struct snd_soc_codec_device soc_codec_dev_uda134x = {
> +	.probe =        uda134x_soc_probe,
> +	.remove =       uda134x_soc_remove,
> +#if defined(CONFIG_PM)
> +	.suspend =      uda134x_soc_suspend,
> +	.resume =       uda134x_soc_resume,
> +#else
> +	.suspend =      NULL,
> +	.resume =       NULL,
> +#endif /* CONFIG_PM */

The #else should be with the definition of the functions so there's no
need for a conditional here.
