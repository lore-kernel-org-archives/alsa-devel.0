From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add support for NAU8824 codec to ASoC
Date: Wed, 4 Mar 2015 12:55:27 +0000
Message-ID: <20150304125527.GM21293@sirena.org.uk>
References: <1423986570-6355-1-git-send-email-Vincent.wan@amd.com>
 <20150224141314.GI6236@finisterre.sirena.org.uk>
 <54F6FC28.4030403@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5D73ElaCPB+dFJZw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54F6FC28.4030403@nuvoton.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chih-Chiang Chang <ccchang12@nuvoton.com>
Cc: "mcuos.com@gmail.com" <mcuos.com@gmail.com>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--5D73ElaCPB+dFJZw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2015 at 08:35:52PM +0800, Chih-Chiang Chang wrote:
> On 2015/2/24 =E4=B8=8B=E5=8D=88 10:13, Mark Brown wrote:

> > I would have expected the headphone volume control to be a stereo
> > (double) control - same for speakers.

> The nau8824 related registers which control left/right volume are located
> in different addresses and different shift bits. Since there is no availa=
ble
> preprocessor macro to meet our requirements, the driver consists of left/=
right
> volume control separately.

Add relevant control types if you need them, it's important to have
proper stereo controls available to userspace.

> >> +struct nau8824_init_reg {
> >> +    u8 reg;
> >> +    u16 val;
> >> +};

> > This looks like you're reimplementing regmap's register sequence
> > stuff...  It's also a *very* large sequence you have, are you sure it's
> > all required?  It seems like this may be doing a bunch of machine
> > specific configuration but since it's all magic numbers it's hard to
> > tell.

> Initial settings are arranged in order

This doesn't answer or address my concern.

> >> +    /* Dynamic Headset detection enabled */
> >> +    snd_soc_update_bits(codec, 0x01, 0x400, 0x400);
> >> +    snd_soc_update_bits(codec, 0x02, 0x0008, 0x0008);
> >> +    snd_soc_update_bits(codec, 0x0f, 0x0300, 0x0100);
> >> +    snd_soc_write(codec, 0x09, 0xE000);
> >> +    snd_soc_write(codec, NAU8824_IRQ_SETTING, 0x1006);
> >> +    snd_soc_write(codec, 0x13, 0x1615);
> >> +    snd_soc_write(codec, 0x15, 0x0414);
> >> +    snd_soc_update_bits(codec, 0x16, 0xFF00, 0x5900);
> >> +    snd_soc_update_bits(codec, 0x66, 0x0070, 0x0060);

> > Too many magic numbers here I think and this looks like it should be
> > configured using platform data and/or the machine driver (what if the
> > headphone detection/IRQ aren't wired up?).  I'd also expect to see
> > reporting via the standard interfaces for jack reporting.

> The above initial settings are for jack detection. As for other jack
> detection flow, it will be implemented in machine driver but not be inclu=
ded in
> this application.

Please either remove this for now or implement it properly.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The privileged confidential information contained in this email is intend=
ed for use only by the addressees as indicated by the original sender of th=
is email. If you are not the addressee indicated in this email or are not r=
esponsible for delivery of the email to such a person, please kindly reply =
to the sender indicating this fact and delete all copies of it from your co=
mputer and network server immediately. Your cooperation is highly appreciat=
ed. It is advised that any unauthorized use of confidential information of =
Nuvoton is strictly prohibited; and any information in this email irrelevan=
t to the official business of Nuvoton shall be deemed as neither given nor =
endorsed by Nuvoton.

Don't include noise like this in upstream communication, if your company
won't fix this then please use an external mail account for upstream
communication.

--5D73ElaCPB+dFJZw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU9wC+AAoJECTWi3JdVIfQdxUH/1bky7Xhhmc2+iShsYDiRB7Y
s8Mzf5Jdcc9+hLOWbu7c+wZy1yDFyRDOL37yXZsGJM1lgAR2msjc49PvhG6uM/Bk
IwS1FcYJJa1BQeKDHRKKMKtNv+/u9ANq8TJcGm9/UDTgDj7AnZaKdc3gD8I3dv39
DUOdIkwDwDgiibmnBuGLwd0/NHoZmFYnIOwOiB7O/HnXJv8qlivq1pk7uX4oDopY
GeNjWYqO+prx7Gc5QRu+y6ZeaZ92AEmNlS44MPBtAd7FNDCL2Ul++VNa41/Yhka9
8MlkcRQ9Ptup4EQNxBu5nSOHAfwYjQUFoFTuIzUFcN2J7zxSSxPOwHjFr6lWePs=
=+/R/
-----END PGP SIGNATURE-----

--5D73ElaCPB+dFJZw--
