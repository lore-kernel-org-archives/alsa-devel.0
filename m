From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rsnd: call missing
	snd_ctl_remove()
Date: Mon, 2 Feb 2015 18:38:11 +0000
Message-ID: <20150202183811.GX21293@sirena.org.uk>
References: <87h9v4gbhg.wl%kuninori.morimoto.gx@renesas.com>
 <87egq8gbfk.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6892521771737934929=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F116426057F
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 19:38:16 +0100 (CET)
In-Reply-To: <87egq8gbfk.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6892521771737934929==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="syo/NduE93Y7hdWp"
Content-Disposition: inline


--syo/NduE93Y7hdWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2015 at 04:53:53AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current Renesas R-Car sound driver is using snd_ctl_xxx()
> functions, but it didn't call snd_ctl free_one() / snd_ctl_remove().
> This patch call these functions.

Applied, thanks.

--syo/NduE93Y7hdWp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUz8QTAAoJECTWi3JdVIfQGbUH/jhJeiXhBZBHrfwWev1qMtlK
tQrTXT7+JFBEX9Xu6rL4bZYjQvLybb76DjmEMFYLZpOfWCHFjTl2LpLuIhvLR2F+
BoXDG/9bQmJDQ5AX0/5Hax3sayGDIt30heCSRd0tC1CfDlyVAirtOSEl3klZAsXG
ThsMllrCHmsoGxfYHueMfc0ux2o59kOPmqiOcCKLTEmKZfE1Eb4fGEh0DzcoFa0T
HSvdQRGD2utMJLUQFy4QmfzEJ/flN7D43S5TSOTahW+aSXdNcrHdJmTiol6Spxgm
Stw8s9hKXviBXsC0TiMnads5jgHhsO1+SGI+URXkvtuSK7nY+yJ/9vQxKlcOIpg=
=UKvE
-----END PGP SIGNATURE-----

--syo/NduE93Y7hdWp--

--===============6892521771737934929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6892521771737934929==--
