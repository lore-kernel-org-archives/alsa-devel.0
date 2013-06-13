From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5640: fix sparse warnings
Date: Thu, 13 Jun 2013 10:27:20 +0100
Message-ID: <20130613092720.GV1403@sirena.org.uk>
References: <1371072864-13205-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2285713736461952558=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6176E2619F0
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2013 11:27:27 +0200 (CEST)
In-Reply-To: <1371072864-13205-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2285713736461952558==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+vl+q9EKybVy/Rgp"
Content-Disposition: inline


--+vl+q9EKybVy/Rgp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2013 at 03:34:23PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> This fixes:
> 975:9: sparse: Using plain integer as NULL pointer
> 1917:24: sparse: symbol 'rt5640_aif_dai_ops' was not declared. Should it =
be static?
> 1924:27: sparse: symbol 'rt5640_dai' was not declared. Should it be stati=
c?
> 2079:19: sparse: symbol 'rt5640_i2c_driver' was not declared. Should it b=
e static?

Applied, thanks.

--+vl+q9EKybVy/Rgp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuZB1AAoJELSic+t+oim9CqgP/jZSI8r46+u2bIAbMKvoProm
FZxu5QYN3z/ZQ+NQIyMKZeU97WNBMNwMDiRaSk4m2YLat2UqCObePjknys1prXQN
oaUOpeFASe22ihynGUlF34jF9h3cW18pV8Tt7vsoVBp8dc4KUo7v0iLYra/EYAZq
F38qwm9ZS6LXRbdG8C7xXwbpRpIWHVoJlV9rz1pm6ZzGMh/nNtOuHpM2apeHVHd2
lvxAZu1ubMRDes3ThbaoBttKW2WzA3J5/AIWsXJ6wLmTQYzhkeeoe6Wa0T89EXLA
KgXi25nkwzv/YGFtfRzGfnk7IhsBOq3oNRvE+2g4Q0GTzjNyw2pinX/fuNoRkG0o
I0yl4FgIM0IbABCIGnKqG5JeYCTDszZai/kQII25HZQC99gD2dIlzscA2HFa1KJ4
m4AMpixkHYpvVuT3i0s5biMKyUOhyMzcXZ2sSGBpakEgHhG+W/XMCu1yzNulGAHC
hH8L1pat9tOXU6p9jcqBeufY2i0mXhIhO7ucZzxDxYZlRkrjyK84n1F6ERD552zt
wJcnx7ilRHUQdIRzN/Te2wsPnAb9TA6cMNfW4eMlrKDzs/exqBVR4wRSZ9j1Ul64
kJlkFhcbwmHe5CsYy5eZ4V3g2Fwsj2jMbKoKygKv4OBGXPMi8dygIJj7F7yPwZNN
zgvDDS/jS+U2SVOfh/QM
=SLnP
-----END PGP SIGNATURE-----

--+vl+q9EKybVy/Rgp--

--===============2285713736461952558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2285713736461952558==--
