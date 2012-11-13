From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.7
Date: Tue, 13 Nov 2012 15:45:06 +0900
Message-ID: <20121113064503.GF18224@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6532875206084247314=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3F2BA2650BD
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 07:45:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girwdood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6532875206084247314==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

  Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.7

for you to fetch changes up to ba027da8eb309252cb611f23808da51487f68e12:

  Merge branches 'fix/arizona', 'fix/core', 'fix/cs42l52', 'fix/mxs', 'fix/samsung' and 'fix/wm8978' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into tmp (2012-11-13 15:13:29 +0900)

----------------------------------------------------------------

ASoC: Fixes for v3.7

A few small fixes plus a large but simple change for WM5102 which writes
out a bunch of register updates to the device when we enable the clock
as recommended following chip evaluation.

----------------------------------------------------------------
Charles Keepax (1):
      ASoC: bells: Correct type in sub speaker DAI name for WM5102

Dimitris Papastamos (2):
      ASoC: bells: Add missing select of WM0010
      ASoC: bells: Select WM1250-EV1 Springbank audio I/O module

Eric Millbrandt (1):
      ASoC: wm8978: pll incorrectly configured when codec is master

Fabio Estevam (2):
      ASoC: mxs-saif: Add MODULE_ALIAS
      ASoC: mxs-saif: Fix channel swap for 24-bit format

Mark Brown (2):
      ASoC: wm5102: Write register value corrections after SYSCLK is enabled
      Merge branches 'fix/arizona', 'fix/core', 'fix/cs42l52', 'fix/mxs', 'fix/samsung' and 'fix/wm8978' of git://git.kernel.org/.../broonie/sound into tmp

Misael Lopez Cruz (1):
      ASoC: dapm: Use card_list during DAPM shutdown

Mukund Navada (1):
      ASoC: core: Double control update err for snd_soc_put_volsw_sx

Wei Yongjun (1):
      ASoC: cs42l52: fix the return value of cs42l52_set_fmt()

 sound/soc/codecs/cs42l52.c |    3 +-
 sound/soc/codecs/wm5102.c  |  552 +++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/wm8978.c  |    2 +-
 sound/soc/mxs/mxs-saif.c   |   17 +-
 sound/soc/samsung/Kconfig  |    2 +
 sound/soc/samsung/bells.c  |    2 +-
 sound/soc/soc-core.c       |    5 +-
 sound/soc/soc-dapm.c       |    2 +-
 8 files changed, 573 insertions(+), 12 deletions(-)

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQoexoAAoJELSic+t+oim9UDoP/jYgBMSuq8zRF980gmRF7E48
QPE40xigQW64sOPHiUJZyVyKjsKRKBBLDZle1+QtCgeDa5Rti8h0XLMZHODXt/Hy
4859TtLJQrvqPQHz7W6jwJTVw0Q65cf5eDDOgkbliDnWGP6xqfCpY6biJrDMlKES
+7ZDQxaQSN7EcJ+4BtDXQjzO0Xpz6DIr3Ryf6C5oGgd4t98ROLm+UlDfYx7LTb1P
Q6y/JEI3yWdjaUjMkFGMYwZVwNxaV9M2xyJMcwFJJ6HaJyMevxED00atQBRZJBEh
lsE4JJ6NEPfRWa+SGvQ2Ed2zEqxJw9el/pCbBFJ9MfJVpCHUWfHzQ32IKrkYEeKH
Xjm3KaYwHMlddnmJJMPkd2mJwJx+oAek/viaqw6LvGyfkLRyhp2uJjVpE6+sQL6W
xa79y6zRrjLOdkNR28eyw9F1bO3nFKVfmDzZvt6wwM1521m761MhO9Lfjln/bxVL
soeHV/1U4/bKaCAucNJAwhAjo+DFmlMJEBRJ6IozyPt5DnGYB+F9i7XyoKULs/Gv
xWb0/Hkd17s2phf1ou/6s2FQVU1UP4w68qV4txizlBrI9QV2VBMRu3YLkn6KZ4mh
Drfgu2BF7yuTCL50kC4mTPolktb9jSqXyYawEjH+zldURAV9iLJcuaF58biMTdyw
3+xaVv9jeq7TQmnyMoSq
=D5T+
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--

--===============6532875206084247314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6532875206084247314==--
