From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: pxa-ssp.c,
	Automatically set TDM when needed
Date: Mon, 17 Aug 2009 15:09:37 -0300
Message-ID: <1250532578.5384.45.camel@brutus>
References: <1249570519-32622-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249570519-32622-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20090812181724.GZ19257@buzzloop.caiaq.de>
	<1250266661.18028.249.camel@brutus>
	<20090817153548.GB19257@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7669609561438729756=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 169AF103881
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 20:09:47 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so931548qwf.56
	for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2009 11:09:46 -0700 (PDT)
In-Reply-To: <20090817153548.GB19257@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7669609561438729756==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-lpG2ERjcVOeOtphs6MVR"


--=-lpG2ERjcVOeOtphs6MVR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Seg, 2009-08-17 =C3=A0s 17:35 +0200, Daniel Mack escreveu:=20
> > 0-1-0-1 should be 4 slots, with slots 2 and 4 active, but I think that
> > what you want is 1-0-1-0 =3D set_tdm_slot(5, 5, 4, 16). But... See belo=
w.
>=20
> Maybe we should first decide which TDM mode _should_ be correct for the
> mode I'm working on, and then amend the actual implementation? And
> provide some documentation once the API is decided.

The correct should be set_tdm_slots(5, 5, 4, 16), no doubt on this.

The problem is that "16" becomes "32" only on the active slots because
of DMYSTOP. :(

> > * set_tdm_slot(5, 5, 4, 16) if pxa is slave of SFRM.
>=20
> Wouldn't 1-0-1-0 rather be 0xa?

Well, I'm reading 1-0-1-0 as a time-line(1-2-3-4) from left to right,
not as the binary value of the TTSA register. Activating slots 1 and 3
means 0x5(0101b) on TTSA value (right to left).

Confusing... ;)

> > Consider that you have real network mode, and you are using 2 slots of
> > 16 bit mono audio. You want to ignore 16bit for each 16bit of data. ie,
> > only one channel active. You really don't want 32bit DMA in this case.
>=20
> I can just say that in case the DMA material is _not_ 32bit, audio will
> play at half speed. So the mode I'm using seems to need the double amout
> of PCM data. For whatever reason.

Its stereo, 2x16. So 32b DMA is correct. I use 32b DMA for 16bit stereo
too, but with 1 slot of 32bits. :)

> > I agree that this should be (slot_width * number_of_active_slots) > 16
> > tough.
>=20
> Ok. And that won't break your use case?

No, in my case number_of_active_slots is always 1. (Both with and
without network mode on the wire)

> > > > +			sspsp |=3D SSPSP_DMYSTOP(
> > > > +					(slot_width * slots) / 2 - width - 1);
> > > > +			sspsp |=3D SSPSP_SFRMWDTH((slot_width * slots) / 2);
> > >=20
> > > These two calculations are wrong my case. What works here is
> > >=20
> > > 	sspsp |=3D SSPSP_DMYSTOP(
> > > 			(slot_width * slots * chn) / 2 - width - 1);
> > > 	sspsp |=3D SSPSP_SFRMWDTH((slot_width * slots * chn) / 2);
> > >=20
> > > ... which is another multiplication by factor 2. But I'm not sure if =
I
> > > got the wrong variable with value 2 :)
> >=20
> > DMYSTOP itself should be accounted for slot_width, but this will only
> > work if all slots are active otherwise you will get asynchronous SFRM.
> > Something like:
>=20
> [...]
>=20
> Care to send modified patches? I'd be lucky to test them.

Unfortunately I would not be able to test them at the moment, not even
compile test.. :/

I will send new patches when I'm back to my workstation.

> > This should be able to deal with I2S when pxa is slave, on both pxa2xx
> > and pxa3xx, with set_tdm_slot(5, 5, 4, 16).
> >=20
> > Or when pxa is master, on pxa3xx only, with set_tdm_slot(3, 3, 2, 16).
>=20
> Again - shouldn't we care for a consistent calling convention here and
> handle the special cases in the implementation rather than feeding
> nebulous integer arguments to it, which vary depending on the clocking
> directions?

Yes, I think we can change the slots configuration in the case we set
DMYSTOP.

> > This still violates the "DMYSTOP must be clear on network mode" rule,
> > but as all slots are active its not really network mode. And it seems t=
o
> > work for you, so... ;)
>=20
> Yeah, that makes no sense at all. I think we should ignore that comment.
> It seems to be simply wrong, or we're not in network mode afterall, even
> though we selected it. I don't know.

The comment is right for real network mode, when you want to ignore some
timeslots. In your case, as all slots are active its not really network
mode, its just a way to increase the frame width above the 32b limit.

--=20
Daniel Ribeiro

--=-lpG2ERjcVOeOtphs6MVR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqJnNoACgkQw3OYl0G0liTsowCePv54SlncjWxTIDQeTNENGjSn
XfgAnjSgLURZ/hnREEmS1H1RAaHkJEIs
=EH1B
-----END PGP SIGNATURE-----

--=-lpG2ERjcVOeOtphs6MVR--


--===============7669609561438729756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7669609561438729756==--
