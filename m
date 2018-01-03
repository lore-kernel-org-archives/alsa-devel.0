From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 1/6] ASoC: Intel: Skylake: Add ssp clock
 driver
Date: Wed, 3 Jan 2018 11:42:45 +0000
Message-ID: <20180103114245.GE5603@sirena.org.uk>
References: <1514306696-7062-1-git-send-email-sriramx.periyasamy@intel.com>
 <1514306696-7062-2-git-send-email-sriramx.periyasamy@intel.com>
 <20180102233929.GO7997@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2358703787936831249=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1030E2668F0
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 12:42:57 +0100 (CET)
In-Reply-To: <20180102233929.GO7997@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: ALSA ML <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, mturquette@baylibre.com, Patches Audi o <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2358703787936831249==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tMbDGjvJuJijemkf"
Content-Disposition: inline


--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 02, 2018 at 03:39:29PM -0800, Stephen Boyd wrote:
> On 12/26, Sriram Periyasamy wrote:

> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright(c) 2015-17 Intel Corporation

> Does this also go into the // part? I thought just the tag was
> with // comment style.

Only the tag *needs* to be in the C++ style but Linus indicated a desire
for wider use of C++ comments and it looks ugly to have one line of C++
comment right next to a big block of C comment so other maintainers have
been asking for consistency.

--tMbDGjvJuJijemkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpMwbUACgkQJNaLcl1U
h9C1iQf/aYT5dz3HpuKyIRmSIPK9tNmbg/j7On3tRqIwPRRS6f54YdF3nMRL+Ox7
XRgUp1K5nt9g5eFngXxjX8WLvh4b4VaAPi5EjSGRaJK3v1hO4CIPyAnPe4KABWyv
3rUshhVMxc7hPiHPPYmrYjAr23vhy07Az2at5QSvxU9gD54ayGBYi2tx3AzT29eG
ZAGeyYHAH+zhVRN44PYddgYQaO6049i5Aw4f8hXJGTUkKCdzxr4ctImR01Ycsnk+
BcPyzNRL2cAsTeaiwLzfttJdJsV6unsW/hpOdjqH5rnd8/d2Co9+8UJn3P5r5Zb7
XGLOhyS7chgEg5DzQlSzTGm7QrwmVg==
=yUja
-----END PGP SIGNATURE-----

--tMbDGjvJuJijemkf--

--===============2358703787936831249==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2358703787936831249==--
