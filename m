From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Mon, 11 Oct 2010 13:11:43 +0100
Message-ID: <20101011121143.GK9231@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6E82F103A88
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 14:11:45 +0200 (CEST)
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

The following changes since commit 9d9641ec891a53ef93a8972c7913605aeb8127c7:

  Merge branch 'for-2.6.36' into for-2.6.37 (2010-10-07 13:44:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

Dan Carpenter (1):
      ASoC: checking kzalloc() for IS_ERR() instead of NULL

Mark Brown (2):
      ASoC: Shrink code size for WM8962 register defaults table
      ASoC: Compress WM8962 register access map

 sound/soc/codecs/Makefile        |    2 +-
 sound/soc/codecs/wm8804.c        |    8 +-
 sound/soc/codecs/wm8962-tables.c |42299 --------------------------------------
 sound/soc/codecs/wm8962.c        | 1834 ++
 sound/soc/codecs/wm8962.h        |   11 -
 sound/soc/codecs/wm8985.c        |    8 +-
 6 files changed, 1843 insertions(+), 42319 deletions(-)
 delete mode 100644 sound/soc/codecs/wm8962-tables.c
