From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm_adsp: Sanitize parameter passing
Date: Thu, 1 Aug 2013 11:59:09 +0100
Message-ID: <20130801105909.GP9858@sirena.org.uk>
References: <1375351888-24877-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8036998736422813044=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 45CE02655D5
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 12:59:11 +0200 (CEST)
In-Reply-To: <1375351888-24877-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============8036998736422813044==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KZSH4Lhcrs6JdLru"
Content-Disposition: inline


--KZSH4Lhcrs6JdLru
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2013 at 11:11:28AM +0100, Dimitris Papastamos wrote:
> No need to hold on to the `codec' pointer.  We can use the `dsp'
> pointer and grab all the information we need from there.  This
> makes the parameters for the functions a bit more sane and idiomatic.

Applied, thanks

--KZSH4Lhcrs6JdLru
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+j95AAoJELSic+t+oim97s0P/2y6i55iWz0+V+js79f2h0QH
uog0wP7LmcWP7cGQ76fXqm6jnK1cY9u3Bp5lRxookngOwYDc5S1EYE6Lc7/AZdtc
YU3sohKSDA+A1NY8dLTZMunn2B//5SiIy5X8wEPrRoYT+5NI4xeVexWyNczSiq3x
FECsHQEat17d/ZSMHo6KHKjPrD+QmjFuNCPmMer+Y6ZwS3pK8PNbbIlxjziVYGdZ
Y34BN1Q3ia5qZ9Do5XEfNC7Cg1u6mL4hveF9MAyzRo264yQM3CKFbH4wm8KdfAL7
5+CJ96kXWorT2s1Ik3A5iltV9SFNWvbQ27+na4wT608KUbccmwwgtSlKNRj0BGG0
ZY+LawbTapakGSkWdfIr6tyJ1VE4QhAHOFnGq/6kGyfgVW7At2UAjnfxjzILwTuv
TFc5UoMYP9NdYj6X6bFO7cpMNBYKpn6ljE959ZGnwzghCrLXkhRaJqBGCv+sTMWs
kItQ6ld/qg607yylyePtNkER2aDxFm1zFA3YAu8JqL7SQ3PZsvaRQGh8knvYcpca
fej3uFgtjpydUZRRitkNBRd3aD66A9/qaGhE2eaAeev5mTwoHnDoGbZxsmqjmd2N
kV61GU2LAfBDnYmprviA7OSv0RVdHJTAEjDkypJVtbMlpNHnJYjqnC7I4NUUfkLJ
IRzlb0jMVli0l4U4/zsz
=1nmU
-----END PGP SIGNATURE-----

--KZSH4Lhcrs6JdLru--

--===============8036998736422813044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8036998736422813044==--
