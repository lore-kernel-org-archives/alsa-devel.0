From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 0/4] Add support for es8388 and hdmi audio on the rock2
Date: Mon, 23 Jan 2017 17:54:51 +0000
Message-ID: <20170123175451.hwvuum4ismutrbsf@sirena.org.uk>
References: <20170123104149.2508-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qh7uxobyyv5bwgbo"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170123104149.2508-1-romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--qh7uxobyyv5bwgbo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 23, 2017 at 11:41:45AM +0100, Romain Perier wrote:

> Changes in v4:
>  - Add support for multi codecs in the asoc machine driver, so the driver
>    matches the hw architecture (analog and hdmi audio are connected on
>    the same i2s line)
>  - Renamed the driver to rk3288-hdmi-analog.c and changed its
>    documentation
>  - Add built-in support for hdmi audio in this driver
>  - Add support for the property 'rockchip,routing'

This is the first version that has been sumbitted upstream.

--qh7uxobyyv5bwgbo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliGQ2sACgkQJNaLcl1U
h9DWrgf/cabHv+hPcw1cw88lEyI/z6V1qI/t3uKPTq8W381/n8UvI74wKx5yuHuS
XJ4GEpe6N7K1tD9+8vPQkkC6dxOYlkOwwXFgwfPtgDLZaLRt1wybyoRkolohJpil
WFMUT6hhfmagvyYIEvPRsMiNVuVUomX0umMZCFpo6CjoJ1ChIiPC3S2iZvwJJhG5
phMUfPD+Q95bbh/ZGH2eIKI9+/oizFnFqVyhzuOLKCLGkSTUgSeteAjE3ySqL8q3
eaMtvtkhCN0HfySxcI+VYqbM0qxOQj34GobXsLjoLPj1w+EAT11pjjauc2VubZ6S
c1+e7Gk2Vw3RYtgwQMQmUDHW+16c+A==
=yj7b
-----END PGP SIGNATURE-----

--qh7uxobyyv5bwgbo--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
