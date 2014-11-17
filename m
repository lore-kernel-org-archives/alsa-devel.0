From: Mark Brown <broonie@kerel.org>
Subject: ASoC fixes for v3.18
Date: Mon, 17 Nov 2014 16:55:27 +0000
Message-ID: <20141117165527.GH2722@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2398046469529804517=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 883D5264F3A
 for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2014 17:55:47 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2398046469529804517==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gAUgrzRZ7tRi/Yr6"
Content-Disposition: inline


--gAUgrzRZ7tRi/Yr6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit fc14f9c1272f62c3e8d01300f52467c0d9af50f9:

  Linux 3.18-rc5 (2014-11-16 16:36:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc=
-v3.18-rc5

for you to fetch changes up to cf9a7f7823c67243da44da2ac47ca944a3108282:

  Merge remote-tracking branches 'asoc/fix/rt5670', 'asoc/fix/samsung' and =
'asoc/fix/sgtl5000' into asoc-linus (2014-11-17 16:41:11 +0000)

----------------------------------------------------------------
ASoC: Fixes for v3.18

As well as the usual driver fixes there's a few other things here:

One is a fix for a race in DPCM which is unfortuantely a rather large
diffstat, this is the result of growing usage of the mainline code and
hence more detailed testing so I'm relatively happy.

The other is a fix for non-DT machine driver matching following some of
the componentization work which is much more focused.

Both have had a while to cook in -next.

----------------------------------------------------------------
Andreas F=E4rber (1):
      ASoC: samsung: Add MODULE_DEVICE_TABLE for Snow

Axel Lin (1):
      ASoC: es8328-i2c: Fix i2c_device_id name field in es8328_id

Bard Liao (2):
      ASoC: rt5670: correct the incorrect default values
      ASoC: rt5670: change dapm routes of PLL connection

Charles Keepax (1):
      ASoC: wm_adsp: Avoid attempt to free buffers that might still be in u=
se

Dylan Reid (1):
      ASoC: max98090: Correct pclk divisor settings

Fabio Estevam (1):
      ASoC: sgtl5000: Fix SMALL_POP bit definition

Fang, Yang A (1):
      ASoC: rt5645: Mark RT5645_TDM_CTRL_3 as readable

Jianqun (1):
      ASoC: rockchip-i2s: fix infinite loop in rockchip_snd_rxctrl

Kuninori Morimoto (2):
      ASoC: fsi: remove unsupported PAUSE flag
      ASoC: rsnd: remove unsupported PAUSE flag

Lars-Peter Clausen (1):
      ASoC: Fix snd_soc_find_dai() matching component by name

Mark Brown (3):
      Merge remote-tracking branch 'asoc/fix/core' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/adsp', 'asoc/fix/cs41l51', '=
asoc/fix/dpcm', 'asoc/fix/es8328', 'asoc/fix/fsl-asrc', 'asoc/fix/max98090'=
, 'asoc/fix/rcar', 'asoc/fix/rockchip' and 'asoc/fix/rt5645' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/rt5670', 'asoc/fix/samsung' =
and 'asoc/fix/sgtl5000' into asoc-linus

Nicolin Chen (1):
      ASoC: fsl_asrc: Add reg_defaults for regmap to fix kernel dump

Takashi Iwai (1):
      ASoC: dpcm: Fix race between FE/BE updates and trigger

Thomas Petazzoni (1):
      ASoC: cs42l51: re-hook of_match_table pointer

 include/sound/soc-dpcm.h          |  2 ++
 sound/soc/codecs/cs42l51-i2c.c    |  1 +
 sound/soc/codecs/cs42l51.c        |  4 ++-
 sound/soc/codecs/cs42l51.h        |  1 +
 sound/soc/codecs/es8328-i2c.c     |  2 +-
 sound/soc/codecs/max98090.c       |  6 ++--
 sound/soc/codecs/rt5645.c         |  2 ++
 sound/soc/codecs/rt5670.c         | 36 ++++++++++----------
 sound/soc/codecs/sgtl5000.c       |  3 +-
 sound/soc/codecs/sgtl5000.h       |  2 +-
 sound/soc/codecs/wm_adsp.c        |  1 +
 sound/soc/fsl/fsl_asrc.c          | 26 ++++++++++++++
 sound/soc/rockchip/rockchip_i2s.c |  4 ++-
 sound/soc/samsung/snow.c          |  1 +
 sound/soc/sh/fsi.c                |  3 +-
 sound/soc/sh/rcar/core.c          |  3 +-
 sound/soc/soc-core.c              |  2 +-
 sound/soc/soc-pcm.c               | 72 ++++++++++++++++++++++++++++++-----=
----
 18 files changed, 123 insertions(+), 48 deletions(-)

--gAUgrzRZ7tRi/Yr6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUaih+AAoJECTWi3JdVIfQxcYH/3QK5CzxHDkfwE46otIMYAJT
HCA81tFStJQzf/qV9Qy3yp0S2xcAhq4jxE3WBUUxEA+QPqVtA9DCQByIsN9d/Yds
nkqZ0QTrL1U65uFqs+I81cwa9WFSsNWuW67y0K4nXCkdNCJHVl/mvBoDI9zdRnot
VRftNLhXK0e1+bp/x/1XxwbROa8m2lz0KyXpCrKXQXCfWxkbPww1yk4fQ+rjuL/D
ktiDSmbSeIJ3AfqUt5z2XZbnvwA42PRLGm0vKPgRE3GaSqM9GySw6eICh5ryWRM5
O/8PjMEe59ZAwgZZPZqt4pLDNVaN4JuJQEwJf9wDGjc7GbZLxAbxikp+ceiXtv0=
=8Dim
-----END PGP SIGNATURE-----

--gAUgrzRZ7tRi/Yr6--

--===============2398046469529804517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2398046469529804517==--
