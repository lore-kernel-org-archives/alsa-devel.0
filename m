From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch] ASoC: codec: Add missing deps/hdrs to MAX98357A
Date: Sat, 14 Feb 2015 13:36:43 +0900
Message-ID: <20150214043643.GE9110@finisterre.sirena.org.uk>
References: <1423737354-27150-1-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423737354-27150-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2015 at 02:35:54AM -0800, Kenneth Westfield wrote:
> From: Kenneth Westfield <kwestfie@codeaurora.org>
>=20
> For the max98357a codec driver:
>   - Add missing build dependancy to GPIOLIB in
>     Kconfig.
>   - Add header files to avoid implicit declarations
>     and indirect inclusions.
>   - Remove use of DRV_NAME constant.

Several of these fixes have already been submitted by other people and
applied and (as covered in SubmttingPatches) each you should submit one
patch per logical change.  Your changelog clearly identifies at least
three different changes.

--C94crkcyjafcjHxo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU3tDaAAoJECTWi3JdVIfQx9MH/2Saet18Pl0c2CzAexz7weQi
Ns/LQU+pepM6yvMEIVkLW9G8pyXuCk0iP1pH4tSAgQfY+/3G22wvx74oGWTGsLb9
DLEgrCWOIVtd9eKDCYu7Yl+bGE0goUFPQkJ4H31kJtXC1+NOHC6CsW3pwi1hq+j2
Z06SnuyRavk8Hp3a+46bYiLSFPakUfVcw+pIp+j+hY9d5kQsvyjQnLW8+mAL8TaC
PgA60XzNz1oWiU8a/THXLwVCSN7i4EaXqm804/4VTtaDrtK4wjBGBY7TS1i1PIQ3
WDpKO03wITZXbRhot/PpT5mit/5jKEtVmmzCYas4hvLjiNPmGiG3nYmRfcJMgG0=
=aAfe
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--
