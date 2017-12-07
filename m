From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 16/19] ASoC: tlv320aic31xx: Add short
 circuit detection support
Date: Thu, 7 Dec 2017 17:23:46 +0000
Message-ID: <20171207172346.tbr4wtdjpxzlqqck@sirena.org.uk>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-17-afd@ti.com>
 <20171201133930.xzfjjj6wzkbtk6c4@sirena.org.uk>
 <4d956cbc-829c-0d81-2980-aa2a79f36660@ti.com>
 <fd362117-ae71-a6a2-eb43-70c2457c0a5d@ti.com>
 <20171207120352.4obvlu4cemagfom7@sirena.org.uk>
 <83e40a88-2c3d-416a-6e19-56c6f96d3af3@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1053999342644045494=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CB835266B67
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 18:23:55 +0100 (CET)
In-Reply-To: <83e40a88-2c3d-416a-6e19-56c6f96d3af3@ti.com>
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


--===============1053999342644045494==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t2fi6v7fi4iuem2s"
Content-Disposition: inline


--t2fi6v7fi4iuem2s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 07, 2017 at 09:37:36AM -0600, Andrew F. Davis wrote:
> On 12/07/2017 06:03 AM, Mark Brown wrote:

> >> As for your other suggestion of "log other interrupt sources
> >> numerically", could you explain this or point to an example of what you
> >> mean?

> > Just print out the bits that were set.

> I don't see anyone else doing this, what would that solve? Maybe I still
> don't get what you mean here. :(

A good proportion of devices require explicit acks for interrupts and
only ack things they handled so don't have this issue, and otherwise
it's common to just handle all the interrupts that the device might
fire.  The goal is to not silently eat interrupts if the device starts
interrupting for some reason.

--t2fi6v7fi4iuem2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlopeSEACgkQJNaLcl1U
h9CwBwf+I+KIGVRJWF4cY21Rpuh+sNXe5mswm15dCZZYeN9X3+yYgUSsrdbdqFpn
MBqj/+LL4dXQjwLsKW/araWXGsQCymVw1Rnsry9DXazqu9kt5jiOAgPtrwe0Tz+y
lxTPeROPSPtavbwHjZc6T7g/OoKMIInSMkiXEOkLAByd5YpsCL5fEccQYuOVShTG
l3ec0KgRovoYWYH52fyhf0mXf5WpjFtbESTVnFH2ZSRewcwPDXUxet2ptZd7PHjb
RAtxSX0K8oSTy9/GvFshrtntq+RoJAXc9HAuUGVXoGupSxJ0WXEvoX+FH2oCTP7f
l9vf2RWcSiBIedOBgYfoqH7L+9MKtg==
=ljPg
-----END PGP SIGNATURE-----

--t2fi6v7fi4iuem2s--

--===============1053999342644045494==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1053999342644045494==--
