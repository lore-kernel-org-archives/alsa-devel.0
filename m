From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] ASoC: ts3a227e: add platform data for
	ts3a227e driver
Date: Thu, 30 Apr 2015 21:02:20 +0100
Message-ID: <20150430200220.GH22845@sirena.org.uk>
References: <1430358238-74659-1-git-send-email-yang.a.fang@intel.com>
 <1430358238-74659-3-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1272435302118709158=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 83B3F2617A5
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 22:02:25 +0200 (CEST)
In-Reply-To: <1430358238-74659-3-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yang.a.fang@intel.com
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, praveen.k.jain@intel.com, praveen.diwakar@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============1272435302118709158==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BCmKmcMXLhrd5LC7"
Content-Disposition: inline


--BCmKmcMXLhrd5LC7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2015 at 06:43:57PM -0700, yang.a.fang@intel.com wrote:

> @@ -296,7 +303,7 @@ static int ts3a227e_i2c_probe(struct i2c_client *i2c,
>  	}
> =20
>  	ret =3D devm_request_threaded_irq(dev, i2c->irq, NULL, ts3a227e_interru=
pt,
> -					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					ts3a227e->pdata.irqflag,
>  					"TS3A227E", ts3a227e);
>  	if (ret) {
>  		dev_err(dev, "Cannot request irq %d (%d)\n", i2c->irq, ret);

This doesn't make much sense to me - no change is made to the
configuration of the device, the driver just passes the flag through to
the interrupt controller code.  I can't see how that's going to work
well, somewhere along the line something must be misconfigured.

--BCmKmcMXLhrd5LC7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQopLAAoJECTWi3JdVIfQ0esH/RMJlcPMj46jhLHWw+6Vrmgc
6wL83xAit1MJKkfA1SkSIIeBeY5BmM3oef7sy4uFKyYP4YWZ6zqXJjB6skGr6Dp0
n+9SdpptKkz+DsHHFK5MSjTnlY4GA3vEMnQnBJNt26YkFme/eZrNy8JJWSfaVCQq
aAb4R5Hb2dh8k8RHyv1nxrtNhMSxGBah81CQhYbOP084tKN5SrcwdZH6QNG1ipjf
bc6s8Llnq+UECzqMHd8pZkkYGHIlnXfKFkLgErUCcuU5vs7PNRGKCbzO0oxHcmxd
O3xQ0CW/PIeF3atavpLpL/yKUnDv2Uy3bdYLeMUJLtnwgekMkr8oOOJfOKOx4Lo=
=axzV
-----END PGP SIGNATURE-----

--BCmKmcMXLhrd5LC7--

--===============1272435302118709158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1272435302118709158==--
