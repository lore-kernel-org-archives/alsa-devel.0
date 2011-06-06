From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V4 1/5] sound: asoc: Adding support for
	STA529 Audio Codec
Date: Mon, 6 Jun 2011 12:55:19 +0100
Message-ID: <20110606115519.GC8286@opensource.wolfsonmicro.com>
References: <1307339856-30656-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1307339856-30656-2-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0D622243FF
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 13:55:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307339856-30656-2-git-send-email-rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 06, 2011 at 11:27:32AM +0530, Rajeev Kumar wrote:
> This patch adds the support for STA529 audio codec.
> Details of the audio codec can be seen here:
> http://www.st.com/internet/imag_video/product/159187.jsp

As I'm fairly sure I've said before please do try to use subject lines
for your patches which are consistent with the style for the subsystem
you're submitting against.

> +struct sta529 {
> +	unsigned int sysclk;
> +	enum snd_soc_control_type control_type;
> +	void *control_data;

why do you need the control_data here?  You also don't need to pass the
control_type if the device is I2C only.

> +static const struct snd_kcontrol_new sta529_new_snd_controls[] = {
> +	SOC_ENUM("PWM Select", pwm_src_enum),
> +	SOC_ENUM("MODE Select", mode_src_enum),

MODE especially should be configured by _dai_fmt().

> +static int sta529_mute(struct snd_soc_dai *dai, int mute)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +
> +	u8 mute_reg = snd_soc_read(codec, STA529_FFXCFG0) & ~CODEC_MUTE_VAL;
> +
> +	if (mute)
> +		mute_reg |= CODEC_MUTE_VAL;
> +
> +	snd_soc_update_bits(codec, STA529_FFXCFG0, 0x80, 00);

This update completely ignores the check you've made above...

> +	/*
> +	 * store the label for powers down audio subsystem for suspend.This is
> +	 * used by soc core layer
> +	 */

You want a space after the period here.

> +static struct snd_soc_dai_driver sta529_dai = {
> +	.name = "sta529-audio",

Does the chip have non-audio funtionality?

> +	snd_soc_add_controls(codec, sta529_snd_controls,
> +			ARRAY_SIZE(sta529_snd_controls));
> +
> +	snd_soc_add_controls(codec, sta529_new_snd_controls,
> +			ARRAY_SIZE(sta529_new_snd_controls));

Like Lars-Peter said use data based init here.

> +static int sta529_resume(struct snd_soc_codec *codec)
> +{
> +	snd_soc_cache_sync(codec);
> +	sta529_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +	sta529_set_bias_level(codec, codec->dapm.suspend_bias_level);

The second set_bias_level() should be redundant - we'll always have been
shut down by the core before we get to suspending.

> +static int __init sta529_modinit(void)
> +{
> +	int ret = 0;
> +
> +	ret = i2c_add_driver(&sta529_i2c_driver);
> +	if (ret != 0)
> +		printk(KERN_ERR "Failed to reg sta529 I2C driver: %d\n", ret);

Error out if we can't load; ignoring the error only makes sense if we
have multiple bus types and another might have succeeded.
