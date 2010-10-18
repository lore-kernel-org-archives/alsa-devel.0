From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC update for 2.6.37
Date: Mon, 18 Oct 2010 06:13:33 +0100
Message-ID: <20101018051333.GA24467@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EB8E8103840
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Oct 2010 07:13:19 +0200 (CEST)
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

The following changes since commit 630f2d445f922c9dcf1bb54ffde78685e2c63072:

  fbdev: sh_mobile_hdmi: fix compilation without SOUND enabled (2010-10-15 11:56:46 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

Mark Brown (1):
      Revert "ASoC: Add max98088 CODEC driver"

 sound/soc/codecs/Kconfig    |    4 -
 sound/soc/codecs/Makefile   |    2 -
 sound/soc/codecs/max98088.c | 2097 -------------------------------------------
 sound/soc/codecs/max98088.h |  193 ----
 4 files changed, 0 insertions(+), 2296 deletions(-)
 delete mode 100644 sound/soc/codecs/max98088.c
 delete mode 100644 sound/soc/codecs/max98088.h
