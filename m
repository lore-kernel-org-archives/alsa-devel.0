From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: ac97c: Fix an error handling path in
 'atmel_ac97c_probe()'
Date: Thu, 31 Aug 2017 11:19:03 +0100
Message-ID: <20170831101903.avhj5tqywpvfsj4u@sirena.org.uk>
References: <20170831044042.23306-1-christophe.jaillet@wanadoo.fr>
 <20170831081021.g4luo557ggtnyfyg@piout.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4628206832210226934=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A11D267217
 for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2017 12:19:46 +0200 (CEST)
In-Reply-To: <20170831081021.g4luo557ggtnyfyg@piout.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, nicolas.ferre@microchip.com, tiwai@suse.com, garsilva@embeddedor.com, arvind.yadav.cs@gmail.com, bhumirks@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4628206832210226934==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="27jextasd6gq6ete"
Content-Disposition: inline


--27jextasd6gq6ete
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 31, 2017 at 10:10:21AM +0200, Alexandre Belloni wrote:

> And here is the fallout of the stupid, brainless "fixing" of issues
> reported by static analysis tools.

> This clk_prepare_enable will never fail. If it was going to fail, the
> platform would never boot to a point were it is able to execute that
> code. It is really annoying to have so much churn for absolutely 0
> benefit.

It may currently be the case that the SoCs you're looking at happen to
make this clock essential but that doesn't mean that it's not going to
be different in some future SoC, nor that we can't have a software bug
that this will detect.  Being consistent with our error checking also
means that we can spot places where it might practically be a problem
more easily, it's even easier if the error checking is there first time
but it's still worth it to go back later.

--27jextasd6gq6ete
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmn4pYACgkQJNaLcl1U
h9C43Af/ebVWJ7nauWDoqQta0APoUk+7uCYH0UOoxehrQwuaIFSdroCa/d/rUFL4
41zTS91d4D1cMOdVi3xRl3bQo2z0tGCjyDLEXaAYmkjr3/x63h1vtuej2uvmztz9
ZxByQ+1VDm42ykE6meDGpqmYkjjyEgPZqyxr6nC+22mwFbIj2kx9FIMKNhikCx4H
6q/jUGaTzmvBAdbFwJivVbd3uiSd5Fi1GWZi6BkiH7v5BFdiwWVDtZ6ymFChO3UA
cYxUARSQEGHjHMb5FmaBpKOMdaHmqR7CkKOfxIMoKAKMFHmjiWoK4CAy77lYuSN4
9TE2Xmd2pNWVhZDZeIMb7AhAjeOTVA==
=dUKa
-----END PGP SIGNATURE-----

--27jextasd6gq6ete--

--===============4628206832210226934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4628206832210226934==--
