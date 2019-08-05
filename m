From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC updates for v5.3
Date: Mon, 5 Aug 2019 19:04:18 +0100
Message-ID: <20190805180418.GL6432@sirena.org.uk>
References: <20190805131327.GF6432@sirena.org.uk>
 <s5hef1zpkke.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6538984463515962306=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EEBEAF8011B
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2019 20:04:20 +0200 (CEST)
In-Reply-To: <s5hef1zpkke.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6538984463515962306==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3xQkynibq3FKlJyM"
Content-Disposition: inline


--3xQkynibq3FKlJyM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2019 at 07:51:29PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > The support for new sample rates in the max98373 driver is a fix for the
> > fact that the driver declared support for those rates but would in fact
> > return an error if these rates were selected.

> Hm, the commit b9da500bde81 looks strange.

> The author and sign-off isn't with a proper name, and moreover, the
> patch modifies the file permissions.

Eh, the name looks perfectly fine for a Chinese name and matches the
e-mail address well enough - it's a slightly unusual transliteration but
if that's how ther want to do it I see no reason to complain, it's their
name.  File permissions are a mistake though, I can send an incremental
patch for that?  Kind of surprised none of the bots or people scanning
for stuff noticed it.

--3xQkynibq3FKlJyM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1Ib6EACgkQJNaLcl1U
h9C76ggAhTM7+c2mbQR867sI9M/hngwXjPpBzC3IVZ8c1SkSANznr0v/ICupYIRw
1AqbWhRv5o5OK/hEOARouGa8VuFqavkqYA7S6hRX9RnueDigEgBbYTQZfZzKMAJ5
tWJFhE0OPg4mZQHoHxDsuK7BL/tV4bHOmFVVqOvgUWTBJ7mG1lzxqzCSv5JeUKtt
e3tCqpu04rRJvzZO3Ecm3cIVUV/O3rLNH4V14Lcqo/quWsHxkxieNm5pPej+klul
2DmU8AwehGKlgBLGj94NcFcwxOBAIRd0QEdQinPBNRP1tG2w+4OKXqaj1Qloydtn
UiZXk+edmc7fOiElA8UA9ojl3Yc73w==
=9qPF
-----END PGP SIGNATURE-----

--3xQkynibq3FKlJyM--

--===============6538984463515962306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6538984463515962306==--
