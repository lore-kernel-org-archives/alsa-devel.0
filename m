From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.3
Date: Tue, 21 Feb 2012 19:48:14 +0000
Message-ID: <20120221194813.GA29984@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8671904130334156186=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C1FBB103D4E
	for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2012 20:48:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8671904130334156186==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1987877d869027ab63dc9df515e11f19279a8091:

  ASoC: fsi: fixup fsi_pointer() calculation method (2012-02-09 10:50:53 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.3

for you to fetch changes up to e555cf363167f09efae96d32a363e24c4de16b7b:

  ASoC: ak4642: fixup HeadPhone L/R dapm settings (2012-02-21 10:00:24 +0000)

----------------------------------------------------------------
A couple of small, driver specific fixes - nothing too exciting going
on.

----------------------------------------------------------------
Kuninori Morimoto (1):
      ASoC: ak4642: fixup HeadPhone L/R dapm settings

Mark Brown (1):
      ASoC: wm8962: Fix sidetone enumeration texts

 sound/soc/codecs/ak4642.c |   31 ++++++++++++++++---------------
 sound/soc/codecs/wm8962.c |    2 +-
 2 files changed, 17 insertions(+), 16 deletions(-)

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPQ/TlAAoJEBus8iNuMP3dyaEP/2xqwF50G3lSiZXpiGQqMEHP
4CdJu4ajnlrw4cBThu6n/kgvasnrIGj/6bvYQe/jGg/eq8iAqB39oJ4xsvP8rVA+
nv4MB8HfUGMeWwNfHEg2fIflKxngFnZZqVpLYcp5WUVEKr50X78UCizseROzEFeb
7GlJz7NfvM0M0mheYC03xFFIQp3FSle3qVMcMfZ07vvtC+OHLojRI8vk87+woyke
LSWzDizDjZVVBc0E8T5SB9C/WkXJR6o0e+WKtWdKH6P074PkoO4KlopJX/3x098h
OL27Mk+qLWVjG3rEwXULzf2aA8PLejCfkgP3Vv90c4LfZDB0kvN0n+Zy9URUTwZB
opCKDXMDGS0Bz9vpl3Yf8OWwlZyTD7Stbbf03CTI6+0S05HlLU1N7snRoIrIUfXy
JUHBvN+J1XFzHaz68PV55K+ucF4dgK3kDrbIYnIKGwrV4QJuzUX/8aDZ2x8Hrffu
zYHdpfS6oLiCoAQxYQgoSM/UdRDSGQKSjjjsXSa3rqj59jo8Dkh6O1J+Ui4ENsLS
BeQUR6aMdMlfQuahMzJWCDEviIxJdakhOJGucYNVFNCicrP9AExvBPI6vTfV0zP6
5fw2OksUnCOYBSZeUbMt7iDumTQqx7R8AG0UdjtGtvnstro5WfCDKbew3zM3AX4U
JZYeZQJATpX68yHRQUb1
=QPCP
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--

--===============8671904130334156186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8671904130334156186==--
