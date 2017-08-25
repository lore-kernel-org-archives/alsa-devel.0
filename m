From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] ASoC: rt5677: Convert I2C driver to
	->probe_new()
Date: Fri, 25 Aug 2017 19:59:09 +0100
Message-ID: <20170825185909.5axsneqpswnawmfr@sirena.org.uk>
References: <20170824134110.63335-1-andriy.shevchenko@linux.intel.com>
 <20170824134924.uwzksz6ln43nurdd@sirena.org.uk>
 <s5hh8wxjarq.wl-tiwai@suse.de>
 <20170824154947.li6yke5vv5llcxhh@sirena.org.uk>
 <s5hziaphrof.wl-tiwai@suse.de>
 <20170825131103.ow3jwntmeshczhff@sirena.org.uk>
 <1503667988.25945.100.camel@linux.intel.com>
 <20170825142140.bobbc2pclcw4x3vh@sirena.org.uk>
 <1503673792.25945.106.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0364817381297544636=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 264662673F1
 for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2017 20:59:14 +0200 (CEST)
In-Reply-To: <1503673792.25945.106.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0364817381297544636==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lsdrt366pbphbm7i"
Content-Disposition: inline


--lsdrt366pbphbm7i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 25, 2017 at 06:09:52PM +0300, Andy Shevchenko wrote:
> On Fri, 2017-08-25 at 15:21 +0100, Mark Brown wrote:

> > I have no idea why you say the ASoC machine drivers would prevent
> > someone adding a platform based user,

> For example, looking into
>  sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
> I see a direct use of codec driver without any platform driver
> involvement.

> Is it exception from the rule, or a common use?

That's an entirely standard driver using normally registered devices?

> >  obviously ASoC predates the use of
> > both ACPI and DT quite considerably.

> Yep, the current users of driver in question either DT or ACPI, would it
> be pure platform in the future?

It could be potentially (well, I2C but registered using a board file).
Most architectures still use board files and neither ACPI nor DT has a
sensible story for instantiating plugin modules yet.

--lsdrt366pbphbm7i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmgc3kACgkQJNaLcl1U
h9DCWwf9EKCnsy6T2yuYpeIonsHu72ToDnOvd5WHUOWYyEu9nJw027ca+MEuICt5
pLOX4/N58gv/YYMMm1MggAzY+VT8TvxDnZu52Q03tMTJEeg/bm3gGOJ9ojlsQGud
AVyfDwnoKq66/Axa7NCOPJ/tuPfbh8jBorFdv1nvXImzM5NYI6hA7RxmpybiES5R
CalM95Ky/UK+6u3uyqkHhlSti7vo3wC5x8UMwBVEKZ2zPySkWFYLGOGsHd7PU0rU
X65HOwI8CSm9wCyY65UPuFoNXsGTrEFcxRJO4HdpmLxx9rpT4/Hjcd6EoysPqaQf
PJNCk17asEhYY1yKRW1Ad5ZP95cP2g==
=75jn
-----END PGP SIGNATURE-----

--lsdrt366pbphbm7i--

--===============0364817381297544636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0364817381297544636==--
