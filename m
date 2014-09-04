From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/9] ASoC: probe/remove and suspend/resume
	manual bias level transitions cleanup
Date: Thu,  4 Sep 2014 19:44:03 +0200
Message-ID: <1409852652-27939-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-125.synserver.de (smtp-out-125.synserver.de
 [212.40.185.125])
 by alsa0.perex.cz (Postfix) with ESMTP id 26461265698
 for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2014 19:44:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The goal of this series is to allow to cut back the number of manual bias level
transitions that drivers have to do.

We do have a lot of drivers which manually go to SND_SOC_BIAS_OFF on suspend and
go back to SND_SOC_BIAS_STANDBY on resume. Often this is even the only thing
done in the suspend and resume handlers. This leads to a lot of drivers with
identical suspend and resume code. In this series a new flag called
suspend_bias_off is introduced. When this flag is set for a driver the ASoC core
will automatically switch to SND_SOC_BIAS_OFF during suspend. This allows to
remove the manual transitions (and often the suspend and resume handlers
altogether).

Similarly a lot of drivers also go to SND_SOC_BIAS_STANDBY at the end of their
probe() callback and a lot of drivers go to SND_SOC_BIAS_OFF at the beginning in
their remove() handler. The first one is already unnecessary as things are today
since the core will make sure to set the DAPM context to SND_SOC_BIAS_STANDBY
when the first snd_soc_dapm_sync() is executed during card instantiation after
all components have been probed. To be able to remove the later from individual
drivers this series introduces a call to snd_soc_dapm_shutdown() when the card
is removed. This not only makes sure that the bias level of all components is at
SND_SOC_BIAS_OFF, but also makes sure that all widgets are properly powered
down.

This series only converts a small set of drivers for now to keep small and clear
and to be able to focus on the core changes, but I do have patches for cleaning
up most of the drivers which in total removes over a 1000 lines of redundant
code.

The series depends on topic/suspend.

- Lars

Lars-Peter Clausen (9):
  ASoC: Set card->instantiated to false when removing the card
  ASoC: Shutdown DAPM contexts when removing a card
  ASoC: Add support for automatically going to BIAS_OFF on suspend
  ASoC: Always run default suspend/resume code
  ASoC: adau1373: Cleanup manual bias level transitions
  ASoC: adau17x1: Cleanup manual bias level transitions
  ASoC: adav80x: Cleanup manual bias level transitions
  ASoC: ssm2518: Cleanup manual bias level transitions
  ASoC: ssm2602: Cleanup manual bias level transitions

 include/sound/soc-dapm.h    |  3 ++-
 include/sound/soc.h         |  1 +
 sound/soc/codecs/adau1373.c |  7 -------
 sound/soc/codecs/adau1761.c |  2 +-
 sound/soc/codecs/adau1781.c |  2 +-
 sound/soc/codecs/adau17x1.c |  8 --------
 sound/soc/codecs/adau17x1.h |  1 -
 sound/soc/codecs/adav80x.c  | 23 ++---------------------
 sound/soc/codecs/ssm2518.c  | 13 -------------
 sound/soc/codecs/ssm2602.c  | 24 ++----------------------
 sound/soc/soc-core.c        | 17 ++++++++++++-----
 sound/soc/soc-dapm.c        | 20 ++++++++++++++++++--
 12 files changed, 39 insertions(+), 82 deletions(-)

-- 
1.8.0
