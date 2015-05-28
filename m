From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 0/5] Add a gpio jack device
Date: Thu, 28 May 2015 20:35:22 +0100
Message-ID: <20150528193522.GF21577@sirena.org.uk>
References: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
 <55633CED.2090600@metafoo.de>
 <20150525171501.GC21577@sirena.org.uk>
 <5564BED6.3070604@metafoo.de>
 <20150526201426.GA21577@sirena.org.uk>
 <5565A6B3.6040509@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1284831403081903700=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9458F260502
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 21:35:38 +0200 (CEST)
In-Reply-To: <5565A6B3.6040509@metafoo.de>
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


--===============1284831403081903700==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4qmSKZ4wRjDlc0ae"
Content-Disposition: inline


--4qmSKZ4wRjDlc0ae
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2015 at 01:12:51PM +0200, Lars-Peter Clausen wrote:
> On 05/26/2015 10:14 PM, Mark Brown wrote:

> >Could you expand on the abstraction problems you see please?  It looks
> >like a fairly direct mapping of GPIOs to a jack to me (like I say I
> >don't see having GPIOs directly on the jack object as a problem - having
> >to create a separate node to put the GPIOs in doesn't seem to solve
> >anything) and we're not likely to have enough GPIOs to make the usual
> >problems with lists of values too severe.

> Sorry, I overlooked something which lead to a bit of misunderstanding. I
> though that the gpio-audio-jack driver also sets up the DAPM pins for the
> jack, based on that patch 4 removes the DAPM jack pin setup from
> tegra_max98090 driver. This would have resulted in a weired dependency chain
> where the gpio-audio-jack driver sets references DAPM pins by name which
> belong to the audio fabric that references the gpio-audio-jack node as its
> jack detection chip. But the driver doesn't actually do that so there is no
> real implicit dependency to the audio-fabric in the binding itself and it is
> all internal to the implementation. So that is OK.

Ah, yes - that would indeed have been bad.

> I'm still a bit uncomfortable with mixing up jacks and jack detection logic.
> For the GPIO based jack detection logic this isn't that bad since we could
> argue that the DT node represents the jack. But I'm a bit afraid that this
> sets a precedence and we'll soon see bindings where the description of the
> jack becomes part of the description of the jack detection chip or CODEC.
> And the component or CODEC driver is responsible for registering the jack.

Yes, we do need to make it *the* binding for a jack when things are put
into DT.  Hopefully that's fairly easy to police, and if we can get some
detection drivers using a binding that works with a jack object (ideally
with helpers) then that will provide positive examples too.

> And the other problem is how do we match up DAPM widgets to a jack. This is
> functionality from the tegra_max98090 driver that is lost in this series.

That is going to be an issue when we start hooking things up isn't it.
Off the top if my head if we define some standard set of widgets that
get created then it just becomes another device for the machine to route
to/from (which is the logical extension of making it an auxdev).

--4qmSKZ4wRjDlc0ae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZ235AAoJECTWi3JdVIfQju4H/jQa+7hPJGsLtBy18AiIan1X
8cr7envbgEUR4kJA4q+zDTSLpn+z0WNU04s9O2iigiFFq1OLc2MzTibQWXS0YMzy
FTLx2q/a9dQ92uUypLlppNJ+omwETBj+vQVsg7UqVPdTB3EJMAi8c/8H/2SyZDpb
Eg9Tdn6viwTePA+wMet3vQlcinNJGUVrS/oczO/3k21IB6skqgeBTGZDw/kVpbnx
+vtqO+rKYJDN77Y1yIOUlH8Yn38PFi59A524dVTrtH0lXieC59oZ7hWC7Z19gtGN
ChNpMXoPL3vu3cIMFog0hPwi98d4cCcjKBHyfBnHjhZOtLH7aXTPRTXbAj6xnV8=
=i9z0
-----END PGP SIGNATURE-----

--4qmSKZ4wRjDlc0ae--

--===============1284831403081903700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1284831403081903700==--
