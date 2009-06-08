From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add
 Left_J support
Date: Mon, 08 Jun 2009 14:26:32 -0300
Message-ID: <1244481992.17327.22.camel@brutus>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090606201225.GA1029@sirena.org.uk>
	<74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
	<20090608124045.GE7858@sirena.org.uk>
	<1244477000.30582.72.camel@brutus>
	<20090608165328.GB14026@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4835534998007092312=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 60FA710385A
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 19:27:52 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1675862qwk.56
	for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2009 10:27:50 -0700 (PDT)
In-Reply-To: <20090608165328.GB14026@rakim.wolfsonmicro.main>
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


--===============4835534998007092312==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ry7vQYfMZOPUNiDRdvCa"


--=-ry7vQYfMZOPUNiDRdvCa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Seg, 2009-06-08 =C3=A0s 17:53 +0100, Mark Brown escreveu:
> > But sample wouldn't cover all cases. eg, magician and ezx uses the same
> > sample size, but magician needs 16bit frames and ezx 32bits frames.
>=20
> See my reply to Philip - even with frame size his case is going to be
> very hard to cover in a standard fashion since it's not clear what to do
> when your frame clock is run too fast relative to your bit clock.  On
> the receive side a lot of devices are just going to discard incomplete
> stereo frames.

I don't see why. If we provide an API to setup the frame size this is
all magician needs.

If we assume that the standard is frame_size =3D sample_size * channels,
then there is no need for a frame size API at all. But then magician
case will not be supported correctly.

> Network mode is just a detail of the implementation of the PXA here - it
> should not be visible outside the pxa-ssp driver.  Or to put it another
> way setting a tdm_slot of 1, 1 ought to result in the same behaviour as
> disabling TDM as far as the user is concerned.

But for pxa-ssp this is not the current behaviour.

Currently, the code uses frame_size =3D sample_size unless the machine
driver explicitly calls set_tdm_slots.

I believe that the correct behaviour would be frame_size =3D channels *
sample size.

Regarding tdm_slot(1, 1), it does not disable network mode, it setups
DMA to 16bits regardless of 2 channels.

> > Using set_tdm_slot to setup this also seems awkward, because the dma
> > configuration to use is also affected by the frame size.
>=20
> I'd not expect it to be?

If we want to support magician, then set_frame_size(16) would also setup
DMA for 16bits even for stereo audio.

> > My suggestion here is to make a clear distinction between normal mode
> > and network mode. We should not abuse SSCR0_MOD when we don't need it.
> > We should not require the machine driver to call set_tdm_slot when it
> > doesn't need to. And for frame sizes that really need SSCR0_MOD to be
> > set we should issue a warning telling that network mode was
> > "automatically" enabled.
>=20
> I'd like to see all these details handled within the driver - knowing if
> and when network mode are to be set up is the sort of thing that users
> ought to be able to rely on the driver for.

I can cook a patch.. All I need to know is:

Does it needs to support magician non-standard format? Or this will be
handled by userspace?

I think we can support magician case too, we just need to provide the
set_frame_size api that was initially proposed. :)

--=20
Daniel Ribeiro

--=-ry7vQYfMZOPUNiDRdvCa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkotSb8ACgkQw3OYl0G0liR7hwCdGhVu0MzFXVnU6lJ3qG2xxcTN
Rn8AnivTwYnsC61A1xkqddsQI19dx9Fw
=x5B9
-----END PGP SIGNATURE-----

--=-ry7vQYfMZOPUNiDRdvCa--


--===============4835534998007092312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4835534998007092312==--
