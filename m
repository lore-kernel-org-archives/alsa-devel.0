From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: sigmadsp: uninitialized variable in
 sigmadsp_activate_ctrl()
Date: Thu, 27 Nov 2014 10:59:41 +0000
Message-ID: <20141127105941.GF7712@sirena.org.uk>
References: <20141126223516.GB443@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2br5ESIskQR/DsXr"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141126223516.GB443@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--2br5ESIskQR/DsXr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 27, 2014 at 01:35:16AM +0300, Dan Carpenter wrote:
> The "changed" variable should be set to false at the start.

Applied, thanks.

--2br5ESIskQR/DsXr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdwQdAAoJECTWi3JdVIfQvO4H/3TRnw0fyBYi0iJOkOtdh3Rj
+pwLMgavF/Ha+lrPe0mgS5RC/7WSS9QZ+OyfeX2VCPDezUdQr4jH7G/Zw4jTGDSc
O2kstEhbrw8IbvrZFZP3SelHjB29ccKBsXmop9KA9HJXvtBCYkZ1HvUXv5VybVm1
tyYooNJVabN+/HiZQ7rQhm+jiiYJQWsasyy7EXdsbzjNZvBgOM7NmDTo5xTGlQyM
jISkvVYknAH6W5UVaQtI9OKOdjKTUsJvN4k3oAyajZ1CZIySwqRff+YkpanNT3bv
//ha9tbvcWjQM67iXB/5Sbdz9qA0nUaCZrFN7LjMwE78EPgqPKtTaUx0vYjzKlM=
=MFKq
-----END PGP SIGNATURE-----

--2br5ESIskQR/DsXr--
