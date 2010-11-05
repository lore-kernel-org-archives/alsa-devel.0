From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WM8770: Initial driver
Date: Fri, 5 Nov 2010 13:21:01 -0400
Message-ID: <20101105172101.GB25977@opensource.wolfsonmicro.com>
References: <1288971105-11297-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 152C4103953
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 18:20:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1288971105-11297-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 05, 2010 at 03:31:45PM +0000, Dimitris Papastamos wrote:

> +	SND_SOC_DAPM_MIXER_E("VOUT1 Mixer", SND_SOC_NOPM, 0, 0,
> +		vout1_mix_controls, ARRAY_SIZE(vout1_mix_controls),
> +		vout12mixer_event, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
> +	SND_SOC_DAPM_MIXER_E("VOUT2 Mixer", SND_SOC_NOPM, 0, 0,
> +		vout2_mix_controls, ARRAY_SIZE(vout2_mix_controls),
> +		vout12mixer_event, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),

Both of these use this event:

> +static int vout12mixer_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec;
> +
> +	codec = w->codec;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		snd_soc_update_bits(codec, WM8770_OUTMUX1, 0x180, 0);
> +		break;
> +	case SND_SOC_DAPM_PRE_PMD:
> +		snd_soc_update_bits(codec, WM8770_OUTMUX1, 0x180, 0x180);
> +		break;
> +	}

If one widget is powered down while the other is kept active then this
will power down both which probably isn't what was wanted.  This can be
handled by attaching the event to a _SUPPLY widget which feeds into both
mixers, or by explicit reference counting in the event.
