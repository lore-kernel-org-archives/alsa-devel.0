From: Mark Brown <broonie@kernel.org>
Subject: Re: Audio codec with multiple I2C devices
Date: Mon, 7 Apr 2014 12:37:10 +0100
Message-ID: <20140407113710.GC14763@sirena.org.uk>
References: <mailman.300.1396595329.806.alsa-devel@alsa-project.org>
 <C71C517D-B88B-48C3-9156-AB9DD40AE4C0@whospot.com>
 <53411B1F.5070004@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6707510649434227322=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D78026157F
 for <alsa-devel@alsa-project.org>; Mon,  7 Apr 2014 13:37:30 +0200 (CEST)
In-Reply-To: <53411B1F.5070004@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Gilles <gilles@whospot.com>
List-Id: alsa-devel@alsa-project.org


--===============6707510649434227322==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8QTINAT9I+GWM3JK"
Content-Disposition: inline


--8QTINAT9I+GWM3JK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 06, 2014 at 11:15:11AM +0200, Lars-Peter Clausen wrote:
> On 04/05/2014 12:02 AM, Gilles wrote:

Always CC kernel related mails to relevant maintainers, it's very hit
and miss if things on the list only will get seen.

> >I'm writing an ALSA SoC codec which uses a 3 distinct I2C devices (a
> >DAC, a CAG for volume and a input selector) all 3 at different I2C
> >addresses.

> If those are 3 distinct devices you'd typically implement them as 3
> different drivers and model the interconnections between them at the
> board/machine driver level.

If they're hard wired together then i2c_new_dummy() allows a single
driver to control multiple slaves - have the driver instantiate from one
of the addresses and then register dummies for the other addresses.  The
framework is probably still going to want to see this registered as a
series of CODECs though unless that's extended.  In any case the
internal mappings for the devices ought to at least have helpers
available so machine drivers don't need to reinvent things.

--8QTINAT9I+GWM3JK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTQo3jAAoJELSic+t+oim9LHUQAIg1jQgSpmNzIStMHztkdezy
WS0YvN3F8OB1SD46IbddmyFmsdfUZMMl4UfBSpNVQWudxcnAG9f6FltGA6KNBoEB
0EvSYSlEJ9OmzSnWNtOWFJaJR8SgMS+jn0BV/DeMiywSfajMzyhQNAMzWPRD36Iz
XM8omawJhySwFgdJHewCH6QW2zrxHsnuVcfYnJEbQaCO7EpuA+sFqNvIxujAkAsF
7KgLT9gic6kVQUqfYKNrJ19KGY/lA6va+ZEq7q8GORkxQw3kyzqwqWbPvK5wxIgk
zsxJXK068HlPbAp3+woutGlOzdcJhSSGoHrqSbCqPU0L4IIvR6WZW+6lSxWJkTJY
yDoH+yGv2PgEPyt41Hnpdh/G82M/QsKegjl/vWchAO7IVuswSyHvj0sQIFlgc6e2
vk8uTenARr2NHGTEPvNomDac8Fi/qL8BMXxFCGrxHKlMBLGrIf0Xu1HH04HCahMF
kYVMeQTLkx3EAtB2F71MC61CypyqJ9CnwtvTG3PRYr/MOuKJTh/NquprJX6fAJWc
STVPuZaucxBQMxHhsVULxynkmiGfnPxAJrIP27Bxd0EfQekBvKsVnfGULark6QR+
6HOpisAbi81NbYFTIFJmvdmU+lfJmOraq/hiodHC2m5rJNSVGaW8LbLEf+2fyuB3
SfAR2GJjZRF98An0BVO6
=Q9wW
-----END PGP SIGNATURE-----

--8QTINAT9I+GWM3JK--

--===============6707510649434227322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6707510649434227322==--
