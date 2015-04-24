From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5645: set platform data base
	on DMI
Date: Fri, 24 Apr 2015 11:12:03 +0100
Message-ID: <20150424101203.GL22845@sirena.org.uk>
References: <1429832118-20741-1-git-send-email-yang.a.fang@intel.com>
 <1429832118-20741-2-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4828123312111705482=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DACA9260529
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 12:12:08 +0200 (CEST)
In-Reply-To: <1429832118-20741-2-git-send-email-yang.a.fang@intel.com>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, praveen.k.jain@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4828123312111705482==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mP0G5DnRF8tiiPfN"
Content-Disposition: inline


--mP0G5DnRF8tiiPfN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2015 at 04:35:18PM -0700, yang.a.fang@intel.com wrote:

> +static int strago_quirk_cb(const struct dmi_system_id *id)
> +{
> +	struct rt5645_priv **rt5645;
> +
> +	rt5645 = (struct rt5645_priv **)id->driver_data;
> +
> +	if (*rt5645) {
> +
> +		(*rt5645)->pdata.dmic_en = 1;
> +		(*rt5645)->pdata.dmic1_data_pin = -1;
> +		(*rt5645)->pdata.dmic2_data_pin = RT5645_DMIC_DATA_IN2P;
> +		(*rt5645)->pdata.en_jd_func = 1;
> +		(*rt5645)->pdata.jd_mode = 3;
> +
> +	}
> +
> +	return 1;
> +}

This doesn't look good - we're modifying the driver data which should
really be global static data.  I'd expect us to be doing something like
return a pointer to the platform data for the device, not modify things
in place.

--mP0G5DnRF8tiiPfN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOhbyAAoJECTWi3JdVIfQzo0H/jUNclVO4YjVYcL0KwNzp2fx
jJodJ19Jp0VWHfIxyxhxM0zk8EPI43edSARzta3MlukuJ2zdS3A5MxExt4EWiQGX
f+1iWXnx4FIvBanZ/vbTBqSrXHSWSkGNWjSuZEs7Jaxl4N7z2/FkKBWX18IyP/v0
qv1TiFrv/CdQTOA5Qp4dtGsjg4TUSEeTcRAOn0PwFzoWVXa6dQ6AmMJxjoSQZAfD
zvkoY2Zy1ITil+h1kf/EHC9RrPX6xhF5xCbaG7jmDYqe6D9Ik3HyL3qIRO5vcVew
VbTs81QTjLLmLA3kwIXaTAkbPC4j+qNPmdDAOwOHGCm35/egApvxLRRiops9Cx4=
=Rn8+
-----END PGP SIGNATURE-----

--mP0G5DnRF8tiiPfN--

--===============4828123312111705482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4828123312111705482==--
