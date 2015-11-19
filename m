From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: sti: reset iec60958 settings on
	close
Date: Thu, 19 Nov 2015 17:50:24 +0000
Message-ID: <20151119175024.GP31303@sirena.org.uk>
References: <1447941250-344-1-git-send-email-moise.gergaud@st.com>
 <1447941250-344-5-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0232040032025930269=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B943D2614FB
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 18:50:40 +0100 (CET)
In-Reply-To: <1447941250-344-5-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Moise Gergaud <moise.gergaud@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0232040032025930269==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/F2XdnRjS8y2HUtp"
Content-Disposition: inline


--/F2XdnRjS8y2HUtp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2015 at 02:54:10PM +0100, Moise Gergaud wrote:
> Reset IEC 60958 settings for next PCM session.
>=20
> Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

It's not 100% clear that we want to do this - normally controls are
persistent and don't reset themselves per session.  Is this something we
normally do for such controls?

--/F2XdnRjS8y2HUtp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWTgvfAAoJECTWi3JdVIfQ5FkH/R3TdfZup9dCMESb9e00+txx
4yTg2wgcX4ZB4j+C0dz0tFm7VhoFKqFQdTRfrnEDkmsADPD4zShsfz9S/xghEijP
NQP9hw1bUxbUHka2tx5ZhHxSFbgM23m0miQgkBxBl3Rh/Ci2ROlxUwPkvjLTg+RL
faW2X7NJvVX9Wkx9kd5SQPmc+avoqYxidiRTQsy28t40FGPc5SXDrBqBeazt7EOD
zBBzB2QblZxWzsuXt7xOdRE66Go/nKILR8FCkMNoUGl9pjVgXEgMn8rEZ76uEFpt
pDLwbNa5ew/9X6A0tTnYCzOwXZPABrPmHCAbh9HX3rLHx3ructPc75PKM6sfya0=
=RGTB
-----END PGP SIGNATURE-----

--/F2XdnRjS8y2HUtp--

--===============0232040032025930269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0232040032025930269==--
