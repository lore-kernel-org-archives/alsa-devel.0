From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 0/5] Add a gpio jack device
Date: Mon, 25 May 2015 18:15:01 +0100
Message-ID: <20150525171501.GC21577@sirena.org.uk>
References: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
 <55633CED.2090600@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7028212736942398134=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AF842619BE
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2015 19:15:13 +0200 (CEST)
In-Reply-To: <55633CED.2090600@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, alsa-devel@alsa-project.org, zhengxing@rock-chips.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7028212736942398134==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RKpxPxAhf7+cN71p"
Content-Disposition: inline


--RKpxPxAhf7+cN71p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 25, 2015 at 05:17:01PM +0200, Lars-Peter Clausen wrote:
> On 05/23/2015 12:09 AM, Dylan Reid wrote:

> >The first three changes add a gpio audio jack device.  This device can
> >be used on systems that report headphone or mic plug through GPIOS.
> >There can be 0-N of these devices created per board each can report one
> >of several events.  For example, this allows for a single jack for
> >HP/Mic and a separate jack for line out.

> I'm not convinced that this series is the right approach and I don't think
> it helps us to solve the problem.

I think it solves the 90% case well enough for simple-card (which is to
the main target user here) and the situation with jack detection is
already fragmented enough that we're not likely to make things
that much worse.  Though now I think about it just taking the gpio out
of the device name would help with binding reuse for other users.

> I think what we need to get the layering and encapsulation right is to
> introduce a distinction between jacks and jack detection logic. The jacks
> are part of the fabric and should be registered by the machine driver. The
> jack detection logic can be implemented by either GPIOs, a dedicated jack
> detection chip, like the TS3A227E, or can be part of a more complex CODEC.
> The jack detection logic is a function that is provided by these. The audio
> fabric, which makes up the sound card, is a consumer of this functionality.

> To be able to properly abstract this changes to the framework are necessary
> to introduce the concept of jack detection logic providers and consumers.

> The chip/driver that implements the jack detection logic register a jack
> detection logic provider, the machine driver registers the jack and
> specifies which jack detection provider is used for each jack.

Yes, this is the complete solution - and it's not an audio specific
thing either, there's a reasonable case to be made for saying that that
this should be resolved in extcon rather than in any one consumer
subsystem.

--RKpxPxAhf7+cN71p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVY1iSAAoJECTWi3JdVIfQWZcH/RphqTG9DTyudgs2Zi+e8P4s
da9atKFlWSaZdKHI7+TIuMhkL8AD6ou6RSsNO4tu93Af5P2yewsDiR6ZsqOsHyjM
c1GEQlKdCATVfyvRQwCw84eyMQ9Ag0dFxeqglUGQneKw/84AZvfIaQ2rsJZtxBNQ
JCniFlYg0WNkBQnF/z03GDZr7Z0pCfodZVJdLkBdUN/WezrCy5jsCauzlzIkhz3X
R4rX1VTV8snwnsfIi7BGVDcuytSWI153+C6hhWFhFKgxX4Qb/TxhqoaTnynJNrB/
ngAOA+O4ChGwIC1vIoFfnQDW7LjGLeEfkW8DTyh+49pbnWPFcsZCKnKi9FR7uNQ=
=22D6
-----END PGP SIGNATURE-----

--RKpxPxAhf7+cN71p--

--===============7028212736942398134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7028212736942398134==--
