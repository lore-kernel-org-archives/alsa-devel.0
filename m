From: Mark Brown <broonie@kernel.org>
Subject: ASoC updates for v3.10
Date: Fri, 3 May 2013 10:20:57 +0100
Message-ID: <20130503092057.GH4945@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2279959468748018755=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 16B9B261664
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2013 11:21:26 +0200 (CEST)
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


--===============2279959468748018755==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HuscSE0D68UGttcd"
Content-Disposition: inline


--HuscSE0D68UGttcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c1be5a5b1b355d40e6cf79cc979eb66dafa24ad1:

  Linux 3.9 (2013-04-28 17:36:01 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.10-4

for you to fetch changes up to 9631c02e240236ec206394fb52380647d0e70e4f:

  Merge remote-tracking branch 'asoc/fix/wm8994' into asoc-linus (2013-05-03 09:30:29 +0100)

----------------------------------------------------------------

ASoC: Updates for v3.10

A few more bug fixes, the DAPM clock fix is actually a driver specific
one since currently there's only one user of the clock support due to
the problems relying on the clock API.

----------------------------------------------------------------
Dan Carpenter (1):
      ASoC: wm8994: missing break in wm8994_aif3_hw_params()

Fabio Baltieri (1):
      ASoC: dapm: use clk_prepare_enable and clk_disable_unprepare

Marek Belisko (2):
      ASoC: McASP: Add pins output direction for rx clocks when configured in CBS_CFS format
      ASoC: McASP: Fix receive clock polarity in DAIFMT_NB_NF mode.

Mark Brown (2):
      Merge remote-tracking branch 'asoc/fix/davinci' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/wm8994' into asoc-linus

 sound/soc/codecs/wm8994.c         |    1 +
 sound/soc/davinci/davinci-mcasp.c |    7 +++++--
 sound/soc/soc-dapm.c              |    4 ++--
 3 files changed, 8 insertions(+), 4 deletions(-)

--HuscSE0D68UGttcd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRg4F2AAoJELSic+t+oim91HgP/1YMNaeU5WwkPP+Z+1+sBCkb
pvwMHPrlAUQoyYibxBGW37CbFpLygE6flID0LJyF8Nt0YsKOP4yWe8S6CNSPIUul
4V/x7EIELAaQ6rMqmHSeUXq1f7c1eUEKBPeYRjMF4y0yCAjtvNuOfLOuu5UIs4o2
jOJDHSKqMnMeNdJzuQemS/c0dRfc/RaC3O+fgY5kcME7fsykm0of+C5Pmm8eEKcx
jkPYgj3Zhsgz4laihP99JcCM+V3dZdzVbtkOre5PfsOIFTElNXnMEG0OT5lBI3jC
qORsF+9/1l3NFsn/XpJ8beKr/vmlVwNLEsXhaxOS1edOJeqV1LCX6b09ixMNZ9iu
caud8F8ONj53Olx2O90smaQWMyuCbX1Spp+KgZi0Ep2oNJa485SjW03d23KbwI2g
o9dsLw9tzOs/8vRmxH3xuC2uVo1WQ2lQwCKJy+5e9zmz2W+A/f0WYgZDZdlSsqgc
wHHRQwnS1tH5tv0tJ68oYDKc19RwchusRsPWcBmeSX1TmJsNuuyIOuZfi+e9TVsq
dnvGtLESV+BqI/Yc8r1n2fyZgAMfTXjieM1eS9wCK46CdSkIlag4TxeWKpfH83xu
vHGfrp+XhAxOJP5OSzNPfOpgzl7ATFODIHLkAWsihYoI8BA49YhPwJzp2r7CzTP2
3cvJRN25r7b2JnpQOzQy
=iGL/
-----END PGP SIGNATURE-----

--HuscSE0D68UGttcd--

--===============2279959468748018755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2279959468748018755==--
