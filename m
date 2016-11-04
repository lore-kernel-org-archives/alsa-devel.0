From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 14/17] ASoC: add simple-graph-card document
Date: Fri, 4 Nov 2016 14:33:42 -0600
Message-ID: <20161104203342.aizjufjokuqrlyhh@sirena.org.uk>
References: <87pomhba6r.wl%kuninori.morimoto.gx@renesas.com>
 <8760o9b9xm.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vcshtpj3anbp2h2m"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8760o9b9xm.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Guennadi <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--vcshtpj3anbp2h2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 31, 2016 at 01:19:58AM +0000, Kuninori Morimoto wrote:

> +This Simple-Graph-Card should be located as CPU driver's port[s].
> +And then, CPU driver need to probe it by itself.

This document really needs quite a bit of fleshing out but I'm not sure
that should be a blocker for the series as a whole especially given that
English is not your native language - we can build out later.  I think
based on what I'm understanding here I like what I'm seeing.  It'd be
good to get some confirmation from the people with more of_graph
knowledge that this is a good usage.

One thing I'm not 100% clear on here is why it has to be a CPU DAI (I'm
guessing just one of them though the above says ports as an option?)
that creates the card?  Is there a concrete reason for that or is it
just being defined as good pracctice?

--vcshtpj3anbp2h2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYHPClAAoJECTWi3JdVIfQiNgH/3unAu79po41rnmGcpxj9keq
Y9Ot59ZAHJjPyrGS/yMvbo0mlgZ954uhlw4qG/A876C2XAn/usFdbOwBfcXR9UJ6
lMhfVnnK9C5Wh5gmIYr3EhoihfRxAHzuxjNrvZsBH8qe6qGwHOhSx9AFdhGgfuuq
7u7IE8gIH9ZZDYAch9fvAfnpVu1eFd3bQKWijNupQpiu51/0LWiPqC5D5ZA+2trB
YTcIZ3YRzEwlfcYOQirBo1xdzP/oq/OB8hNQCoR1cw3oxMzyFB9rDwRJ+KFcE9aa
M4CDP+uNSlwQpeTf8DWPJ6mV0UuZwrg9Yf3K3gQp/q9tMcRYpCCcfx+/Jxd3Mhg=
=uorA
-----END PGP SIGNATURE-----

--vcshtpj3anbp2h2m--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
