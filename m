From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: Intel: use common helpers to
	detect CPUs
Date: Mon, 17 Jun 2019 15:47:27 +0100
Message-ID: <20190617144727.GR5316@sirena.org.uk>
References: <20190528200255.15923-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3296825607145648300=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 289D5F80764
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 16:47:31 +0200 (CEST)
In-Reply-To: <20190528200255.15923-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Randy Dunlap <rdunlap@infradead.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3296825607145648300==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UuuTb5hZdWr4w/Ub"
Content-Disposition: inline


--UuuTb5hZdWr4w/Ub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2019 at 03:02:55PM -0500, Pierre-Louis Bossart wrote:

> 2. is there a better way to do this for all Intel chips or do we keep
> this in sound/? Andy?

ARM has platform detection stuff in the architecture code, something
similar seems sensible for x86?

--UuuTb5hZdWr4w/Ub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0Hp/4ACgkQJNaLcl1U
h9BQXwf6AiLrtgjV2fuE0szKqyv5VkcnkrEukEJfxaGSaArMy8f1zuab1VydWr59
8sHP5zlpF79CcgVL5CFHzGOGHRshS7BDnP3pY8lc1Tp0uGv4wOpZhD4vWgFnHZki
dqeExtm/IwCaYAQGyTdkMsgyxL6GofoSHiDSrNxtUvWa53oeGKAnWR9Hm/PTeABV
Nu9C0x/p2IPpaQ6Z4UeJSAMmjHewSqE1h13umzZTdH4vAaoxFCTozmdngIVwudzD
DQzpKEp78ckxvrEUutXIhYjsP6ynwQ/Apllp3qZTjDJSuW2uPsCwCLIPGm0xE/zR
5Qt030I39ikeNnxXyheOLomvqMRVJg==
=0VwX
-----END PGP SIGNATURE-----

--UuuTb5hZdWr4w/Ub--

--===============3296825607145648300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3296825607145648300==--
