From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Fix double prefix addition
Date: Fri, 17 Jan 2014 18:57:47 +0000
Message-ID: <20140117185747.GI17314@sirena.org.uk>
References: <1389819796-12858-1-git-send-email-aruns@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hy6Wd/+xmQCqA1QQ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1389819796-12858-1-git-send-email-aruns@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arun Shamanna Lakshmi <aruns@nvidia.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Songhee Baek <sbaek@nvidia.com>
List-Id: alsa-devel@alsa-project.org


--Hy6Wd/+xmQCqA1QQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2014 at 01:03:16PM -0800, Arun Shamanna Lakshmi wrote:
> The prefix for the codec driver can be used during dual identical
> codec usecases. However, dapm adds prefix twice for codec DAI widget
> in snd_soc_dapm_add_route API.
>=20
> This change is to avoid double prefix addition for codec DAI widget
> and is needed while using identical dual codecs.

Well, it's just a cosmetic thing so it's not *needed* per se but anyway.
Applied, thanks.

--Hy6Wd/+xmQCqA1QQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2X0oAAoJELSic+t+oim96d8P/1O+PSeuDEQ50EnNEBS4G/xe
YXYexDLAHURgNh67gPRymixAyaxsiIC1CzHREPF7m/5eiOsjZxSU6Jic1j0Hkljk
BWYe7w3g0bt0eK8ZRuOT5/VvB8zloTI7IV5hkOHa2mMEQwTDMaBbc2yQvZh/1XhN
OWcOgYiTLMO2T4iwEGvnc288j9Yvxsas+uF/sbf9mya0jP7lLaCSJv1XeiNwn25f
AZYTgz0jGBW3CqT8moRNEjCpeiZHDRe/6DLdhl4VWvs/OSHsR8YUDq864eJf7/od
6UwEkFqi6xgXuJrT3LOlSnxetZcm3wgdRoMLU1NyXUr94ekLX+mfhw61WpfwTSzP
nyIUTnhC6LyeWFw49x5m7hhWuDyXV+9KJNhFJcTdujwzK1H0YP9h9oc9vw8fP6Ay
DNM1pu7h2uMXFgaXYFKs43MPRLwNktP+eTjDtRGlnQpL8okLPRJazcfkfPqNsnJz
7EgCugY5GdQrFl8taY6IV0O36COqzqnUUdSb1GuowYPAfDZErJeWPp5yFhkRkjCu
hIf3tIVxPPnwnXdU+Ssy9IVVf5ZXahkQuNbAf72IqYD7JsxjVfuLz4uj/kyF9/4U
CQ+hW6SLGCDpagAoYQbcWEArQPUmDh7IMLFucUnfyj10d7AWK933fHskz0vGYmm7
nbMuVLrmVQVoVHN9SNyM
=p4Cf
-----END PGP SIGNATURE-----

--Hy6Wd/+xmQCqA1QQ--
