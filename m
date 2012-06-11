From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: dmaengine-pcm: Add support for
 querying stream position from DMA device
Date: Mon, 11 Jun 2012 23:35:53 +0800
Message-ID: <20120611153550.GW11439@opensource.wolfsonmicro.com>
References: <1339416253-4121-1-git-send-email-lars@metafoo.de>
	<1339416253-4121-2-git-send-email-lars@metafoo.de>
	<20120611132409.GG11168@n2100.arm.linux.org.uk>
	<20120611145735.GU11439@opensource.wolfsonmicro.com>
	<4FD60CA9.3070701@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7168720465762745555=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EC09E2454C
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 17:36:48 +0200 (CEST)
In-Reply-To: <4FD60CA9.3070701@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============7168720465762745555==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ItroYk2LVxvwOvi/"
Content-Disposition: inline


--ItroYk2LVxvwOvi/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 11, 2012 at 05:20:09PM +0200, Lars-Peter Clausen wrote:

> Another option is to provide the current implementation of the pcm_pointer
> as a standalone legacy function, which can be used by the old platforms
> until their dmaengine drivers have cached up. And add a new residue-only
> implementation which will be mandatory for new drivers. That would make it
> more explicit that those platforms are sort of broken and need to be fixed.
> After all of them have been fixed the legacy pcm_pointer implementation can
> be removed.

This seems like a good approach, yes.

--ItroYk2LVxvwOvi/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP1hBPAAoJEBus8iNuMP3dBLwP/iO2/LhgFePPUJBpydqbTHfp
ZxpByLG2lsEHp/c+OiHhNk5Su7Dm7/36XpY/R/7B8/+tqQ4+mbgxb8xb5B2GTdje
tXpMkc0IHg5+rRBFLClezhPdx34vLJ5jtmYZOCUM9eS2o5VFqsd+i+SXrJ/mkoKH
f+Tw6VFogeQ8jCqaYoQ13mI+YlZxzGD5Sx48zkZDeotYJwbq6jQFpf1GbUXL2so3
WiUaQhXA7FgMjlX2+ttksonuIv0Apg2fAxLTJXrGI71TH+8Cphj0K+EVmiGQJjwG
w9iUnc1g8Wihhe8O/z8Jfk3OiorIpQBcaSg2hczxAxJSog+PCh7ovLav+6Wwa3VE
Rf2D0OExAK7xWfPCHCIAil7Km1sX/kFlVewDxPxHeiQMfVcsPAqpS6iiOUGV4uoU
YnJgt05sFPIjqauGMgJQFPJxM+zXDr4mOmvOtKHO9S/nrK3Me5/AsTyRQQBcDKiF
UJhjA7S7Zpeh6ViOMvdXGeYeUJhNhT0vu4El3oWUJ1uRpTkZPMPiVu63V3aArhZ7
7mikYGVfRvMpCu1rmoOCUcr4Hiex+JpjmMwvul9KJL/Fj4YwkzyzzxzTRdz8OZsc
KJN/t3glgiAeUzWWg+FWEt/OdFeG5RYQruDQ9yTqQKaoQxIdvi7A1ZQ+SeajHkmP
b3iHlc1GODRKLUhEiAUu
=iW81
-----END PGP SIGNATURE-----

--ItroYk2LVxvwOvi/--

--===============7168720465762745555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7168720465762745555==--
