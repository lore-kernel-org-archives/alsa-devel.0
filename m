From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 0/5] Add a gpio jack device
Date: Thu, 28 May 2015 11:17:44 +0100
Message-ID: <20150528101744.GT21577@sirena.org.uk>
References: <1432332563-15447-1-git-send-email-dgreid@chromium.org>
 <55633CED.2090600@metafoo.de>
 <20150525171501.GC21577@sirena.org.uk>
 <5564BED6.3070604@metafoo.de>
 <20150526201426.GA21577@sirena.org.uk>
 <CAEUnVG4FT-U_iwB573VchtQqe9p8jnMYYSptFoYHmzSiwOiG7A@mail.gmail.com>
 <20150527172631.GG21577@sirena.org.uk>
 <CAEUnVG6_p7xqYmkxjrqFwTbqwCEO0JiNwjL-pLE2GKv3eLbN+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7835263367001333328=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E66F7260423
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 12:17:55 +0200 (CEST)
In-Reply-To: <CAEUnVG6_p7xqYmkxjrqFwTbqwCEO0JiNwjL-pLE2GKv3eLbN+g@mail.gmail.com>
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


--===============7835263367001333328==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Il4pjpEPUke4dLdr"
Content-Disposition: inline


--Il4pjpEPUke4dLdr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2015 at 10:38:32PM -0700, Dylan Reid wrote:
> On Wed, May 27, 2015 at 10:26 AM, Mark Brown <broonie@kernel.org> wrote:

> > So like I say I was thinking that either the jack object has a list of
> > detection method phandles which point to other devices or the other
> > devices point at the jack object.

> I might not be completely following this.  Do we want to create a
> binding for the physical plug and another for the method used to
> detect the if a device is attached?

Yes, or at least allow other things to extend what the device is doing.

> What is the benefit in separating the plug from the detection method,
> these seem pretty tightly bound to me.  There are three main types of
> detection for headsets, gpio, ADC measurement, and offload to a codec
> or HP chip.  Are there situations where those would change separate
> from how the jack is connected?

No, but they can be combined onto a single jack - for example have a
GPIO switch that detects mechanical insertion and a CODEC that detects
microphone and button presses.  The GPIO/ADC combination used to be very
common, it's essentially just a non-integrated way of doing what your
accessory detection device does.  If you have non-audio functions on the
jack then things get even richer.

--Il4pjpEPUke4dLdr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZutIAAoJECTWi3JdVIfQ5IoH/2CqJ4jGBey0WSYaXPGpIfLv
hvxrLOLfRoQX/FaJ4CJ49FJKs2Qfbck69uF18DAw0dO+tRUbXOWGwTo4OC/oflmF
khdbETbG+yRF5CCFlDKHbvY59g1pbiyPnVo6zzg2YPZ9boIVWTfha3pNc5YLAetM
NTyzHVIcu4yEzboCMrwz7m9+1Dl+h/zZnNSuBphzcR156guyzbmIBY+RMmTGZawl
Fmug6l05rSR9eoPFpP6xJtnjkcMR6EJSscUmjGcS4e6sxi2JSAcxZPJ89OmcN2UZ
kITydPI29rCmNUdiqa9wk4D4bji1hAbduay16VFdyyWVds5jU9cvHAiHfspfRvg=
=vLQN
-----END PGP SIGNATURE-----

--Il4pjpEPUke4dLdr--

--===============7835263367001333328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7835263367001333328==--
