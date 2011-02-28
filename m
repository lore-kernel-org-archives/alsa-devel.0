From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.39
Date: Mon, 28 Feb 2011 15:09:15 +0000
Message-ID: <20110228150915.GA26619@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AFAFB247F2
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 16:08:54 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Taksahi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 9b34e6cc3bc2bf826c078c93c81b46f6c08da25f:

  ASoC: Add Freescale SGTL5000 codec support (2011-02-25 12:09:33 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2=
.6.39

Eric B=E9nard (2):
      eukrea-tlv320: fix platform_name
      ASoC: eukrea-tlv320: add MBIMXSD51 support

Mark Brown (3):
      ASoC: Move WM2000 to dev_pm_ops
      Merge branch 'for-2.6.38' into for-2.6.39
      ASoC: Staticise non-exported symbols in SGTL5000

Zeng Zhaoming (1):
      ASoC: remove unnecessary header including in SGTL5000 codec driver

 sound/soc/codecs/sgtl5000.c   |    7 +++----
 sound/soc/codecs/sgtl5000.h   |    2 --
 sound/soc/codecs/wm2000.c     |   14 +++++++-------
 sound/soc/imx/Kconfig         |    3 ++-
 sound/soc/imx/eukrea-tlv320.c |    5 +++--
 5 files changed, 15 insertions(+), 16 deletions(-)
