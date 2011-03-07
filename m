From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add MAX9850 codec driver
Date: Mon, 7 Mar 2011 15:15:36 +0000
Message-ID: <20110307151536.GG1829@sirena.org.uk>
References: <1299501913-3772-1-git-send-email-christian.glindkamp@taskit.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D4C62447B
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 16:15:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1299501913-3772-1-git-send-email-christian.glindkamp@taskit.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christian Glindkamp <christian.glindkamp@taskit.de>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 07, 2011 at 01:45:13PM +0100, Christian Glindkamp wrote:

> I've all ready sent this patch some time ago, but it hung in the moderation
> queue. This is a slightly modified version. Unfortunately I do not have the
> hardware anymore to test suggested changes that alter function.

As mentioned in SubmittingPatches you should always CC maintainers on
patches.  This will bypass things like list moderation and also helps
ensure that people see your mail on busy mailing lists.

Overall this looks pretty good.

> +static const struct snd_kcontrol_new max9850_controls[] = {
> +SOC_SINGLE_TLV("Headphone Volume", MAX9850_VOLUME, 0, 0x3f, 1, max9850_tlv),
> +SOC_SINGLE("Headphone Switch", MAX9850_VOLUME, 7, 1, 1),
> +SOC_SINGLE("Mono", MAX9850_GENERAL_PURPOSE, 2, 1, 0),

...Switch.

> +	/* lrclk_div = 2^22 * rate / iclk with iclk = mclk / sf */
> +	sf = (snd_soc_read(codec, MAX9850_CLOCK) >> 2) + 1;
> +	lrclk_div = (1 << 22);
> +	lrclk_div *= params_rate(params);
> +	lrclk_div *= sf;
> +	do_div(lrclk_div, max9850->sysclk);

Should check that sysclk() has been set and return an error if not
before doing the division here.

> +	da = snd_soc_read(codec, MAX9850_DIGITAL_AUDIO);
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		break;
> +	case SNDRV_PCM_FORMAT_S20_3LE:
> +		da |= 0x2;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		da |= 0x3;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	snd_soc_write(codec, MAX9850_DIGITAL_AUDIO, da);

Use snd_soc_update_bits() here.  The above doesn't clear any of the
bits so if 20 or 24 bit is set they'll get latched.

> +static int max9850_set_bias_level(struct snd_soc_codec *codec,
> +				  enum snd_soc_bias_level level)
> +{
> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		break;
> +	case SND_SOC_BIAS_PREPARE:
> +		snd_soc_update_bits(codec, MAX9850_ENABLE, MAX9850_SHDN,
> +				MAX9850_SHDN);
> +		break;
> +	case SND_SOC_BIAS_STANDBY:
> +		snd_soc_update_bits(codec, MAX9850_ENABLE, MAX9850_SHDN, 0);
> +		break;
> +	case SND_SOC_BIAS_OFF:
> +		break;

This pattern looks awfully like you should set idle_bias_off for the
CODEC and then move the code blocks down one power level - _SHDN sounds
like a general power down for the device which fits better with the _OFF
state.

Or use DAPM like Dimitris suggested.

> +	/* enable charge pump, disable everything else */
> +	snd_soc_write(codec, MAX9850_ENABLE, 0x30);

This sounds like it should be in either bias management or DAPM.

> +	/* enable slew-rate control */
> +	snd_soc_update_bits(codec, MAX9850_VOLUME, 0x40, 0x40);
> +	/* set slew-rate 125ms */
> +	snd_soc_update_bits(codec, MAX9850_CHARGE_PUMP, 0xff, 0xc0);

If this is for the charge pump this is fine but the _VOLUME makes it
sound like this should perhaps be user visibile?

> +static int max9850_remove(struct snd_soc_codec *codec)
> +{
> +	return 0;
> +}

Just delete this if not required, all ASoC functions should be optional.
