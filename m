From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Add support for Conexant CX2072X
	CODEC
Date: Fri, 3 May 2019 15:52:07 +0900
Message-ID: <20190503065207.GG14916@sirena.org.uk>
References: <20190423141336.12568-1-tiwai@suse.de>
 <20190423141336.12568-2-tiwai@suse.de>
 <20190427175938.GJ14916@sirena.org.uk>
 <s5h36lxpcbd.wl-tiwai@suse.de> <s5hsgtxnvhz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1904691544575323139=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25E5CF8075A
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2019 08:52:20 +0200 (CEST)
In-Reply-To: <s5hsgtxnvhz.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1904691544575323139==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qCuyVVLLFvr0p6ls"
Content-Disposition: inline


--qCuyVVLLFvr0p6ls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 02, 2019 at 09:52:40AM +0200, Takashi Iwai wrote:
> Takashi Iwai wrote:

> > Not to read the register while the chip is turned off, I suppose.

> Actually other way round: the codec driver tries to avoid the whole
> register access while the chip is in BIAS_OFF state.  OTOH, the jack
> state check is still required even in that state, so it flips the
> cache-only flag temporarily at reading the jack detect bit.

> I guess we may remove the cache-only behavior, although this is a
> nice-to-have thing.

No, it should be removed - it's buggy and racy.  Devices should only be
going into cache only mode if they can't be physically accessed,
otherwise you end up with incoherent things like this that create bugs.
If the driver is actually able to access the register map, actively
doing so and therefore needs to try flipping cache only mode on and off
without coordinating with the rest of the device it isn't really in a
cache only mode.

--qCuyVVLLFvr0p6ls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzL5RYACgkQJNaLcl1U
h9B39Af8DFdRU4DenPYRVOhhCVX5lnAR3Y1cM7UtBQlzr6G2ZaWkp5tK51mXP4E0
3QttvJVXq/Vv3ckDP8CuLtN9LMGc1030IeYe1nUglbsmo82qt4IKxY2WqdKrXCDd
4IqfHD/qRn77l513Eq0bYueZ04XBXTyua6LejeO1YqEao3jlESvwF4SzLdKjlwu7
nsKns/xTma7PQhjXVA66SMr8BHzIQZx3QRNmA2v6BT5XTKUick+oz+k+UdHBu7uv
wxuIXDb02iVEdn2jKHlVG6DQQFw2OyEu/KDuWzK0pcZbKNyxSwWr3lptwFG7gtbh
ojRy7vadrRTT04OYJTtGMHbFP5Nblw==
=DMEO
-----END PGP SIGNATURE-----

--qCuyVVLLFvr0p6ls--

--===============1904691544575323139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1904691544575323139==--
