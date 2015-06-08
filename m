From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: wm8731: initialize the hardware
 when loading the codec driver
Date: Mon, 8 Jun 2015 19:01:55 +0100
Message-ID: <20150608180155.GQ14071@sirena.org.uk>
References: <20150605115527.d7c116e0dfbc751f066d417c@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3155247959890716680=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BE5F92604C7
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 20:02:03 +0200 (CEST)
In-Reply-To: <20150605115527.d7c116e0dfbc751f066d417c@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergey Kiselev <sergey.kiselev@intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============3155247959890716680==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rjUVCMa02lvNeL3Z"
Content-Disposition: inline


--rjUVCMa02lvNeL3Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2015 at 11:55:27AM -0700, Sergey Kiselev wrote:
> From: Sergey Kiselev <sergey.kiselev@intel.com>
>=20
> This patch moves the requesting supplies, hardware reset and
> initialization from wm8731_probe to wm8731_i2c_probe and wm8731_spi_probe.

This doesn't apply against current code, please check and resend.

--rjUVCMa02lvNeL3Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVddiTAAoJECTWi3JdVIfQigMH/33qBOKoLpEDdugOrMdHVAt4
n3VN3CQNhk4WqLXtNv9VlPo8pD3hi0FVlIXW3+os/XPn3UM3YGAlxkNAdXTFEXcI
ooDO9kmbvHj167PwgRMohddly5A5brAzS0Pg89L7NLnXiCH38eX0bQC/z0nB4MpZ
y1PkRXjX3Kuo05yd8UgSYcDkQu6A7fuFM+wlWnunONFrSTS878e+h1ULHqHosTmv
SFgtAD5dqi35p/n+rJZv88T/rLIC6o9nxqyg3Uc9q2svA8mM027gHL/jWtbTEqdC
NBOFW5UCgOigJ4Hka814pyB/RAV9DZPCgNWQ2nPz+OYAVxwZ4a7u1PBVaLi5oas=
=1WyZ
-----END PGP SIGNATURE-----

--rjUVCMa02lvNeL3Z--

--===============3155247959890716680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3155247959890716680==--
