From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: Samsung: Add NULL check in i2s.c
Date: Fri, 24 Jan 2014 13:18:22 +0000
Message-ID: <20140124131822.GA11727@sirena.org.uk>
References: <1390560804-31135-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3066574086138169589=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C3B42616F4
 for <alsa-devel@alsa-project.org>; Fri, 24 Jan 2014 14:18:27 +0100 (CET)
In-Reply-To: <1390560804-31135-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============3066574086138169589==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mPYgjWmOFizS0g23"
Content-Disposition: inline


--mPYgjWmOFizS0g23
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 24, 2014 at 04:23:22PM +0530, Sachin Kamat wrote:
> 'res' could be NULL from one of the operations above (line 1243). Thus
> check 'res' for NULL before releasing the region to avoid null pointer
> dereference.

Applied, thanks.

--mPYgjWmOFizS0g23
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS4mgbAAoJELSic+t+oim9DMsP/3xft861xMxVGQ9jU7V0Yj8U
ZwS9gTkq8ETv9WC7DTQHscvkv4MK7tCECe8yuJhaPGndfTGNE3WELlE5Nblkfqs9
nOrJxjW8tmTU3Q14YmxUw2N+Ka99Oq76K0v/uGbb2Hy/XRWABYRobo+o/cer2GZe
l2rPwVbjMf7vKQ3PeiZGmdWAcRj8MhYE3ZIh++wixyxuUY4lcRUFHDGzGYXnh8+v
P4KXaFcGsqNGBSgpuiYbsl+h8dsWQyEEZnfkHP9j7SwEQXu5vCWm0GCGdIW658t4
Mv7pS0qR6ZtiGLkAu+WFMYgkP7ph0HFU4RupjL6UxAxXXy7Ttfa5S1bTlombBLAC
f/ZMf0t2fEColDGw0+39F0i4uoe4//pm+dDRTYLp40L6RmTENZ43Sco7DLVxTOI2
0Oq4gcAwvhzkSmLb8FdvT/e0H1KRTsfpAU4yMDFoUvv5FwIwNHIOUfMPMah6KlDY
E0NR9Htiili9jAYD5HOpOsclSZMW+Biu1QSYV5p1ePR1ir4WSVXTrcVf2ttJNPu+
dh7jg+QXxd8Lbc04CJcMC3TAyNQs/v2zGoy2JMgCouArzx6skn3ombFBQ37kxl0p
txg2QTdsIwrYcKZGzlYstGmUKHmdXPO2//tjRC9yhsGlthSGaE3tEWnOrzIfXZiu
dgIMmCfFfUHWzPD0+TAu
=J4AJ
-----END PGP SIGNATURE-----

--mPYgjWmOFizS0g23--

--===============3066574086138169589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3066574086138169589==--
