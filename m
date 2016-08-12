From: Mark Brown <broonie@kernel.org>
Subject: Re: Correct modules for Bay Trail MAX98090 soc?
Date: Fri, 12 Aug 2016 12:49:05 +0100
Message-ID: <20160812114905.GE9347@sirena.org.uk>
References: <88774f89-ce4a-1877-db49-b018d725f1cd@redhat.com>
 <3a548725-5b52-4b3e-457a-f6ca93645b15@linux.intel.com>
 <20160812095317.GZ9347@sirena.org.uk>
 <4cba0e60-2dd4-38bd-6353-a6bf5b404d75@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/7F8UcOhwbEJvS7n"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4cba0e60-2dd4-38bd-6353-a6bf5b404d75@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Laura Abbott <labbott@redhat.com>, Jie Yang <yang.jie@intel.com>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--/7F8UcOhwbEJvS7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 12, 2016 at 06:37:11AM -0500, Pierre-Louis Bossart wrote:
> On 8/12/16 4:53 AM, Mark Brown wrote:
> > On Thu, Aug 11, 2016 at 06:31:27PM -0500, Pierre-Louis Bossart wrote:

> > > If you remove support for all other baytrail options this driver should
> > > still be there and selectable. We just can't support both this driver for
> > > Chromebooks and the rest for other machines with the same distribution at
> > > the moment.

> > That sounds like a regression, what's the plan to fix it.

> The simple fix is easy: disable all other codecs and the
> BYT_MAX98090 option will be enabled. BYT_MAX98090 relies on the 'old'
> non-dpcm driver which is used only for Chromebooks with Baytrail, which
> never enable any other codecs, so there was never any issue before.

That's not really that helpful for a distro kernel (this is for Fedora
AIUI).

> If there is a need for concurrency, then a new machine driver based on the
> dpcm Atom driver needs to be created. I don't have a Baytrail chromebook so
> don't want to commit on the change.

Presumably someone at Intel has one (or could get one)?

--/7F8UcOhwbEJvS7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXrbewAAoJECTWi3JdVIfQaIAH/3GxHEbTwfLfSj0lPJrIJqYs
xA3J8u0eNUP5s7KRTUZt8gnlvUWLsbXm6qM3zSRg9ipFH7eac5/SSStHDl2+BAON
roO+xllkKeU6QbI9YApywphcjYVCtncNaqXsqu7CD2HT9ZoulZQvwH4H5Z1RA11x
Nl7USYuUdew3icjvlLIo/sSmDBOZOwk38as+0qZ7Qz781eHeuLP8NOUtVOeDBF8H
s/OlZ1G/wOQP3lZjW8bRQnnygPUUTrvKyiqJNK3ZjhEnQPU9aVOhXfgjdMCD1cDk
czu6aw7DtvmHA8QN0JMw7Oe4KkRJ0tcpx4wBrpaFgCq4cPCHJs/O88joAb+Ii3w=
=VR+v
-----END PGP SIGNATURE-----

--/7F8UcOhwbEJvS7n--
