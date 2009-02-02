From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Mon, 2 Feb 2009 12:52:02 +0000
Message-ID: <20090202125202.GB10845@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4B8D92444E
	for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2009 13:52:03 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following changes since commit 7393958f630ac91e591e62058f2bdb61523ec60c:
  Peter Ujfalusi (1):
        ASoC: TWL4030: Add analog loopback support

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Eero Nurkkala (1):
      OMAP: ASoC: Fix spinlock misuse in omap-pcm.c

Grazvydas Ignotas (1):
      ASoC: Update OMAP3 pandora board file

Mark Brown (1):
      Merge branch 'for-2.6.29' into for-2.6.30

Timur Tabi (2):
      ASoC: fix initialization order of the CS4270 codec driver
      ASoC: fix documentation in CS4270 codec driver

 sound/soc/codecs/cs4270.c     |  332 ++++++++++++++++++++++++-----------------
 sound/soc/omap/omap-pcm.c     |    5 +-
 sound/soc/omap/omap3pandora.c |   49 ++++---
 3 files changed, 230 insertions(+), 156 deletions(-)
