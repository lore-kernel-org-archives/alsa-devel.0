From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] ASoC: rt5677: Convert I2C driver to
	->probe_new()
Date: Thu, 24 Aug 2017 16:49:47 +0100
Message-ID: <20170824154947.li6yke5vv5llcxhh@sirena.org.uk>
References: <20170824134110.63335-1-andriy.shevchenko@linux.intel.com>
 <20170824134924.uwzksz6ln43nurdd@sirena.org.uk>
 <s5hh8wxjarq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4131300812505685453=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 30B7B266DE5
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 17:49:53 +0200 (CEST)
In-Reply-To: <s5hh8wxjarq.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4131300812505685453==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fg24lan6idu3y3oy"
Content-Disposition: inline


--fg24lan6idu3y3oy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 04:33:29PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > On Thu, Aug 24, 2017 at 04:41:10PM +0300, Andy Shevchenko wrote:
> >=20
> > > There is no platform code that uses i2c module table.
> > > Remove it altogether and adjust ->probe() to be ->probe_new().

> > What is the value in doing this?  Removing the ability to instantiate
> > via board files is just inconveniencing people doing that, it's not a
> > goal in itself.

> But the id table is already empty...?

Right, that seems like a bug though.

--fg24lan6idu3y3oy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlme9ZoACgkQJNaLcl1U
h9D4iwf+PKAZ7ClN7RxTkRrVewuiufreDp/HTm020BhQUNR+nbBC0vJhnR7mSPlU
X04GNUkSgUREMuqs3eybcvKRj1qD+ZpTHv2sFN6zU/HmpO2wXN6VepBEw8Ng+n/o
lkVd059IBsCZPmiXVpPIuOR6Le7TgsVQr8kZLMMbETm/0ErEykIqcSJAW7f5E/g1
mi+q81OFxXc78bNZ+Axo8updKO5WlthyfpuPPFp+5xzHRcMJPJhplsrKS6W5xznB
qRcgYCjkDhenxl1COlr/sPJ+/Cc6TTVjw0bxOR8vH/hq3rgZRC041yhZ3ezfAHgB
0fo0CzyiYgEXlMNh1V+2Vd9YiOiAfg==
=P38g
-----END PGP SIGNATURE-----

--fg24lan6idu3y3oy--

--===============4131300812505685453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4131300812505685453==--
