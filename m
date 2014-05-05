From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] ASoC: Make soc_find_matching_codec() static
Date: Mon, 5 May 2014 02:31:45 +0200
Message-ID: <20140505003145.GA18069@earth.universe>
References: <1399223910-28710-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1660685092248007809=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.19.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B6BB261A88
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 02:31:52 +0200 (CEST)
In-Reply-To: <1399223910-28710-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1660685092248007809==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 04, 2014 at 07:18:30PM +0200, Lars-Peter Clausen wrote:
> The function is only used locally, make it static.
>=20
> Fixes the following warning from sparse:
> 	sound/soc/soc-core.c:1644:22: warning: symbol 'soc_find_matching_codec' =
was not declared. Should it be static?
>=20
> Fixes: 3ca041ed ("ASoC: dt: Allow Aux Codecs to be specified using DT")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTZtvwAAoJENju1/PIO/qam6EP/jhf+ELJ3hy0LZGZET1JB4Ay
PTi5lo8BdCdfQzmfO4Bq715Ww1LsnK3/naQFAEK7APZ1bu2CTS1UHbZc2ACmh8jQ
Qr7PhejQzf4QeNvvUgMJg6hW6YvlxccmA2xvuRhDZLeBDR/R1qj1xZ7nSKLbWScw
i+FDO/GBTx4Vb6Q2hQund52OOOdstujbvGDgE8Urf/MKTPrn8RyRlnIUdtXggwJT
wTo7mrYMMptKgpodpB1alI9MYZR/yvi2CEVTogMpnF/EyuH3ebhhR3nFBjJ35Kbm
MoUSgtcMZ2GGFnUvy8Z7Wg8H9Sr/gDjsCt3ylrjpyn8Ukze5kLiCbTb6MyMK09Mo
r0u7tTILcRG4Pz9P7sRR7sAPJ/MCRW6YfsXCjBXnCA2iX6V8EyypYWTogI1929no
VNN6WtBmjbMDCZOEVTfnY30kt0e0/wsVFiA27zMRg6kGTKp25ksFteTlnHT+eMzs
/lk1uBzgEntLig612HtqfR/LSkGpTb96bFwDnDh75iIq+gQw2H8BWMdb3YR7SgvR
/cF4UR6xTzJt4ioyLAWU7/D4JNycHjg5+knZgAHXSx0/F7MyFnX9X77yfmdEmr+X
Zp/a8qpgo8lQhiHlit2JxcUwfGMJzedea61BS3hmNplkORK9b097i2JMS3GmwIFx
wC9CAk+W57M3wFH5ir2/
=VfI5
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--

--===============1660685092248007809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1660685092248007809==--
