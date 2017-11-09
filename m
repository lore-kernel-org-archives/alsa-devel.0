From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/17] ASoC: tlv320aic31xx: General source
 formatting cleanup
Date: Thu, 9 Nov 2017 16:15:53 +0000
Message-ID: <20171109161553.vgefnocjktnpmrj2@sirena.co.uk>
References: <20171109002741.10897-1-afd@ti.com>
 <20171109002741.10897-2-afd@ti.com>
 <20171109124143.mpolqcvsdzj2t6tv@sirena.co.uk>
 <98eaa342-8405-56af-0804-38c7c1e5bc2a@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1153015218566630172=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A5D96267826
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 17:16:05 +0100 (CET)
In-Reply-To: <98eaa342-8405-56af-0804-38c7c1e5bc2a@ti.com>
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


--===============1153015218566630172==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yfks4eiqhcynewa3"
Content-Disposition: inline


--yfks4eiqhcynewa3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2017 at 08:13:17AM -0600, Andrew F. Davis wrote:
> On 11/09/2017 06:41 AM, Mark Brown wrote:

> > There's other things in here like adding error reporting...  please
> > don't send changes like this, if you want to do cleanups you should
> > split them up in the same way you would other changes.  Bigger patches
> > are harder to review especially if they're not repetitive examples of
> > the same pattern. =20

> I'm never really sure with these where the split point should be, almost
> every change in here could be its own patch if I really wanted to pad my
> kernel patch count, but this series is already 17 patches long and I
> usually see these all as the same logical action: non-functional cleanups.

> I agree the added error message isn't purely non-functional and so
> should be broken out, I'll break out a couple other changes for v2.

This is why cleanups don't happen :)

A separate cleanup series would probably cover it, when they're split up
well they're quick and easy to review.

--yfks4eiqhcynewa3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloEfzgACgkQJNaLcl1U
h9Bwxgf+K/x//kbeY+xtueRKC+CWDmVc7UjYIAHAqS6s5l/psxdb2e6SPOY8e4MM
VgRj0/gMsOkGDy/fUUEaI6ZiX+eqX4ucQLwV3wCgYPWqGxlkLG8OrAf6UPZrN8Ko
/1O3/XD6ju6adaF6jC4BCzl1naF0tXSRzz6a4EICPKJj0Fi7NH97q56moKM4m/YT
WU7aREusATrfXSyQdD8lU/iCbSLBgCTIAfBENLqKVy0fQIrx2uvhap/ACkEgunkI
Z7nR9ufSaMJSiDOtJMl4QOTgvpdI9lKHu3NAKfBFYGgfwyfag4tqCWh9sI+yeTNE
7gJjdIUyjBs82Wjx/SuQUoSPPylrOA==
=B6Fn
-----END PGP SIGNATURE-----

--yfks4eiqhcynewa3--

--===============1153015218566630172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1153015218566630172==--
