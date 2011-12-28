From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.3
Date: Wed, 28 Dec 2011 11:43:29 +0000
Message-ID: <20111228114329.GG24405@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4066A244D2
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 12:43:33 +0100 (CET)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit c5cf4dbc7f804bb4ff02a065b927bd8688204253:

  ASoC: Add trivial pm_runtime usage to Samsung DAI drivers (2011-12-23 12:08:32 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-3.3

Axel Lin (8):
      ASoC: Convert da7210 to devm_kzalloc()
      ASoC: Convert lm4857 to devm_kzalloc()
      ASoC: Convert uda1380 to devm_kzalloc()
      ASoC: Convert 88pm860x-codec to devm_kzalloc()
      ASoC: Fix build error in sound/soc/kirkwood/kirkwood-i2s.c
      ASoC: Use dai_fmt in kirkwood-openrd machine driver
      ASoC: Use dai_fmt in kirkwood-t5325 machine driver
      ASoC: Convert kirkwood-t5325 to table based DAPM init

Joachim Eastwood (1):
      ASoC: wm8776: add missing break in sample size switch

Mark Brown (1):
      Merge branch 'for-3.2' into for-3.3

 sound/soc/codecs/88pm860x-codec.c    |    7 ++-----
 sound/soc/codecs/da7210.c            |    7 ++-----
 sound/soc/codecs/lm4857.c            |   13 ++-----------
 sound/soc/codecs/uda1380.c           |    6 ++----
 sound/soc/codecs/wm8776.c            |    1 +
 sound/soc/kirkwood/kirkwood-i2s.c    |    3 +--
 sound/soc/kirkwood/kirkwood-openrd.c |   14 ++------------
 sound/soc/kirkwood/kirkwood-t5325.c  |   24 +++++++-----------------
 sound/soc/kirkwood/kirkwood.h        |    1 -
 9 files changed, 19 insertions(+), 57 deletions(-)
