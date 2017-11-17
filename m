From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] sound updates for 4.15-rc1
Date: Fri, 17 Nov 2017 14:24:16 +0000
Message-ID: <20171117142416.r3xkxmwshrvntkrr@sirena.org.uk>
References: <s5h4lpwap7p.wl-tiwai@suse.de>
 <CA+55aFw0PPt3T1DG9HL_x_wH56D-5R_CoOy=rnRJduDo_Qp6nQ@mail.gmail.com>
 <s5hmv3oatce.wl-tiwai@suse.de>
 <8bcf9060-92b9-8058-cdee-4a222e796b3e@linux.intel.com>
 <s5hy3n61cpq.wl-tiwai@suse.de>
 <a70760ea-50e9-229e-9f89-d56136e1872d@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l5gvxtrwggf3nv2j"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a70760ea-50e9-229e-9f89-d56136e1872d@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--l5gvxtrwggf3nv2j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 16, 2017 at 02:27:48PM -0600, Pierre-Louis Bossart wrote:

> I am also not sure if there should be hard-coded 'y' default. If you use
> make defconfig, there is currently nothing selected at all for any of the
> ASoC drivers, should we instead use 'default m' for all the sensible drivers
> (i.e. default n for deprecated stuff) and automagically select them when
> X86+ASoC is true?

The hard coded defaults were being talked about in the context of the
SoC level options that mask out the machines for a given platform -
those should default on so the user gets the full list of machines by
default and so that existing users don't get the config options for
their boards turned off.  Those options shouldn't directly enable any
code, they should just function to make the list of boards more
manageable.

--l5gvxtrwggf3nv2j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloO8Q0ACgkQJNaLcl1U
h9CKNQf9FNjF9FojTfM2ofxY1GKKllyAN43oCLH3J1ue7GxaDi2Rt3K3JjKyKa2c
6IhxqPelYRL7FVnmhwYS4bDrH1XwAYrnSd45IlEtYUon1JIpL81Q/8wtk951iQJ+
+Ge0B1y/NEtgvNm5ib851CV1QtiHkKStHm+s4R8T39FeqIm0ZFkSiHPqdZcnwXFp
X0MFWEE/DK+xEfglh/yQg5y/dFu3UOctSfjjjA0aLoIt5spiaPQzdqd6CprzZFKE
IgIucjHPPEzk4j+VXAuMeY7psRxU8dPY3h4YytofzyzNwZ/cN6zVh2rNdOIAFRfV
wJWkkox/u+W6CsaGwGKvFM5S/NJdUw==
=a8Fp
-----END PGP SIGNATURE-----

--l5gvxtrwggf3nv2j--
