From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs35l32: Simplify implementation of
 cs35l32_codec_set_sysclk
Date: Thu, 28 Aug 2014 19:14:30 +0100
Message-ID: <20140828181430.GH29327@sirena.org.uk>
References: <1409214476.21395.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1049262015716880898=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C2E4626A7CC
 for <alsa-devel@alsa-project.org>; Thu, 28 Aug 2014 20:14:52 +0200 (CEST)
In-Reply-To: <1409214476.21395.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Brian Austin <brian.austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============1049262015716880898==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFBW6CQlri5Qm8JQ"
Content-Disposition: inline


--nFBW6CQlri5Qm8JQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 28, 2014 at 04:27:56PM +0800, Axel Lin wrote:
> Use single snd_soc_update_bits() call to update the register bits.

Applied, thanks.

--nFBW6CQlri5Qm8JQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/3GDAAoJELSic+t+oim96PsQAIIH0yaRZ5/DKAOKNAXFFoYx
8hy5nnPok7XDCDfCkEnVAf1f3NnGDRiNp2OLqYvc44GoNAEG1pXSvaLu5fnW1GUO
i7WhYKScx3vXMdv0VYo1NJEXJWkTkMzKxJHAnm4iKXz/NgQFWLhJFZ0iiQF1oAEu
+sQICy8nhf6Qt5z2Pycki+LxEHMigmIXgzPR122oqChJHDbZBpPfGulKcbjKxg6c
TDF0E0JmIJhFX0FRR1MrgoOO5xZFLIl7A32+4vqjd4zCGWmaI2qbiIjMUAUCAbVW
a2nLdqeTsrCvOGYqxwQUKPRJEw5Y4GcpQoRtCq5MrLm9AGBh69+Jgt7lTgO7RcsF
5SOKZ3d6qR8v55VCU54gjtmMzQ9CKsrHGIPJxtGngg+nJRVRvtnGcoWwdyINVYoH
wxsCKtYgbo+WqH+Uxrilb0LMqkq9F+/QyIcDgfmnvseM51LW6Lkl95WlztK52O0W
VF9pT+9IUN4rpGI5Z1fBYJ3o+nrp9mRdWHgEODny2jBSOK2lakgwmTBpI81rPszh
97LiVJTQyXc7gdoI7oGzHe3U67CaiCLziZEqd3UEn8U1UmA5NRXQEjNP4iG9zIuf
MNaWufOgl6kuqmW/haOG3oun+D9+G0Wd2oxrv5oFfB0NR+JVM9zpsdCdcVA+Wsbg
B0zTEFQdZQZkHZw15bls
=q2qy
-----END PGP SIGNATURE-----

--nFBW6CQlri5Qm8JQ--

--===============1049262015716880898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1049262015716880898==--
