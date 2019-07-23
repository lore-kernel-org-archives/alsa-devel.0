From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: madera: Read device tree
 configuration
Date: Tue, 23 Jul 2019 16:03:02 +0100
Message-ID: <20190723150302.GH5365@sirena.org.uk>
References: <20190722135209.30302-1-ckeepax@opensource.cirrus.com>
 <7a6ca46b-9ca7-6c91-6aa9-d1be785c64c5@intel.com>
 <20190723081706.GL54126@ediswmail.ad.cirrus.com>
 <026ea350-db7b-d78c-cae5-e03cf735607c@intel.com>
 <20190723150125.GP54126@ediswmail.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3329091669038067503=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06EEDF8044A
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 17:03:08 +0200 (CEST)
In-Reply-To: <20190723150125.GP54126@ediswmail.ad.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3329091669038067503==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tcC6YSqBgqqkz7Sb"
Content-Disposition: inline


--tcC6YSqBgqqkz7Sb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2019 at 04:01:25PM +0100, Charles Keepax wrote:

> Ah.. yes I follow. Yes this is intentional, all the DT fields in
> question are optional so the driver should proceed if even if they
> are corrupt or missing.

If they're present but unparsable you should probably say something
about that really.  That's clearly different to optional.

--tcC6YSqBgqqkz7Sb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl03IaUACgkQJNaLcl1U
h9CnLAgAgBMgulNbgO+mODCP3VqzAG+tRDZpD7cC5cCiV1x/aXNSfavPK2GNXrxg
qOHgdcKgDQI+IgBReSd9FoZ9MfxRzcm65GyCpAdNqksiV9yDzPZLdkp0hjwv6E4d
IQEf0AvesltIfos6J8qzi1/Calu2ongmihCSkm9DMaR1JTZBEsydBrNbZ2PH6VZ3
wxh/GK45jpJODP51VXStnU9kYb8KIiBI4B6qbOPb6uOrTd01t8PyLNR2rDg5TiCw
gy+lXg+wbjM8hymIPzEX/EqG/CWq1StEN1ZLj+FH9ieeXCONylqRn4gdWp7i4w2v
vK7VmVM2mdKhfwzDb6bre4SvwcqpUw==
=Gbh1
-----END PGP SIGNATURE-----

--tcC6YSqBgqqkz7Sb--

--===============3329091669038067503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3329091669038067503==--
