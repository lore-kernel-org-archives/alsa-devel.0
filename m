From: Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] ASoC fixes for v3.14
Date: Thu, 20 Feb 2014 10:31:12 +0900
Message-ID: <20140220013112.GL2669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2249069703823425703=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D407B26538B
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:31:19 +0100 (CET)
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


--===============2249069703823425703==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f0zqVmjcfsFBnCVp"
Content-Disposition: inline


--f0zqVmjcfsFBnCVp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6d0abeca3242a88cab8232e4acd7e2bf088f3bc2:

  Linux 3.14-rc3 (2014-02-16 13:30:25 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.14-rc3

for you to fetch changes up to 895be5b31e5175bef575008aadb4f0a27b850daa:

  Merge remote-tracking branch 'asoc/fix/wm8993' into asoc-linus (2014-02-19 13:13:58 +0900)

----------------------------------------------------------------

ASoC: Fixes for v3.14

A few fixes, all driver speccific ones.  The DaVinci ones aren't as
clear as they should be from the subject lines on the commits but they
fix issues which will prevent correct operation in some use cases and
only affect that particular driver so are reasonably safe.

----------------------------------------------------------------
Adam Thomson (1):
      ASoC: da9055: Fix device registration of PMIC and CODEC devices

Alexander Shiyan (1):
      ASoC: txx9aclc_ac97: Fix kernel crash on probe

Dylan Reid (1):
      ASoC: max98090: sync regcache on entering STANDBY

Jarkko Nikula (1):
      ASoC: rt5640: Add ACPI ID for Intel Baytrail

Lars-Peter Clausen (1):
      ASoC: blackfin: Fix machine driver Kconfig dependencies

Mark Brown (2):
      Merge remote-tracking branches 'asoc/fix/blackfin', 'asoc/fix/da9055', 'asoc/fix/davinci', 'asoc/fix/fsl', 'asoc/fix/fsl-esai', 'asoc/fix/max98090', 'asoc/fix/rt5640', 'asoc/fix/samsung' and 'asoc/fix/txx9aclc-ac97' into asoc-linus
      Merge remote-tracking branch 'asoc/fix/wm8993' into asoc-linus

Peter Ujfalusi (4):
      ASoC: davinci-mcasp: Harmonize the sub hw_params function names
      ASoC: davinci-mcasp: Configure xxTDM, xxFMT and xxFMCT registers synchronously
      ASoC: davinci-mcasp: Consolidate pm_runtime_get/put() use in the driver
      ASoC: davinci-evm: Add pm callbacks to platform driver

Sachin Kamat (2):
      ASoC: samsung: Remove invalid dependencies
      ASoC: samsung: Fix trivial typo

Shawn Guo (1):
      ASoC: fsl: fix pm support of machine drivers

Stephen Warren (1):
      ASoC: max98090: make REVISION_ID readable

Wei Yongjun (1):
      ASoC: wm8993: drop regulator_bulk_free of devm_ allocated data

Xiubo Li (1):
      ASoC: fsl-esai: fix ESAI TDM slot setting

 drivers/mfd/da9055-i2c.c          | 12 +++++-
 sound/soc/blackfin/Kconfig        | 11 +++---
 sound/soc/codecs/da9055.c         | 11 +++++-
 sound/soc/codecs/max98090.c       | 21 +++++-----
 sound/soc/codecs/rt5640.c         |  1 +
 sound/soc/codecs/wm8993.c         |  1 -
 sound/soc/davinci/davinci-evm.c   |  1 +
 sound/soc/davinci/davinci-mcasp.c | 83 ++++++++++++++++++---------------------
 sound/soc/fsl/fsl_esai.c          |  4 +-
 sound/soc/fsl/fsl_esai.h          |  2 +-
 sound/soc/fsl/imx-mc13783.c       |  1 -
 sound/soc/fsl/imx-sgtl5000.c      | 10 +++--
 sound/soc/fsl/imx-wm8962.c        | 11 ++++--
 sound/soc/samsung/Kconfig         |  6 +--
 sound/soc/txx9/txx9aclc-ac97.c    |  8 ++--
 15 files changed, 99 insertions(+), 84 deletions(-)

--f0zqVmjcfsFBnCVp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBVrdAAoJELSic+t+oim9MYIP/A/1i4YQAsBoTI9SObJyl+OM
0Nb7jsAK0WK9j5L/u4VReGumyoKhcnk3ybe2OTc9I3Ubre/sa+ZO0yyU3Ha8EEUJ
uMk/5ntqkgLz907goT+3Yhda0PcjlOMqiMbzEY+Dc8rFRitdC8qp4NftPZUr6Jd9
1aqWatYcq/25sJLEMaFfP1saO9ivJsaKqTZsltpojozL7bTBxwW6qdqXffvo63Gh
rlztGnpiue4aFK2zlBESvocNgUjCD+kGQYPttHP8niAWt3uQjB+Mw7jAfsMnNKy7
y0Tp0K6iTDLglFINubEaZZoZnFqIgwFyVrSNaLaq+VknyBQs9vPBP5AMOM3eOCm4
I0RajyvuLrEX/fX90z43QhjF0nnBWyUayNMoHWECQkHjiPQE0kI3sijIyixZ2VdG
XtFyyqn9K+z9wyfiZ1BWvzuU254L0NB4E0LvJC57GOnsaFOY9agF56DKdUGg0cTU
RftJ84deWIiCmx5ULcK54mXhik8WwxhlsfA0T7SUv9G3T7IfbSE1n4ufue59ghsO
nY9XdHXfxyWvEiLvSM+bAatbGI/gk5byJQWR9flK7pOzAj8HZlvcpzC9zxemONPP
y44ymqM6t50t1VEJSq3JyxYMBjcMWMCgvRnuK0JmEJ38w7LyyCWsx5tIFIRFccic
5LA1680bSFQzzEo8AARw
=UkV2
-----END PGP SIGNATURE-----

--f0zqVmjcfsFBnCVp--

--===============2249069703823425703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2249069703823425703==--
