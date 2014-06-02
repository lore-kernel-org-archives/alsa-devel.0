From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: intel: The Baytrail/MAX98090 driver
 depends on I2C
Date: Mon, 2 Jun 2014 10:40:20 +0100
Message-ID: <20140602094020.GU5099@sirena.org.uk>
References: <1401650018-31023-1-git-send-email-broonie@kernel.org>
 <65206.10.254.34.105.1401672603.squirrel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5076509669180983041=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 32B6E2651ED
 for <alsa-devel@alsa-project.org>; Mon,  2 Jun 2014 11:40:35 +0200 (CEST)
In-Reply-To: <65206.10.254.34.105.1401672603.squirrel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kevin.strasser@linux.intel.com
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5076509669180983041==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1a0hRYDdJmE1GM/c"
Content-Disposition: inline


--1a0hRYDdJmE1GM/c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 01, 2014 at 06:30:03PM -0700, kevin.strasser@linux.intel.com wrote:

> >  	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
> > -	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS
> > +	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && I2C

> I think the dependency on I2C is specific to the MAX98090 codec.
> Can we add this to the codec config entry instead?

No, selects ignore dependencies.

--1a0hRYDdJmE1GM/c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTjEaBAAoJELSic+t+oim902wP/R6mzaKV65nUmLcBAenNU3J7
Jw+GV8q0ZZrDLEEtd/fkkdXlBZ1wUJQe0pBhp5EkuD5hSCa6H3aWw72q8KVvaOYz
nucG0WtioM30falTrWlYD6WlY+q6j2lP7O+1dAf4mZgTfDDYUHlU62bf5U9Thhq9
5zLs3U0cmdV8N6C30NWprLbkU8SrWBwkZLWcNgiZCrAS2Ra90e+DGNogH6YoO5bY
p5vqD8N77Sth9Vy9Db5ma34A2tHx35BtOOVuf6Jr/32WU1T0e6pwW6/OwCYTwwbV
uaueVv5z0Z1rjON03vahiWFfNXQDk4mtEocR4LjPIO4qa2WU16XxLCoYSQkhoknf
KMof9DuV4/51PyCh16AlSMT1knMpA3nBh49elpUNwo0Vm7RfmhK5IemcooV6br1S
08n34xUJE6qQVv9NiVizDO3TqVvzU6rCdqpVEHvdtghEUq2/vVdgjv1phenxwvrG
pOGLXgwKLvYUo/0RytZnRqr6cwBtEMeVs1B17EUgVQo3WlLmBLQgpMTkejs+OhY1
ismJPB7RvPYyHTxksKPOh0jZi06AbqeLxP3TLUyObEAQRNB62rqGbr5vaVJlojzu
M29bk4nDAK+14TeMnw53Pu654nJpQ+mJTcBPH9c+EHz3OUiBlpowz2XfK8/bsPrh
VEi+1u02aGZ8pMJoDOCi
=ZVtT
-----END PGP SIGNATURE-----

--1a0hRYDdJmE1GM/c--

--===============5076509669180983041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5076509669180983041==--
