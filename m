From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 0/5] Add a gpio jack device
Date: Wed, 27 May 2015 18:26:31 +0100
Message-ID: <20150527172631.GG21577@sirena.org.uk>
References: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
 <55633CED.2090600@metafoo.de>
 <20150525171501.GC21577@sirena.org.uk>
 <5564BED6.3070604@metafoo.de>
 <20150526201426.GA21577@sirena.org.uk>
 <CAEUnVG4FT-U_iwB573VchtQqe9p8jnMYYSptFoYHmzSiwOiG7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1282135263628097657=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 632BE26044E
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 19:26:41 +0200 (CEST)
In-Reply-To: <CAEUnVG4FT-U_iwB573VchtQqe9p8jnMYYSptFoYHmzSiwOiG7A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Xing Zheng <zhengxing@rock-chips.com>
List-Id: alsa-devel@alsa-project.org


--===============1282135263628097657==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MWrNmmo+n+ez9Z40"
Content-Disposition: inline


--MWrNmmo+n+ez9Z40
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2015 at 09:22:53PM -0700, Dylan Reid wrote:
> On Tue, May 26, 2015 at 1:14 PM, Mark Brown <broonie@kernel.org> wrote:

> > The only things that concerned me particularly were the name (which I
> > did agree on once you mentioned it) and the use of a bitmask to describe
> > what's being reported but it's hard to think of anything much better
> > than that.

> Is just "audio-jack" too generic?  There are a lot of audio jacks that
> wouldn't be described by this binding, such as those reported by the
> 227e or 5650.  The original goal here was to describe a jack that has

I think it's fine - I think we can use this as a jack object and have
other things reference it to supply additional detection mechanism.
Lars' point about jacks not just being for audio is a valid one, though.

> one or more gpios, each representing a particular type of device being
> attached.  This doesn't overlap with the binding for a jack that is
> handled by a headset detect chip.  Does this seem like the right goal,
> or is there a benefit to having an "audio-jack" binding that tries to
> cover all different types of jacks?

So like I say I was thinking that either the jack object has a list of
detection method phandles which point to other devices or the other
devices point at the jack object.

--MWrNmmo+n+ez9Z40
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZf5HAAoJECTWi3JdVIfQlOYH/2WZqZs4aa7jKjpvUUH2nd87
iEP6n4sRhVhlzqSM8qIpkb/Shvo7YW996uOa1BTMVReRT3R8ZGg9rH66ksVYs5va
YDIXdAWkvq6tvI2+igQqNydJ+dEo5nKc1WmpkdJiAmaCoOAZlZorLE0vnoLQs04q
aCk8ubEQL7TYixv+KVBT0u0J6YT7X9Osg9bZPS9M0egqaznjayhs41q2RmQdRE1w
yEeBhXEUvZy+nwDyCgBRgtyhx7WlOWK6PVY8t949iJz+66PiNKrcwe1Ntml8S6af
m2UoVbBYJ3bdb3TrNWVeHfXPBK1Ostz1uLcSl/So6zSd2oBDSRQxVY00iZglfNk=
=8a05
-----END PGP SIGNATURE-----

--MWrNmmo+n+ez9Z40--

--===============1282135263628097657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1282135263628097657==--
