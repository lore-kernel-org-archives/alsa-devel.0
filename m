From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5 1/2] ALSA: ASoC: davinci-mcasp: don't
 configure AFSX direction in DIT mode
Date: Thu, 4 Apr 2013 15:04:36 +0100
Message-ID: <20130404140436.GB9368@opensource.wolfsonmicro.com>
References: <1362663483-5886-1-git-send-email-yegorslists@googlemail.com>
 <CAGm1_kuVfwFKfUZkPTLyjza4FcpegJqxH=fCKUhPykJKMXp48g@mail.gmail.com>
 <20130404105824.GA9368@opensource.wolfsonmicro.com>
 <CAGm1_kunqGUvjwX=tiyuQAxgMf5i48Hq29y0QDMiygwjJuEnAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1401785690653198707=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 70D8E265ECE
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 16:13:40 +0200 (CEST)
In-Reply-To: <CAGm1_kunqGUvjwX=tiyuQAxgMf5i48Hq29y0QDMiygwjJuEnAA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: tiwai@suse.de, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1401785690653198707==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2013 at 02:21:35PM +0200, Yegor Yefremov wrote:
> On Thu, Apr 4, 2013 at 12:58 PM, Mark Brown

> > Don't send contentless pings.  If you want patches to be applied you
> > need to send them to the maintainers as covered in SubmittingPatches,
> > please do that.

> Do you mean sending v6 with you in CC? Looking through MAINTAINERS, I
> couldn't find any person responsible for sound/soc/davinci/. So you
> were the closest maintainer.

> Do I see it right?

Yes, you need to send me a copy.  You can just bounce the posts along
to me but unless it winds up in my inbox it's likely to get lost.

If you can't find a maintainer for the specific driver then go to the
subsystem; in general you should copy in the subsystem maintainer anyway
as it's them who usually actually does the commit (looking at the git
logs to see who's commiting things will help here).

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXYgxAAoJELSic+t+oim9yScP/2QbCmx6X9R6qtnO1MSDCYKC
FXjFofA+hsaloA8RVZF+2l6XLI/nGLBVs8c5wWL761MNmwXXQdvmvYs0+xhH2rLp
aU9LvFXwBeAd/o0lyM6dSf8E4V1kVmQtoSc8VAD9qeHO1STcpMZgkTxK7+w2wX6i
hN03N0a2kiKcXvUEgHzR1nnzG+BIZlB9qUwT1deVbJWqXxCMkKWZE4DdeizGTsJC
Elel+VMIgjYf94EJOUpS0ZYnSM/55+vByzv3uIoXtnObnsLUYcgkMsFJ7gWUGgSS
OFGRxL5L0q54eX9urLlAaLFJEGnIgyUrK850HLhMwSWZPNNOylpB95870B0t1CEL
uJXS5S2Yu9G77J3hQceR7eSRHumzr0uWW92/nPkYK+OnhoPJMCoCT9P81peE8k66
jM0/XSJ4bMnCiX/OzwIxSyejkUVtdt0AGEUBEurmSopz4XzglKY9qvBg+W/YuhpJ
jnLRZ7FoH7Wm8garRcgUqpWwvTzoan0PDKB9/Vs2Rs4w6yWJlqHF4aDBpXX6ht2I
mJbGE67YV1Bdg7SGovY/ynW1yOaw3nCMZ3B3huYIp5X2I/lZrToF5eYoe0f4P1+w
66WYd6Z7GIiWei0ZukjOGpnTum7Mi6mM5quPifPH+b6O5H7xIv6Hx/CeMYDitZaF
Qn6RpU81vunFWfAD4VzN
=r22w
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--

--===============1401785690653198707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1401785690653198707==--
