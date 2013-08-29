From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: ep93xx-i2s: Remove unnecessary
 dev_set_drvdata()
Date: Thu, 29 Aug 2013 13:21:59 +0100
Message-ID: <20130829122159.GB10783@sirena.org.uk>
References: <1377519915-23998-1-git-send-email-fabio.estevam@freescale.com>
 <1377519915-23998-2-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2162763473774357579=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 13D18265502
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 14:22:02 +0200 (CEST)
In-Reply-To: <1377519915-23998-2-git-send-email-fabio.estevam@freescale.com>
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


--===============2162763473774357579==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ddcd+dsiJrvLd0CP"
Content-Disposition: inline


--ddcd+dsiJrvLd0CP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 26, 2013 at 09:25:14AM -0300, Fabio Estevam wrote:
> Driver core clears the driver data to NULL after device_release or on probe
> failure, so just remove it from here.

Applied, thanks.  The actual thing here is a bit deeper - if anything
ever relies on the driver data being set after remove() it's buggy
anyway, setting it to NULL at all is pretty much ornamental.

--ddcd+dsiJrvLd0CP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSHzzkAAoJELSic+t+oim9uRMP/RBXWJLImiLtwhkiteXDmMIY
NKC2F2bqN1+TmZ4qQSOJkYSh55yyrix0BOyULWPTNA+75PnVVOk5KaGorEDZRze6
N8Rd5i3YFmECKBP5yujqiC0Yae36mc1x2VChe9ZMxMxLVSzv5TXcjvIcehs86NR+
f25W9fm6a+EpxvLDs1f+84i2NHGZaHG78st9SOYgbFJKylljaZwwsmWblC9PIgLN
5JbBe+2GWmierd6E1GsmLR9QdKcj5SYSIokN2QqEkHe/YO7U6HDRMct7FDJuIf36
T/rKqjtPuZd/ceN0ouE1RXNmrpRNR6TOdn6vON2XsXv5gi6OyE60Cqf9tvit1i+k
dSDevtbHY5XgPEPC7T4s52T5IS6PXDJQ23foxZTBem2Wezu3wRtPmWVYYANHqkmT
P/1uvpqmNVfe4qKA+mEbNdodXs8VAxl9gczwuHxuj3+L/x3gs7/o8YwGc1D4yrPz
DAtB395IhqpfUmMdXyDPpkGpDsitowH9GgDQkxVmu3ycUam82d5CZLkpkXn6b2JT
X0yTmkppe9h64Vg6jck9W80NaHwj5PC/g0Z4Nzwo9MJ5eP1hB6SqlZJy7lbUFsmY
AZ41NMr17jkrnn7OBFswB57oNOWM22Rajd0ZgqUh+sEWu69x2fOXz+x0UpzyzXiy
BnCq2Sof/yqT9xQfuTM7
=+/NA
-----END PGP SIGNATURE-----

--ddcd+dsiJrvLd0CP--

--===============2162763473774357579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2162763473774357579==--
