From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98090: Fix missing free_irq
Date: Thu, 19 Jun 2014 10:57:17 +0100
Message-ID: <20140619095717.GM5099@sirena.org.uk>
References: <1403159525-4352-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OuRzA7sCM3dW6CQj"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1403159525-4352-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Stable <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--OuRzA7sCM3dW6CQj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 19, 2014 at 09:32:05AM +0300, Jarkko Nikula wrote:
> max98090.c doesn't free the threaded interrupt it requests. This causes
> an oops when doing "cat /proc/interrupts" after snd-soc-max98090.ko is
> unloaded.

Applied, thanks.

--OuRzA7sCM3dW6CQj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTorP6AAoJELSic+t+oim9SuoP/Rj2LUNV/89F26CRFgUL4Igi
XqT1YP0oTEtVYEbU7c6z3xJk9VqwimJm6UZZZgGZLaUaU/nLrgEJu3Zhf8gJFbFi
wz2LpCo8NOqOPAWKTue4fDKXoQDJ1zESSJ3ZGObHWAjVFDsSUcR7/qbcKIReJPPG
xkIXwzEaBYa35zz3a91XHSHuMyrflpDu9O7kPWsk5JHofAZrSC4FlyomW3JtJxCh
4qvmvr8Wk8FysBybBauBjD2skkagLF6NdDovxd1td1JLkc5DuWO3X/j/rbvBvvW3
AX2blAozjcFRXI4ORYmgUUX/YnjgFrO5yIEDiUE7El8CCvndfcMX1Vv+Y9iY8PmH
EGA9NSro4nJH2E1GynJo0XZ+bAvSZwr9/0jiz2g+ZySfqcBkGEhk2HDXO2AXqodt
KnK0qQYzICVr6oU3UmFMTI39uGn8heYIncR5PpwBRKKE31XBXgXoQxYEaG2eOUEm
saYaQWQIoDEANioCoGtrObFuRXppYA0UHeSB4FqwkDd5BNXyUjlgbExvtWTrBMl2
TZR5ggQLPhSjyZkThcg8/jFyE4hL5WsGjcid2kf6t3VKXN4kvGPu5YFl+gE0m1NT
bgDFTuCa+omYMpoyy4RSlYySK9eKUjdCxGfhSJO6OWn5Vj1PO649OJi5wLxlNkVR
O7HurJuRlB1/BUm3o9dX
=J/do
-----END PGP SIGNATURE-----

--OuRzA7sCM3dW6CQj--
