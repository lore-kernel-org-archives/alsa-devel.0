From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC 2/3] ASoC: hdmi-codec: add support for
	bclk_ratio
Date: Fri, 1 Mar 2019 16:05:25 +0200
Message-ID: <6962d496-cd18-2fae-01a0-7b387ad672c9@ti.com>
References: <20190222212619.ghxly3eb6dx7p2ut@shell.armlinux.org.uk>
 <E1gxILm-0004MX-Kb@rmk-PC.armlinux.org.uk>
 <520b346f-a874-790d-61ec-fb4ac67ad046@ti.com>
 <20190301123629.GC7429@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3269101076122216443=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 93911F8073C
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2019 15:05:43 +0100 (CET)
In-Reply-To: <20190301123629.GC7429@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sven Van Asbroeck <thesven73@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: alsa-devel@alsa-project.org

--===============3269101076122216443==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="yQXnHwgkfj9mHhDL7BAmSB1bGzHWAsczq"

--yQXnHwgkfj9mHhDL7BAmSB1bGzHWAsczq
From: Jyri Sarha <jsarha@ti.com>
To: Mark Brown <broonie@kernel.org>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
 Sven Van Asbroeck <thesven73@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@ti.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 alsa-devel@alsa-project.org
Message-ID: <6962d496-cd18-2fae-01a0-7b387ad672c9@ti.com>
Subject: Re: [PATCH RFC 2/3] ASoC: hdmi-codec: add support for bclk_ratio
References: <20190222212619.ghxly3eb6dx7p2ut@shell.armlinux.org.uk>
 <E1gxILm-0004MX-Kb@rmk-PC.armlinux.org.uk>
 <520b346f-a874-790d-61ec-fb4ac67ad046@ti.com>
 <20190301123629.GC7429@sirena.org.uk>
In-Reply-To: <20190301123629.GC7429@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 01/03/2019 14:36, Mark Brown wrote:
> On Mon, Feb 25, 2019 at 03:45:44PM +0200, Jyri Sarha wrote:
>> On 22/02/2019 23:27, Russell King wrote:
>=20
>>> +	/*
>>> +	 * If the .set_bclk_ratio() has not been called, default it
>>> +	 * using the sample width for compatibility for TDA998x.
>>> +	 * Rather than changing this, drivers should arrange to make
>>> +	 * an appropriate call to snd_soc_dai_set_bclk_ratio().
>>> +	 */
>>> +	if (fmt.bclk_ratio =3D=3D 0) {
>>> +		switch (hp.sample_width) {
>>> +		case 16:
>>> +			fmt.bclk_ratio =3D 32;
>>> +			break;
>>> +		case 18:
>>> +		case 20:
>>> +		case 24:
>>> +			fmt.bclk_ratio =3D 48;
>>> +			break;
>=20
>> AFAIK, this is not the usual choice for 18- or 20-bit samples. Usually=
,
>> the bclk_ratio is set to the exact frame length required by the sample=

>> width without any padding. That is at least the case with
>> tlv320aic3x-driver and 20-bit sample width.
>=20
> So, this is true.  On the other hand like Russell says further down the=

> thread it's preserving the existing behaviour so it would be surprising=

> if it actually broke anything and it will help systems that explicitly
> set the ratio so I don't think we should let perfect be the enemy of
> good here.
>=20

Sure. Still, the requirement for having bclk_ratio of either 32, 48, or
64 is coming from tda998x, so that requirement should be satisfied in
tda998x driver, not in hdmi-codec that is supposed to be generic and
imposes that behaviour to all other user too.

Of course we should not make things overly complicated just because of
such principle. But in this case we are trying to preserve existing
behaviour that has hardly ever worked, and the new behaviour will
potentially cause more trouble. And if we really want to preserve the
existing behaviour there is another way that affects only tda998x driver:=


- hdmi-codec leaves the struct hdmi_codec_params bclk_ratio to 0 if
  snd_soc_dai_set_bclk_ratio() is not called

- tda998x_audio_hw_params() checks if bclk_ratio =3D=3D 0 and makes the
  implicit bclk_ratio setting the same way as the code above does it

Of course the configurations that we are trying to fix would only work
if the cpu-dai would by some luck (or intentional hack) use bclk_ratio
of 48 for 18- and 20-bit sample formats.

This is the problem with implicit blck_ratio setting at frame clock
slave end. Currently there is only a way to set bclk_ratio from the
machine driver, but there is no way ask what a dai driver would prefer
to use. That is why it is unlikely that 18- or 20-bit sample formats
have worked with any platform with tda998x, or will work in future with
just the implicit bclk_ratio setting.

But, after (hopefully) making my point, if both you and Russell want to
use Russell's original approach, please go ahead. As you said, it is
unlikely that it breaks anything.

> As Russell outlined there's quite a bit of hopeful assumption in how
> ASoC handles the mapping of memory formats onto wire formats which work=
s
> almost all the time but not always and definitely not through robust
> design, that should be a lot easier to address once the component
> conversion has been done as we'll actually have all the links in the
> system directly visible rather than bundled up together and implied as
> they are currently.  Sadly that's a lot of work with not many people
> working on it so progress is super slow.
>=20

Yes, there is lot more that could be done there. Ideally there would be
an option to let the dai drivers on the wire to negotiate the i2s format
and related parameters by them selves based on sample width, channels,
and sample rate.... but yes that is not a simple thing to implement.

Best regards,
Jyri

--=20
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


--yQXnHwgkfj9mHhDL7BAmSB1bGzHWAsczq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEMuwitgUoIEsi53ohkDazUNfWGUEFAlx5PDIACgkQkDazUNfW
GUFT0A//cW5aJGfU3uPwwQNsS5i4pDb4s1jsRTU/v7uuDnO8DdDnIU8w45miE18H
hfhCz95pZxWka3FJmc0j9moZE10Vv38GSiWelnHrAPZ1J+6ae51hXEv4RpH7TvRh
Uo3+Eq4/KR+EOEHj3NBKzijPHBfmzFa7oaMvvbLcJlBDgbNdShviiZhp/LcG0/WQ
zPj4Q3kVDHZd9GHMA3yn1OFtENNx48eV8Q+oeLLgiu1ObPstDcYl+QKgS8Rzihky
ZvPwle7PwN3pB+LHikwzH5Df5hYoIR9FivfIFMAT8T8T4rU/kdH6CRcoCPKjOCOb
LxymhjFOk77JYM2fTrVzZnlqSi0yP60OKUUqwo9aeqBgOaWeFKJzEEG8N9zJ2+mX
WlXuLgEdRaCjqj6tL3cjZBQ3O4DCqoPhgYaMW5tT0LG46GeGdlAvJ+fPFDyOdu+q
i8Wp8Wx9Q2hOpwENRaAj4RFSbQq/zMuGjaAEAEeReo+7Iy1wzC9HsT2yCtaF60e6
18Sv3z8nNeRN5nVHD4oEUGDx+GDNLsfDrT1X/wXRzrC5WGunZGHPE/oljoJYfohF
1CaCmwGFyBMxM6RZnHkPg7PYcz3tnfBnA07HsC88ndkn8AvvvHcBtV0C+xOt8lG8
ET9UEi9IEe1WN9xAdaERtUctuo/rkxJW//kGGu0byBsmlBkMZ4M=
=4d2U
-----END PGP SIGNATURE-----

--yQXnHwgkfj9mHhDL7BAmSB1bGzHWAsczq--

--===============3269101076122216443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3269101076122216443==--
