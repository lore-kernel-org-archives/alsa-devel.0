From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 00/10] ASoC: support adding PCM
 dynamically from topology
Date: Sat, 15 Aug 2015 08:50:35 -0700
Message-ID: <20150815155035.GG10748@sirena.org.uk>
References: <cover.1439217448.git.mengdong.lin@intel.com>
 <55CEF0A8.5030707@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4496778395335105488=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B7B826510A
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 17:50:55 +0200 (CEST)
In-Reply-To: <55CEF0A8.5030707@metafoo.de>
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
Cc: tiwai@suse.de, mengdong.lin@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4496778395335105488==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fjRHIBfqI5bf54wl"
Content-Disposition: inline


--fjRHIBfqI5bf54wl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 15, 2015 at 09:56:24AM +0200, Lars-Peter Clausen wrote:

> This all sounds as if the dynamically loaded topology information does not
> describe dynamic topology, e.g. like DSP firmware, but rather the static
> topology that would usually come from things like devicetree or ACPI. Maybe
> you need to rethink when the topology information is loaded and make sure
> that the parts that describe the static topology are available before the
> card is instantiated.

I do think that's some of it (as I said in my replies in the series),
but I got the impression from some other discussion that some of this
was about host<->DSP channels that exist purely in software which does
seem like something that could reasonably be in the topology, but this
does seem more like the fixed links stuff.

--fjRHIBfqI5bf54wl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVz1/KAAoJECTWi3JdVIfQZ6MH/iXZdD0ax/yhaclojELLNtLj
YXWbR4FZ85n3LPEqW81gGUqAv6GQ2cShiJ7F3UQRROcXsMcYmLclZdWljHQ07Z1m
bEMvYspMBl4jYY2+XebnDiN3dxKfY6veV/C7Spxp+OcZhU5eLMjTCf4hBKj+tDjI
nUjiCqjZD5MBGdg2I3iO53WLZay6zy/asEq13nSeMfIU/UzigNIy6cq6joH+dBgh
I1rvgW/2HKcOw0nBIr4EsZhvEqY6BKKng+1/8hvyOCpUbK66D8rjcN64axrVNY0K
UQ5UnZYfOJQx6UJA0gdpQfRQRr7z5RgnAz+ZdQU1/9SQFWQEXi1VHv581P6oVzU=
=/cYj
-----END PGP SIGNATURE-----

--fjRHIBfqI5bf54wl--

--===============4496778395335105488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4496778395335105488==--
