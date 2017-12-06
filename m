From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 08/19] ASoC: tlv320aic31xx: Switch GPIO
 handling to use gpiod_* API
Date: Wed, 6 Dec 2017 12:46:38 +0000
Message-ID: <20171206124638.GD1827@finisterre>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-9-afd@ti.com>
 <537c8d62-de11-15e8-11bc-08e8334d4322@ti.com>
 <17fcc926-9ee8-1229-ea3d-f38347cb9a23@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3586602946237265480=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CBED266AE1
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 13:46:41 +0100 (CET)
In-Reply-To: <17fcc926-9ee8-1229-ea3d-f38347cb9a23@ti.com>
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


--===============3586602946237265480==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Content-Disposition: inline


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2017 at 03:23:49PM -0600, Andrew F. Davis wrote:
> On 12/04/2017 10:47 AM, Andrew F. Davis wrote:

> > Kbuild bot seems mad a this one, looks like I need to include
> > linux/gpio/consumer.h, will fix for v3.

> Looks like you already have this in your -next branch, how do you want
> this fix, I can send a delta patch with the added include, a new v3
> version that you can replace the patch in-tree with, or if it's easier
> for you manually fix in-tree?

As the patch applied mail says:

| If any updates are required or you are submitting further changes they
| should be sent as incremental updates against current git, existing
| patches will not be replaced.

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlon5q0ACgkQJNaLcl1U
h9B6Vwf+Mim1FuDiJAqRFw5C3aCj84xUEoCjBY3Cm39RFdpTANw0nH9p5+GJa7DB
8mspachRVyVILrexXPyWnpr1WGW0YSdNU+ZJPfh5qjg79mt8F4ELo7HKyl3LHN3x
OLa8G0z/gTJ9oQNfeb8kzU77nEiA8/eUU33CVr6pQEyHpde2XF+Fvvsl3FqCB7Jt
I07tR1FHbO14+RqrVeY778lOy8jAXzxYhMfMR14iPA+GeuwlkZ9uQmWxE7y0Dwyt
RLehl/4UoJuJWM1TNBEoSLwvW0tBeap/tHvu1240gwx0dHVZzi+XhUZWVq+5z/ul
gGcVKLBbq4Hp8r+IdZp+cMmU5fCB7A==
=ZRtc
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--

--===============3586602946237265480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3586602946237265480==--
