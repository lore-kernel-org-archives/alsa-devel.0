From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: sgtl5000: Remove cache support
Date: Wed, 8 May 2013 16:11:28 +0100
Message-ID: <20130508151128.GW7478@sirena.org.uk>
References: <20130503223613.GR4945@sirena.org.uk>
 <CAOMZO5B84e0YdcJLa27e4KZv459CGL=msU0fqe4LyFZfM-t1+A@mail.gmail.com>
 <CAOMZO5BG-3SKZF_ZrQ=C51nLvKYSNJEgy-KavzBXJcb=fCk=iA@mail.gmail.com>
 <20130505101515.GT4945@sirena.org.uk>
 <CAKGA1bmKdtAoUP7Yn0CJRVwsCNX5JkEWdWVJj1VJBaJn+9PA=A@mail.gmail.com>
 <20130506220650.GJ7478@sirena.org.uk>
 <CAKGA1b=+j5BpHzWOfkDv+xjLLcauHeD4jDj_Do+6ft6UPhYEtA@mail.gmail.com>
 <20130508103150.GW7478@sirena.org.uk>
 <518A608E.8030802@boundarydevices.com>
 <20130508145919.GU7478@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3335749412741846820=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 00AA32616B9
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 17:11:47 +0200 (CEST)
In-Reply-To: <20130508145919.GU7478@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Nelson <eric.nelson@boundarydevices.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Matt Sealey <matt@genesi-usa.com>, "troy.kisky" <troy.kisky@boundarydevices.com>, "zengzm.kernel" <zengzm.kernel@gmail.com>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3335749412741846820==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JQJYpj0es6mGpGbU"
Content-Disposition: inline


--JQJYpj0es6mGpGbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2013 at 03:59:19PM +0100, Mark Brown wrote:
> On Wed, May 08, 2013 at 07:26:22AM -0700, Eric Nelson wrote:

> > An initial pass of writing all of the default register values with a
> > sort of 'cache flush' appears to be the right thing.

> > Then it doesn't even matter if the values match the datasheet, or if
> > the spec changes over time. If the values are reasonable, the device
> > will function properly.

> No, it does matter - when we do things like cache syncs on resume the
> core will suppress writes of registers which have their power on value
> since either the register will have been reset to that value by power
> loss or retained the value due to power being maintained.  This is a
> useful win when resuming to audio activity, I2C is pretty slow.

Actually the simplest way to implement this solution (at least with
regmap, IIRC there might've been some issues with the ASoC cache code)
is just to discard the register defaults.  The core will fall back to
reading the hardware for any register it doesn't have cached but will
continue to cache values that are written. =20

Something that iterates all the known registers and reads the default
values in will be required in order to support control access with the
device powered down.  I'd therefore suggest just not telling regmap
about the current defaults and instead changing the code to loop over
them and write them out during startup.  Probably with a big fat comment
about why we're doing this.

--JQJYpj0es6mGpGbU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRimsdAAoJELSic+t+oim9rRMP/i2EH/+DWr/i+duryGVRYW27
l55anjhaVOSnF3DIoAeeGIBzaJWjPxQIDlLe2rUNd9xIZpEv8Tem4BO24YNu/MKH
W4R1Jarxb0+GSNFmWWpJl+8NhLFMBW4/V7wP6L6wwh5Pxm8Wjyi74DEgy8kPMDk9
3KteQoPtIkTcPCxuJ5TfBUwXKsaaGg7KImnk1ceMwL/v2ozckU6qPJdeqG4Xtocz
07c+AwTCEdQ+wxm8CQdbLYdJq2VR8O8s4UdWPNu9OMixozsmKZagFbR+qr64bOwQ
GxPOLc8Q4PDxUwtxHb7ICb4Fhl+5joIXVXlqX866BvMqSpBXGoHM7Hz48R8F5F27
qM7gmUGCWecnj7si51icq9YGvrOBIgT8LnbfX2XY4QR+udXOIm+WwhZA4Zj0Xv2G
wyWc731nsOkSIq+Abx4JS+IC/gxSjhdNnfT5MTPLD7m1pi8t8pgQUm9CPkuEsrAE
TLHkJ0Lo5VLBvm28utjLkP6TV7+tUnAvStbVap1cZaDlD4uNMtZkMiDwhzCG03TP
Bmls30tm1BgIHshm+UZOgRfmSTXtD7I+FlRh3MSyTKVXFLWRa6HgWjTeh6xoFbuH
pzYIw56In0anwk/v0dky6KBumVPJZCvC6kJlm8vM6Cwr09c5LxoQdSWyrt5vybOp
jcnz0Y38hPPV62ekRNpc
=qyzo
-----END PGP SIGNATURE-----

--JQJYpj0es6mGpGbU--

--===============3335749412741846820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3335749412741846820==--
