From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: jack: Fix multiple definition of
 `snd_soc_jack_add_gpiods'
Date: Tue, 27 May 2014 12:05:42 +0100
Message-ID: <20140527110542.GP12304@sirena.org.uk>
References: <1401176397-17591-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6756939617472103598=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0451C261691
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 13:05:53 +0200 (CEST)
In-Reply-To: <1401176397-17591-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, kbuild test robot <fengguang.wu@intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6756939617472103598==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ToPhyPkr1RwLFl0y"
Content-Disposition: inline


--ToPhyPkr1RwLFl0y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 27, 2014 at 10:39:57AM +0300, Jarkko Nikula wrote:
> Commit f025d3b9c64e ("ASoC: jack: Add support for GPIO descriptor defined
> jack pins") caused build error when CONFIG_GPIOLIB is not set:

Applied, thanks.

--ToPhyPkr1RwLFl0y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJThHGDAAoJELSic+t+oim9NuAP+waIO7nS6jGWnrB5PKLclRIJ
BgAxelAtvqV+2SIJvV+CA62pjIy2L54jMZsABdf8xC434UQP4xzM59Hq4jc12JJe
wuAgVSclD4kwNxWBtPlmCNwrow6NdSWvRAU71DS8yXfvQlOzgN+KYUaQyXNYOzhS
gFRL0OEK12xyawI4awlzHdqPp0HMybte5HG4rU4JDJp2ZTDg93KutnzGjIkuEnaP
syeTaP8GmsWCVcorjiHM+4BYA/NYPH3OLgiP1C+qj7bOSVtvj2hAPC24+wNcRhGU
0ksOxK3aLeYzIktjHZjdyzkSKYdpKf4NgLlhvrnR4TjHjYUTBcFbYWQG1VkHsJLX
JuQXAz2AbPrUewy3g1jHXpnkxffXOt05y4iol+nNubvkD08LWqmrzPH550rhCMfv
5PMu/EjCc2inN+OcNrOEWGOvSxKYwqeQdq3A4/2yS4LZLW92+umfiw5ypcNx2RNU
o6qDickgnI/4PLmxpR3V5DXMdb6xZ7GPdQVqhrd+bSJ9o+cbZtF16V1EhyBWWKva
NhXGrAwof1DLJNPgW1o8Uq9aDHK8lMewypIMli+iExkrnulev1j44IgUmqu4KTH1
xx8LXpn77twvv30grJdxSu2T6QQ/vom2uiLJTnG8gYRulfd3jIZLyufV8natfwwj
BWaekWHskrwVrEbm+QHO
=kbAq
-----END PGP SIGNATURE-----

--ToPhyPkr1RwLFl0y--

--===============6756939617472103598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6756939617472103598==--
