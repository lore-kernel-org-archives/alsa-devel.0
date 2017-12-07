From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 16/19] ASoC: tlv320aic31xx: Add short
 circuit detection support
Date: Thu, 7 Dec 2017 12:03:52 +0000
Message-ID: <20171207120352.4obvlu4cemagfom7@sirena.org.uk>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-17-afd@ti.com>
 <20171201133930.xzfjjj6wzkbtk6c4@sirena.org.uk>
 <4d956cbc-829c-0d81-2980-aa2a79f36660@ti.com>
 <fd362117-ae71-a6a2-eb43-70c2457c0a5d@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1059093800932191349=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 998CA2670BC
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 13:04:04 +0100 (CET)
In-Reply-To: <fd362117-ae71-a6a2-eb43-70c2457c0a5d@ti.com>
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


--===============1059093800932191349==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2rxxai2avwi7xst3"
Content-Disposition: inline


--2rxxai2avwi7xst3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2017 at 02:22:39PM -0600, Andrew F. Davis wrote:
> On 12/01/2017 09:32 AM, Andrew F. Davis wrote:

> >> This will report the interrupt as handled even if we didn't see an
> >> interrupt we understand which will break shared interrupt lines.  At the
> >> very least we should log other interrupt sources numerically.

> > Okay, I think I can make that work by checking if no bits are set in the
> > interrupt regs and returning early if not, IRQ_NONE.

> This turned out to be more difficult than I expected, plus if I do
> handle an interrupt it doesn't mean the other device did not right? So
> this wouldn't fix shared lines as far as I can tell, but I don't
> register it as shared so this should be fine.

It'll mean that we don't offer the interrupt to anything else sharing
the line.

> As for your other suggestion of "log other interrupt sources
> numerically", could you explain this or point to an example of what you
> mean?

Just print out the bits that were set.

--2rxxai2avwi7xst3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlopLicACgkQJNaLcl1U
h9DlkAf/Swg/pQ9TfBpAbuL1qabvbPSFYutbVk2QDkaIJII+toomOWiK55H/jIQL
roYqlO2HchUUcD92WPm+kR9zclGbqFJWhBkxXhZwzNfZqB2QpBQw74aVTjYyLmwZ
D3GCeqxDq/mHbgMB5j3aBD9uo/lX44eA75vi+37+tgXzrAz/GbM4IGkY/6cQxPnC
ntrHDMuVBPDOPTLkGdqjTuHjKfGiYbnsYQUWKaeveG6Ew7kenUv3qMASYowqJ61V
Y9al7/OxVitva4uYODj2cDmi/Y4uL8rr0xo9v/CcuubI24n7b8gZPgrRGXO1Tg/t
4naeMJttnrXsmaiSGyMjzXWyULOcDA==
=oks2
-----END PGP SIGNATURE-----

--2rxxai2avwi7xst3--

--===============1059093800932191349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1059093800932191349==--
