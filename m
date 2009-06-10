From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add
 Left_J support
Date: Wed, 10 Jun 2009 19:24:09 -0300
Message-ID: <1244672649.25905.70.camel@brutus>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090606201225.GA1029@sirena.org.uk>
	<74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
	<20090608124045.GE7858@sirena.org.uk>
	<1244477000.30582.72.camel@brutus>
	<20090608165328.GB14026@rakim.wolfsonmicro.main>
	<1244481992.17327.22.camel@brutus>
	<20090608180656.GH7858@sirena.org.uk>
	<1244494349.17327.174.camel@brutus>
	<f17812d70906090239p5dee129egda49918b3862c0ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6450547785160796013=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id B9A1210381C
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Jun 2009 00:24:16 +0200 (CEST)
Received: by qyk1 with SMTP id 1so1602280qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2009 15:24:15 -0700 (PDT)
In-Reply-To: <f17812d70906090239p5dee129egda49918b3862c0ca@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6450547785160796013==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ScBPui5Z6O3C9DpogpxB"


--=-ScBPui5Z6O3C9DpogpxB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Em Ter, 2009-06-09 =C3=A0s 17:39 +0800, Eric Miao escreveu:
> frame_width =3D sample_width * channel ( =3D LRCLK for I2S )
>=20
> is no longer (and ever) correct.
>=20
> E.g. the frame width could be 64fs, meaning a whole frame is
> consisting
> of 64 bitclks - that's saying, sample width from 1 - 64 are possible,
> For typical 16-bit sample width I2S format, the envelope for each
> sample
> is 32 bitclks, and offseting by 1 bitclk starts the 16-bit sample.

I'm working on supporting I2S right now, and I found some issues with
this enveloping thing.

First, it doesn't work on pxa2xx. DMYSTOP on pxa2xx is only 0-3.

Second, is enveloping needed at all? The patch you sent supports 32bits
frames for 2*16bits samples or 64bits frames for 2*32bits samples using
FSRT.

We already use FSRT for DSP_A, and if this works on littleton I2S we
should just stick with FSRT (and frame_width =3D sample_width * channels)
to keep the code simple.

> And the TDM mode is actually special for PXA-SSP to emulate the I2S
> protocol, it's no way generic TDM in a common sense. So talking about
> set_tdm_slots(), I'd really like to hide into the format setting code
> of I2S/Left_J to avoid further confusion.

TDM is needed for frames larger than 32 bits on any dai format. Its not
something specific to I2S.

--=20
Daniel Ribeiro

--=-ScBPui5Z6O3C9DpogpxB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkowMokACgkQw3OYl0G0liSx6QCfRxMcrzjjek7/oe4t3xeEl4J0
wQgAnj4UrjTegmrUWi/w5IZbWTywzPGp
=IJp3
-----END PGP SIGNATURE-----

--=-ScBPui5Z6O3C9DpogpxB--


--===============6450547785160796013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6450547785160796013==--
