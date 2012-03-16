From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Samsung: Update Kconfig for Exynos5250 and
	Exynos4412
Date: Fri, 16 Mar 2012 19:01:10 +0000
Message-ID: <20120316190109.GB3158@opensource.wolfsonmicro.com>
References: <0c4001cd034a$19b862f0$4d2928d0$@com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0046152120073381547=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 55DBF24336
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 20:01:19 +0100 (CET)
In-Reply-To: <0c4001cd034a$19b862f0$4d2928d0$@com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, sbkim01@gmail.com, 'Liam Girdwood' <lrg@ti.com>, sangsu4u.park@samsung.com
List-Id: alsa-devel@alsa-project.org


--===============0046152120073381547==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 16, 2012 at 04:55:05PM +0900, Sangbeom Kim wrote:
> Update Kconfig file to support the Exynos5250 and Exynos4412

I tried to apply this but git am complained about a corrupt patch on
line 13 and I couldn't immediately figure out why, sorry.


> -	depends on SND_SOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210 || MACH_SMDK4212)
> +	depends on SND_SOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210 || MACH_SMDK4212 ||
> MACH_SMDK4412 || MACH_SMDK5250)

Converting to platform device would be better for device tree and would
mean we could just remove the dependency here which would make adding
new boards easier - just include it in the board instead of having to
list all the boards in ASoC as well.

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPY42+AAoJEBus8iNuMP3dOfUQAIu8kIDlCiLXAtHsuemz181A
fztcp4tcAIo93UBimxipXRn/T5XEmOG+yxJzLw3kf8giUxhbO4JStZt4u4DRmYNN
L2IA/ragPpLKT4YkC02Nma7ezn8MJHd3wjAm9Iib3ZaOgI6H7dKtCNSCWl4zDKb/
HdLdIrwZkKSjsxerm+1LZg4irJLZ4ilXFNE5UusPm9+KuXRl/P/UElVKShDmrQ1y
A3n5c7pTPwAtUJOfsQBcwPcVHjqtgwxe8/xbTbK3gcX/OFk6yK9hjmpHcXryabu1
nbRVU7TIRXHvwbHhIS39Xof9QvW8uqrC6RUv0mTA09CrS3jXEa2WmU5N83zR7tVk
bAiSwsi5kzdRE0RPtmjHgM9veNmHaswOhUp6KDRh9sYAkc+MmvG0UPLl3X69vCLe
wtZP541ljBO99LWCS+PHMh8H+yyXSpUd5DpuxbhuK7jA8wA5e7gC/u1GhMhlmYpQ
mAjGs0Tul/4h2qeCHt7sRHURmZtZC3ysfEBXXtdRvJXbRU5SlEOoKgngrt42Ko9y
CahWobgastMT16Dkb1aEy3tcQiM4FaFeqzc6CjcNdgAwkFf6wHSagNcEcWCsFiKo
9OXWK/hJbi7fIOHNJoxTTp0TXuE/C5bt10S/G2kHU1zXWMmSkWkCOrvbw/EWKrNv
htgOLqNGCZM5K4WT/boG
=Q0IX
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--

--===============0046152120073381547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0046152120073381547==--
