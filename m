From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 0/7] Allow ADSPs to be preloaded with firmware
Date: Tue, 20 Sep 2016 13:52:29 +0100
Message-ID: <1474375956-10443-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id BE408266CF5
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 14:52:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

As requirements to bring up audio paths are continuous getting tighter and
the DSP download to most ADSP devices happens over an external bus it can
become an important factor in the path bring up time. As such sometimes it
is a reasonable trade off to download the firmware ahead of when it will
be required and take a small hit on power consumption for keeping the core
powered up.

This patch chain adds such functionality to the wm_adsp driver, broadly
speaking there are three parts to the chain. Firstly we setup the existing
preloader widgets such that they will be easier to power up independently.
Secondly, we setup the ALSA controls such that they will gracefully handle
the DSP being in a low power state between loading the firmware and
starting the core. Finally, we actually add the preloading features itself.

Thanks,
Charles

Charles Keepax (7):
  ASoC: arizona: Attach SYSCLK to DSP preloaders
  ASoC: wm_adsp: Make DSP preloader a supply widget
  ASoC: wm_adsp: Separate concept of booted and running
  ASoC: wm_adsp: Move control cache sync out of preloader
  ASoC: wm_adsp: Put DSP into low power state between loading and
    running
  ASoC: wm_adsp: Allow preloader to do the final shutdown of the DSP
  ASoC: wm_adsp: Add mechanism to preload firmware on a core

 sound/soc/codecs/arizona.h |  18 ++++---
 sound/soc/codecs/cs47l24.c |   5 +-
 sound/soc/codecs/wm5102.c  |   3 +-
 sound/soc/codecs/wm5110.c  |   7 ++-
 sound/soc/codecs/wm_adsp.c | 126 ++++++++++++++++++++++++++++++++++++---------
 sound/soc/codecs/wm_adsp.h |  18 ++++++-
 6 files changed, 138 insertions(+), 39 deletions(-)

-- 
2.1.4
