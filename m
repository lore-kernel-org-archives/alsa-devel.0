From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/9] ARM: dts: sun8i: add device tree for
 Lichee Pi Zero with Dock
Date: Mon, 27 Feb 2017 08:49:11 +0100
Message-ID: <20170227074910.hdsge4qhbqqufe36@lukather>
References: <20170225123029.55939-1-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0020968750742451794=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 626EE2669AF
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 08:49:11 +0100 (CET)
In-Reply-To: <20170225123029.55939-1-icenowy@aosc.xyz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Icenowy Zheng <icenowy@aosc.xyz>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0020968750742451794==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o7rhhkyaybixokpx"
Content-Disposition: inline


--o7rhhkyaybixokpx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 25, 2017 at 08:30:21PM +0800, Icenowy Zheng wrote:
> Lichee Pi Zero features a dock, which adds some functions, and should be
> soldered with the core board of Lichee Pi Zero.
>=20
> Add support for the dock as a new dts, as soldering is needed to make
> the dock usable and there's functions enabled on the dock that is
> unavailable at the 2.54mm pins of the core board.
>=20
> Currently no new feature on core board is available in the mainline
> kernel, so the dock dt file only includes the core board device tree.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

How does that relate to the rest of the serie, which seems to be about
the audio on V3s?

This should be clarified in a cover letter, but you know that already.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--o7rhhkyaybixokpx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYs9n2AAoJEBx+YmzsjxAgOF0QAIIfE4B+6EZWoFBkrCEvMJ6W
JZX2eoH0K23ZB9XvvsgR4DeQ8fYPZV3Oj23AuUvOvz7jSNoQFDR57UY3A/YVRmDG
bl9ddr9EvLrqFNFN8QuVeuYAhXJybAa+Z0dPHRyXN0Axz8tb78IfhKlNbw0ROVSc
y3mcPlYv3ssw9EVCjVngX77R4GHI1NFtBiMsIsb+/F5QFjvSIIQ57zm7v2P6wdPf
5NJqvXr5Vz5KiFOX2ixD9bpWI+w5twROEbIYDmRlQM71qKwCRly92GrMB34W525r
mnA3m+Mmmr1L9WJEYh2LJj8Y7sPlhGi4WoKrSPbnP0Z1bvZ9x6qt29izfzeTXtq7
1US8m8BFS5lwzIKjBR4Cececrc/0w7798NqELC/P6FRTwS0gV3qTaiEuXX7u0BUT
tMg06OEjQ/oGXXg8x2nnfZJAB+EepqMUSEPzLHE8elfRBkBMN8UDmrzd43mWifo1
YFtUpStzUmh0keIFLbGt2lZ81j2nIDD0ED5Vz2k5wq/FDaAGZEchzsbm2z/WLQAg
qVW8Kh6N9ozpMbZkMx4b7Lc1jDBbNBC/B2Vw/asnJkfiLCgnh2hEWzgGXm0DIlkI
4HCD05JnyiqAcCGbMW6oTEw30JOg7+nXkprIuVax+BhW4O4zzOhO9KPsAIW+4gLz
XQnykiagMrNoJ0TRD64F
=1z7j
-----END PGP SIGNATURE-----

--o7rhhkyaybixokpx--

--===============0020968750742451794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0020968750742451794==--
