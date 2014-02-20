From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 082/102] ASoC: Add SOC_ENUM_SINGLE_CONST()
 and SOC_ENUM_DOUBLE_CONST() macros
Date: Thu, 20 Feb 2014 18:09:38 +0900
Message-ID: <20140220090938.GA2669@sirena.org.uk>
References: <1392724308-13375-1-git-send-email-tiwai@suse.de>
 <1392724308-13375-2-git-send-email-tiwai@suse.de>
 <20140220023339.GR2669@sirena.org.uk>
 <s5heh2yxnuk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6288979278958044780=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DB9F2619E9
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 10:11:43 +0100 (CET)
In-Reply-To: <s5heh2yxnuk.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6288979278958044780==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mMVwBWE2stLN+mTQ"
Content-Disposition: inline


--mMVwBWE2stLN+mTQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2014 at 08:08:51AM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> >  I'd also expect this to be more what the default naming does
> > since we want to try to steer people towards using the simplest and
> > least error prone mechanism for doing this.

> If changing the existing API is fine for you (not adding the new one),
> it's trivial to convert the patches to do so.  Looking at the end

Yes, I think that's a better approach.  It's fairly obvious that the
existing interface isn't awesome so it shouldn't be the default one.

> result, all SOC_ENUM_SINGLE() and SOC_ENUM_DOUBLE() usages are
> covered.  For any specific usage in future, we may provide lowlevel
> macros, __SOC_ENUM_SINGLE() with the number of items, too.

Indeed, I was intending to go through and look at renaming the legacy
macros so they're implementaton details once I'd got through all the
patches.

--mMVwBWE2stLN+mTQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBcZPAAoJELSic+t+oim9n3YQAJXqfMCm/LXD3gR5zymYVmSc
Z4WWG4OU4vyBhc+ZSchT1JfTRz552Tnhcaku89qL8O3TvLqCc5QI+T+UjkjqEyGV
557tsSe6urHZQ7mcMNgLxKqacE3i2u/tWoGHwxTWGRTP+8RnMVW830EF210gdBuT
mlVHqyPZSvuX/a9sOpNjWhYGkFeDVh+F3i0c+fD71EH8QtPTMpQ4nIOd0uqGzkhW
8RAH/3MFqVi7jkScibn3ke5+kEzcPpJFxBRbMHr7NAz3bGSbhE/NkI9nX+NQba62
PMBXy+uoboLsKhMomggxF/4JEqV2eYdioYFQPDnm2GDyEiUKQImq4WtSk5fFQ3A1
ZXxvjcBO6mAmUOWd9oyiSkwj1EFdhEbWkUNXptmjWrqOgnRBVdQnqoH4ELd87EN9
iITnV79IPWISSKsjMBwMGjpCgaODvofSLWtBENTEIbS5wS9xthnMClA44IDse8/S
Chy+2/cQhpSaRFQ9ucQ7ssMjmvsc2cU0I/ezIxIUt0ZeOB1fjL2zgEPRqIkImTe3
AK59p/pKUvR/5unLPZ/Ufj/bytc6i05aoAtRo0OJCKPInCMVLHoh2JM/9Jy4Y6PG
ecHhwr23OG/Airyy1/M7YMBjHQDXkRWPb+op7veVi6VSy5s+toyb5Fx8m84nBef9
i7sqJAiB4kBeIoc1W73T
=gHLW
-----END PGP SIGNATURE-----

--mMVwBWE2stLN+mTQ--

--===============6288979278958044780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6288979278958044780==--
