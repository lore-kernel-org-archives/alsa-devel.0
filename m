From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Skylake: Acquire irq after
 RIRB allocation
Date: Tue, 14 Aug 2018 16:18:29 +0100
Message-ID: <20180814151829.GF5810@sirena.org.uk>
References: <1534202114-29164-1-git-send-email-yong.zhi@intel.com>
 <12781660-7bdf-d0eb-cec7-3fdc82c47b87@linux.intel.com>
 <s5ha7pp9dwp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5578224706830303619=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E50D526770B
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2018 17:18:34 +0200 (CEST)
In-Reply-To: <s5ha7pp9dwp.wl-tiwai@suse.de>
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
Cc: wenkai.du@intel.com, alsa-devel@alsa-project.org, harshapriya.n@intel.com, yang.jie@linux.intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, michal.wasko@intel.com, naveen.m@intel.com, sanyog.r.kale@intel.com, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5578224706830303619==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aPdhxNJGSeOG9wFI"
Content-Disposition: inline


--aPdhxNJGSeOG9wFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 14, 2018 at 05:16:38PM +0200, Takashi Iwai wrote:
> Pierre-Louis Bossart wrote:

> > I am not that familiar with PCI gory details but that patch was
> > reviewed internally with no objections raised; there was also an
> > agreement that the SOF driver would follow the same sequence, so

> It's a standard idiom for a driver allocating a shared irq line.
> Because an irq may be issued by another device on the same line, the
> registered irq handler may be kicked off before the registers or
> whatever else is ready for use, eventually leading to some Oops.

> The destructor is other way round; first free the irq handler, then
> release the rest resources.

Right, it's nothing to do with PCI specifically.  We even have a debug
option in the kernel which will simulate the interrupt firing on
potentially shared lines immediately on registering to try to catch such
bugs.

--aPdhxNJGSeOG9wFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlty8sUACgkQJNaLcl1U
h9A8Gwf/S+kYk6FF7/7oFl6Fu12wvLtWLEA38HGFI5FQLZLDgyyg60DvOGzGiJMF
aJqCW9p5aqbl3uyuUjsyizKablcmhxtsHnzMuIGnc7DzdC39jGxMW+Y71fE4K6mg
BN51kbctj6VgeVfsJt2nMYphKAZ7+wgARaAicj+gQOtOm8o9b00uBf+4vhFyvXyq
F0m7x43LNbj8guSg/nkWdPOf2nNS0Q78+W5u/JM9XrpzuRR4UZU6hKojPwvL5Fh+
7YktG+mkxshbEhF19+y4j1AsTRRaHVuPRtNwW63Bn9va2LKwXBmSApQlIwXkKXun
TEo+WIfsLn1zrpPGg0y9L8a0hr8MaQ==
=wu3e
-----END PGP SIGNATURE-----

--aPdhxNJGSeOG9wFI--

--===============5578224706830303619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5578224706830303619==--
