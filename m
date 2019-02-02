From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: dapm: fix out-of-bounds accesses
 to DAPM lookup tables
Date: Sat, 2 Feb 2019 17:11:24 +0100
Message-ID: <20190202161124.GA23441@sirena.org.uk>
References: <20190201170513.13905-1-pierre-louis.bossart@linux.intel.com>
 <20190201170513.13905-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2811646765736888670=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 222F9267477
 for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2019 17:11:27 +0100 (CET)
In-Reply-To: <20190201170513.13905-2-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2811646765736888670==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 01, 2019 at 11:05:11AM -0600, Pierre-Louis Bossart wrote:

>  	[snd_soc_dapm_mixer_named_ctl] = 8,
>  	[snd_soc_dapm_pga] = 9,
>  	[snd_soc_dapm_adc] = 10,
> +	[snd_soc_dapm_input] = 10,
> +	[snd_soc_dapm_output] = 10,

I'd put these at the same place as mics.

> +	[snd_soc_dapm_mic] = 10,

This is already in the table (at 5)?

> +	[snd_soc_dapm_vmid] = 10,

This should be goingn along with supplies and micbiases.

> +	[snd_soc_dapm_siggen] = 10,

Looks like this should go along with the other sources as mics.

> +	[snd_soc_dapm_sink] = 10,

This is an output so should be to the end, 11 looks like the right
number.

> +	[snd_soc_dapm_buffer] = 10,
> +	[snd_soc_dapm_scheduler] = 10,
> +	[snd_soc_dapm_effect] = 10,
> +	[snd_soc_dapm_src] = 10,
> +	[snd_soc_dapm_asrc] = 10,
> +	[snd_soc_dapm_encoder] = 10,
> +	[snd_soc_dapm_decoder] = 10,

These feel like they should go along with PGAs.

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxVwSsACgkQJNaLcl1U
h9Bqswf+NhY4T627d9aaC9p9003kdKgrjU0G9xgMIfJeQrzsbl7JDV6pFaQcGE4u
kplT1KnaI4E/6ANCsr8CIdPgHd3t27J85OxSQYXZ7/t002/uYPigTajOyYD6KugW
pQW0+vXLSM+eu39dGMJimf7fVwbv9yWtEyruK8RaU3SxdG4nQVRwVkPo400JlIey
Kzqr5zpm3zA3PCWeLpPZIBcT0v42CCvBNJXs4BI5VA0LuJLwnab7V5VbHj8VbA05
i0wUE8egY8fL0iQ5AVXonrljNTKrNnyd2o2PaSSfP882SLoZ+azebwk131S7iuP6
y/nbmonpPt/vAyo+Ixo6uFi4uqhPkg==
=uIRq
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

--===============2811646765736888670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2811646765736888670==--
