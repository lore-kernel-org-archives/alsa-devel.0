From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/5] ASoC: Move standard kcontrol
 helpers to the component level
Date: Mon, 12 May 2014 12:03:04 +0100
Message-ID: <20140512110304.GB12304@sirena.org.uk>
References: <536CF16F.8010807@metafoo.de>
 <CAOMZO5Cb4Q80ux1R9EOcsaCPFsmxz3K5Obt02or=s0RitmPMKw@mail.gmail.com>
 <536CFBE7.3070805@metafoo.de> <20140510050747.GI2870@dragon>
 <536DCF6F.9020507@metafoo.de> <536DD108.2090607@metafoo.de>
 <20140510083131.GL2870@dragon> <536DE548.9050008@metafoo.de>
 <20140510091209.GM2870@dragon>
 <20140512104204.GF25203@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8585614724363341155=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C3CF2616F6
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 13:03:24 +0200 (CEST)
In-Reply-To: <20140512104204.GF25203@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8585614724363341155==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m/MsweddsUN8J3b6"
Content-Disposition: inline


--m/MsweddsUN8J3b6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 12, 2014 at 11:42:04AM +0100, Charles Keepax wrote:

> > Yea, you're right.  When the error message shows up, _regmap_read()
> > returns -EBUSY for reg WM8962_CLASS_D_CONTROL_1.  But how do I find out
> > why the reg is not in the cache?

> From what I can see it doesn't look like this register should be
> volatile. I am checking with the hardware guys here, incase I am
> missing something, but otherwise I will wing out a patch to make
> it non-volatile.

IIRC at least one of the bits in the register also appears in another
register.  They aren't volatile but the cache could get confused unless
something is open coded to keep the two cached registers in sync.

--m/MsweddsUN8J3b6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcKplAAoJELSic+t+oim9EhwQAIofzlqz/jsdhAW6K0H3cKuk
4KVyVJjMCzLm1R2Iagp7vbyG7gedTRv4WDZNdfpWTas5gfP4HgobsOKYXH7iYrUu
uHVnGEudu90lBolLEvQG/nEvHiS9AdOzStWzXZJePCimG2xD6SDGAT/yG6dV4Y8F
4KnXo2zojtP8UcOCFOK0Rtk57HeOEfKtvIsT+WKEzcvcDlscwrw8HwiF3NxUv4Hs
MRZ1RAHwX65Bn8V6fnjAYTkkmkUzR9UKxhR2AXMQvJuqoM+rfoEtdU//P0g3OZG7
nzvCeUkRqxSqE5wyYfdI7s/cRsteoF0x4mysPRUJTbbp0EzY5b8ZE1fBF7wQOxE2
T9laHcxLD2HK3bTKYT9PxmXes09Cw6sKKtlTURe5wCvrsC5YgVcxxEs+zcTPBhjx
oz3EQes8HU/NhoiYR+UGgi8yzgpifT9+oZxA0D29GSm0voWZq8lpYnMiyO5/G3oP
AThZieJ9BMF17r7osFIWqokcn5rbYrosLtGJ+PcJ9T8tetubQ+NCslhDAq01sEOI
YSCf3JlepI3fXMdL6VbVTnAOCIQiKmDJqSVbpac15wrO2NESS6n4JaGmDhkNNNX/
Efk+ovmyIXhephigsd4YL+k8fn1zt3JDhtXtPDNreRpJPtTXv+912J04EWUIpF96
NFxQ1JELUwSebuzz9mD2
=Jx95
-----END PGP SIGNATURE-----

--m/MsweddsUN8J3b6--

--===============8585614724363341155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8585614724363341155==--
