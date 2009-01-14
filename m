From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: hda-intel on macbook5,
	1 (was: lockdep warning on 2.6.29-rc1	with	pulseaudio)
Date: Wed, 14 Jan 2009 11:19:08 +0100
Message-ID: <1231928348.3730.7.camel@johannes>
References: <1231866121.3847.6.camel@johannes>
	<s5hiqoj870o.wl%tiwai@suse.de> <1231868779.3840.11.camel@johannes>
	<s5hk58yfko5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6809886432884120580=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 51D6A1037F1
	for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2009 11:19:32 +0100 (CET)
In-Reply-To: <s5hk58yfko5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============6809886432884120580==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MDc4G/fsVk1Ywim3IPA7"


--=-MDc4G/fsVk1Ywim3IPA7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-01-14 at 07:47 +0100, Takashi Iwai wrote:

> > I'm sorry I phrased that wrongly, I'm not aware of any working kernel
> > version.
>=20
> Ah OK, then it's no regression, at least :)

No :)


> > I've tried googling for this macbook 5,1 (13.3") issue, and have found
> > various information, some people claim it should work, but it doesn't
> > seem to for me with the same software versions...
>=20
> Did you try some model options?  For example, model=3Dmacpro, model=3Dmbp=
3,
> or model=3Dimac24.

Yes, I'm not sure which ones I tried, so I just went back and tried
these, no help. The optical output lights up when I enable it, but I
have no way to check if anything is modulated onto it. Your initial
comment seems to make sense, some GPIO line that controls the PA is
maybe not enabled? Unfortunately Apple hasn't published their driver as
open source, afaict.

johannes

--=-MDc4G/fsVk1Ywim3IPA7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJbbwZAAoJEKVg1VMiehFYzRoP/iDpUWBXGeRQ+oD6A6coHsu3
OFuQmPg/1lrKMUit3GsD9xhwDxO6SoWiDRQEsWqu3VXjJDCW02BW6WzyVnugHjuT
mqqZGf53HCxg3dEQkjN56bp+8+SAnxfoaSZ5wV2cE947Lpgbfua4tq0UAXyjQUGY
dAEBW2TrA3SrL9wVKuvtv1Iul5KIAH5xqn+puwvSOLB++CanDX72mNfC8/4l0R+d
AlojhJUcP0NsK7AlucHeQAywGT4ST0NoeElJdiXhoDLm/vSGWVasEYqUk8e9CbIb
GDJ9JRGH8anMDwoR2CMctYrIFHz6tzfLKNRzdFjvXVIV6gpJFJ4osFeHtfJ+BJsQ
vuzopz4uCvRGOfxtWgGXuOhy05xAxjRY7VIGrLMj+1qEC/IB9CAM8j9a2TJHye7M
6fBIMUbIz3Dv1tyz4qye37ZP+DbBZVuWKSFMLF7+JnxFSU6c1pC5+rUW/49bTJ1R
ddql39dMVVv/JLYwTRMlmUCI7qniVIkW+ULhQlg/3E2tFWg9b7elVXJotKi7lyhZ
0+B00bgKBIxCUw09h6Ark4TaM2QTLjSKWPDCctvJOn/x7y+MR5VqyTEowm90GyPl
LPZ/NT0PEzpHrr0/9e1eHSQMtZymrNeFFB+dO65j8ssvSx2M3AQGFzemW8sG0iVb
I+SRuwcDZQIND8wJmagQ
=Cd+O
-----END PGP SIGNATURE-----

--=-MDc4G/fsVk1Ywim3IPA7--


--===============6809886432884120580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6809886432884120580==--
