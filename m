From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] ASoC: davinci-mcasp: Return value
 handling cleanup for mcasp_common_hw_param()
Date: Fri, 31 Jan 2014 16:10:30 +0000
Message-ID: <20140131161030.GK22609@sirena.org.uk>
References: <1391087725-4088-1-git-send-email-peter.ujfalusi@ti.com>
 <1391087725-4088-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4441549395662604073=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4874F261B19
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2014 17:10:37 +0100 (CET)
In-Reply-To: <1391087725-4088-4-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4441549395662604073==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lFd1dPlLw0MeZdw2"
Content-Disposition: inline


--lFd1dPlLw0MeZdw2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 30, 2014 at 03:15:24PM +0200, Peter Ujfalusi wrote:
> Take the return value from mcasp_common_hw_param() and use that in case of
> error.

Applied, thanks.

--lFd1dPlLw0MeZdw2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS68rzAAoJELSic+t+oim97K8P/jUdGzHrw6M5rPqDK7iuSZp7
q6TMCbY8YuLq4gWE3IPr12s2lfQ4vbk47xxF16WQhdie+PjhBagF1uq54mdvMjtL
/zC5oZWV0kEsiZf55q2BN7LJll5cL76xIrRtqIeNpIqpaaBkEz+PpXj31MKvy47O
uqDcEQ8jllpiAbCwNroeN9/I6tXYJnoG0HkfMPRKXpVJWzUmyU25pQg/zG1VAclG
l9Rs/lAU+Y9PTF8UrtnogAwC3Fc67WQ/cr/EzRa78gxYCaV6ZzGQe91rexvpfF/M
QXlZQ70vIjaM/I6TAw15UAce7qrblrRjiZDQrYdnm8/ZiWaTsjGr75TY0wrZ/uQS
bYXM/wZvxHk5NPmTMN8FaELXYjYIh1H8Z60XosZ5tpqg9Zggv+9nx7HQIHsV5hvG
zh4wRrHiB8Fx4gwc8LvLHD0ePXvSlMH3kpwwMp4ObIEQgnKwIuue5Sch3GhZVf/l
6d8opq8+EjAvUkirg/qIrIUV7VPZ9NJwSVkCVJ03w7QhZYrFofTv+S4+MIZAzZEB
iOEcONEbhJTeoSNwy1jps484sEcQizvi4dkTFjCOVV9TyveUNjOSTWE0I14zPxrk
9fX3CY7YwD4MXsaeK/HDpyPwhAPUY1n8qfToESm/6a0db4yDVeGqI0zEbNLZreR7
B0JotYXuiGcGDlMgin5w
=NPW1
-----END PGP SIGNATURE-----

--lFd1dPlLw0MeZdw2--

--===============4441549395662604073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4441549395662604073==--
