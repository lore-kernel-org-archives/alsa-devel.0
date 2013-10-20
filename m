From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] ASoC: kirkwood: prefer external
 clock over internal clock
Date: Sun, 20 Oct 2013 17:29:45 +0100
Message-ID: <20131020162945.GM2443@sirena.org.uk>
References: <20131018203452.177f8693@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2571115179239165239=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B192326167E
 for <alsa-devel@alsa-project.org>; Sun, 20 Oct 2013 18:30:05 +0200 (CEST)
In-Reply-To: <20131018203452.177f8693@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2571115179239165239==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3GT2kwQl5jGSYsf9"
Content-Disposition: inline


--3GT2kwQl5jGSYsf9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2013 at 08:34:52PM +0200, Jean-Francois Moine wrote:
> When there is an external clock, always use this one.
> This prevents the two Dove audio devices to use the same DCO clock
> at different rates.

Applied, thanks.

--3GT2kwQl5jGSYsf9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZAT1AAoJELSic+t+oim90vkP/Aud9VHi7tWPswoJtJ74g9yh
2T0U67gEiYFLsAcoH7kvRAfnqgByRcZkfZNihWHM9zdP3plY+DlS02RiuQynwh/I
OPbzFNcPGVDgxILKksWpzXzSCk+hYbgV5+7qXDekG5ojW4DeSqb7md7w3t+7SJ0A
SzgKileIRekOKGb25DqpyEtCT/2mp6H4zHnwxosI/Mietu3E/uWGoWBhb7r6SCZ7
IlY8tIAk1oGp4L1bNO1/rBNBKUfW/DRy3Ru2cwzHP+PujwyPgGYj2BQTsuMJLMAd
XsOIteqFJVVn4RUcm6SZ8m7kjktQqXQMDQ6dsIgOpE+XE5vwrXNF6qjcZlkEbkDX
x+L/MSDPFb5E1Or3pFZMOnqJIlTd+yHIYsWYJ1kcY33wE1aumgpxzwz21vkdse8U
Egwyb/ahNCfgRIBvP3V/9mhq9vyZu8vLgNzNIgCYd0jW6L+AOCYC/C9fA2y9Qxd/
d54v0yPGaveASXfAk2wBbcPf8WO0hlgQR5fA3qtYklKsqW5En6z7KcFjRabWcATV
BR+/AI/AU3pcYlorJh2YWFonPwxK5zQMipmGySw2vn1AWxiSfwyedLKtthMQQuSd
ma1c3vYnYoxZiJQWPW+u1D94Ur3YgUJpVWVctdHacYvWyuu70NWNB7EdF2GNNrqJ
3lYgWu4si5YJ0LuqayV3
=icIr
-----END PGP SIGNATURE-----

--3GT2kwQl5jGSYsf9--

--===============2571115179239165239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2571115179239165239==--
