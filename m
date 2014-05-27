From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: jack: Clarify GPIO descriptor lookup
 in struct snd_soc_jack_gpio doc
Date: Tue, 27 May 2014 12:03:57 +0100
Message-ID: <20140527110357.GN12304@sirena.org.uk>
References: <1401188058-18129-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3916859005590288778=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ED59226559B
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 13:04:08 +0200 (CEST)
In-Reply-To: <1401188058-18129-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3916859005590288778==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zv8pCbYjkbT4685J"
Content-Disposition: inline


--Zv8pCbYjkbT4685J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 27, 2014 at 01:54:18PM +0300, Jarkko Nikula wrote:
> Clarify struct snd_soc_jack_gpio documentation for the idx and name fields.
> Because name is passed as connection ID to gpiod_get_index() when using GPIO
> descriptor defined jack pins it is not only used as a label in debugfs but
> also as function name lookup in systems that support functions names for
> GPIOs.

Applied, thanks.

--Zv8pCbYjkbT4685J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJThHEaAAoJELSic+t+oim9oP8P/jYjJylcvP5/okMnIjEldCmp
C39cixtm+uGm8HuwqS2cbkxSjD5SkNSabDJTWIXDR4VUFlYkgWkSV8oGW4Y7tqFc
O+7Up1jUOPq33fzXgMSfyKSHznX4lCOPGMF1J9IQ+9uVTP3VvB9cCtWB79BXTQdk
WTx9AdBrGXWgW16GKmMIeYSfow1DKpsXjHgfgsTFp+4dzbcHR0BK/ZHWRrWOi+rf
Q7/t8ijHsrIy1y6nBgvCU284cY0F1JYlYtPM9F8JR6hGCUWmi0vxOewgw2OF8/2p
x2ijW/YFf54N9EytMghHlGakbEQOsGeaJlvaLJ9c2NIWerPEovH6YhYZAFAByX8W
LTFIpYOv+cKAR9scv/FZPTQFTHCLlQ0h+Djltv0qXj95pzseylAqDBKEVlMvFXvn
h7nNwn2pn33tc1uXubbLZqa48nXIaYFsmF1Zk21mfgI+6B7b8nab2dBIbEJihKXE
gbIm+bbTJPZWR6fjn3aS9gqz+kKxICbc07ITdoKPk600l9UJEpytbMzPpEq6zAOY
ySy/g3ScN9R0V9KKDJxe3ecPy8IunHOOCQ33HDj//8iX2G5/5lbu2h6mT+uLf4qf
tn7w3CpVw1U4GP5zc/y3+Z6ErYHcYb2auCAyfEFsYojgecxJ0fZhkfhQCnypHp3l
xj7iiddzNMCOiFJFF41L
=oBt9
-----END PGP SIGNATURE-----

--Zv8pCbYjkbT4685J--

--===============3916859005590288778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3916859005590288778==--
