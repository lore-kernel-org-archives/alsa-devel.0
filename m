From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/4] ASoC updates
Date: Wed, 24 Sep 2008 12:59:07 +0100
Message-ID: <20080924115907.GA12401@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 596FC2415D
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Sep 2008 13:59:09 +0200 (CEST)
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

This series fixes a couple of bugs (neither of which affect 2.6.27) and
introduces a new API call for marking disconnected pins, mostly as a
placeholder for future development so machine drivers can start using it
now and then benefit when a more substantial implementation follows.

The following changes since commit 3090258fed179996ac4daecb482bad28d84cb054:
  Jean Delvare (1):
        ALSA: ASoC: Convert tlv320aic3x to a new-style i2c driver (v2)

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Mark Brown (4):
      ASoC: Fix inverted input PGA mute bits in WM8903
      ASoC: Fix build of GTA01 audio driver
      ASoC: Allow machine drivers to mark pins as not connected
      ASoC: Use snd_soc_dapm_nc_pin() in GTA01 audio driver

 include/sound/soc-dapm.h           |    1 +
 sound/soc/codecs/wm8903.c          |    4 ++--
 sound/soc/s3c24xx/neo1973_wm8753.c |   17 ++++++++---------
 sound/soc/soc-dapm.c               |   20 ++++++++++++++++++++
 4 files changed, 31 insertions(+), 11 deletions(-)
