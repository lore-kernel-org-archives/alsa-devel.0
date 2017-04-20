From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codec: wm9860: avoid maybe-uninitialized warning
Date: Thu, 20 Apr 2017 20:48:17 +0100
Message-ID: <20170420194817.yeybbnjutta6yxcf@sirena.org.uk>
References: <20170419170449.2965453-1-arnd@arndb.de>
 <CAEnQRZCDi1_dsBjo_10h2ntOH57mCXMS=GeqLUgahnoVu8pBDw@mail.gmail.com>
 <CAK8P3a1_8GmVXu_gQ-dm_5SrA2bn8M7Vdb+kFC-hugkHCnYOww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="va553gnzjeu4swoe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a1_8GmVXu_gQ-dm_5SrA2bn8M7Vdb+kFC-hugkHCnYOww@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Daniel Baluta <daniel.baluta@nxp.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--va553gnzjeu4swoe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2017 at 09:44:28AM +0200, Arnd Bergmann wrote:
> On Thu, Apr 20, 2017 at 8:48 AM, Daniel Baluta <daniel.baluta@gmail.com> wrote:
> > On Wed, Apr 19, 2017 at 8:04 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> > gcc version 6.2.1 20161016 (Linaro GCC 6.2-2016.11)

> I'm using gcc-7.0.1 here, which overall has better warnings for
> -Wmaybe-uninitialized
> than older versions, but sometimes also finds new false positives.

FWIW the PLL stuff has typically been really good at generating false
positives with older versions of GCC for some reason, this driver is a
bit different though.

--va553gnzjeu4swoe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlj5EIAACgkQJNaLcl1U
h9AVbQf/b0QaCF9PcK32vq3A6jSdicSqbLLV+lRhg6P1otMtz891wOphdx2PpIv5
/RVHu63KF3uiREHwICDrP0rjT3uh0em1MwGp00WWljztmiVoSknySdb5X7lCEPcF
4XS3ZXezlGMdVo4Sswuz28sdWnrPdsKDIU/wGdxCyAvc1nAoDVIntHWU8ulhtuUm
5jeKxn0b0fcYu0oTxYCzN7MjIpXbRhb0fAeypnHRBwAb9WZ1TlqaRv9wdYraenrW
xU/H3Ho015hYbpVbn69bSp7LQwD8bvsjiyosxrzYhIklIbLLmvLGXcJERxTIqOQv
ZOYluuaZ56KgKnrCcIpwJsn1IrJDjg==
=x0Ju
-----END PGP SIGNATURE-----

--va553gnzjeu4swoe--
