From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [PATCH 1/4] ASoC: pxa-ssp: enhance I2S and add
 Left_J support
Date: Mon, 08 Jun 2009 13:03:20 -0300
Message-ID: <1244477000.30582.72.camel@brutus>
References: <f17812d70906030533m49eb023bid19a80231921f59b@mail.gmail.com>
	<20090606201225.GA1029@sirena.org.uk>
	<74d0deb30906080512q29b9915fvec9b068bf4b2e126@mail.gmail.com>
	<20090608124045.GE7858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0467405991929043825=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id BCAD4103851
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 18:04:39 +0200 (CEST)
Received: by qyk1 with SMTP id 1so4087228qyk.16
	for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2009 09:04:37 -0700 (PDT)
In-Reply-To: <20090608124045.GE7858@sirena.org.uk>
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


--===============0467405991929043825==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-qqy/cfmsMyvoNN8+k0mc"


--=-qqy/cfmsMyvoNN8+k0mc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Seg, 2009-06-08 =C3=A0s 13:40 +0100, Mark Brown escreveu:
> > set_sample_width or set_frame_width?
>=20
> I'm inclined to go with sample here since it seems harder for the
> machine drivers to get wrong but I've not really thought it through yet?

But sample wouldn't cover all cases. eg, magician and ezx uses the same
sample size, but magician needs 16bit frames and ezx 32bits frames.

Just to confirm that I'm understanding the terminology here..
Sample size is SNDRV_PCM_FORMAT_*, and frame size is the actual distance
in clocks between each SSPFRM assertion. Is this correct?

> > I'd prefer a separate operation over a parameter to set_tdm_slot becaus=
e
> > in my setup I just need to force the (SSP) frame width to 16 bits.
> > Enabling network mode and calling set_tdm_slot(..,1,1) wouldn't be
> > necessary at all, then.
>=20
> OTOH I don't really see much difference between the two cases - it's
> just an extra couple of parameters on the end of the call.  That said,
> it'd be much nicer if the driver were able to just do the right thing
> for DSP mode unless explicitly configured, there's not the issue you
> have with I2S where extra clocks would change the offset of the second
> channel within a stereo frame so it's much easier.

I agree with pHilipp, I don't need to set network mode for normal
operation, but i want to be able to use real network mode.

Using set_tdm_slot to setup this also seems awkward, because the dma
configuration to use is also affected by the frame size.


And finally, set_tdm_mode doesn't cover all use cases, I may want to
receive on a timeslot and keep the TX line high impedance, or I may want
to use a different timeslot for TX...

This is used on ezx to record GSM audio. I want the TX line to remain
high impedance, while I sniff BP <-> codec data.

This also brings another issue.. We are enforcing network mode on ALL
modes (with Eric's recent I2S patch), and at the same time we want
RWOT(Receive Without Transmit) always enabled. But the manual says(Table
185): "RWOT must not be used when SSCR0_x[MOD] is set"


My suggestion here is to make a clear distinction between normal mode
and network mode. We should not abuse SSCR0_MOD when we don't need it.
We should not require the machine driver to call set_tdm_slot when it
doesn't need to. And for frame sizes that really need SSCR0_MOD to be
set we should issue a warning telling that network mode was
"automatically" enabled.

--=20
Daniel Ribeiro

--=-qqy/cfmsMyvoNN8+k0mc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
 assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkotNkgACgkQw3OYl0G0liRAfACgkM5V915VO4wcKW1/lHFGV6/N
ZgQAn0cXMGvnZiAV5vGYapUJFwZbvfiv
=kRPx
-----END PGP SIGNATURE-----

--=-qqy/cfmsMyvoNN8+k0mc--


--===============0467405991929043825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0467405991929043825==--
