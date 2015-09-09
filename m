From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] How to perform audio offloading in none
 tunneled mode
Date: Wed, 9 Sep 2015 10:56:20 +0100
Message-ID: <20150909095620.GH9751@sirena.org.uk>
References: <E1ZNiBu-0005i8-Ks@finisterre> <55EF06FC.90400@st.com>
 <55EF10CE.3040803@linux.intel.com>
 <20150908173245.GF9751@sirena.org.uk> <55EFEF84.9090102@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1821368554116050885=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AABE22602AD
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2015 11:56:32 +0200 (CEST)
In-Reply-To: <55EFEF84.9090102@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1821368554116050885==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fd5uyaI9j6xoeUBo"
Content-Disposition: inline


--fd5uyaI9j6xoeUBo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 09, 2015 at 10:36:20AM +0200, Arnaud Pouliquen wrote:

> I have my answer, not standard API for no tunneled mode.

Well, the standard thing is what Pierre described - play back and
capture via standard PCMs with routing internally to the card in the
usual fashion.  It's just not something people normally do.

--fd5uyaI9j6xoeUBo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJV8AJEAAoJECTWi3JdVIfQv4AH+KrpwB34+370AQRsrSiYyERT
HJKZMbBuZsxaFZJWxL/Vfmjdf7mCWQC6siU5p1o7cP5tz/MX2BLq8qkpGXIyXp6Z
cOuqYWpW4EsuQM18tzSFVkT1H5ILLJIKyvCqdNNEpFaCAwy7fd+hmhbPwBObl3Mm
FbzX7tkJwKCOMCoTSvy8IyxFvgSrlFwgnQznGjDdB0aLD/uC+Y9eZFeqfQdXUY1U
gCRO45z9f2ba7gcyzAUg6NXdL9ZcZOBleYQmjdCA2WeTb4zutMc40R3oLWiaF6Xw
wk0u+fkfSquneHAMYYQY/HFADDLIC3CAFTxCGjyQwmy3hyVVUqvYB1inmBgGPw==
=d60n
-----END PGP SIGNATURE-----

--fd5uyaI9j6xoeUBo--

--===============1821368554116050885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1821368554116050885==--
