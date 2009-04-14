From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/2] ASoC: omap-mcbsp: Correct the DSP_B
	mode
Date: Tue, 14 Apr 2009 14:56:49 +0300
Message-ID: <200904141456.49897.peter.ujfalusi@nokia.com>
References: <1239695131-30367-1-git-send-email-peter.ujfalusi@nokia.com>
	<200904141334.33497.peter.ujfalusi@nokia.com>
	<20090414142004.fee14e30.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BAAC10383E
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 13:57:20 +0200 (CEST)
In-Reply-To: <20090414142004.fee14e30.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ext Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 14 April 2009 14:20:04 Nikula Jarkko (Nokia-D/Helsinki) wrote:
> On Tue, 14 Apr 2009 12:34:33 +0200
>
> I meant something like this below integrating your FWID(0) and temp_fmt
> from my earlier commit da6320becf31c40b60d4b1dc6b339c9a766b671c so that
> SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF will produce correct format.
>
> I tested this only with Beagle McBSP3 and oscilloscope but I like to veri=
fy
> it with real codecs as well :-)
>
>
> Jarkko
>
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index d6882be..c40ea21 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -272,7 +272,7 @@ static int omap_mcbsp_dai_hw_params(struct
> snd_pcm_substream *substream, break;
>  	case SND_SOC_DAIFMT_DSP_B:
>  		regs->srgr2	|=3D FPER(wlen * channels - 1);
> -		regs->srgr1	|=3D FWID(wlen * channels - 2);
> +		regs->srgr1	|=3D FWID(0);
>  		break;
>  	}
>
> @@ -291,6 +291,7 @@ static int omap_mcbsp_dai_set_dai_fmt(struct
> snd_soc_dai *cpu_dai, {
>  	struct omap_mcbsp_data *mcbsp_data =3D to_mcbsp(cpu_dai->private_data);
>  	struct omap_mcbsp_reg_cfg *regs =3D &mcbsp_data->regs;
> +	unsigned int temp_fmt =3D fmt;
>
>  	if (mcbsp_data->configured)
>  		return 0;
> @@ -317,6 +318,8 @@ static int omap_mcbsp_dai_set_dai_fmt(struct
> snd_soc_dai *cpu_dai, /* 0-bit data delay */
>  		regs->rcr2      |=3D RDATDLY(0);
>  		regs->xcr2      |=3D XDATDLY(0);
> +		/* Invert bit clock and FS polarity configuration */
> +		temp_fmt ^=3D SND_SOC_DAIFMT_IB_IF;
>  		break;
>  	default:
>  		/* Unsupported data format */
> @@ -340,7 +343,7 @@ static int omap_mcbsp_dai_set_dai_fmt(struct
> snd_soc_dai *cpu_dai, }
>
>  	/* Set bit clock (CLKX/CLKR) and FS polarities */
> -	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	switch (temp_fmt & SND_SOC_DAIFMT_INV_MASK) {
>  	case SND_SOC_DAIFMT_NB_NF:
>  		/*
>  		 * Normal BCLK + FS.

In case of the osk5912 board with tlv320aic32 codec, than you need to =

configure it like this?

snd_soc_dai_set_fmt(cpu_dai,
	SND_SOC_DAIFMT_DSP_B |
	SND_SOC_DAIFMT_IB_NF | /* invert bclk + nor frm */
	SND_SOC_DAIFMT_CBM_CFM);


Btw, what does:
	inverted bclk
	normal bclk
	inverted frm
	normal frm
actually means?

Is it so that it is:
inverted bclk:
	sample is driven on the rising edge, sampled on the falling edge
normal bclk:
	sample is driven on the falling edge, sampled on the rising edge
inverted frm:
	FS is active high
normal frm:
	FS is active low

-- =

P=E9ter
