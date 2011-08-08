From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Rename of WM8996 for 3.1
Date: Mon, 8 Aug 2011 17:27:25 +0900
Message-ID: <20110808082723.GA12336@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3503810380B
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Aug 2011 10:27:34 +0200 (CEST)
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

This update to rename the WM8915 to WM8996 had some cross tree issues
due to the use of the platform data for the device in the Cragganmore
machine driver so got held off until things settled down during the
merge window.  I'm posting it separately to any other updates in case
you're nervous about taking it.  I can guarantee that only that one
machine is affected.  This is probably about the best time to do the
update while minimizing the cross tree issues.

The following changes since commit 322a8b034003c0d46d39af85bf24fee27b902f48:

  Linux 3.1-rc1 (2011-08-07 18:23:30 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git wm8996-rename

Mark Brown (2):
      ASoC: Rename WM8915 to WM8996
      ASoC: Acknowledge WM8996 interrupts before acting on them

 arch/arm/mach-s3c64xx/mach-crag6410.c |   18 +-
 include/sound/{wm8915.h => wm8996.h}  |   28 +-
 sound/soc/codecs/Kconfig              |    8 +-
 sound/soc/codecs/Makefile             |    4 +-
 sound/soc/codecs/wm8915.c             | 2995 --------------------------
 sound/soc/codecs/wm8915.h             | 3717 ---------------------------------
 sound/soc/codecs/wm8996.c             | 2994 ++++++++++++++++++++++++++
 sound/soc/codecs/wm8996.h             | 3717 +++++++++++++++++++++++++++++++++
 sound/soc/samsung/Kconfig             |    2 +-
 sound/soc/samsung/speyside.c          |   32 +-
 10 files changed, 6757 insertions(+), 6758 deletions(-)
 rename include/sound/{wm8915.h => wm8996.h} (63%)
 delete mode 100644 sound/soc/codecs/wm8915.c
 delete mode 100644 sound/soc/codecs/wm8915.h
 create mode 100644 sound/soc/codecs/wm8996.c
 create mode 100644 sound/soc/codecs/wm8996.h
