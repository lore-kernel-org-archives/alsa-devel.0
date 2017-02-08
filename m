From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC:nau8825: automatic LRCK and BCLK
 divide in master mode
Date: Wed, 8 Feb 2017 18:24:40 +0000
Message-ID: <20170208182440.cqnvlfqo524ryfzf@sirena.org.uk>
References: <1486021010-32340-1-git-send-email-KCHSU0@nuvoton.com>
 <20170203115757.q2ku7xzymqcx3yq2@sirena.org.uk>
 <58992FE5.6020001@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7327299264828484915=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 58E18266AB2
 for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2017 19:24:47 +0100 (CET)
In-Reply-To: <58992FE5.6020001@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7327299264828484915==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4ffqq7xuceudwolb"
Content-Disposition: inline


--4ffqq7xuceudwolb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 07, 2017 at 10:24:37AM +0800, John Hsu wrote:

> I see. Maybe I can get the bit clock and frame sync information when
> hardware parameter. According to the information to make LRC and BCLK
> divide confirguration.

Yes, that's the normal way this is done.

--4ffqq7xuceudwolb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlibYmcACgkQJNaLcl1U
h9DQowf/TnH8jwcT2h95sTBMZDakK8kA1PpNeineARwcJj+pPNesfWFP2ONSD3Kh
WGcOTdIuOOmNOO+4R+irPsggrqkwenT063crv9XUnYTy845N1zft7jw1DwmxKnxZ
B6bZktM4wsuLLkzkAyxPHiKy82uMkFM2lZ8bgZeoXIgZjPQwDwQPP5gsSy5E1dWI
qLQjF7o3ITQwa0pjVLMwg9lAnbY+AnQA+6xouwc926f+SJa5ali/70WrkfE/tG+b
Dbh5qfCHBgje517lSJb+eY/RKuUGo69oAkXA7EZMyUT0aLWBxC3sZljSzAeVBDyG
bQC1U9t8TF8/r6xvwZXiMFCRQqvxRA==
=rLL9
-----END PGP SIGNATURE-----

--4ffqq7xuceudwolb--

--===============7327299264828484915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7327299264828484915==--
