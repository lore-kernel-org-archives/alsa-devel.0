From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] ASoC: dwc: Add devicetree support for
	Designware I2S
Date: Wed, 3 Dec 2014 20:19:05 +0000
Message-ID: <20141203201905.GO7712@sirena.org.uk>
References: <547F3CAC.9050105@arm.com>
 <2041200.ZjakFFAZAU@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4645114241075374645=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 31A222604D2
 for <alsa-devel@alsa-project.org>; Wed,  3 Dec 2014 21:19:42 +0100 (CET)
In-Reply-To: <2041200.ZjakFFAZAU@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4645114241075374645==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pmewarBF2ZzreSyu"
Content-Disposition: inline


--pmewarBF2ZzreSyu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 03, 2014 at 09:13:18PM +0100, Arnd Bergmann wrote:

> I don't think we even have to worry about the platform_data case here:
> the only platform using this hardware in Linux is arm/mach-spear, and
> it defines a device node with a binding that is similar to the one you
> document here but that is not implemented in the driver.

Not all the world uses DT, this is a DesignWare IP so it's likely to get
deployed widely - potentially on PCI cards and things like that.

--pmewarBF2ZzreSyu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUf3A4AAoJECTWi3JdVIfQH4gH/R3yPL0BX9ABaSL9ZtwgNQXC
PKfHlsCE3P24RrJ7Tzy42n8UkkZv1BWMq1wLGAp8ZQ1foep2BCdPlD+dcmeKMe/S
/g/8X7KhJ8j/sT2Hr6z0M8oRQfuagV6/Y9rZZu3HrymOB/PiPWUGvq+rejcuHqGH
tbtchpaAquuNW3QhPT42s1I6+iryoes83Kx7dB6pegQMJNUDrmaiFmrXQnb6x+NU
98Q8YOOtoFq79+KqQfTVMK4Auq1bmkNouj07tCdKhNoCZcPNdxcXQNT4BviWtTAb
pw04LM75ZoyoVgb5MPCEnMdlffP14PdJJ179/UdFy79qXhTydsZhnFFLTBzg7Ds=
=Cm/k
-----END PGP SIGNATURE-----

--pmewarBF2ZzreSyu--

--===============4645114241075374645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4645114241075374645==--
