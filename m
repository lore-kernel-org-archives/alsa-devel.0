From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: snd_dmaengine: add common api for
	pcm_mmap
Date: Thu, 28 Jun 2012 11:51:48 +0100
Message-ID: <20120628105148.GD28922@opensource.wolfsonmicro.com>
References: <1340866886-24432-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1226339653261071282=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D36A8103F54
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jun 2012 12:51:50 +0200 (CEST)
In-Reply-To: <1340866886-24432-1-git-send-email-ldewangan@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: alsa-devel@alsa-project.org, swarren@nvidia.com, tiwai@suse.de, linux-kernel@vger.kernel.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============1226339653261071282==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 28, 2012 at 12:31:26PM +0530, Laxman Dewangan wrote:
> The pcm mmap for the substream dma buffer is done using the
> dma_mmap_writecombine().
> Some of the chip sound driver like Spear, Tegra, Davinci,
> ep93xx,snd_imx, snd_mxs, NUC900, OMAP, Samsung are doing this
> mapping locally.
> Add api in the snd dmaengine driver so that different client of
> snd dmaengine can use this rather than implementing locally.

OK, but I'd expect this to come along with one or more patches
converting at least some of the users to the new API...

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP7DcKAAoJEBus8iNuMP3d+osQAIvuuvCUKlZ1Vd4zES6f6LbA
YDCXj05mH/leRfNHq3DU19M+jKyP+GZ81NXfpq76BpcjLf0ieTECyOUc7lKs6Ivw
EGb3GMRV+TnBZaTUlQTLc4UR2F/AVvOgAoLSqaL9fM0eLm2w95HyECt1vGsSX4A6
FxDswxf5tDGxoMjZsOdv6EOzYOSiqM+f+HPegmiyGFs/ghlNKuDKupgvN3JwHs3j
F4fcDm7ARELKHCCKxHzAfC40oAfXUdF4iZbHMm1BBzTAQIRY0UW1s6SNdZMNdiLs
ylaV7aNVvXhanM69MIQ5iJsXftsdQ8c8J0hr2L6JJCV8DxAqV23mo9q/jEq/MOeJ
yeAB0PDbdn/VXCuuv8e6RVBpftsdwN9Xmzx+4HlMcaKyyJ7Ci63jzP/iM7lIvg4q
4EKP8ox1inSCQpWTJ8TWqH0imjARrwcHHL3q1nbV60kgd9aUSAEYnQxF3IeSHo1M
DCUlqGt4FShXvXY9NmAt/a+uHko6BhFe9mcuaqCP1UIqCC2Pjpumn6WnfMIoEzxC
cHuQq2HPXmqYdX9AzmaLAPHWQqD7msc1vtlFRjGyWDF78aQdm1Eu0IgrLCdZwXK/
/GV5Cv6R8nHuBS/ibN/KbWejk6SX68orPYJnOMos7shVhFjkzQM48FD4J+TrLNsU
/PH9ZFKm0jDoj501PqZQ
=task
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--

--===============1226339653261071282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1226339653261071282==--
