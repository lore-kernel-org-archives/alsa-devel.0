From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: core: call
 snd_soc_unregister_card() when component cleanup
Date: Mon, 9 Feb 2015 16:20:16 +0800
Message-ID: <20150209082016.GD2593@finisterre.sirena.org.uk>
References: <87h9v4gbhg.wl%kuninori.morimoto.gx@renesas.com>
 <87iofj7qhc.wl%kuninori.morimoto.gx@renesas.com>
 <20150204205503.GM21293@sirena.org.uk>
 <87lhkcj55p.wl%kuninori.morimoto.gx@renesas.com>
 <87k2zwj4zf.wl%kuninori.morimoto.gx@renesas.com>
 <20150206214659.GA31311@finisterre.sirena.org.uk>
 <87lhk7x58a.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3392078712887584364=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 12026260606
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 09:20:49 +0100 (CET)
In-Reply-To: <87lhk7x58a.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3392078712887584364==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 09, 2015 at 01:06:13AM +0000, Kuninori Morimoto wrote:

> It needs more and more change if we solve this issue without above hack,
> then, it is very difficult to check all consistency for all features, all situation.
> I'm afraid that it can be next bug.

Yes, pretty much - that's half of the reason why this is the way it is.
Not many people want to do this and it's hard to get working.

> So, how about this ? if un-loaded component unregister card, and if re-loaded component
> re-register un-loaded card automatically, it is easy, and safety ?

I'm not 100% sure what that would look like - presumably something would
need to remember the card?

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU2G2/AAoJECTWi3JdVIfQaJgH/R9PRRZptlVFYOSWfe9lYz+t
8rSbK9QzjjAMxvLNPyE+cY8EQJGkD2lPBMKYpySNHrj98QsIJZh4a4bqU4cOzZun
7Uhk4gKhmTc4C95Hl2isTWALkLKMxE4T8ULjLxSjFn7So5N4oVg/TjXrkH43qVyr
YmkCIfyxqe8bukM32XWqRmG+gcRYPVR3oJwczM9pHdFKA+eXvB79KUf+EyzU1Wp5
5lGmgDefJcxus+NVAkzH2qrHRZNVYhgndA124UmTd4fp3rYKw20KLyhaTONl3c/j
UvRfYBi2jlkqgVk4QbKZAKb/CIATESDTfvfNV41K624cS0kOwvtZjbxdr2nel2s=
=DTKg
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--

--===============3392078712887584364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3392078712887584364==--
