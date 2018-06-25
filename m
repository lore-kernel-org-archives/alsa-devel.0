From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: add generic simple-amplifier
 support
Date: Mon, 25 Jun 2018 13:39:52 +0100
Message-ID: <20180625123952.GJ9413@sirena.org.uk>
References: <1529924777-21136-1-git-send-email-nicveronese@gmail.com>
 <20180625112144.GB9413@sirena.org.uk>
 <1529926289.2900.26.camel@baylibre.com>
 <CAGb2v64D=DC02vVfwJj3XHwQTcAeS6y6fujdj2v=f5O5QHmLxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6651712890152829158=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E6C8B26720C
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 14:39:58 +0200 (CEST)
In-Reply-To: <CAGb2v64D=DC02vVfwJj3XHwQTcAeS6y6fujdj2v=f5O5QHmLxg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Linux-ALSA <alsa-devel@alsa-project.org>, =?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============6651712890152829158==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x+WOirvrtTKur1pg"
Content-Disposition: inline


--x+WOirvrtTKur1pg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 25, 2018 at 08:28:32PM +0800, Chen-Yu Tsai wrote:

> I think slightly different semantics apply for "shutdown" vs "mute"
> pins / controls.
> "shutdown" implies a low power, if not powered off altogether, mode which might
> require a slight delay to charge up when the amp is enabled. "mute" is
> just that,
> disconnecting the output, which would be useful in masking pops or other noises,
> but does nothing to help power consumption.

> Not sure if the subtle differences can be handled in DAPM, but it would be nice
> to have. I've seen devices that have both control pins.

It's certainly potentially useful to have pins for both and treat them
differently - ideally something that's a mute would get autodisable type
treatment so we mask out any pops in the input path but also make it
available to userspace if it needs it.  That's something that could be
done when the need arises though, until something that actually has both
controls appears handling a mute pin like a power control is probably
going to result in the most reliable integration.

Having the binding specify both differently would be good for future
proofing.

--x+WOirvrtTKur1pg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsw4pgACgkQJNaLcl1U
h9Cpmwf/TiwmTUdVSAb0LeeWkyk2hygDiacTevdoKcNhHYYBvm1N4l4p9AdHskzk
SikaiDzNyBAX6br2f42u80frdQ0s66qqkBTHY6y6x+Vj16aRieBKzxnjjIwOiYqV
YoZUGoqXyQ5KSpM9uapuAMZCpAy5LAO8vvEtcKtvSnza68+TAXp7R0zHym0pbQst
lyyla6EMSuVX9UAPtZxgPP8JCF03NRewF6cu+v/iMYYmJJXX3We2lNeBpPoehKDF
yU2zFGyjKINuCFH0TKv0ECILxFjXt7+lJ+hGqzyw3FRX9mPwkxJgfaZ1mBSs1400
qHXooWi3A8/sRDc+3aXjwyyFXd6gVg==
=GoTy
-----END PGP SIGNATURE-----

--x+WOirvrtTKur1pg--

--===============6651712890152829158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6651712890152829158==--
