From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] ASoC: fsl_ssi: use flat regmap cache
Date: Mon, 26 Sep 2016 12:13:38 -0700
Message-ID: <20160926191338.cxqqqq5eybxqxqss@sirena.org.uk>
References: <20160919193029.8119-1-marex@denx.de>
 <20160919193029.8119-4-marex@denx.de>
 <57E2B53C.6080708@maciej.szmigiero.name>
 <b54cd59a-97d0-e02d-16be-7aa6752bbb35@denx.de>
 <57E3074E.4070601@maciej.szmigiero.name>
 <8d5ad78b-3850-93bd-e299-215f001da9c2@denx.de>
 <57E318DB.3040600@maciej.szmigiero.name>
 <20160922104530.GL7994@sirena.org.uk>
 <0ae54910-0712-006c-0afa-a59b63a904be@maciej.szmigiero.name>
 <5506d5e4-4480-3a7d-9455-b314070bda7c@denx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0581716719778743328=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 17CBD265598
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 21:13:56 +0200 (CEST)
In-Reply-To: <5506d5e4-4480-3a7d-9455-b314070bda7c@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org


--===============0581716719778743328==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4ths4ov45hazh6ev"
Content-Disposition: inline


--4ths4ov45hazh6ev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 22, 2016 at 05:27:42PM +0200, Marek Vasut wrote:
> On 09/22/2016 04:37 PM, Maciej S. Szmigiero wrote:

> > There are three possible solutions:
> > 1) Go back to RB tree cache (revert patch 4) and debug the lockdep warning,
> > 2) Keep the flat cache introduced by patch 4 but debug the oops at
> > cache init time (while keeping defaults read from hardware),
> > 3) Keep both patches and risk the same issues that were previously
> > caused by hardcoded register defaults in driver.
> > However, Marek says the device works fine for him with the patches.

> I believe switching to flat cache is harmless and it should be a better
> mode for devices with small mmio address spaces. After some discussion
> on IRC, I believe [1] should resolve the RBTREE crash (?).

So, can we get a clear decision on this after testing?  The discussion
here and the discussion on IRC are a bit disjointed and I'd like to make
sure we end up with something that definitely works.

--4ths4ov45hazh6ev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX6XNeAAoJECTWi3JdVIfQpsMH/iq/5JeraXT3XLTSl/ZVQazm
CYZ6GIBKshC0Gfs4d/ZmtHkkdo8ehJeO7OD1N/1FOCWmLFLaPptFk632WhvL7r1P
yKeoQgJ4gLbqvtx8zGEAEiOFRWtqZKGGM3zB0vpobEgkqiLbyjD8ToBOVpaK/uVj
v8f9FpXFPFL+OLBuO5np9H5PhfOWQcyklsifvy5sFdYVhvx+zT32hu5ePn/cmaMa
mgnNqoTdxiKlZQb9qVj67p4QqAtCM30rvF05hpovLKpiCrcrQhr1NcRO3cfi7i0N
dflRSnylLmT4Y+QMBGq6zDvb3vF1mQKdbqZJf/N67SPxlU5byDbHFdl3C1CzkPg=
=uSKu
-----END PGP SIGNATURE-----

--4ths4ov45hazh6ev--

--===============0581716719778743328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0581716719778743328==--
