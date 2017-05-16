From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/3] SoC: es8328-i2c: Add compatible for ES8323
Date: Tue, 16 May 2017 12:18:37 +0100
Message-ID: <20170516111837.3uf5f5jbdkrnjudi@sirena.org.uk>
References: <20170512132227.24916-1-romain.perier@collabora.com>
 <20170512132227.24916-10-romain.perier@collabora.com>
 <20170515214138.u63u7j53jogk3prm@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oqgk6hcciwcs2oz5"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170515214138.u63u7j53jogk3prm@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--oqgk6hcciwcs2oz5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 04:41:38PM -0500, Rob Herring wrote:
> On Fri, May 12, 2017 at 03:22:25PM +0200, Romain Perier wrote:
> > This commit adds a compatible string for everest,es8323. This is an
> > audio codec that is compatible with es8328 and can be found for example
> > on the Firefly-RK3288 board.

> If it is compatible with the es8328, then that should be a fallback and=
=20
> you don't need the driver change.

While people don't strictly need the driver change it doesn't do any
harm either and encourages people to get the information into the DT
that it's a different chip.  Thinking about it it might be good to have
a way for something to validate if fallback compatibles are being listed
when they should - the drivers could provide the information fairly
easily I guess, or it could go into the binding docs once we have a
schema format.

Even if it doesn't currently make a difference to software I'd rather
get the information in there for mixed signal devices like audio CODECs
- it's not that unknown to find later that supposedly register identical
chips have some differences in the analog which we want to care about.

--oqgk6hcciwcs2oz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlka4AwACgkQJNaLcl1U
h9CnCgf/eh6wnAxeB6o6ruQceS0PLXfL9HZ1JONpYvQSsvZbHL6J6CPa9gcnrXpa
9jtMJ4LoNWhXQKh9N9X8lSH5Jyuxz+giNXai/vEdvDG/bQeD/19zL9DRx90dO2sN
ccKfScTBRGEsR4V1Njgw5EHBBIbMhoPSJIQt/ccRBizpLHOaBe2x0l2IPgEwUzy+
sUFbhXY5B0aVjLhlQlVLhnxqVcd5piVg5m8NhhycdGwc5rrjXEJCwwx0/8qgxW/S
vghQ/OGGSJDXvTD8uZ2x5UiSakHor0BYGT4pW+0ZPyxDm5NV0hn5QcHwQWdqQUgp
xDq5M+6/qalIW3o6RX2RxInRjLJzBg==
=nVsJ
-----END PGP SIGNATURE-----

--oqgk6hcciwcs2oz5--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
