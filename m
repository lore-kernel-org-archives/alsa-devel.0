From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 3/6] ASoC: codecs: msm8916-wcd-analog: move codec
 reset to probe
Date: Fri, 28 Jul 2017 14:40:13 +0100
Message-ID: <20170728134013.vsneppa35kra77ot@sirena.org.uk>
References: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
 <20170726003512.18965-4-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ea6fdfknur5bqkt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170726003512.18965-4-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--4ea6fdfknur5bqkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 02:35:09AM +0200, srinivas.kandagatla@linaro.org wr=
ote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>=20
> This patch move the codec reset code from dai ops to codec probe, so
> that the codec is not held in reset when headset detection block is
> still active.

This means that the CODEC will no longer be held in reset (which
presumably has a power benefit or something) even if jack detection
isn't in use.  What most devices do is have things like this be
controlled via the bias level or other power management functions and
then have jack detection hold the CODEC out of the lowest power states
when it's active.

--4ea6fdfknur5bqkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll7PrwACgkQJNaLcl1U
h9Bf2gf/c/0HewKx7J0GGIIyasdH7To5toi1CvxzHTez6akg53pFwCH9uEREYfM4
mPcN8xvT5auKVTS9JTciVw/axFZDr8HAjwsh/qz27VmV8pIOJBfO9UtJ+8vIycBU
Ovw7voP3l3sxvGiTjKJa2NbXAaIoOaUW66uNdaEKTxAyLynSMmwzu4AKRN4b0GoE
DC5/8rKbPgGTexdFGJmkKWx5WeNFvKF+fAhjlhifQsnOb/MPaDG36c0ee1VZ75yw
+e+o/k52+nLUV6ht+LF3Tfk/LTw5ofPMQlyFbuN/FsjA9tAhYW95f7b6gLg12pwq
9PpNo7ySiVLA5ihqm67NVgLYDGPePw==
=EdL0
-----END PGP SIGNATURE-----

--4ea6fdfknur5bqkt--
