From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: mxs-saif: Use a signed integer for
	error value
Date: Tue, 8 Jan 2013 12:33:23 +0000
Message-ID: <20130108123322.GV4544@opensource.wolfsonmicro.com>
References: <1357648033-8101-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8424261175089809587=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C90FB265B76
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 13:42:49 +0100 (CET)
In-Reply-To: <1357648033-8101-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8424261175089809587==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6qFdnjy6dKaiDX/E"
Content-Disposition: inline


--6qFdnjy6dKaiDX/E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 08, 2013 at 10:27:13AM -0200, Fabio Estevam wrote:

> -	saif->id = of_alias_get_id(np, "saif");
> -	if (saif->id < 0)
> -		return saif->id;
> +	ret = of_alias_get_id(np, "saif");
> +	if (ret < 0)
> +		return ret;

Why not remove said->id completely if we don't need to store a value
there?  Alternatively, this needs to store the id if the return value is
OK.

--6qFdnjy6dKaiDX/E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ7BGRAAoJELSic+t+oim9zdcP/Rum5DkzGNS/MpRMVthU6s/g
XhgrNckYiAaeYy7SWUz6W2b056/HapMfz9qzBrrM9rWlZFkSv+H8f1jTNgqKKyDM
GL4zldWrCb6fTXo7THv7lh6Qr2Cbht2DaQiJyIVno7hKtRgI+FcOi0+AafpckrAw
Nbfg5V5I9GkYL+rItN/Tj9zgy4U9DXQvPMeDewuev3f7MF7vixFytbyQkYXhdfXf
l/6xFiX+H/ZUGMW8zkzmHNAmpgLCWHsvcLuXqm6NbKQg/fgk38S9GITlOMfO5N3e
p2CDvCg5rtSCKD3AorX9C43n4Wy4vLLMUgSbLVQh6bcaS4X3rLKElSXPI5FDnVJX
DjVxaFYVVLJClP8wGMueDPwJg5mwY/PCD3qrMG1N3BQLZEjk5fNf5FWUkkP948Sz
S1eKNMZDqem3jyLX1TGdQpSRBH5z/uqVyFXnwn88cI+s0wrPCY7LPU7tnyIdOnzk
Ca6y6eLri/HjWl8MZVX4Mad07hKdwlFl6sfQRZmsXcZ/S9s5n8ZoiTJfMnh9i4tM
r0z+GSC7LizU6N5Mx7oGwF6ea8Qbnmwvlgh0jd3i7l5O39QyP5LqS4fPiouT84c7
ZiR3zEEdlRZHkzL9VHG373507GmwIbxs+8McqtoLbnGE6/8GIixalaY5UPCg1J1c
OroeSfjlkVIE9qAsDkZz
=JKYt
-----END PGP SIGNATURE-----

--6qFdnjy6dKaiDX/E--

--===============8424261175089809587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8424261175089809587==--
