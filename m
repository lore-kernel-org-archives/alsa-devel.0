From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: adau1761: Use the standard
 fall-through annotation
Date: Fri, 5 Oct 2018 12:42:54 +0100
Message-ID: <20181005114254.GB6266@sirena.org.uk>
References: <20181004183006.23983-1-tiwai@suse.de>
 <20181004183006.23983-2-tiwai@suse.de>
 <6342c80c-7d4e-74d5-f5e9-9353e83c7e5c@metafoo.de>
 <s5hr2h5lfow.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1983175626137599828=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A60B62678D6
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 13:42:57 +0200 (CEST)
In-Reply-To: <s5hr2h5lfow.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============1983175626137599828==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 04, 2018 at 08:39:11PM +0200, Takashi Iwai wrote:
> Lars-Peter Clausen wrote:
> > On 10/04/2018 08:30 PM, Takashi Iwai wrote:

> > > As a preparatory patch for the upcoming -Wimplicit-fallthrough
> > > compiler checks, replace with the standard "fall through" annotation
> > > at the right place.  It has to be put right before the next label.

> > Looks good, but somebody else already sent the same awhile ago. I'm not
> > sure, maybe it did not get picked up:
> > https://patchwork.kernel.org/patch/10560465/?

> Yeah, seems to have slipped from Mark's hands.

> I don't mind which patch is taken, of course.

IIRC I had a query about it as it was part of a series that had some
oversights.

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu3Tj0ACgkQJNaLcl1U
h9B14wf+Ko0+IzYByGSlWTtlaZ9RykIeu8ErLdTtbQO2gKoVmwB+TlBx6Mq990gS
hp1wX7fiCko3hxRA+vjehR7GkIyr958flleXzW36p3UJ2PqbDjgj53h+H0JaXsKh
UcCkqZMZM9n/UdgMf1PLwASpfyAvQ197N7EK+mznS7ccShtBEcIbfj4+X3lT+mkU
HGsapD0gCO6MIEi3oXd5cdT1gYfVbwzPSs80E72Kz0yVWz/T3gV4fblhsp9fPYz5
Z17+8N9t/urRDEvHpzwTbYCqbilbC4QJzdxNIk3ljEesLDyMGVIK9/hsNCgZ/5ba
Wugiz8Zk2P9LwIXWHgD9dv3EvhhayA==
=qB6N
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--

--===============1983175626137599828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1983175626137599828==--
