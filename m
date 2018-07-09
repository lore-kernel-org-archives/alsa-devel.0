From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card support
Date: Mon, 9 Jul 2018 13:41:17 +0100
Message-ID: <20180709124117.GG16082@sirena.org.uk>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
 <20180709111437.GB16082@sirena.org.uk>
 <b5a3f0e2-d420-603d-f9a0-f93bdbd2619f@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b5a3f0e2-d420-603d-f9a0-f93bdbd2619f@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Rohit kumar <rohitkr@codeaurora.org>, lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 09, 2018 at 01:34:42PM +0100, Srinivas Kandagatla wrote:
> On 09/07/18 12:14, Mark Brown wrote:
> > > +static const struct component_master_ops sdm845_ops = {
> > > +	.bind = sdm845_bind,
> > > +	.unbind = sdm845_unbind,
> > > +};

> > Why is this using the component stuff rather than the normal support for
> > finding the components of audio cards?

> Could you elaborate this please?
> Do you mean something like snd_soc_lookup_component()?  Or in general audio
> card binding during startup.

Just the normal audio card binding during startup.

> AFAIU, The issue with that mechanism or EPROBEDEFER is that it works only
> for first time.. for the second time(restart usecase) there are no hooks
> like bind/unbind.

This is not the case, the card will be unbound at the ASoC level when
any of the components are removed and then probed again when they
reappear.

> The reason why we chose to use component framework is because of bind and
> unbind functionality. Am more than happy to rework on this if there is
> already a alternative mechanism in ASoC which can provide this.

The component framework is a generalization of what ASoC does.

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltDV+0ACgkQJNaLcl1U
h9BaCwf8DPkajFrD2z0vPsuEoi+2W0C8+W5Ts6wFobM8vKNYBOY8NpGUF/EOjjUI
fTKW7aZXV6KQaxV6ESwfJw/ye1gZXb18fZVW/xPuzLSHpkcSzJwG+1Mg2jSSj3q2
BqezmNMnnB3MTMfw5w9jM1xwyM1a4AXrWK2jSSA8NfKV+vKvoa1HtydyzGLEjGyR
Bw6HiB5+93AT2ljB/Rvt2hKluHPEkfnYbhyEm18KzAnma6xacsC2OLmFMW550/x7
TuwA6wNajAgvIOKpf9b9USAqUQaL5GlvMpA+zgJk/ApKs5ta+Rq5mGeqUwdxogKi
AlbHY++iPkl8pqExaB9J7aZGM80PIA==
=nKqd
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--
