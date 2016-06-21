From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 0/2] ASoC: da7219: Convert driver to use
 generic FW functions
Date: Wed, 22 Jun 2016 00:21:16 +0100
Message-ID: <20160621232116.GG28202@sirena.org.uk>
References: <cover.1466523027.git.Adam.Thomson.Opensource@diasemi.com>
 <6274a042-da99-e3e6-20f2-37ce2651645c@intel.com>
 <2E89032DDAA8B9408CB92943514A0337D4644644@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1550405484819894160=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B41F6261561
 for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2016 01:21:32 +0200 (CEST)
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D4644644@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, devicetree <devicetree@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>, Frank Rowand <frowand.list@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-acpi <linux-acpi@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============1550405484819894160==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XRI2XbIfl/05pQwm"
Content-Disposition: inline


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 21, 2016 at 10:54:39PM +0000, Opensource [Adam Thomson] wrote:
> On 21 June 2016 23:30, Rafael J. Wysocki wrote:

> > I'm fine with the first patch and the second one carries a couple of
> > ACKs already, so do you want me to apply them both?

None of whom are from anyone who works on the subsystem at all!  I've
not looked at the patch yet.

> Thanks Rafael. I think we still need Mark's Ack for the ASoC codec changes
> though before we can proceed.

Probably the easiest thing would be a tag for the core change that I can
pull.

--XRI2XbIfl/05pQwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXacvrAAoJECTWi3JdVIfQJ0gH/1Xq4MRqO/W6mePzXOH4ThPL
RSfBji5Ji5t+cv1FtWU0f453fDro7QRsQP6FVb65JzNRCKlZOS9FcsJQ631Lzb7S
LpqrCQfr1jdwGZMknAAcZVl98k8GarBFIfr2YnAcXZ549vYm2z92GozUlE9TO4ur
AcOVC5hEW5ThjFfImqzzTQGCd+XIELJAOZVb6zHgGc7glES23fmeIfnCRcR/LY/h
y6dZA+d5WW3+tZa3nTUf2J/TNtKo+vXPV0cexSt8Blpi/QOZDhTJI/oyXUvCVRu4
htQ4j8nfgB7+/nLwbGExmz78J+S+K2uIIK7eR90Bzm8xcdPoyYiTLttVzdGr/EA=
=e9EC
-----END PGP SIGNATURE-----

--XRI2XbIfl/05pQwm--

--===============1550405484819894160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1550405484819894160==--
