From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel][PATCH] ASoC: wm8960: Move register initialisation
 to I2C driver probe()
Date: Thu, 27 Nov 2014 10:35:11 +0000
Message-ID: <20141127103511.GC7712@sirena.org.uk>
References: <1417078388-1289-1-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B5GJtDArd/slIW8G"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417078388-1289-1-git-send-email-b50113@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <b50113@freescale.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, lars@metafoo.de, ckeepax@opensource.wolfsonmicro.com, Li.Xiubo@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--B5GJtDArd/slIW8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 27, 2014 at 04:53:08PM +0800, Zidan Wang wrote:
> We must ensure that the clocking configuration is valid as rapidly as possible.
> And do software reset before the others registers updates, or the registers
> will be reset to the default state.

Applied, thanks.

--B5GJtDArd/slIW8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdv5eAAoJECTWi3JdVIfQZpoH/06iAJE6OiN6mFYSKHk9GhCA
GB/eedAgleSxP5RGjD0XM5QNktpsHNPfJbuoI1tPAdNyPXEKXCh/DMRdNYMH1YW8
u51kQyJUnjPVjnkZFeUVuX0apcWvR0lfLeWr0MgzShy3EgzEoMLF/Pfzp+UMSBc3
WyFeQfsC740XjFPEf3BJ1vndmoNfcDPevY0b9YU8fTM3HpRFXdwDtYpCcAlAyAJ5
moGMOL+YLwTuMA9ZnF7EYFDj0ihz1FwmGaoJbJQq1Lo9tw+aAbmqc0JVhgF4wi56
cYmZYAgyYChEeklIubMHtC5X+Kbxm/ohlBZwncsHCuQUMDg6HNc90j0U4/C62Gc=
=k9Fk
-----END PGP SIGNATURE-----

--B5GJtDArd/slIW8G--
