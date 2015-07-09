From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v7 1/4] ASoC: Intel: add Skylake HDA
	platform driver
Date: Thu, 9 Jul 2015 09:50:37 +0530
Message-ID: <20150709042037.GD836@localhost>
References: <1436153066-23962-1-git-send-email-vinod.koul@intel.com>
 <1436153066-23962-2-git-send-email-vinod.koul@intel.com>
 <20150708185655.GD11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1412049016441629073=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 385AF265AF8
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 06:18:52 +0200 (CEST)
In-Reply-To: <20150708185655.GD11162@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1412049016441629073==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2015 at 07:56:55PM +0100, Mark Brown wrote:
> On Mon, Jul 06, 2015 at 08:54:23AM +0530, Vinod Koul wrote:
>=20
> > +	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
> > +	pm_runtime_get_sync(dai->dev);
>=20
> Check the return value please, this can fail.
Yes..

>=20
> > +static int skl_get_format(struct snd_pcm_substream *substream,
> > +		struct snd_soc_dai *dai)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd =3D snd_pcm_substream_chip(substream);
> > +	struct skl_dma_params *dma_params;
> > +	int format_val =3D 0;
> > +	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
> > +
> > +	dma_params  =3D (struct skl_dma_params *)
> > +			snd_soc_dai_get_dma_data(codec_dai, substream);
>=20
> Should be no need to cast away from void.
Right.

>=20
> > +	if (substream->runtime->dma_area)
> > +		memset(substream->runtime->dma_area, 0,
> > +				params_buffer_bytes(params));
>=20
> Why do we need to memset here?
Nope, the buffer is allocated thru snd_pcm_lib_malloc_pages() which IIUC
would for this case do a kzalloc, so we should rmeove this
>=20
> > +	dma_params  =3D (struct skl_dma_params *)
> > +			snd_soc_dai_get_dma_data(dai, substream);
> > +
> > +	pm_runtime_mark_last_busy(dai->dev);
> > +	pm_runtime_put_autosuspend(dai->dev);
> > +	kfree(dma_params);
>=20
> We check elsewhere for dma_params being NULL, shouldn't we set it to be
> NULL when we free?
Thanks for pointing, fixed now

--=20
~Vinod

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnfaVAAoJEHwUBw8lI4NHGpsQAMXewhAP26rDHLdllsYwl6id
+xJhvpywdaiOyzYxj65TZnJiRrExakkrMn3rtWdLkunuY8WbTGDHkfXVTbICZf2h
Lik5R3wuy4EPiB2kf6eJzoZQxbbvxgjSmWNqTsDtwKAQz4BOKckHh4z+Clof8MM0
GNDOXYdMrKu6TnsoVncWUf2vZ4IZZnzIEELqisVJXi8bQVsfbgjLWCMQuBQxUAUr
H1XVZYC5QGLGXesb0Xs8yrXSOgPgHo7yuVwGp86zMC2KY7skfyUBv9HLnHWJameH
mxByHDpVwgZrJrJ0aw0cvaDXgh+MF2FfWIzSbQ6KuhsyIhv4twvvA+NqcCAqvLSa
TFlTzLcMwEunM+hAeVeeZLw6jTMT5C+PLCNM+ZXgXaso+d3Pvsw5VMR5zZaakLVC
3qcmQU8d2EX294KV7EKfOtO8xVirIUhJwOgjC3YhNwDkOswjvG2equoxUH7S6fAq
gRWNwerCZs1WWGh2sBTh7XLtFdVgkb7vicd9idTkHGb8YsrXKwzp1rAf4NSr9QWE
oLm++TKKih20uhwj2mTRkS6gnulkg4bUXfAQF9hoLR/KQ0cCC2P3v3BT1rZiifO7
IHyRYrThqIDUPPcS7ZqcUuPMki1lF3E/7Hkf9XiQIMPJ3QfM0o4RZGOOfEEkvHwW
6u3uIOQQTHtvPgAtu14Y
=Wki7
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--

--===============1412049016441629073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1412049016441629073==--
