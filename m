From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: pxa-ssp.c,
	Automatically set TDM when needed
Date: Fri, 14 Aug 2009 13:17:41 -0300
Message-ID: <1250266661.18028.249.camel@brutus>
References: <1249570519-32622-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249570519-32622-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20090812181724.GZ19257@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2490733671120460259=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f185.google.com (mail-qy0-f185.google.com
	[209.85.221.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 2807224330
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Aug 2009 18:17:43 +0200 (CEST)
Received: by qyk15 with SMTP id 15so1170731qyk.16
	for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2009 09:17:41 -0700 (PDT)
In-Reply-To: <20090812181724.GZ19257@buzzloop.caiaq.de>
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


--===============2490733671120460259==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-x+OsEGzITTxAMi7UrmkW"


--=-x+OsEGzITTxAMi7UrmkW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, sorry for the delay on replying to this thread, busy with other
stuff. :)

Em Qua, 2009-08-12 =C3=A0s 20:17 +0200, Daniel Mack escreveu:
> Again, to summarize what this is all about - what I need the code to
> produce is the following output:
>=20
> 	- syncronous LRCLK
> 	- 64fs on I2SCLK
> 	- I2S data on the first 16bits of each LRCLK edge
> 	-> http://caiaq.de/download/tmp/2.png
>=20
> So I applied all three patches and added the following call to my board
> support code:
>=20
> 	snd_soc_dai_set_tdm_slot(cpu_dai, 3, 3, 2, 16);
>=20
> Which translates into "give me 2 slots with 16 bits each, and distribute
> them over the timeline as a 0-1-0-1 pattern". Which is exactly what I
> need, right?

No. in an ideal world, set_tdm_slot(3, 3, 2, 16) shoud give you 2x16
bits slots, on a 1-1 timeline, and shouldn't be a valid network mode
configuration, in this case, one should use a frame width of 32bits and
_not_ use network mode.

0-1-0-1 should be 4 slots, with slots 2 and 4 active, but I think that
what you want is 1-0-1-0 =3D set_tdm_slot(5, 5, 4, 16). But... See below.

> But unfortunately, the code didn't make the SSP port do that. I ended up
> having a asynchronous clock and the data somewhere where I wouldn't have
> expected them: http://caiaq.de/download/tmp/1.png

I think that the source of the problem is that we can't assert SFRM past
the end of the first slot, and DMYSTOP changes the slot_width on the
wire.

Consider that PXA is _slave_ of SFRM: (SFRMDIR=3D1)

* SFRMWDTH is ignored.
* Only one edge (set by SFRMP) is considered.


And when PXA is _master_ of SFRM: (SFRMDIR=3D0)

* SFRMWDTH is needed for I2S.
* SFRMWDTH can't be asserted past the end of DMYSTOP.
* DMYSTOP changes the slot width, as it generates extra cycles after the
last bit of data.
* DMYSTOP only changes the _active_ slots width. (this is what causes
async SFRM).
* DMYSTOP is restricted to 0-3 on PXA2XX
* DMYSTOP must be cleared in network mode, or when FSRT is set.


We want to write 2x16bit samples with 1-0-1-0 pattern for I2S, so we
can:

* set_tdm_slot(5, 5, 4, 16) if pxa is slave of SFRM.
* use SFRMWDTH(16) | DMYSTOP(16) if pxa is master of SFRM. (pxa3 only)
* use DMYSTOP(16) if pxa is slave of SFRM. (pxa3 only)


> I did some minor modifications to the patches 2/3 and 3/3 which made it
> work for me eventually - find them inline.
>=20
> Not sure whether I got the theory about the API right, and of course I
> didn't test on any other hardware than the one I have.
>=20
>=20

> > -	cpu_dai->dma_data =3D ssp_get_dma_params(ssp,
> > -			((chn =3D=3D 2) && (ttsa !=3D 1)) || (width =3D=3D 32),
> > +	cpu_dai->dma_data =3D ssp_get_dma_params(ssp, slot_width > 16,
> >  			substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK);
>=20
> The condition for the width4 parameter needs to be
> (slot_width * slots) > 16 for me. With that parameter set to 0, audio
> plays at half speed on my system.

Consider that you have real network mode, and you are using 2 slots of
16 bit mono audio. You want to ignore 16bit for each 16bit of data. ie,
only one channel active. You really don't want 32bit DMA in this case.

I agree that this should be (slot_width * number_of_active_slots) > 16
tough.

> And in patch 3/3,
>=20

> > +			sspsp |=3D SSPSP_DMYSTOP(
> > +					(slot_width * slots) / 2 - width - 1);
> > +			sspsp |=3D SSPSP_SFRMWDTH((slot_width * slots) / 2);
>=20
> These two calculations are wrong my case. What works here is
>=20
> 	sspsp |=3D SSPSP_DMYSTOP(
> 			(slot_width * slots * chn) / 2 - width - 1);
> 	sspsp |=3D SSPSP_SFRMWDTH((slot_width * slots * chn) / 2);
>=20
> ... which is another multiplication by factor 2. But I'm not sure if I
> got the wrong variable with value 2 :)

DMYSTOP itself should be accounted for slot_width, but this will only
work if all slots are active otherwise you will get asynchronous SFRM.
Something like:

/*
 * If the user did not use network mode, we assume the codec
 * is I2S compliant.
 */
if (frame_width > 0) {
	sspsp |=3D SSPSP_SFRMWDTH(frame_width / 2);
	sspsp |=3D SSPSP_FSRT;
} else {
	if (sscr0 & SSCR0_SFRMDIR) {
		/* pxa slave, FSRT is enough */
		sspsp |=3D SSPSP_FSRT;
	} else {
		/* pxa master */
		int slots =3D ((sscr0 & SSCR0_SlotsPerFrm(8)) >> 24) + 1;

		/* PXA2XX doesn't support DMYSTOP > 3 */
		if (!cpu_is_pxa3xx())
			return -EINVAL;
		/*=20
		 * We need all slots active, otherwise DMYSTOP causes
		 * asynchronous SFRM as it only appends bit cycles after
		 * active slots.
		 */
		if (ssta !=3D (1 << slots) - 1)
			return -EINVAL;

		/* slot width on the wire is doubled by DMYSTOP */
		sspsp |=3D SSPSP_DMYSTRT(1);
		sspsp |=3D SSPSP_DMYSTOP(slot_width * slots - width - 1);
		sspsp |=3D SSPSP_SFRMWDTH(slot_width * slots);


This should be able to deal with I2S when pxa is slave, on both pxa2xx
and pxa3xx, with set_tdm_slot(5, 5, 4, 16).

Or when pxa is master, on pxa3xx only, with set_tdm_slot(3, 3, 2, 16).
This still violates the "DMYSTOP must be clear on network mode" rule,
but as all slots are active its not really network mode. And it seems to
work for you, so... ;)
	=09

--=20
Daniel Ribeiro

--=-x+OsEGzITTxAMi7UrmkW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkqFjhkACgkQw3OYl0G0liQWBQCglTieF6hRmDym30Em8dZYhlZ9
hW8AnA0af9ZdVbPpyPDT2A6+puvM8cx3
=SlVC
-----END PGP SIGNATURE-----

--=-x+OsEGzITTxAMi7UrmkW--


--===============2490733671120460259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2490733671120460259==--
