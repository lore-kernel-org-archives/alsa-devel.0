From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5659: Add mclk controls
Date: Fri, 29 Jul 2016 17:39:33 +0100
Message-ID: <20160729163933.GJ10376@sirena.org.uk>
References: <1469660568-3511-1-git-send-email-nicoleotsuka@gmail.com>
 <20160728155732.GG11806@sirena.org.uk>
 <20160728181419.GA4742@Asurada-Nvidia>
 <20160728185510.GK11806@sirena.org.uk>
 <20160729161521.GL9681@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aziWXe2aaRGlkyg3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160729161521.GL9681@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, bardliao@realtek.com, oder_chiou@realtek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Darren Hart <dvhart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--aziWXe2aaRGlkyg3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 29, 2016 at 09:45:21PM +0530, Vinod Koul wrote:

> Yeah I am not aware of any plan to have clks on x86. For audio we are not
> going to use much. ACPI and controller w/ firmware does the job.

> I have added Darren, he oversee platform things so might know if clocks
> would be there in future..

Not having controllable clocks is fine but as we've discussed before
you're going to need to represent the clocks that are there with fixed
clocks instantiated through whatever you use to enumerate boards.  We
don't want to have to special case x86 all the time in CODEC drivers.

--aziWXe2aaRGlkyg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXm4bEAAoJECTWi3JdVIfQw1gH/163HvlZDgT+dvkx9mvZKxVH
DzCeODijEp++mUFcmtQrOSmXOUnoBiv1gC7ZKSjAJp13Eoa8GjEWjv7JetZtyexp
o00UWuTgEE4+tYaphamJcFv4y6evV98OISlRA+HiJxYEO2yICXhv3POuQj7eXTzE
XPBVQ7MqUgPxy+E0PRBqSgUqOa7+6pvuH9l9G83vo9vMbnV8WzIfG6ZAqUuCZuSF
OJVtYaULQAXVuSXBqZ01uydWDtRjeYZCWq9LQCXo3+02VNDuIqPh6svoQ+b/lq+f
OFRbofuQs/IsgUAiuzdSr6TL+sll6waA4h+3K7TVOYYomcumuDv+faTIVUOkbso=
=MaYQ
-----END PGP SIGNATURE-----

--aziWXe2aaRGlkyg3--
