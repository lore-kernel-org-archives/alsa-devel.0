From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Get correct usage_count value to load
 firmware
Date: Tue, 14 Jul 2015 19:16:15 +0100
Message-ID: <20150714181615.GH11162@sirena.org.uk>
References: <1436897626-118574-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ma/1igxvOqeHYdvR"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436897626-118574-1-git-send-email-yang.a.fang@intel.com>
Sender: stable-owner@vger.kernel.org
To: yang.a.fang@intel.com
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, vinod.koul@intel.com, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, srinivas.sripathi@intel.com, shilpa.sreeramalu@intel.com, dinesh.mirche@intel.com, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--Ma/1igxvOqeHYdvR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2015 at 11:13:46AM -0700, yang.a.fang@intel.com wrote:

> +#ifdef PM_CONFIG
> +#define GET_USAGE_COUNT(dev) (atomic_read(&dev->power.usage_count))
> +#else
> +#define GET_USAGE_COUNT(dev) 1
> +#endif

PM_CONFIG?

--Ma/1igxvOqeHYdvR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVpVHuAAoJECTWi3JdVIfQs7cH/3JgsMSS6qrUtbyN1VcVVDBk
nvi3QWokmN3URcKqvFM76/gmjLM/dErXVRb90V602PX8xOP2p3qp8snXPIK9kW5d
vyfvbuP7UprYbgJJO+0EYBnBDmkSSMKFvJPi17hjxKgAQRs9oC1naKgW61tGPm16
ph2CxGGOcfcl0L7kU9vBP4lwW6juYQRQwyFPPOW+b6exlVhqQMw8Px+1uvgWtR23
qZKnWguIAytoxvBAXLemjIsXI357PiHkpSc8RDzgM+roHJHNCe8RaF+8cy/ceWBz
zCSRevUngcVtyOqp1XzOmK73FN+4NiGoJDv9X2whRE13XmVjbwquX8k0W0+69Mk=
=ZG00
-----END PGP SIGNATURE-----

--Ma/1igxvOqeHYdvR--
