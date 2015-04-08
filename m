From: Mark Brown <broonie@kernel.org>
Subject: Re: How to correct params_format on DPCM ?
Date: Wed, 8 Apr 2015 19:01:18 +0100
Message-ID: <20150408180118.GG6023@sirena.org.uk>
References: <87twwsttp5.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8513743404600906673=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F3FE2606CB
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 20:01:29 +0200 (CEST)
In-Reply-To: <87twwsttp5.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============8513743404600906673==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="912EcOTuijd+RHJr"
Content-Disposition: inline


--912EcOTuijd+RHJr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2015 at 05:05:34AM +0000, Kuninori Morimoto wrote:

> Here, SNDRV_PCM_FMTBIT_S16_LE is always selected on non-DPCM card.
> This is OK.

> 	rsnd:   SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S16_LE
> 	ak4642: SNDRV_PCM_FMTBIT_S16_LE

> On DPCM card, FE gets S24, BE gets S16 if aplay selects S24 wav.
> But, FE needs S16, same as non-DPCM card.
> I know we can fixup BE side via dai_link.be_hw_params_fixup,
> but this is FE side.

> It can't use correct sound playback in corrent DPCM card.
> But, how to solve this issue ??=20

I'm not sure what exactly was intended here but this seems to need
fixing in the core - I think the assumption in the DPCM code is that
the sort of hardware that uses it will have rewriting support that makes
the back end constraints irrelevant to the front end.  I think what we
want here is some way to signal to the framework that the front end
constraints aren't used and it should use the back end ones instead -
perhaps just omit the constraints that aren't rewritten and then have
the framework take those from the backend instead.

--912EcOTuijd+RHJr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJWztAAoJECTWi3JdVIfQwrUH/0D0NcZwPxjwMNcSI15AG91d
gqQaG/ZUT/s5zA7myjU3KeV/rKNLQSuxvsimIyu2Orz4y6VdpCG4UiTyNruFf1LU
D5RUbAoqQ9jNaBBrdeSfYZAcQ81MSXEFiEA+FMpT+PrC0D+JnV9VRjYJjT7Ql2Go
ZUe2lRtvqBbm+BHuLbD5UyEiYgR/qFCFbl0EUL4ZbnlG6ojbn8VR1KAKqvfDYsgi
vJT04KUGAq+kILaV/yWMGcVTaoJBOwQcrFcgQD93A6cLqZn0uqQvtCk5oT0EBZGP
wTTVfdSn4jWvF4iERF59vzdRuZ3VT9DQWSnfAxDTamMokqR7pinV2lXkoxjOepc=
=0d7e
-----END PGP SIGNATURE-----

--912EcOTuijd+RHJr--

--===============8513743404600906673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8513743404600906673==--
