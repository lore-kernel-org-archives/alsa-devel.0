From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 1/1] ASoC: bcm2835-i2s: Support 384k sample
	rate
Date: Wed, 13 Jul 2016 18:37:47 -0700
Message-ID: <87k2gp80es.fsf@eliezer.anholt.net>
References: <1466358739-31669-1-git-send-email-clive.messer@digitaldreamtime.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1192048396385398997=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anholt.net (anholt.net [50.246.234.109])
 by alsa0.perex.cz (Postfix) with ESMTP id 19871260851
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 03:37:53 +0200 (CEST)
In-Reply-To: <1466358739-31669-1-git-send-email-clive.messer@digitaldreamtime.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-rpi-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, Clive Messer <clive.messer@digitaldreamtime.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

--===============1192048396385398997==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Clive Messer <clive.messer@digitaldreamtime.co.uk> writes:

> Add support for sample rates up to 384k to bcm2835-i2s driver,
> with SNDRV_PCM_RATE_CONTINUOUS and specifying 8k min and 384k max,
> for both playback and capture.

It looks like this should be OK -- the PCM clock should max out at
25Mhz, and that divided by 2*32 (max bclk_ratio) is just over 384k.

Reviewed-by: Eric Anholt <eric@anholt.net>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXhuzrAAoJELXWKTbR/J7owxwQAJZguy7ZsK1mjg9P8tpocx8L
TUXyix7HNBMl5aksOZlBKhqckbWnuoDgAHF2zxpFQH5fB+wPNG3ycJ7Sw6aQn+zf
W0cfK5BF+nIiCIUjbKF/nfFGKHttOU9EY+bMncXkZMtOSP/pIN8ShtL+GIZsOVCA
55ZfYStQrpO1WhTTLcmbQySY5pK7uy8g7g4RBe80xcLiuZau0TPW/yXWguYVHwfR
Nj92X5y57NYItJQjQAMpm1skGEVxCXsqNd+6RnbxXoNeY495EVXk4C0nu4pijOV7
iu2osOvVFN4xmb8bv+/yLPa1DcIqMLkf2yg9spvEHPvKghyz+54nGuIyHlwPUBK8
l8Q2OUsAboWkqpYyp9tdV+jbyeS/NBK2RC3BfJZB1MMYK23dR+qRQS0l96YOzkbB
q/FpBs2UwnPbWnuTkumr2mxoBNWg93qcTzPKQyDGpuD9OqN7XjO6XGXhSJolWoS+
J5/fjA1YJPRdmHSOJHwPdzyAmN7GdP+rQKRbY4XpI4NbOPde/vNItiqXfw1F+I+/
O1sUSbR5jF8pN6UjDlf+CqxaJfcuDNgWKU4Wb1OgqLTJGDCeCuFX1gS6GL+uDoa4
tTnbbGiUwnEnH3snYMD6KfEXeByub0Mby5mkzHl/3rYgj+5X25Sl6S6CuoU55xsd
/rOKCLRF6okxXEbS7XoQ
=WfHr
-----END PGP SIGNATURE-----
--=-=-=--

--===============1192048396385398997==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1192048396385398997==--
