From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.38
Date: Wed, 12 Jan 2011 11:17:02 +0000
Message-ID: <20110112111701.GD20911@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C300D24508
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 12:19:12 +0100 (CET)
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

The following changes since commit 2f55eaab56ea083498034c18e09d356594081fca:

  Merge branch 'for-2.6.38' of git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6 into topic/asoc (2011-01-12 07:20:30 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.38

Dimitris Papastamos (1):
      ASoC: soc-cache: Fix invalid memory access during snd_soc_lzo_cache_sync()

Guennadi Liakhovetski (1):
      ASoC: fix migor audio build

Timur Tabi (1):
      ASoC: cs4270: use the built-in register cache support

Vasily Khoruzhick (1):
      ASoC: RX1950: Enable Mic Jack during glue driver init

 sound/soc/codecs/cs4270.c          |  161 +++++++++++-------------------------
 sound/soc/samsung/rx1950_uda1380.c |    1 +
 sound/soc/sh/migor.c               |    2 +-
 sound/soc/soc-cache.c              |    2 +-
 4 files changed, 51 insertions(+), 115 deletions(-)
