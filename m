From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
Date: Tue, 13 Aug 2019 20:19:55 +0100
Message-ID: <20190813191955.GJ5093@sirena.co.uk>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
 <95c517ab-7c63-5d13-a03a-1db01812bb69@intel.com>
 <71fb21d0-3083-e590-db83-dbe489a4357e@linaro.org>
 <34a1a317-ac6b-bb1e-6b1b-08209f0d1923@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <34a1a317-ac6b-bb1e-6b1b-08209f0d1923@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org, pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, spapothi@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2019 at 07:29:50PM +0200, Cezary Rojewski wrote:
> On 2019-08-13 18:52, Srinivas Kandagatla wrote:
> > On 13/08/2019 17:03, Cezary Rojewski wrote:
> > > On 2019-08-13 10:35, Srinivas Kandagatla wrote:

> > > > +=A0=A0=A0 if (dai->driver->ops->get_sdw_stream)
> > > > +=A0=A0=A0=A0=A0=A0=A0 return dai->driver->ops->get_sdw_stream(dai,=
 direction);
> > > > +=A0=A0=A0 else
> > > > +=A0=A0=A0=A0=A0=A0=A0 return ERR_PTR(-ENOTSUPP);

> > > Drop redundant else.

> > Not all the dai drivers would implement this function, I guess else is
> > not redundant here!

> Eh. By that I meant dropping "else" keyword and reducing indentation for
> "return ERR_PTR(-ENOTSUPP);"

The above is the idiom used throughout the rest of the file.

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1TDVoACgkQJNaLcl1U
h9Bc/Qf+N4icKyyTDGlB5i1IOi6wDoQsSE1SgcAlrHFKoE0fOmNhKrhSQvskWPhS
4k6/x6JLxBu8CH9ZJAq8njVhSJ6BdfPkPM7H6Nd0tA29DaUCwHR4IDeZ9iIuAMOi
pX+z060wwGKdMbQUbYMOR4P1eLL1LYlxVZx1zWjXSxsDoYQYvhg8lMkeNDc6xLFI
smVcoYd0fRYsLRZtZXfSRQORdKdlYh34z7uLXkSTQpQIJtLH3Okb3U6pdOhkD1fu
steqUnEf89sHiHNuXZ506xZP8iUlLK13pzSfizTyI/Zl6Qp9PrQuMtN3KW5P2ZBT
kdXtRZSolgTjhJT5CgVHQUA8yneXgQ==
=vuyE
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--
