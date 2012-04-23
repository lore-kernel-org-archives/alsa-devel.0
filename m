From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.4
Date: Mon, 23 Apr 2012 17:28:57 +0100
Message-ID: <20120423162857.GQ8318@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0849849105414553972=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7EE26243C3
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2012 19:26:05 +0200 (CEST)
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


--===============0849849105414553972==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="chReQkDOePndSGWY"
Content-Disposition: inline


--chReQkDOePndSGWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8abe05c6eb358967f16bce8a02c88d57c82cfbd6:

  ASoC: tegra: fix i2s compilation when !CONFIG_DEBUG_FS (2012-04-06 12:28:49 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.4

for you to fetch changes up to 1a38336b8611a04f0a624330c1f815421f4bf5f4:

  ASoC: wm8994: Improve sequencing of AIF channel enables (2012-04-23 12:55:52 +0100)

----------------------------------------------------------------
ASoC: updates for 3.4

Slightly larger than normal - the DAPM fix is a "this should always have
worked" type of thing which is very clear and should have no impact on
systems that don't need it.  The WM8994 fix is driver specific but
pretty important for that driver.

----------------------------------------------------------------
Jesper Juhl (1):
      ASoC: cs42l73: don't use negative array index

Liam Girdwood (1):
      ASoC: core: Fix card RTD count for deferred probe.

Mark Brown (2):
      ASoC: dapm: Ensure power gets managed for line widgets
      ASoC: wm8994: Improve sequencing of AIF channel enables

Paul Mundt (1):
      ASoC: fsi: update for dmaengine prep_slave_sg fallout.

 sound/soc/codecs/cs42l73.c |    2 +
 sound/soc/codecs/wm8994.c  |  276 +++++++++++++++++++++++++++++++++++---------
 sound/soc/sh/fsi.c         |    7 +-
 sound/soc/soc-core.c       |    1 +
 sound/soc/soc-dapm.c       |    2 +
 5 files changed, 230 insertions(+), 58 deletions(-)

--chReQkDOePndSGWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPlYMYAAoJEBus8iNuMP3dZeQQAIM/keC6XgT/kJTLIPDmedgU
0zpMf11kTEFztn7eO03Ys6amgXATk2EgUcnpbTvOoomW9rrgLPDw2tfVcWGrbruS
BnFJfC1ZKO5cC4io9Pr1iNgxp/UZm4gdV02XxsNM82msJdWEWLDN1eIzLFBeSPCW
6jYfEOmltmI/SYiKCZEiOUdytskpnKt43fTNHQg/1sb/UgJvAoCa1rRXWO/gAtte
Nvg2ZrCGRFSVT86lr4ttOl0uvYcy9jMzuhkUTVtRV1A1NCFUB+ZgnVbGSmH+Zt7W
cwJoku1sVpANlKthDnUajQdc1aiWQywaWvGzJ2m8yDL+s/GEV0wKfp/AAmU6AgKC
4h4O3HOsgyfYTe+ftfQv33IK1v+yTFv66KJFEUtI6ZetOfOoulLabHGmtY8AE7rX
qQ+pQcDsF3PYdPIk8omJ0VlIyI8NMi+pGAvxstmN/wgowIzTTqxvfDvecEzSmK40
Z3pLkXQ4CgQWEVOlGRbzQdIdQV0pU4zmfFxsH2dz35LNr6gdkrqGicwu3fdjENxY
CjG4hsxXD0cn1RaK38ULm+DtSUP+YX7HoBC4+q4UnkpvMcAb+z+oSAUrPodKPRFY
JXJWDFTMVe7eXp3Lk5Yy4rOxV839uIOuqPkBVBPOKiVOM8Fe2Vy3Uss7FUqviJZ6
9wd0mm6XjlgS6z1Ddx21
=pYAy
-----END PGP SIGNATURE-----

--chReQkDOePndSGWY--

--===============0849849105414553972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0849849105414553972==--
