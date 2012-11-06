From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm0010: Only output debug status
 message on status change.
Date: Tue, 6 Nov 2012 09:20:53 +0100
Message-ID: <20121106082053.GE3283@opensource.wolfsonmicro.com>
References: <1352126712-6747-1-git-send-email-scott.ling@wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8539837364931883325=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 67B532616C9
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2012 09:20:55 +0100 (CET)
In-Reply-To: <1352126712-6747-1-git-send-email-scott.ling@wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Scott Ling <scott.ling@wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============8539837364931883325==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
Content-Disposition: inline


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 05, 2012 at 02:45:12PM +0000, Scott Ling wrote:
> Rather than outputting the debug status message for every status
> received from the DSP, only output a message when the status
> changes.

This doesn't apply against -next, please check what's going on there.

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmMhPAAoJELSic+t+oim9EGUP/2K2RLk/0qt2/dVBddLqMAB4
XcaPVzD4DPsh1LDJTNYz9nPhj7Ysse0Mjxq7Ue7sFLIOcRCMXvu6hj6PLtfG6r/A
GUZhhjd/qXrDfejpFuhzIq/KC27Fmra0OJUYVnTkJ18dn4HPswxbblnIZm1BpUfj
wqOSgnK1mhmCk9zOCBivMWLKUbb29WbRBK7FjLxvt8qTumY96aXuNBzE+CcztgcG
Yy9VTnCY+pbCuU2xKO/NAoHMRNcHdhDcarjx/QPcsnGvyhWm+S+nj/yQXs/B6bw/
+UA7kD/g93zws1dHvXiAbgk6N1R/aJAoWKNqLN2ABhy6FVHA5Ccd5wJteA16jT45
Yp5nHF/0s6Fng1zr5ZwzlDHnxjeZKJgSbGMhlNuVRoY3QybxJt3uatPMF31lMpVI
eHOHFhYKXNeQlgCWDHcJFtrU3POP89mOnsGcWij/QCs01z6Xa47UhuGjxkhuzfW7
UsRn3Fo+WtuFZEgDQNYk4vowkxVTCpredu0Qn/iyZ2rzFzFAKkNBq7EvMsQYte30
v/5n+DYl57OpXZ2BYzCNXS9Lb3EBV21GXAW9JTEDvrgeVB6nthQuwduIbgzi0Owd
Ij6vmaE455/CQSKeLD5v22D9dyVM7jboF1BSPuS4YI2qe37xxWMbqBOSHHYLgXyx
6L5Qpg7FD/6EmOSy6+O3
=wAXM
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--

--===============8539837364931883325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8539837364931883325==--
