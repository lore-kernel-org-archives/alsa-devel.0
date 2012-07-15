From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RESEND PATCH 1/2] ASoC: Convert S3C24XX I2S
 driver to gpiolib API
Date: Sun, 15 Jul 2012 22:23:00 +0100
Message-ID: <20120715212259.GJ4041@opensource.wolfsonmicro.com>
References: <1342200165-13021-1-git-send-email-sylvester.nawrocki@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8596819808450340657=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ACA382499E
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Jul 2012 23:31:26 +0200 (CEST)
In-Reply-To: <1342200165-13021-1-git-send-email-sylvester.nawrocki@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc: alsa-devel@alsa-project.org, Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org


--===============8596819808450340657==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CD/aTaZybdUisKIc"
Content-Disposition: inline


--CD/aTaZybdUisKIc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 13, 2012 at 07:22:44PM +0200, Sylwester Nawrocki wrote:
> The s3c2410_gpio* calls are obsolete and have been scheduled for
> removal since several kernel releases. Remove them and use common
> gpiolib API.
> This patch is a prerequisite for removal of the obsolete S3C24XX
> SoC GPIO definitions.

Applied both, thanks.

--CD/aTaZybdUisKIc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQAzSgAAoJEBus8iNuMP3dl34P/1M9oHn57LvpbnP6rvZA2jUL
qjXt9vOh5tccB0irdvI7K3QjDQsGV7yJyyJJ4JxKJ1GdbFGw3Q7BZH+1G/OFf8WR
/f5tu4ZAvQGHBEYlO/fIjI5FU0zi6ICZL15kZ8kkDextaFhd2FljxqgqDFg1AtVA
T7TixdabkDRHvgZE+zrY1fYWCN35djtz5EZwNlMbVRwa3XrI8S64Ibw3R3ZMAX7A
DZc7O74pFl6qt2b0UIGiCj/jq23aoTryCp9l7DW/RVQtviYXQoj0kgQ3n0l7cnoA
amAhlJsMQCUS2WD8szurZVu13Sz4JLzvco16bS2ej7Ag+kiu4Vg1ANVqK2+WJQP9
PdiAH3szVQgDaZiRTPwPloJcvbHA17dW9HUxI6VITJrp1Tw0DEYWkD6x6RCDfFzn
s7O7Yftnl8NWamAZ6fjuwAUtnQIBPtMVcr72cBiZ5b7Newnyvqdpyh72Hprjkcoz
14bd7GSbgFhhNn0Fyb2AB79WllRqdatjMFL9QxvOwswVAOmJInWyp30g4oigWE17
4ZkhiTQZr6TawwDCnWtfrslcWEzYcAvaZNiqUds4939j8WHYE3CKWA+7v9ScsllK
cviLk7qsrYE51GqNyvcvyG+Z8rT6nh5ITaWUcRW+7YlKzkmrW72/kwoMIOZnlyAU
3L2PvBHA/nSfcNr2oums
=I9Xm
-----END PGP SIGNATURE-----

--CD/aTaZybdUisKIc--

--===============8596819808450340657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8596819808450340657==--
