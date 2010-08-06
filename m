From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/2] ASoC: multi-comp: twl4030 updates
Date: Fri,  6 Aug 2010 08:49:53 +0300
Message-ID: <1281073795-4364-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (mgw-sa02.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DA9924390
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 07:49:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hello Liam, Mark!

The following two patch is for the current multi-comp
branch with twl4030 related fixes.

I have separated them, so they can be squased to the
corresponding commit in multi-comp branch for now.

The changes in short:
- We do not need the header sound/soc/codecs/twl4030.h
  anymore, so remove it
- Fix machine drivers with theis header removal
- The codec no longer get's the former setup data, all
  configuration is coming from board files via the
  platform_data. So change the code accordingly
- Move the twl4030_priv allocation to a proper place
- Codec can shall go OFF instead of STANDBY, so add back
  the idle_bias_off flag
- The MFD driver is twl4030-audio

TODO after the multi-comp is merged:
- Rename the mfd driver to twl4030-audio.
  Clean up the internal naming within the mfd
  This going to touch many files...

One more notice:
The multi-comp branch does not have the
"ASoC: TWL4030: Capture route runtime DAPM ordering fix" commit
yet, and I have tested my changes on top of that, but it should
not be a big problem, when you rebase this driver.

What do you think?

Peter

---
Peter Ujfalusi (2):
  ASoC: multi-comp: twl4030: TI CODECs
  ASoC: multi-comp: twl4030: TI OMAP Platform

 drivers/mfd/twl-core.c        |    2 +-
 drivers/mfd/twl4030-codec.c   |    4 +-
 include/linux/i2c/twl.h       |    6 +++-
 sound/soc/codecs/twl4030.c    |   73 ++++++++++++++++++++---------------------
 sound/soc/codecs/twl4030.h    |   52 -----------------------------
 sound/soc/omap/igep0020.c     |    1 -
 sound/soc/omap/omap2evm.c     |    1 -
 sound/soc/omap/omap3beagle.c  |    1 -
 sound/soc/omap/omap3evm.c     |    1 -
 sound/soc/omap/omap3pandora.c |    1 -
 sound/soc/omap/overo.c        |    1 -
 sound/soc/omap/sdp3430.c      |    4 ++-
 sound/soc/omap/zoom2.c        |    4 ++-
 13 files changed, 50 insertions(+), 101 deletions(-)
 delete mode 100644 sound/soc/codecs/twl4030.h

--
1.7.2
