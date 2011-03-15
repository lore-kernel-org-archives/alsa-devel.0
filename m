From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.39
Date: Tue, 15 Mar 2011 13:18:42 +0000
Message-ID: <20110315131842.GA23533@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 28B32103803
	for <alsa-devel@Alsa-project.org>; Tue, 15 Mar 2011 14:18:26 +0100 (CET)
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
Cc: alsa-devel@Alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 80e1b84ffe1354f314fd85c939900b816f394e5a:

  Merge branch 'for-2.6.38' into for-2.6.39 (2011-03-10 14:16:35 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.39

A final batch of updates for 2.6.39 - these have been sitting in my
-next tree for several days now.

Christian Glindkamp (1):
      ASoC: Add MAX9850 codec driver

Mark Brown (1):
      ASoC: Fix spacing in MAX8950

Takashi Iwai (1):
      ALSA: Add snd_ctl_activate_id()

Vasily Khoruzhick (2):
      ASoC: PXA: z2: Mute internal speaker when headphones are connected
      ASoC: PXA: Z2: Fix codec pin name

 include/sound/control.h    |    2 +
 sound/core/control.c       |   46 +++++
 sound/soc/codecs/Kconfig   |    4 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/max9850.c |  389 ++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/max9850.h |   38 +++++
 sound/soc/pxa/z2.c         |    7 +-
 7 files changed, 487 insertions(+), 1 deletions(-)
 create mode 100644 sound/soc/codecs/max9850.c
 create mode 100644 sound/soc/codecs/max9850.h
