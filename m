From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC updates for v3.10
Date: Mon, 24 Jun 2013 12:48:36 +0100
Message-ID: <20130624114836.GK27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3229816480158018418=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A608A261B30
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 13:48:44 +0200 (CEST)
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


--===============3229816480158018418==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cO2ZlOvi7VNgmdOy"
Content-Disposition: inline


--cO2ZlOvi7VNgmdOy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7d132055814ef17a6c7b69f342244c410a5e000f:

  Linux 3.10-rc6 (2013-06-15 11:51:07 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.10-rc7

for you to fetch changes up to b12a530682ec725ff7a95871d8003d1753e315b8:

  Merge remote-tracking branch 'asoc/fix/wm8962' into asoc-linus (2013-06-19 19:49:23 +0100)

----------------------------------------------------------------

ASoC: Updates for v3.10

A few small updates, one small core fix and several simple driver ones.
The wm8962 changes are a little large but are pretty important.

----------------------------------------------------------------
Axel Lin (1):
      ASoC: adav80x: Select SND_SOC_ADAV80X if SND_SOC_I2C_AND_SPI

Charles Keepax (1):
      ASoC: wm5110: Correct rate control for DSP4

Lars-Peter Clausen (1):
      ASoC: dapm: Add snd_soc_dapm_switch to the power up/down sequence table

Mark Brown (4):
      Merge remote-tracking branch 'asoc/fix/adav80x' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/adsp' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/dapm' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/wm8962' into asoc-linus

Nicolin Chen (2):
      ASoC: wm8962: Remove remaining direct register cache accesses
      ASoC: wm8962: Enable start-up and normal bias after reset in runtime resume

 sound/soc/codecs/Kconfig   |  2 +-
 sound/soc/codecs/wm8962.c  | 35 ++++++++++++++++++++++++-----------
 sound/soc/codecs/wm_adsp.c |  2 +-
 sound/soc/soc-dapm.c       |  2 ++
 4 files changed, 28 insertions(+), 13 deletions(-)

--cO2ZlOvi7VNgmdOy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRyDIRAAoJELSic+t+oim9RMAP/3HLJERgykKpMf+XhFFZMhCW
uzeFT92mcaRfns2ZHZlBrdfvqGOKnoegv2uqxJRjujnls2bexQpREz1Y0nueIzd6
XYlGFR8SqgEbD6sD7TBmeNNdL7/xK4nlU2uolOJ5TbZgT0hrbpzi/wM985Pa6XuM
sFPTKRcLvfO8JF8CwQ9gYWXfsRm4KtiV1hpptW3aLPK41Ss17g4soMKpbjm8cxXa
5GcRnOSpn/uq4lgr//zWVa/TJnBDdBIv3CJkx+fVa5DY0LQdR5LuEPwd2UifimFb
E10QSW7KXN2ziPuoEDg94N0D6VdAFwEvBMRZ7LQO+OH66n+JywCssQMfMbga9IHN
QUylEp1Ec+vEVZLLPOMQWd35AZp7DdLHEZw8J/SvJ9QS0n2tXspJm5PbeLwgYwp+
p9WYmFQvkZES3MvJNnoNh2L4cIdZpgIYaY0X1aNzc4HS7CdnSweI0EUJzGR7PiiZ
yCad57AuoNoEbtRS96rbt9YHC/+Ov2g/2X3tQgYZ7F2AL+EgDz3IoLmZwNYxlu1M
zYRpHu/SMXiJmSDEhr5I+/Hv/Bs6bu369zaMeGqLrg5UTsXk7p/lECTt/ZUYefeU
CBH6DOVVHHdVg+uKv1YovGRoGOtltHzaNHCg2KpF2eYcNRkRWcQM3ULMy0KtHMnh
AtHfx/qDVqqdeTtshK13
=mn7M
-----END PGP SIGNATURE-----

--cO2ZlOvi7VNgmdOy--

--===============3229816480158018418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3229816480158018418==--
