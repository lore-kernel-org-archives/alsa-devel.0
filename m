From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.37
Date: Mon, 1 Nov 2010 15:50:05 -0400
Message-ID: <20101101195004.GC13509@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 894F8243B9
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 20:50:00 +0100 (CET)
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

The following changes since commit 89e1e66d6be8a520cdcd26043cda2cc870a34015:

  ALSA: usb-audio: automatically detect feedback format (2010-10-27 09:17:41 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.37

All minor and localised fixes with the exception of the patches from
Jarkko which improve build test coverage.

Jarkko Nikula (2):
      ASoC: Fix SND_SOC_ALL_CODECS typo for jz4740
      ASoC: Include cx20442 to SND_SOC_ALL_CODECS

Joe Perches (1):
      ASoC: Update WARN uses in wm_hubs

Mark Brown (2):
      ASoC: Check return value of struct_strtoul() in pmdown_time_set()
      ASoC: Remove volatility from WM8900 POWER1 register

 sound/soc/codecs/Kconfig   |    3 ++-
 sound/soc/codecs/wm8900.c  |    6 ------
 sound/soc/codecs/wm_hubs.c |    2 +-
 sound/soc/soc-core.c       |    5 ++++-
 4 files changed, 7 insertions(+), 9 deletions(-)
