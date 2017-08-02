From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: soc-core: add component
 remove/unregister_exp/lookup functions
Date: Wed, 2 Aug 2017 14:17:52 +0100
Message-ID: <20170802131752.zkvb2i2xvtrnz6e2@sirena.org.uk>
References: <87a83t6ulz.wl%kuninori.morimoto.gx@renesas.com>
 <878tjd6ukd.wl%kuninori.morimoto.gx@renesas.com>
 <877eyx6uiu.wl%kuninori.morimoto.gx@renesas.com>
 <20170802110549.ncpzscdey43nplmp@sirena.org.uk>
 <87a83ip5rq.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1467816344761862318=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 051B3267299
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 15:18:00 +0200 (CEST)
In-Reply-To: <87a83ip5rq.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============1467816344761862318==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ahcwwihndo5h43iw"
Content-Disposition: inline


--ahcwwihndo5h43iw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 02, 2017 at 11:35:38AM +0000, Kuninori Morimoto wrote:

> > Isn't this just a convenience for drivers though?  It means they can
> > just clean things up with one call and I'm having a hard time thinking
> > of any use cases for only unregistering some components.

> This means like this

> or do we want to have like this ?

> 	register_component(dev, driver_A);
> 	register_component(dev, driver_B);

> 	unregister_component(dev); /* unregister both driver_A/driver_B */

This was what I was thinking of.  It might not actually be the most
sensible thing but I'm pretty sure it's what I was thinking when things
were set up originally, if there's other use cases we might need to
change.

--ahcwwihndo5h43iw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmB0P8ACgkQJNaLcl1U
h9BefQf/XOYdaJqArJVoKwpnV2L0czJ5lm6byIJoR9hcS7ldSQ02svSQHozcCjxv
Byj9fqsS+e9fw5SgZ+ETxXHrznWI1UvA5cAPIcfd/kVTbk9qGC6VdXPVYzUKjntT
U/3MMsMEllfRjXJ5dtabIr6dlANmbAwHEVTzU37uWmSujMcEKImXlmA6W4/pQ/nv
0Pq5wbhTuRbDPFHkPeCQiExihqi7VFHoSw1K/Sf25V8CwhdpUZ6iixv+ga7/3epR
eJQEwHkiH9px6ZlwvWB7Wj8nKJG5wY/8zrPBaqfwS5JxZQUkn+KmbVXpyArNkILj
EwwZjzCQV8NbO6O1dv+MF25xRJu6XA==
=+Wdb
-----END PGP SIGNATURE-----

--ahcwwihndo5h43iw--

--===============1467816344761862318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1467816344761862318==--
