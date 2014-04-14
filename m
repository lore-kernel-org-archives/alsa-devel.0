From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: pcm512x: Use CONFIG_PM_RUNTIME
	macro
Date: Mon, 14 Apr 2014 20:32:53 +0100
Message-ID: <20140414193253.GF25182@sirena.org.uk>
References: <1396591153-10924-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0721572859928722111=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D70342656E5
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:33:06 +0200 (CEST)
In-Reply-To: <1396591153-10924-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0721572859928722111==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Content-Disposition: inline


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2014 at 11:29:08AM +0530, Sachin Kamat wrote:
> Fixes the following compilation warnings:
> sound/soc/codecs/pcm512x.c:520:12: warning: =E2=80=98pcm512x_suspend=E2=
=80=99 defined but not used [-Wunused-function]
> sound/soc/codecs/pcm512x.c:545:12: warning: =E2=80=98pcm512x_resume=E2=80=
=99 defined but not used [-Wunused-function]

Applied, thanks.

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTDfiAAoJELSic+t+oim9jU8P/RTKC0OCf+pb3SvmHkn3KV6k
M3XU44TiXDoxsZ+rRPa1FehBdvAm2X5DEJGePTY4Xx6VuNISkYpKrrqNQDaU7mv5
7p4wdLpRNt3s44v+3rzZKpK/5aPb4Tr0yWlbKSBP+iXOrOwPNaKS0b4U/CWU5vrZ
29c0xqAIDZr3Onx21I6t2SmM2cLGP78KW9ppZWLJdQBtMjq7FTqyqIPYluvP31Mo
HkKR5dsgXAeM+8BO+W1rJIBcZRfCK/pF+lnd9KiQdLoOhvbBqFJxOWfZshMpguxI
BaX2R2HabJZPAC2GLY3M8J7HmECc0pS7Kh0dAIs0hJusR71H6Uz++wioUORsqjDj
Jz5EFqISjrBWygFZGtk7tIAB3qGY6tsw7TEv9rELYdcwnI53RqU3AfPo6QbJhtku
6zGcA8L7CFqrqAAq+oKSeQ8Zcr5CHQoOFlOfVRzFoqaylove1syn4HFimVsTPB2o
G5jQ7Qt99LYsFeYdWqP1fzDa+UHfM/j7fNV5IK3eLJZtrpkb1gPD/hXn8X8hu02R
b8pzLQ9GuVgj4kXyGqVY1JRm2h6UO28P26GnD57qJy71KR4ec6dnNI9hXBQlUxzq
5kSOkziVJ3deCrhhoAgH5IWCJxiOHOujkR8ZBgJWKrFfB0YtlqGxfcrG5Nyfs8mG
mVJ6Ottn8SNoHszSNw5I
=DhmO
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--

--===============0721572859928722111==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0721572859928722111==--
