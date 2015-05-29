From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] ASoC: max98090: read micbias from
	device property
Date: Fri, 29 May 2015 10:58:58 +0100
Message-ID: <20150529095858.GM21577@sirena.org.uk>
References: <1432684686-14460-1-git-send-email-yang.a.fang@intel.com>
 <1432836048-102175-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1689930498360405815=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 364C7260673
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 11:59:06 +0200 (CEST)
In-Reply-To: <1432836048-102175-1-git-send-email-yang.a.fang@intel.com>
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
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, praveen.k.jain@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============1689930498360405815==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oB61DKt4BTdhjpGI"
Content-Disposition: inline


--oB61DKt4BTdhjpGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2015 at 11:00:46AM -0700, yang.a.fang@intel.com wrote:

>  - maxim,dmic-freq: Frequency at which to clock DMIC
> =20
> +- maxim,micbias: Micbias voltage applies to the analog mic

This needs to be more specific about what the value is - it looks like
it's the value to be written into a particular register?

> +	err =3D device_property_read_u32(codec->dev, "maxim,micbias", &micbias);
> +	if (err || micbias < M98090_MBVSEL_2V2  || micbias > M98090_MBVSEL_2V8)
> +		micbias =3D M98090_MBVSEL_2V8;

We should be logging an error if we read and out of range value here -
it's expected that the value might be missing but if we manage to read
something and it's invalid we should say so rather than silently ignore
it.

--oB61DKt4BTdhjpGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVaDhiAAoJECTWi3JdVIfQJZwH/0zJ4nv3EmJvZ87N/m6bnD72
aO2uVf+vxT4aXYb3ZOWt/Ka440/CzIDNohDur9+Jcw/ks85ROc1M5e48ubr0VCR4
CXlzvkRqJqvsO3zETWnVRx6K8fr4NfiOB9imIodqeNWwaHZzKHUgwrMAEa31S09U
3AOM4rdsMH4jYAa/27+3ho3S2z+MBFvuefKsYRy9AO0sxbIcZPFjA9pFu3aCicHc
sAWHIRpEhYkMFE+LiBpgMv4YPNlkkmx7NoFG2MClTJJTL+Fdxr6ie4xUMidbFaTX
aGe2kHdBhgBVwcZFEbj6anEQps9txM8LuSveSygBQfVbhzkeP1/d5e5B1N3l3AA=
=GKVW
-----END PGP SIGNATURE-----

--oB61DKt4BTdhjpGI--

--===============1689930498360405815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1689930498360405815==--
