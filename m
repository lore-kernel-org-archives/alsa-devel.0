From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/8] ASoC: rsnd: Add Volume Ramp support
Date: Wed, 29 Oct 2014 22:56:59 +0000
Message-ID: <20141029225659.GS18557@sirena.org.uk>
References: <8761fc7vpx.wl%kuninori.morimoto.gx@gmail.com>
 <87tx2w6h2r.wl%kuninori.morimoto.gx@gmail.com>
 <20141028223814.GM18557@sirena.org.uk>
 <87oasviuw0.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3548019047116160507=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D3C12604F3
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 23:57:32 +0100 (CET)
In-Reply-To: <87oasviuw0.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============3548019047116160507==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SI+x/MFwqKaBjKyD"
Content-Disposition: inline


--SI+x/MFwqKaBjKyD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2014 at 05:26:06PM -0700, Kuninori Morimoto wrote:

> > > amixer set "DVC Out Ramp" 100%		// Mute as default
> > > amixer set "DVC Out Ramp Period" 80%

> > Normally this would be expressed as an enum with some sort of time
> > units.  We did discuss at the mini-summit making a standard way of
> > expressing this but nobody did that yet.

> OK, I can be a 1st guy :)
> The HW setting is like below
>=20
>     value: mean
>     00000: 128 dB/1 step

> Current "DVC Out Ramp Period" wants to have direct value of register.
> But, upstream want to have time like this ?

Yes, please - much easier for users.

> > > amixer set "DVC Out Ramp" 0%		// to Volume 100%
> > > amixer set "DVC Out Ramp" 100%		// to Mute

> > I'm not sure I quite understand this control - what exactly is this
> > setting?  It appears that the ramp value is the opposite of the volume
> > we end up with which is a bit odd and the comments suggest that this is
> > actually triggering a ramp when normally ramps would be done as part of
> > a volume set, mute or power up/down operation.

> Current "DVC Out Ramp" want to have direct value of register.
> It is...

>    000:  1 time
>    ...
>    031:  0.5 time
>    ...
>    3FE:  4.1 x 10^-7 time
>    3FF:  Mute

> Maybe I can used inverted value for it ?

That sounds like it'd address part of it, though I'm still not 100% sure
what the effect of this control is - is it the final value or something
(0.5*programmed volume for example)?

--SI+x/MFwqKaBjKyD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUXC6AAoJECTWi3JdVIfQm9gH/i+yW8+/+hbPLozws1YEXY7E
2EPcg1nidcY+dGARdnPgk59oZvGmKwSLKC2XBdYxCouNI7T8RgM/HX2KxUIYIjTm
166KY0sb+vfxyZj9zY+TkFiWYTh1nhq6lgd7B+2PIFZa5ZOunevqQPSK2sZzssma
3DjB6xiVvGQ2qPsAT4PJiXOaVWhI/fRid3APO/pSpBLvTzFMcTYF3Oovz5JmSVHv
J3cB920Ju3mDjUH7RM8mNS2v9l17vwsY15tQNO/vnwcPmwQWgNKGwjzHtpP9h7FZ
mXESTaz/VKHfisVs3RT+96Qi0Lj/nRhn4q4s6QC3ySwZiGsyBNBzyq+ldxcrAI8=
=X+a9
-----END PGP SIGNATURE-----

--SI+x/MFwqKaBjKyD--

--===============3548019047116160507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3548019047116160507==--
