From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: codecs/wm8978: pll incorrectly
 configured when codec is master
Date: Tue, 6 Nov 2012 09:38:07 +0100
Message-ID: <20121106083806.GB5044@opensource.wolfsonmicro.com>
References: <1351890344-9938-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8225340290061117922=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2AD5B261712
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2012 09:38:25 +0100 (CET)
In-Reply-To: <1351890344-9938-1-git-send-email-emillbrandt@dekaresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8225340290061117922==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 02, 2012 at 05:05:44PM -0400, Eric Millbrandt wrote:
> When MCLK is supplied externally and BCLK and LRC are configured as outputs
> (codec is master), the PLL values are only calculated correctly on the first
> transmission.  On subsequent transmissions, at differenct sample rates, the
> wrong PLL values are used.  Test for f_opclk instead of f_pllout to determine
> if the PLL values are needed.

Applied, thanks.

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmMxlAAoJELSic+t+oim9GIkP/j77QGi0kiZ7DagW2dAbytXL
FOnz0X4TxUZlWgJG6O13IH5/pYx2EkbOMGInlFbGsNfkxJg+tvhuhSBhIZdfr+tY
44b69L8DgQsHjRWr7M+H1Vch+R8QJT0AHABcmZhbhQTHTyxyA9pMXfj3FVv+y19M
xAqwNrydy3RivRbf87w1o1PqVvMbjlU9c6oRFEQkhNsV+c0diAnW95t2ZFBB3c3H
n+u06/LY63XzwDwy0AJM6XdMLZE61qNA2PsVjdQhi7IzdAncNe5guc0yngAElhy5
my6VxGe9iPuU4gv68wupcWbrbR8/DU2jSidyDs3dgeT6VL6ei2J2KEKG7hP/grRB
cr8+2YWi3x+f5nxgbwuux42xBOMjnxZ+B1qi4Yg26KTVHFBsOcBK0a7/gr8PYrTz
/GwowHOPuloN7WYLKiEoIMeCVIREua6sx7RDONPH7iioycrjEpSzqXe1C27D1g9W
lTHa/BdPa1G1ovlWmRsaobP3qe4tNu4dufynOKNuCJf5nr/NyZKNUC8jKhQ+nQfX
6/4LliD7c08fKA+Kq094P6fLBW0KlBAyqC1FfrYfBOjTf8tct4yKjyCQIEZGhJMD
9a6JL0CCPmu3HSD2Qo+tXdz1J64W8a11N1KISd6+WF1asodYTkVgTQefdLF06hZ7
wbprlhtpQegvJ0EJwTo8
=yLg4
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--

--===============8225340290061117922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8225340290061117922==--
