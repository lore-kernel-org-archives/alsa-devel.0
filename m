From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add
 Left_J support
Date: Mon, 08 Jun 2009 17:52:29 -0300
Message-ID: <1244494349.17327.174.camel@brutus>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090606201225.GA1029@sirena.org.uk>
	<74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
	<20090608124045.GE7858@sirena.org.uk>
	<1244477000.30582.72.camel@brutus>
	<20090608165328.GB14026@rakim.wolfsonmicro.main>
	<1244481992.17327.22.camel@brutus>
	<20090608180656.GH7858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0158656374990666739=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id F3426245DA
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 22:53:49 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1761280qwk.56
	for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2009 13:53:49 -0700 (PDT)
In-Reply-To: <20090608180656.GH7858@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0158656374990666739==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-s0xFKvVVssbd9PDQr4z1"


--=-s0xFKvVVssbd9PDQr4z1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Seg, 2009-06-08 =C3=A0s 19:06 +0100, Mark Brown escreveu:
> Think about TDM mode for a minute here - there a separate configuration
> for the sample size on the wire opens the way to using a lower sample
> size in a given timeslot than the timeslot supports, reducing the need
> for the CPU to rewrite data.  Or to put it another way, I can't see TDM
> mode working unless the sample size is constrained to always be exactly
> that desired so it seems sensible to have a standard way of doing that.

Hum... Now I understood this. If i want to use network mode with 2
different codecs, and they differ on the expected frame_size i have to
use the smaller frame_size for both codecs.

And indeed, in this case the best place to setup the frame size would be
on set_tdm_slot().

> I'd rather come up with a cleaner way of configuring the magician case
> that's explicit about what it's trying to achieve.  It doesn't need to
> be in user space, though.

I dont know how to do this other than just changing the frame size... :)

--=20
Daniel Ribeiro

--=-s0xFKvVVssbd9PDQr4z1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoteg0ACgkQw3OYl0G0liRb8gCfT847UlP4SlX3oOEj/bCTkLZM
bCYAn2e/hH7Avqyc4YgQbSasSlh1ezM5
=PcrO
-----END PGP SIGNATURE-----

--=-s0xFKvVVssbd9PDQr4z1--


--===============0158656374990666739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0158656374990666739==--
