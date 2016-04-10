From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add max98371 codec driver
Date: Sun, 10 Apr 2016 19:04:21 +0100
Message-ID: <20160410180421.GA18319@sirena.org.uk>
References: <1458629605-6225-1-git-send-email-yesanishhere@gmail.com>
 <570720D5.9060901@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8199023393642699271=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A033F26074D
 for <alsa-devel@alsa-project.org>; Sun, 10 Apr 2016 20:04:31 +0200 (CEST)
In-Reply-To: <570720D5.9060901@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8199023393642699271==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 08, 2016 at 05:09:09AM +0200, Lars-Peter Clausen wrote:

> > +	ret = regmap_read(max98371->regmap, MAX98371_VERSION, &reg);
> > +	if (ret < 0) {
> > +		dev_info(&i2c->dev, "device error %d\n", ret);
> > +		return ret;
> > +	}
> > +	dev_info(&i2c->dev, "device version %x\n", reg);

> Drop this, it is just noise in the boot log.

It's generally OK to print information about the actual hardware found
in the system, it can be a helpful diagnostic.  Getting all this stuff
into sysfs files would be even better but that doesn't seem to be how we
do things at the minute.

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXCpWkAAoJECTWi3JdVIfQetkH/1BNLxtexro4dQx4gWwiZfKj
7wVGC1v6cFHhlD1KjBlMOn3zKmdjwBNqVZa6I9AVQcC7NU9e/C+7Uu0hzdr/ZDqX
Nq0dedWwfuhmnNZuLYU238m6fxCgl/jF5zBUPQhAUx66GnbP7wzEzNAt7AKAUq5r
T7I3IXt6N0+StbVpDNvXWxzoAX2hp3o7S1S/FNBiKv1HDeLruRqJJcMbJdmWXUdc
hDnKYMm1aNk9wsNycOHzaAs+Jp+20alWMOE0u87bT7OA8/Rch9pHWL28riEQRxN8
xJYBF2OLaNkMVo/2ma8xAJ6st4pzLAYPs0IrxmlYRPZoQuI5n4dva6WYu6ER0zU=
=fyII
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

--===============8199023393642699271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8199023393642699271==--
