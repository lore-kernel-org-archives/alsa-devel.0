From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: pxa: add COMPILE_TEST on SND_MMP_SOC" to the asoc
 tree
Date: Thu, 22 Jun 2017 10:17:43 +0100
Message-ID: <20170622091743.x3userwryot4fhdx@sirena.org.uk>
References: <87lgom6jun.wl%kuninori.morimoto.gx@renesas.com>
 <E1dNdcn-0004Ex-6P@debutante>
 <87o9tgdgyf.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qinwrwrl2u7honqh"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87o9tgdgyf.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--qinwrwrl2u7honqh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 22, 2017 at 12:11:31AM +0000, Kuninori Morimoto wrote:

> Oops.
> It seems this patch breaks ia64's compile.

> I'm sorry, but can you remove/revert this ?

I did that yesterday - it breaks everything except plain ARM.

--qinwrwrl2u7honqh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllLizYACgkQJNaLcl1U
h9BNMQf/Yw+/VQTDX/Ys2BLRgKTViG3KbEeAP14uANTYdrh3bMx2vrC/SkEa/UL3
1h8aUPorXnmJlw+K7U/AhhDqoU1SrD1FkDe3sspGP+oZTC29tA43zgR66qr03mus
duZda9OpncUsUH/KeGCqsSEKEpkGmIbFhuj9NX/l4pSejpEyipBa+zTOZa/tgWNZ
2QPDkKJKfuvb+urlpoRDqwLmUq292yAXg/VFXS1fUxAIJNQIPcQCUyHlKhF+UFea
sx4LRWY9N/2zRnAJF0KGfzOfEsdZT9nDzBRL/rBVv+34lUUIri7hOAIW/qyK+myy
DNyCHMjllOL4k4KBpEFL4mXFaXoKeA==
=8jzq
-----END PGP SIGNATURE-----

--qinwrwrl2u7honqh--
