From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/2] ASoC: omap-mcbsp: Correct the DSP_B
	mode
Date: Tue, 14 Apr 2009 15:32:30 +0300
Message-ID: <200904141532.30478.peter.ujfalusi@nokia.com>
References: <1239695131-30367-1-git-send-email-peter.ujfalusi@nokia.com>
	<200904141334.33497.peter.ujfalusi@nokia.com>
	<20090414142004.fee14e30.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id D77F424342
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 14:33:06 +0200 (CEST)
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
> "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com> wrote:
> > Well, I think the mcbsp module is quite - maybe too - flexible...
> > To have the DSP_B mode correctly (for the tvl320aic32 codec used in
> > osk5912 board) the FS polarity has to be handled by the mcbsp as it has
> > been inverted. If we don't do this, there is no way to have the MSB at
> > the correct place (it has to be available when the FS is high).
> >
> >
> > The DSP_A mode can use the FS polarity 'correctly' - as it is. Or we can
> > also consider to require to invert the FS polarity, than add 1 bit delay
> > for DSP_A mode.
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

Should it be like this instead:
 +		temp_fmt ^=3D SND_SOC_DAIFMT_NB_IF;

We only need to invert the FS polarity and the bclk should stay as it is..
Also should than this modified fmt stored to mcbsp_data->fmt later?


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

-- =

P=E9ter
