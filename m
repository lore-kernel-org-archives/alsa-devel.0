From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ASoC: Allow drivers to specify how
 many bits are significant on a DAI
Date: Tue, 17 Jan 2012 09:55:23 +0100
Message-ID: <4F15377B.6080108@ti.com>
References: <1326739267-9678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog126.obsmtp.com (na3sys009aog126.obsmtp.com
	[74.125.149.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D3DA24552
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 09:55:28 +0100 (CET)
Received: by yhnn12 with SMTP id n12so1131283yhn.17
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 00:55:27 -0800 (PST)
In-Reply-To: <1326739267-9678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 01/16/2012 07:41 PM, Mark Brown wrote:
>  /*
> + * List of sample sizes that might go over the bus for parameter
> + * application.  There ought to be a wildcard sample size for things
> + * like the DAC/ADC resolution to use but there isn't right now.
> + */
> +static int sample_sizes[] =3D {
> +	8, 16, 24, 32,
> +};
> +
> +static void soc_pcm_apply_msb(struct snd_pcm_substream *substream,
> +			      struct snd_soc_dai *dai)
> +{
> +	int ret, i, bits;
> +
> +	if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> +		bits =3D dai->driver->playback.sig_bits;
> +	else
> +		bits =3D dai->driver->capture.sig_bits;
> +
> +	if (!bits)
> +		return;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(sample_sizes); i++) {
> +		ret =3D snd_pcm_hw_constraint_msbits(substream->runtime,
> +						   0, sample_sizes[i],
> +						   bits);

Should we apply the constraint only if the sample size is bigger than
the msbit request:
		if (sample_sizes[i] > bits) {
			ret =3D snd_pcm_hw_constraint_msbits();
		}

Might be not an issue to say that we have 24msbit on the 8bit sample,
but it does not sound right.

> +		if (ret !=3D 0)
> +			dev_warn(dai->dev,
> +				 "Failed to set MSB %d/%d: %d\n",
> +				 bits, sample_sizes[i], ret);
> +	}
> +}
> +
> +/*
>   * Called by ALSA when a PCM substream is opened, the runtime->hw record=
 is
>   * then initialized and any private data can be allocated. This also cal=
ls
>   * startup for the cpu DAI, platform, machine and codec DAI.
> @@ -187,6 +220,9 @@ static int soc_pcm_open(struct snd_pcm_substream *sub=
stream)
>  		goto config_err;
>  	}
>  =

> +	soc_pcm_apply_msb(substream, codec_dai);
> +	soc_pcm_apply_msb(substream, cpu_dai);
> +
>  	/* Symmetry only applies if we've already got an active stream. */
>  	if (cpu_dai->active) {
>  		ret =3D soc_pcm_apply_symmetry(substream, cpu_dai);


-- =

P=E9ter
