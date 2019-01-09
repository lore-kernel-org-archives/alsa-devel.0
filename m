From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic32x4: SND_SOC_DAPM_MICBIAS
	is deprecated
Date: Wed, 9 Jan 2019 18:38:36 +0000
Message-ID: <20190109183836.GI10405@sirena.org.uk>
References: <20190109171121.GA12810@Ideapad-330S>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5774012187872782776=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7869626742C
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 19:38:38 +0100 (CET)
In-Reply-To: <20190109171121.GA12810@Ideapad-330S>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: b-ak <anur.bhargav@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5774012187872782776==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2nTeH+t2PBomgucg"
Content-Disposition: inline


--2nTeH+t2PBomgucg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 10:41:21PM +0530, b-ak wrote:
> SND_SOC_DAPM_MICBIAS is deprecated, replace it with SND_SOC_DAPM_SUPPLY.
>=20
> MICBIAS voltage wasn't supplied to the microphone with the older
> SND_SOC_DAPM_MICBIAS widget, hence the microphone wouldn't work.
>=20
> This patch fixes the problem.

Note that the reason we've not done that already for everything is that
the DAPM graph needs updating for the new routing in machine drivers as
the two widgets are wired differently.  However this is fine here as
there aren't any in tree users I can see so I'll apply, thanks!

--2nTeH+t2PBomgucg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw2P6sACgkQJNaLcl1U
h9CTzwf8CHx4tksZFKzyy1F8/aAi0gjcds5AuFQHz7K20Fmrvr6QvPbtCT7JVt/T
uVSnOIBqpXMo+NY36bJieBEgol5y8iKrpDvJG9JWQtOZTzjMT9yKEi3JdqFrN24Z
QB/NOFIfIuIut0Wj2npruViGZh0K/LW45tp1ykl5RfZA1dNYEMhnGSM0oqhBvP1d
uxf1VYyxY5c9fFiYNlBJdzbqQvJIZyNJM1U+APm+9miAbdSw0//hu4KxnwVQgJx3
hSApVBtwc2ySN7jAuR5Q+lsm68tR9AfGh19PE1+Tf7xLjorq6nLS56IcKJgL5TCM
fgjN4I15oddD9zi0/ibTid0ICyxDsA==
=A9Mu
-----END PGP SIGNATURE-----

--2nTeH+t2PBomgucg--

--===============5774012187872782776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5774012187872782776==--
