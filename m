From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/11] ASoC: SOF: Add PCM operations support
Date: Tue, 24 Jul 2018 16:07:55 +0100
Message-ID: <20180724150755.GG13268@sirena.org.uk>
References: <20180719185335.30912-1-liam.r.girdwood@linux.intel.com>
 <20180719185335.30912-5-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4835332209928623748=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9923D26733D
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 17:07:56 +0200 (CEST)
In-Reply-To: <20180719185335.30912-5-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4835332209928623748==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I3tAPq1Rm2pUxvsp"
Content-Disposition: inline


--I3tAPq1Rm2pUxvsp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 19, 2018 at 07:53:29PM +0100, Liam Girdwood wrote:

> +/* Create DMA buffer page table for DSP */
> +static int create_page_table(struct snd_pcm_substream *substream,
> +			     unsigned char *dma_area, size_t size)
> +{

That's a very generic name!

> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_component *component =
> +		snd_soc_rtdcom_lookup(rtd, DRV_NAME);
> +	struct snd_sof_dev *sdev =
> +		snd_soc_component_get_drvdata(component);
> +	struct snd_sof_pcm *spcm = rtd->sof;
> +	struct snd_dma_buffer *dmab = snd_pcm_get_dma_buf(substream);
> +	int stream = substream->stream;
> +
> +	return snd_sof_create_page_table(sdev, dmab,
> +		spcm->stream[stream].page_table.area, size);
> +}

...for a super thin wrapper.

> +	/* nothing todo for BE */
> +	if (rtd->dai_link->no_pcm)
> +		return 0;

Should these operations be defined for a back end or should back ends
have their own set of operations?  Do we even need to use DPCM here for
that matter?

> +	case SOF_DAI_INTEL_DMIC:
> +		/* DMIC only supports 16 or 32 bit formats */
> +		if (dai->comp_dai.config.frame_fmt == SOF_IPC_FRAME_S24_4LE) {
> +			dev_err(sdev->dev,
> +				"error: invalid fmt %d for DAI type %d\n",
> +				dai->comp_dai.config.frame_fmt,
> +				dai->dai_config.type);
> +		}
> +		/* TODO: add any other DMIC specific fixups */
> +		break;

We print an error but don't actually do anything about it?

--I3tAPq1Rm2pUxvsp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltXQMoACgkQJNaLcl1U
h9BJmgf8DGyQleQFsbG/oqW8CBp+T84VS0VaUWfhTc+Dd+Wqh5t1MG+2FsfpqTHj
cG7Cy/n1nEcK8M/EliRvxYIoZNoKcpgGpO02OV2kT+4FywPlUjA5wvic9TF/+ijl
LWV+o4k11lC6cTcBwsGhREErDBKr8TFhaI2U/EsfCm08PVFgcKqRNlGfCYklIj8f
MJtJ8EYylELxalVfK6R4pEqIPZ0EBP8WcrgvklcwwQ1eTDCenvcDCOYCmwUlWbFz
m32fq5Rx/pOHbv3id5gxBsivwAsBD17jvd0SmZRAPlUQORl1rhoG8HmpD/VNU/H6
ZwlcWfjoxAGJrEbSuqlhLSLwxR9SuQ==
=UgEq
-----END PGP SIGNATURE-----

--I3tAPq1Rm2pUxvsp--

--===============4835332209928623748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4835332209928623748==--
