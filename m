From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.39
Date: Thu, 10 Mar 2011 14:41:20 +0000
Message-ID: <20110310144120.GC18973@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5853024388
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2011 15:41:03 +0100 (CET)
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

The following changes since commit f9c540456ab662a3b5d79c1fa93c51305a97fdf3:

  ASoC: Remove warnings in ep93xx-i2s.c (2011-03-07 17:32:02 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.39

Alexander Sverdlin (4):
      ASoC: Manage mode and rate bits correctly for CS4271 CODEC.
      ASoC: EDB93xx: Manage I2S rates according to datasheet for CS4271 CODEC.
      ASoC: Improve EP93xx I2S clocks management.
      ASoC: Enable 192kHz sample rate for EP93xx.

Dan Carpenter (1):
      ASoC: sgtl5000: use after free in ldo_regulator_register()

Mark Brown (16):
      ASoC: Add DAPM widget and path data to CODEC driver structure
      ASoC: Use data based init for WM9081 DAPM
      ASoC: Fix section mismatch warnings in WM8994
      ASoC: Provide CODEC clocking operations and API calls
      ASoC: Convert WM9081 SYSCLK configuration to be device wide
      ASoC: Refactor symmetric_rates check to reduce indentation
      ASoC: Warn rather than set a silly constraint when we can't do symmetry
      ASoC: Fix prefixing of DAPM controls by factoring prefix into snd_soc_cnew()
      ASoC: Simplify WM9081 speaker startup by using widgets for spaker output
      ASoC: Fix broken bitfield definitions in WM8978
      ASoC: Use the correct DAPM context when cleaning up final widget set
      ASoC: Fix double addition of prefixes due to widget prefixing
      Merge branch 'for-2.6.38' into for-2.6.39
      ASoC: Fix typo in late revision WM8994 DAC2R name
      ASoC: Ensure WM8958 gets all WM8994 late revision widgets
      Merge branch 'for-2.6.38' into for-2.6.39

 include/sound/soc.h              |   20 +++++-
 sound/soc/codecs/cs4271.c        |   83 ++++++++++++++--------
 sound/soc/codecs/sgtl5000.c      |    4 +-
 sound/soc/codecs/wm8994-tables.c |    2 +-
 sound/soc/codecs/wm8994.c        |   10 +++-
 sound/soc/codecs/wm8994.h        |    2 +-
 sound/soc/codecs/wm9081.c        |   51 ++++---------
 sound/soc/ep93xx/edb93xx.c       |   16 ++--
 sound/soc/ep93xx/ep93xx-i2s.c    |   23 +++---
 sound/soc/ep93xx/ep93xx-pcm.c    |    4 +-
 sound/soc/soc-core.c             |  141 ++++++++++++++++++++++++++++++--------
 sound/soc/soc-dapm.c             |   45 +++++++++++--
 12 files changed, 274 insertions(+), 127 deletions(-)
