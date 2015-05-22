From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: How to mix multi input ?
Date: Fri, 22 May 2015 19:04:24 +0100
Message-ID: <20150522180424.GW21577@sirena.org.uk>
References: <87pp5v3jz9.wl%kuninori.morimoto.gx@renesas.com>
 <20150520181306.GP21577@sirena.org.uk>
 <87fv6qu6k5.wl%kuninori.morimoto.gx@renesas.com>
 <20150521110519.GX21577@sirena.org.uk>
 <87pp5t8otj.wl%kuninori.morimoto.gx@renesas.com>
 <1432317571.2772.40.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4858545588376311992=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F0FC9260422
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 20:04:31 +0200 (CEST)
In-Reply-To: <1432317571.2772.40.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============4858545588376311992==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FnF+XOoO+XCcZ18I"
Content-Disposition: inline


--FnF+XOoO+XCcZ18I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 22, 2015 at 06:59:31PM +0100, Liam Girdwood wrote:
> On Fri, 2015-05-22 at 00:01 +0000, Kuninori Morimoto wrote:

> > > > 	init          => working:
> > > > 	start sound A => working: codec + A
> > > > 	start sound B => working: codec + A/B (mixed)
> > > > 	stop  sound A => working: codec + B
> > > > 	start sound C => working: codec + B/C (mixed)
> > > > 	stop  sound B => working: codec + C
> > > > 	stop  sound C => working:

> DPCM should work with all the above. It worked on OMAP4 ABE when I last
> checked OMAP4 over 2 years ago.

Yeah, I was pretty sure people had been doing that already and I didn't
see anything that might have changed it.

--FnF+XOoO+XCcZ18I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVX2+nAAoJECTWi3JdVIfQtTwH+wZKMn2+qjT4xlkZnGE5gu1Q
dCZxI+Z8o1YfPbKaEBRlces0+liAgNHeb7B60u/ECnWAo5dwbJ6YBZN/IviD5sdO
z7nK790mMlH8WszP8wvBt2ncrMABwpv0/zKZq3DyFkhLFYWHilnbkO9iWyA1KEwW
atZCFgodj2La+RI6RJiO65pDyMMU5BmffbdR8tsOllsbyRj1fJYinHNRXX8SmoYL
CokMIbbSugJ3gFhtRl/se6VIMWOj1go7pZJeNHwwa/EvDrgjkfDQaS6euYXCb7xf
fqIaLHH/tt37FgzvlQSqEd9o7oFARHYpZbhbVa3wHGAmuoO8XCP0Shdmm8rpaGA=
=epYe
-----END PGP SIGNATURE-----

--FnF+XOoO+XCcZ18I--

--===============4858545588376311992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4858545588376311992==--
