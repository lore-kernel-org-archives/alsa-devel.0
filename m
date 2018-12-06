From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND 5/5] ASoC: max9867: Add copyright
	and module author
Date: Thu, 6 Dec 2018 20:10:29 +0000
Message-ID: <20181206201029.GC3084@sirena.org.uk>
References: <20181204181725.GA1136@lenoch>
 <20181204182200.GF1136@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6228788090653179471=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BAD5267C93
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2018 21:10:31 +0100 (CET)
In-Reply-To: <20181204182200.GF1136@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6228788090653179471==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 04, 2018 at 07:22:00PM +0100, Ladislav Michl wrote:

> -/*
> +/* SPDX-License-Identifier: GPL-2.0
> + *
>   * max9867.c -- max9867 ALSA SoC Audio driver

SPDX headers in C files need to have C++ comments - please convert the
entire block to C++ so it looks more consistent.  Otherwise this looks
good.

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwJgjUACgkQJNaLcl1U
h9AI4wf+N1aUZW+ZlKu33u0Ze68PktKIR3nn0xnZKcJMybZRtSdWPoaPmjuMEqI3
Ka4oCkjddh0VWAxpvdrrzbsST2T4Ly7h2bW62pQjTcWxuaIJxNprHQ+BAY6V5kJM
zuqg1Aq7I9GJ9zbk6CrB8q9g5r0YNUjnguYRyQvSFF6j8Xd3dArnmFupJbIbnmJW
J4giWAy437TkD3BEpza7L1nZZDuX0I7wS8w1JefXesLoFazPuaQbB9X7axya1Zv8
kqWVrl/Ky/NZhJ643OuMbQjUtFPVNtjYv2h9AUOI5IPgFbtAFulWGHbeGWt8iTl4
sF8wADJbY/N29zEe+OK/VihVtKX8ag==
=+cXK
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--

--===============6228788090653179471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6228788090653179471==--
