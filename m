From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Add support for PM ops in
 bxt-da7219_max98357a
Date: Fri, 17 Jun 2016 17:44:00 +0530
Message-ID: <20160617121359.GH16910@localhost>
References: <1466138010-27740-1-git-send-email-vinod.koul@intel.com>
 <20160617111407.GE26099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7127818778503857434=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id CCC7426582C
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 14:07:16 +0200 (CEST)
In-Reply-To: <20160617111407.GE26099@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7127818778503857434==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="90KBcPA0h13nTGdQ"
Content-Disposition: inline


--90KBcPA0h13nTGdQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 17, 2016 at 12:14:07PM +0100, Mark Brown wrote:
> On Fri, Jun 17, 2016 at 10:03:30AM +0530, Vinod Koul wrote:
>=20
> > +static void broxton_complete(struct device *dev)
> > +{
> > +	snd_soc_resume(dev);
> > +}
> > +
> > +#else
> > +#define broxton_complete NULL
> > +#endif
>=20
> Just use snd_soc_resume() directly.

Nope, that leads to warnings.

=2Ecomplete is the only callback that expects void return whereas
snd_soc_resume like other returns int.

struct dev_pm_ops {
        int (*prepare)(struct device *dev);
        void (*complete)(struct device *dev);
        int (*suspend)(struct device *dev);
        int (*resume)(struct device *dev);
	...
}

Thanks
--=20
~Vinod

--90KBcPA0h13nTGdQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXY+mHAAoJEHwUBw8lI4NHcpAQAJkTbUcuGjxby+wR5Q7cepdg
kNaZ/NK3bm6ip+tERC3gvae4T7mNOsggccrcMB3CTF9UUrRpH6joSDWqb1MXYSGV
aMmMMt0JuRtqfYcss9GhaDnySBeqU9fLGiK0vGYSnujjJR5eDZeK+F8O1110axZB
85dJCzAMe5vHHvvpwpPuTM5u+GMMk5N07MsB8BzxY2iR1Yf6Em0slJv/YpTPusIG
JKxjpSvF/GE0BCmBG4pNUUxeQhol90uEC+deVvSrbMi0XijVOEfaWpaDSdznAjDC
qANm4gwmwcYLwGwRBMw65L7ogOaMQGZmfK858Tx81bpsXYphcgGfxGk2BzAYr2H8
fcmXwo9Tt4/jN4yrNi6f7a2pMvkD94xoGmqgIF+LFyDUZI9rHzU9qcJEPgW2BykD
VLDJUKjzU5U4gMobSN599tXF1Akrb94nOfQznVTZNfy5QRd6KVHN5Mq0F8kaSLuT
Py67XhaYD/hJrVio9wgG6ZPF1NEWnpEetLwolOaHA/RUCUdWakXCjcCWI+AZdD1k
rn3DWZlV4kRNWUnKjjV0UiKPyt8q3GpBlQaYfPfGsvUBmiEL/vYfflSnqmChkaaB
nSgCJT4Bbx4zU0gnvK0lUhBagLdSxf1av1KSqDyOiJmbHPQn/KPfDjAKzmwaHgoF
VIm5nzYQobjd+Y+mPGQ5
=QbdQ
-----END PGP SIGNATURE-----

--90KBcPA0h13nTGdQ--

--===============7127818778503857434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7127818778503857434==--
