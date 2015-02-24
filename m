From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5670: Set RT5670_IRQ_CTRL1 non
	volatile
Date: Tue, 24 Feb 2015 17:22:29 +0900
Message-ID: <20150224082229.GX6236@finisterre.sirena.org.uk>
References: <1424063205-4256-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4725443361537341051=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FD632604EB
 for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2015 09:23:41 +0100 (CET)
In-Reply-To: <1424063205-4256-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, mengdong.lin@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4725443361537341051==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yQ6PUHtvLgXN2OhJ"
Content-Disposition: inline


--yQ6PUHtvLgXN2OhJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 16, 2015 at 01:06:45PM +0800, Bard Liao wrote:
> RT5670_IRQ_CTRL1(0xbd) is a non volatile register. And we need to
> restore its value after suspend/resume.

Applied, thanks.

--yQ6PUHtvLgXN2OhJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7DTEAAoJECTWi3JdVIfQwYcH/i8RWxcOopZwYL+vMfdn7b5O
Ti+MJwxWHvMH8Ravx9meb1V2WWp3LprBVWAfT4+MxpvsxKv0t21/fy48u000Tmr9
wKNU8oCu2KWwSUqQ6nIJtm5uCt+aUPyVlnG8FDduMOStHo++JJ5k2dSCpX+/DrIO
ZBba4gjsS1bErAgj0fDZpLWnTdMoHWUrg7zebxokp/MXpRLH/GSXZ7LPU8oAhjwO
qKM4eQsmmDrR3DC/AzJJ0M4GDb21M6sY+uHslIOd5G4Kv2GQJ8E+V5MXVxt9DdPp
8ecnqlWWg7zZNy00EFF0w5+gLDlTpPoPB7im0bQ7Swl3uFT9sQBZUJu7Y/9Arw4=
=eVxd
-----END PGP SIGNATURE-----

--yQ6PUHtvLgXN2OhJ--

--===============4725443361537341051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4725443361537341051==--
