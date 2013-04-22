From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/8] ASoC: mxs-pcm: Set
	SNDRV_PCM_INFO_HALF_DUPLEX
Date: Mon, 22 Apr 2013 11:28:24 +0100
Message-ID: <20130422102823.GE30351@opensource.wolfsonmicro.com>
References: <1366478947-9377-1-git-send-email-lars@metafoo.de>
 <1366478947-9377-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1861322266358632279=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 549F02610CF
 for <alsa-devel@alsa-project.org>; Mon, 22 Apr 2013 12:28:26 +0200 (CEST)
In-Reply-To: <1366478947-9377-2-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============1861322266358632279==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AjmyJqqohANyBN/e"
Content-Disposition: inline


--AjmyJqqohANyBN/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 20, 2013 at 07:29:01PM +0200, Lars-Peter Clausen wrote:
> The MXS SAIF is only half-duplex so set the SNDRV_PCM_INFO_HALF_DUPLEX flag for
> the PCM in order to prevent playback and capture from running at the same time.

Applied, thanks.

--AjmyJqqohANyBN/e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRdRC8AAoJELSic+t+oim9CmUQAIEwctLP3c2FYbp5h9NFgjX2
WQTKZpeOiTOnuTQnJDcYbbGwzEzOFnZg56r7EnNrzm82fh06+JaMvkN/AyOXdi19
YstOYfpxFM4OEmhY7Gdo4Abm9FrRCCpx3mtbLjq1zQnqwVyBSEM75wUIojxtJWzw
bKJVwviRzS0L9cMFS8dVR0N2Cq7MlZ3AXhn0HH31yyrCr25u59yl3RDeOMjwg7R0
w4elbr6E7MBz0/VsOwlTl2saFwVj3yJAQ78ulru1IsYMO+yVGvzIpVVMpvc/FvJY
3z27EqC3YlwnflAJrw+/O0qBvTjqjL32aSKAJlVCfikdFuSAAPqicZUUdC0CxH56
8ubrnmIEdhYFttFkxOwHmitjU4uiLToJBYgO4u6LingJrhGcKPhDTETavVW5PoYX
2Ui6LTl2I8VIFrL0DgnKqrZTZlMzE2QrGQuMF9+UgZKvn/WYLlhwbZLc99CoDBLD
YSs7sD5w1N4bTGUTqhFAzBhac4BH8VHBXv2riEFS0z9zyMr1a69BVbbBCJS5yt2/
wiPkPGeTW+eiS3vi3fh4t6zUyfjEYNqgj3yVzJV1PlMG82eD5iKPacBk62rq3f+C
sYEJlTetQMb1tSbEnVB2o5z6tZa4i1mxXaWgCZoHaG7uvOzCqNub63Dhcd4Knogy
D2fZy+B0KyuSLAQ+en30
=puH1
-----END PGP SIGNATURE-----

--AjmyJqqohANyBN/e--

--===============1861322266358632279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1861322266358632279==--
