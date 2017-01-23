From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 3/4] ASoC: rockchip: Add machine driver for RK3288
 boards that use analog/HDMI
Date: Mon, 23 Jan 2017 18:08:28 +0000
Message-ID: <20170123180828.s66tpj6yiopnezy2@sirena.org.uk>
References: <20170123104149.2508-1-romain.perier@collabora.com>
 <20170123104149.2508-4-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eruzgxvmquxakrwe"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170123104149.2508-4-romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--eruzgxvmquxakrwe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 23, 2017 at 11:41:48AM +0100, Romain Perier wrote:

This looks mostly fine but:

> +	machine->gpio_hp_det = of_get_named_gpio(np,
> +		"rockchip,hp-det-gpios", 0);
> +	if (machine->gpio_hp_det == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;

Rather than explicitly checking for probe defer here it's better to
check for the error code that indicates there's nothing to find (-ENODEV
IIRC but I might be misremembering for GPIO).  That way if there's some
actual error like running out of memory allocating some structure that's
required then we'll not just silently ignore it.

--eruzgxvmquxakrwe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliGRpsACgkQJNaLcl1U
h9ByBwf/TdiOCjxv3D6cOn5eNYMi29qwKJIEz2ZFaY9eLP8I652Z5ltxsiJL+C6v
8gmKPzXQPWYu/XOtKRC4TtC9LKvSGg76CQHndgB+qLwPA/59lbXGNPFfTZwJl/Nf
ZghkqsildElJ83NKVaBBTk/HksQ0j+KQlesO+9NT7UoRtXX6CiU3Bz6IKjpOtJD5
7+0wekiKn5j9yXGUrk90PvtNdeowgtMjRmFUq6gdJpPaOIVz0jmLvO9PqYmlS2Uz
IL3rmz6LDUnbKEH5FfiiMwiuD2bAdHpwpz7s2VUzZRDh1yrmC2K5dR0dHutSkwD0
1ICNXtdXppfd+GXTFnPgro0NSefqng==
=i5XN
-----END PGP SIGNATURE-----

--eruzgxvmquxakrwe--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
