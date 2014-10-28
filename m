From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/8] ASoC: rsnd: Add Volume Ramp support
Date: Tue, 28 Oct 2014 22:38:14 +0000
Message-ID: <20141028223814.GM18557@sirena.org.uk>
References: <8761fc7vpx.wl%kuninori.morimoto.gx@gmail.com>
 <87tx2w6h2r.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8193309285910520831=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AFE23260443
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 23:38:39 +0100 (CET)
In-Reply-To: <87tx2w6h2r.wl%kuninori.morimoto.gx@gmail.com>
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


--===============8193309285910520831==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aTq0RFdLe0rSEdju"
Content-Disposition: inline


--aTq0RFdLe0rSEdju
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 21, 2014 at 06:14:55PM -0700, Kuninori Morimoto wrote:

> This sample indicates Mute -> Volume 100% -> Mute

> amixer set "DVC Out Ramp" 100%		// Mute as default
> amixer set "DVC Out Ramp Period" 80%

Normally this would be expressed as an enum with some sort of time
units.  We did discuss at the mini-summit making a standard way of
expressing this but nobody did that yet.

> amixer set "DVC Out Ramp Enable" on

That "Enable" should be a Switch control.

> aplay xxx.wav &
> amixer set "DVC Out Ramp" 0%		// to Volume 100%
> amixer set "DVC Out Ramp" 100%		// to Mute

I'm not sure I quite understand this control - what exactly is this
setting?  It appears that the ramp value is the opposite of the volume
we end up with which is a bit odd and the comments suggest that this is
actually triggering a ramp when normally ramps would be done as part of
a volume set, mute or power up/down operation.

--aTq0RFdLe0rSEdju
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUBrVAAoJECTWi3JdVIfQpyMH/jiz1kE9SWEK6yG/zF9oe0Bk
rX3QShfMDz7jCD2vCyFveieQN2tIJLFLkhtM0wv3prxRXsdAU/IMpqSfyjKxa9re
BJHXny+J7mGnX5yBqAUZbbKYDd0PH4vhpBsP22qkB0Um3jWwJ2NLAQnWFrzUJvwe
ltE5eDd1rN6HlUj2fWNUfrHJnNvBNVfnH0VU6STU1q+AO8HFdF6V2eRZ2gUaITrv
o8PqUBW+oNsYN9vbGx5EhH0v/35Iq2tbXN9ioew2dLGGrVrjBnKczXNXN6fJ95ji
1KBoMarf9Sxx/yZwnda5VNxbxxteji0/MXiMkd2GS+s7hw4RLX7sFX4PBOj23NE=
=bqIi
-----END PGP SIGNATURE-----

--aTq0RFdLe0rSEdju--

--===============8193309285910520831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8193309285910520831==--
