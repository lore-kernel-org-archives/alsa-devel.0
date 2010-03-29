From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.35
Date: Mon, 29 Mar 2010 21:13:11 +0100
Message-ID: <20100329201310.GA7256@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1E275103805
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Mar 2010 22:13:12 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 923a00427a141a6d1c83f1b151221a2458b2de8d:
  Tejun Heo (1):
        ASoC: update gfp/slab.h includes

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.35

Barry Song (1):
      ASoC: ad193x: move codec register/unregister to bus probe/remove

Dan Carpenter (1):
      ASoC: wm8994: playback => capture

Graham Gower (1):
      ASoC: Fix passing platform_data to ac97 bus users and fix a leak

Kuninori Morimoto (4):
      ASoC: fsi: ensures process inside master lock
      ASoC: fsi: IRQ related process had be united
      ASoC: fsi: Add FIFO size calculate
      ASoC: fsi: Add FSI2 device support

Mark Brown (2):
      Merge branch 'topic/asoc' of git://git.kernel.org/.../tiwai/sound-2.6 into for-2.6.35
      Merge branch 'for-2.6.34' into for-2.6.35

 sound/soc/codecs/ac97.c   |   15 ++--
 sound/soc/codecs/ad193x.c |  102 ++++++++++--------------
 sound/soc/codecs/wm8994.c |    2 +-
 sound/soc/sh/Kconfig      |    3 +-
 sound/soc/sh/fsi.c        |  191 ++++++++++++++++++++++++++++++++-------------
 sound/soc/soc-core.c      |    3 +-
 6 files changed, 192 insertions(+), 124 deletions(-)
