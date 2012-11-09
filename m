From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Use card_list during DAPM
	shutdown
Date: Fri, 9 Nov 2012 16:02:32 +0000
Message-ID: <20121109160232.GL23807@opensource.wolfsonmicro.com>
References: <1352397792-2233-1-git-send-email-misael.lopez@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8577698675364108662=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B703A261744
 for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2012 17:12:15 +0100 (CET)
In-Reply-To: <1352397792-2233-1-git-send-email-misael.lopez@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Misael Lopez Cruz <misael.lopez@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8577698675364108662==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="00hq2S6J2Jlg6EbK"
Content-Disposition: inline


--00hq2S6J2Jlg6EbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 08, 2012 at 12:03:12PM -0600, Misael Lopez Cruz wrote:
> DAPM shutdown incorrectly uses "list" field of codec struct while
> iterating over probed components (codec_dev_list). "list" field
> refers to codecs registered in the system, "card_list" field is
> used for probed components.

> Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
> Signed-off-by: Liam Girdwood <lrg@ti.com>

Applied, with Liam's signoff changed to an ack - please don't add
signoffs for other people, the signoff means something fairly specific.
Please see SubmittingPatches for details.

--00hq2S6J2Jlg6EbK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQnSkPAAoJELSic+t+oim92QkP/11uDdyDf3v8Gg4XzJH1pxKF
xDb+LU667YPYxHtvPQfwqvpoRxIxmUmkpAAnn8kzWsaFgYqMVr2UtRNDoxlEWpxh
KEMFhfu9RFkV4jrtenzWcUz5sDm6tbW5f+V+BLGJPzVOVgQcc2jHW3JntTtVEqNK
10oQDvD+wx+aJQbqX+4DfLO6RtEgbQH53mt4xcpClr193uVx81Xmm4vRJP81nT86
AJ5+kF+46E6edLJcpyVpRtdz/i7LfWoN7Ck/pbBUm+xdzbyXptKYl+xYQYwJSCr6
FwpPaWbYtLdOmYbhiiSaNA0rvvW3QcMtqhLxhWO2gxGZvwcZiBb2AFsOA9EppBy2
o6uNiV/hP/7ODcX9KcA4Ch+WxoXgp82TtQH+ciftpBTbUgicg/T5xlzUI8ZfZpxn
tP+c53qynuZDsJd5W3hJgDpONOvcjxJ5TwmVDGskrhrBfUb1b2SgO0os103Ln5IQ
D0hHV7iZPEkUwM7YIYnQJUcEDv5fGcGah5akEwo0GFlUf50BMeLjSfex5Yx/Y6iu
Pp5kJlG+imUpWLesfNWOgSAo35VynIgtPTtdHFbJhXH0FTW3EMTlKQIMIi96ZTx6
n/zy1TCB9LL79EilHqAIAc182BzuYCcJc/rog4jXQxCamhBA0VFi+Jo1hcR4nNlS
ZjfvC7ElrEmTlq72T7bV
=eHnO
-----END PGP SIGNATURE-----

--00hq2S6J2Jlg6EbK--

--===============8577698675364108662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8577698675364108662==--
