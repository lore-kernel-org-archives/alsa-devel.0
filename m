From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pxa: add I2C dependencies as needed
Date: Tue, 3 Jun 2014 22:59:44 +0100
Message-ID: <20140603215944.GB2520@sirena.org.uk>
References: <46560700.2S4p0nUZl8@wuerfel>
 <87k38xg0k6.fsf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9025492731225516098=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C2451261AB6
 for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2014 00:00:12 +0200 (CEST)
In-Reply-To: <87k38xg0k6.fsf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, lgirdwood@gmail.com, Daniel Mack <zonque@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============9025492731225516098==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2014 at 11:12:09PM +0200, Robert Jarzmik wrote:
> Arnd Bergmann <arnd@arndb.de> writes:

> > To shut this up for good, this adds the dependency to every board
> > that uses I2C as the interface to the codec. I have gone through
> > all board files and verified that they all either use AC97 or
> > I2C, and this annotates the latter. Some of these already enable
> > I2C from mach-pxa/Kconfig, but since that can change it's better
> > to be explicit here.

> Any reason SND_PXA2XX_SOC_MIOA701 escaped ? The board is PXA based, and its
> codec wm9713 is I2C based, and relies on AC97.

The WM9713 is AC'97 only, there's no I2C interface there.

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTjkVIAAoJELSic+t+oim9t+UP/38qON8kF0c9RTqGVgyXkBG0
xq9USKYJ7xofHRpL6/oURyQlbYB2KYVGcWHC4c2ca9RAum10Dzgl4z4XGkydixJk
sspb2V9WXOf9MdRHie0PIhVBtzhsB2elK5iI6r0UjOIh6lkFTNttYR2gSz45scok
fH3dorWvwjdI3IyoGsKHbjljHVSEU6eXNtst9divgzwwoBPbxgnpVHbr6TRDKEZJ
HEAVsC4Hp13pLQ+NSmE61rwbGQezZ+BNKg98dHDU+KFlw1Pxu88OsrZobyNLaS8m
PJE/6idvFPGgsCoPsn7w+/3Qt+gslK1HCWwdPQpzlmdUVdgHX8pNzkbTZx5w12gn
mFcDV53fMcoTPIbOXdoxQAjmg4IB0iMUUOaYscTvu0JkljWjEbWh66uUpK28ky3T
aJIjdhKSGbFL+k6jSQOMAVClAvD+UMcyA1DZNHJvQIuhA1rgZA1G4f5YsgB9rNyD
TxYxpkWIC/brWzVcXoFGswtI4MFGxLOEa/nell212qDSDEsr5P1EGyKROoQ2gaR5
HuMZoXPFHXK/IB3suXUKUYn9LWm7Q0YgFhrNDGCNmsxXiLmjuK47sLkOdEOuwUz6
n593loouQ8M7k6+h02ag2W9CFvER4Kf9/Nv53L+GFzNwJGDd04X8v4sKDQCQdLn1
pA87xZMZcvGnN0DCGsp3
=tFsU
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--

--===============9025492731225516098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9025492731225516098==--
