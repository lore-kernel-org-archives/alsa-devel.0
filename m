From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/13] ASoC: tlv320aic32x4: Propery Set
	Processing Blocks
Date: Tue, 19 Mar 2019 15:37:58 +0000
Message-ID: <20190319153758.GJ5514@sirena.org.uk>
References: <20190319033756.20616-1-nh6z@nh6z.net>
 <20190319033756.20616-13-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6791255572597445502=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8557EF896FD
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 16:37:59 +0100 (CET)
In-Reply-To: <20190319033756.20616-13-nh6z@nh6z.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: alsa-devel@alsa-project.org, team@nwdigitalradio.com
List-Id: alsa-devel@alsa-project.org


--===============6791255572597445502==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ofZMSlrAVk9bLeVm"
Content-Disposition: inline


--ofZMSlrAVk9bLeVm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2019 at 08:37:55PM -0700, Annaliese McDermond wrote:
> Different processing blocks are required for different sampling
> rates and power parameters.  Set the processing blocks based
> on this information.

Is this another bug fix or does it depend on the rest of the series
somehow?

--ofZMSlrAVk9bLeVm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyRDNUACgkQJNaLcl1U
h9B3Ogf+JISEGpuYLsomnwFNkABRJtoydpsyveI2HXN2cs4OgT+1+HXObPkzwF6Y
JsbR43pY+fmhClx3IG0JHrG8RwG+W4LybdZl1n+LvXM/As/qhgXeH9DHW2bUVCYj
GNHHSuuZ2GQAgqYRwqvQM5nAlLvevF1oxT+saVBLlJURWJVhmbeKZZB/oB8sJjgh
MTF38gUOVGwMZDg2AHvR9iczm4j5WUO8HQuetaD56eim2cAwW4CFRHfKPFw59Hhk
2GpzmDQU16nG4N2kPlWNgshvctsB06Prh8HhZCZ3lSOOMQPpXAdTLC7Q2Qf70dy8
JsczW9IdSVutYy1+IETUirnEsEVTjg==
=+H9J
-----END PGP SIGNATURE-----

--ofZMSlrAVk9bLeVm--

--===============6791255572597445502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6791255572597445502==--
