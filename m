From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] ASoC: rt5677: Convert I2C driver to
	->probe_new()
Date: Fri, 25 Aug 2017 15:21:40 +0100
Message-ID: <20170825142140.bobbc2pclcw4x3vh@sirena.org.uk>
References: <20170824134110.63335-1-andriy.shevchenko@linux.intel.com>
 <20170824134924.uwzksz6ln43nurdd@sirena.org.uk>
 <s5hh8wxjarq.wl-tiwai@suse.de>
 <20170824154947.li6yke5vv5llcxhh@sirena.org.uk>
 <s5hziaphrof.wl-tiwai@suse.de>
 <20170825131103.ow3jwntmeshczhff@sirena.org.uk>
 <1503667988.25945.100.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0380320078226639200=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8439C2673DA
 for <alsa-devel@alsa-project.org>; Fri, 25 Aug 2017 16:21:45 +0200 (CEST)
In-Reply-To: <1503667988.25945.100.camel@linux.intel.com>
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


--===============0380320078226639200==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qichjcxhvtosaov5"
Content-Disposition: inline


--qichjcxhvtosaov5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 25, 2017 at 04:33:08PM +0300, Andy Shevchenko wrote:
> On Fri, 2017-08-25 at 14:11 +0100, Mark Brown wrote:
> > On Thu, Aug 24, 2017 at 06:11:12PM +0200, Takashi Iwai wrote:

> > > Well, that's what the commit ddc9e69b9dc2 does after all: it cleans
> > > up
> > > the legacy usage, and moves all either OF or ACPI matching.

> > Which is broken since not all the world is ACPI or DT.

> While I agree on the second part, I don't think it's broken per se,
> there never was a single user of that, and looking how ASoC board files
> are organized it is quite unlikely there will be one...

I have no idea why you say the ASoC machine drivers would prevent
someone adding a platform based user, obviously ASoC predates the use of
both ACPI and DT quite considerably.

> > That's what I said, yes.

> ...though we can (re)introduce this dead code back for a potential user
> in the future.

The IDs are back as a result of the merge resolution I did.

--qichjcxhvtosaov5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmgMnQACgkQJNaLcl1U
h9Ad3Af+MsZMOrir3LI7W2nNXhoWSpF3yFuKhCV+9A6YmxzjPK5UOWRPgsWI4kzn
XaT3MOBQIpFGkHNot6ROVbRrw6WStaSEEvxR/9boRipb2hZIb+XaPM/W5EFCSZCf
7nhwMAjzne9Uat53iTagsqWbnDUmZro1LBhCYjgJdCnnJpKqbY+VX7Ba+idqb3Sb
bs14FerEXXVDW2hZxQzzvw2Zx/iFs5Tqs9CphAUdLBMQedP6nEajR0eHKlq150f5
54NvvY7qlwutM+GNAfSAd3s8fanFqfPGo0JZuhVeNw2zWrfx2XfGPDFVHWSFsSM9
0uO0NyIUnNVA9NF+/aLd9y+i3Tkmzg==
=WZsM
-----END PGP SIGNATURE-----

--qichjcxhvtosaov5--

--===============0380320078226639200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0380320078226639200==--
