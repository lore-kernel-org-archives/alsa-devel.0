From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH resend 05/11] ASoC: soc-core: don't alloc
 memory carelessly when creating debugfs
Date: Thu, 22 Aug 2019 18:18:57 +0100
Message-ID: <20190822171857.GC23391@sirena.co.uk>
References: <87a7c41lf1.wl-kuninori.morimoto.gx@renesas.com>
 <8736hw1lde.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3291320765867180315=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6FE07F80147
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 20:21:11 +0200 (CEST)
Resent-Message-ID: <20190822182102.GF23391@sirena.co.uk>
Resent-To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 ranjani.sridharan@intel.com
In-Reply-To: <8736hw1lde.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "Sridharan,
 Ranjani" <ranjani.sridharan@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3291320765867180315==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 20, 2019 at 02:05:06PM +0900, Kuninori Morimoto wrote:

> Current ALSA SoC might allocate debugfs name memory via kasprintf(),
> but, it is unnecessary and the code becoming very complex.
> Using local variable with appropriate size is enough.

> This patch uses 64byte local variable for it.

Is it enough though?  It'd be a very long name but as soon as you
start putting a fixed limit in you're tempting fate a bit.

The other potential issue is that it's a relatively large
allocation to do on the stack and while we're probably fine it
still doesn't feel great.

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1ezoAACgkQJNaLcl1U
h9A8rQgAg6Lut5zwamdfXGOUV35xOXekSeZb8a3B9nHlGaE8qPFWHnp/+vQklzQB
o20UOaEA7ZBJKUppexfv/Nc0eDMJPjbnmR+4KrhghasQi1HKxjvoTUK76wTjOK/6
StkoMAs87oAOb1tYH6w1VbPbAR7HfXqvnFK3XReZ9UZJGiFXBeLjQHZkwJWsIHR/
KIFYbWtvuhW+S07I7W8aVaSe1G/Sr/QYpwdk2mnHF/kudAy4r4IA6SkKoH/xDeie
cmJO+aN5mUImMiMafBmMh95IM/cL7nxzWzAZayCIMx3AR/FUQEj6jgRBETf+3qnz
uVMTBOijbqmM+kUVQ9O1NLyb4LbAcw==
=Uero
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--

--===============3291320765867180315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3291320765867180315==--
