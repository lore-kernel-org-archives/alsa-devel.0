From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH][ASoC]Add ability to remove rate constraints from generic
 ASoC AC'97 CODEC driver
Date: Sun, 29 Mar 2015 21:19:35 -0700
Message-ID: <20150330041935.GA1568@sirena.org.uk>
References: <54FF7E13.4060801@maciej.szmigiero.name>
 <20150322182744.GB6643@sirena.org.uk>
 <551821A1.5030902@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <551821A1.5030902@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2015 at 06:00:33PM +0200, Maciej S. Szmigiero wrote:
> W dniu 22.03.2015 19:27, Mark Brown pisze:

> > Please use subject lines matching the style for the subsystem.  This is
> > helpful for identifying relevant patches and not getting your messages
> > deleted unread...

> I assume "[PATCH] ASoC: driver: subject" format would be right?

Yes.

> > I'm sorry but this just doesn't explain what this patch is intended to
> > accomplish.  If we can talk to the AC'97 CODEC at all we can already
> > identify whatever constraints it has by looking at the ID registers so
> > it's not clear when or why a platform would need to use this.  It feels
> > like there is some underlying problem that you're trying to address.

> This patch itself is supposed to allow using this CODEC driver with
> CODECs that support other rates that these that were already hard-coded
> in the driver (8000, 11025, 22050, 44100, 48000).

You're talking about Linux internal implementation details here but the
change you are proposing a change to the device tree?  Like I think I
said in reply to a previous iteration of this patch we can clearly
enumerate the required information from the hardware already.

> While it would be possible to simply add ac97 bus enumeration to
> either fsl_ssi driver or fsl-asoc-card sound card driver it looks to me
> that even in this case a platform device for codec would need to be
> registered anyway.

That's the way the ASoC AC'97 support currently works, yes.

> If the ac97 bus enumeration is added to fsl_ssi driver then there is
> also a problem of communicating a name of ac97 platform device
> to sound card driver so it can then reference it in DAI links
> that it builds.

=2E..

> And, naturally, this would result in a small code duplication with
> regard to this generic driver.

This sounds like something that can easily be put in some generic code
and either used as a helper library by the drivers or just done directly
=66rom the framework when it knows it's dealing with an AC'97 bus.

Alternatively if you're just trying to open up the constraints why not
just open them up by default and make sure that the AC'97 generic code
is constraining things appropriately if it's not doing so already?

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGM7SAAoJECTWi3JdVIfQv6oH/3etFvbxzLHe8pQrTTUhyoMK
fG6FM3m0YRZmykH0vTuLkN7+ijQ8do4k3+FoRPWQrnOUUzpnFvJy4ae6dOjIs9SY
bHLQPzeygd9dB4GkgyH7Z03aIKn/vVlLLhIN4+CZK9YJ93EBHHWgVQJRPZqbp4KF
IjkBGvQCADAsBDDtgrqum6YcsUgS5v03qzlW8D7m7CE9502jVgLiK+dj9c54MKo2
BUa/ablM9AlQoH4xiupFy0Vfx+noig3a1ZbVDtBWsfN2+wx2ST+zs9xmlyIx9Ses
zkKjOWKYwBs0RBB/FRvwjhZ8FmT42JPYXk8Xi7iE8dJoOji9weUu514brgxJsNo=
=HyBD
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
