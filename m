From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 18/19] ASoC: tlv320aic31xx: Add
 headphone/headset detection
Date: Wed, 6 Dec 2017 17:52:23 +0000
Message-ID: <20171206175223.2f6ki2w2ryaguhuy@sirena.org.uk>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-19-afd@ti.com>
 <20171201134127.2msgmjrfj47ypl3w@sirena.org.uk>
 <b2d9ffa9-3923-cb86-f0ad-cf4f37e56334@ti.com>
 <20171206173215.bitae546h2ibedhz@sirena.org.uk>
 <8e52d973-2335-e3c5-5e57-15621819cf45@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7948135014560896327=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B2F8D267A29
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 18:52:30 +0100 (CET)
In-Reply-To: <8e52d973-2335-e3c5-5e57-15621819cf45@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============7948135014560896327==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5bkb6c2vmnla7nal"
Content-Disposition: inline


--5bkb6c2vmnla7nal
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2017 at 11:47:14AM -0600, Andrew F. Davis wrote:
> On 12/06/2017 11:32 AM, Mark Brown wrote:

> >> missing a generic way to report jack information up to the machine layer
> >> driver.

> > snd_soc_codec_set_jack()

> Hmm, this looks close to what I was thinking (I was wanting to go the
> other direction and have the codec report what jacks it supports, this
> could allow for more than one jack), I'll see if I can make it work.

Almost always the CODEC requires some extra connections in order to
enable jack detection features, these are going to be board specific so
they come from the machine driver.

--5bkb6c2vmnla7nal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlooLlYACgkQJNaLcl1U
h9DmZQf/cB+ZYSTwBE/qbDozUDWCs9h0CyvqvPdc90spap371JSWZP9owyNT72eX
EsxXJahTHLW9WPZu12pSVIQ8oMUldfYfIvL5DI+Jz+sWFFrTzgauNy1/eyNGlamn
dPwnRZCF6VO7IVTbNNqkmgrTn6zaV73WApMw0RUwRLJooL8WLy8NjPQtncqfZdUy
VbY+mFggOUHLUKJIjLtsuTJJkjEcmLASOteb1wvTVEnM9O+hytuOk/+IG9OZH3Ff
TtbZK/HFct4gArvYg2aOV+357pPkWpduL/tRAa2OZIKEOZTRc1L+jn0PT5+TfHw9
2smtXuQD0U0s+woTU3LKAjYcJJoZ6w==
=i7mZ
-----END PGP SIGNATURE-----

--5bkb6c2vmnla7nal--

--===============7948135014560896327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7948135014560896327==--
