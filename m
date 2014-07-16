From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mcasp: don't override bclk divider
 if it was provided by the machine
Date: Wed, 16 Jul 2014 22:18:20 +0100
Message-ID: <20140716211820.GX17528@sirena.org.uk>
References: <1405512281-8188-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4560923274261044924=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BB4B2654AC
 for <alsa-devel@alsa-project.org>; Wed, 16 Jul 2014 23:18:38 +0200 (CEST)
In-Reply-To: <1405512281-8188-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4560923274261044924==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kVhvBuyIzNBvw9vr"
Content-Disposition: inline


--kVhvBuyIzNBvw9vr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 16, 2014 at 02:04:41PM +0200, Daniel Mack wrote:
> If a machine driver provides an BCLK divider to the McASP driver, skip the
> automatic calculation.

Applied, thanks.  I had to merge with Peter's changes for the DMA but
the resolution looked straightforward so hopefully it's OK - you
probably want to check though.

--kVhvBuyIzNBvw9vr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxuwZAAoJELSic+t+oim9j3EP+gO0zrWOuSls1+srz+pLjNVD
XwDkAQKrzsvaOrm5YYq6JF+TD7GYPXBJl3rZidJMH/1cN5wKWD32GtkHbOM3mStI
74WUv6TPAiDzydO3ag1V4cjjrOLMSBCm5/UiTNMLDyrrS+sjMmYLUDW3Gk5KoVff
jdJkXU1e949N1bhAekpUTKQv5//gyrqOiZTqFLUqEB7aKuu+hyx5ocZC/5+D0BsB
n1mP+YlhYhQEb5ZaG+fAXy/QqBORv+yYc6LENsdt4oj42kA1JGUb82N2rD32ExRv
hSkCYRMUkCPHkQOi7z+YlZJqrKAUI+cXklymvEhSTH0aEUxcmIHUWFfYZro19Gvn
JmxfZ2+Xhn9xy3h2gKUykhYRC2ABGFKbghZit4df8CX/z5O/42EiLv0Ozj3jnwWI
+0eFDc2Bu6DrwCnuMLZtTDx/POkmpfXECjuzq8UHOUhX+mzWcXfD+KYebUBZiT5J
IPcT89mYHiirnOMonJhk/UZd3l6DTukzWoNb4L5n7tBnGOBW1dYNxLGPpVQe3kp/
NuBDd0dFKOOmfBhhfdQtlHi3kX95W4N/tkLgNcGwIQIkvILpkGRPNrWXmoTKzW1Y
gIQGP9eHjun2QqQgB6C09Zmo6zsGWFjFZZk6+ri2m0LRsI4R+LWulZXNf4cJXeIU
vZemlzGbFxXcEihgWDCG
=Dhz3
-----END PGP SIGNATURE-----

--kVhvBuyIzNBvw9vr--

--===============4560923274261044924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4560923274261044924==--
