From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6] ASoC: dapm: add code to configure dai link parameters
Date: Fri, 10 Oct 2014 17:49:59 +0100
Message-ID: <20141010164959.GG18557@sirena.org.uk>
References: <1412957836-2186-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8sldprk+5E/pDEv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412957836-2186-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--a8sldprk+5E/pDEv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 10, 2014 at 05:17:15PM +0100, Nikesh Oswal wrote:
> dai-link params for codec-codec links were fixed. The fixed
> link between codec and another chip which may be another codec,
> baseband, bluetooth codec etc may require run time configuaration
> changes. This change provides an optional alsa control to select
> one of the params from a list of params.

Has anything changed since the previous version?  I've postponed
reviewing that until after the merge window given the way you were
ignoring feedback and the approach of the merge window, is this a new
version or just a reposting.

--a8sldprk+5E/pDEv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUOA42AAoJECTWi3JdVIfQuLIH/R4q5v7R4FJQn2otp//iuU9H
Og5IPFRjDjULd3zCqO0TSGjU1/dBoVIRdyVmIfQd/4mcRn3jkCLL1ThcYX13jt6v
41TClQe5dENeNvsJaM05gaXncvXy8tK76rCa7/6xEoKVcJD1K/SAYGCqxb6yednU
mOtOzQKasTTnABNTlEx87HqzyZCVgl2fYiRkL66tFD7N5HRWIAEcnFuf2gzPA3x2
cLdvJg/TCbMJp0yc9aw/FdefKVM9MqjEbsuJPH7rKWpyfMo8LDic574QwSg2yE6r
w4vSZbiK3dhBShGBuAZMdiRBqY6VcZ5UloHLOHbVFuwlLU3KWa2MPQlzUEQ2boo=
=vUP3
-----END PGP SIGNATURE-----

--a8sldprk+5E/pDEv--
