From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 1/3] ASoC: add support for alc562[123]
	codecs
Date: Tue, 12 Oct 2010 18:16:02 +0100
Message-ID: <20101012171602.GG30933@rakim.wolfsonmicro.main>
References: <20101012094453.660938870@rtp-net.org>
	<20101012100036.605541759@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 38A8524487
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 19:16:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20101012100036.605541759@rtp-net.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, Saeed Bishara <saeed@marvell.com>, Martin Michlmayr <tbm@cyrius.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 12, 2010 at 11:44:54AM +0200, Arnaud Patard wrote:

> This patch is adding support for alc562[123] codecs. It's based
> on the source code available in HP source code and other places.

Looks very good - a few minor things below but they should be fairly
easy to fix up.

> +static int amp_mixer_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	/* index 0x46: class-d internal register */
> +	snd_soc_write(w->codec, ALC5623_HID_CTRL_INDEX, 0x46);

This is a bit magic; some comments would help.

> +	if (pll_id == ALC5623_PLL_FR_MCLK) {
> +		for (i = 0; i < ARRAY_SIZE(codec_master_pll_div); i++) {
> +			if (codec_master_pll_div[i].pll_in == freq_in
> +			   && codec_master_pll_div[i].pll_out == freq_out) {
> +				/* PLL source from MCLK */
> +				pll_div  = codec_master_pll_div[i].regvalue;
> +				break;
> +			}
> +		}
> +	} else {
> +		for (i = 0; i < ARRAY_SIZE(codec_slave_pll_div); i++) {

I'd expect a switch statement here.

> +	coeff = get_coeff(codec, rate);
> +	if (coeff >= 0) {
> +		coeff = coeff_div[coeff].regvalue;
> +		dev_dbg(codec->dev, "%s: sysclk=%d,rate=%d,coeff=0x%04x\n",
> +			__func__, alc5623->sysclk, rate, coeff);
> +		snd_soc_write(codec, ALC5623_STEREO_AD_DA_CLK_CTRL, coeff);
> +	}

Shouldn't we be returning an error if we can't get coefficients?

> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +		enable_power_depop(codec);
> +		break;

enable_power_depop() takes a rather long time - about 500ms - which is
surprising for _ON.  Are you sure it should be done here?

> +static int alc5623_suspend(struct snd_soc_codec *codec, pm_message_t mesg)
> +{
> +	/* we only need to suspend if we are a valid card */
> +	if (!codec->card)
> +		return 0;

This isn't needed any more, this won't get called if there isn't a card.

> +	/* charge alc5623 caps */
> +	if (codec->suspend_bias_level == SND_SOC_BIAS_ON) {
> +		alc5623_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +		codec->bias_level = SND_SOC_BIAS_ON;
> +		schedule_delayed_work(&codec->delayed_work,
> +			msecs_to_jiffies(caps_charge));
> +	}

Just go directly to the bias level you want, don't use delayed work.
ASoC will already do resume out of line with the main system so there's
no need to do this and it will disrupt audio operation just after resume
if you do it.

> +/*
> + * rt5623.h  --  audio driver for ALC5623
> + *

Bitrot here.
