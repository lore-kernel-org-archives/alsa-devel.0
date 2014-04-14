From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/17] Removed deprecated ENUM/MUX macros
Date: Mon, 14 Apr 2014 21:30:55 +0200
Message-ID: <1397503872-20864-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-046.synserver.de
 [212.40.185.46])
 by alsa0.perex.cz (Postfix) with ESMTP id ED6C82656AD
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:31:19 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

Hi,

This is a follow-up to the enum consolidation series. It updates all users of
the now redundant and deprecated macros and once that is done removes the
macros.

- Lars

Lars-Peter Clausen (17):
  ASoC: adau1373: Replace usage deprecated MUX/ENUM macros
  ASoC: adav80x: Replace usage deprecated MUX/ENUM macros
  ASoC: arizona: Replace usage deprecated MUX/ENUM macros
  ASoC: max98090: Replace usage deprecated MUX/ENUM macros
  ASoC: mc13783: Replace usage deprecated MUX/ENUM macros
  ASoC: pcm512x: Replace usage deprecated SOC_VALUE_ENUM macro
  ASoC: rt5640: Replace usage deprecated MUX/ENUM macros
  ASoC: wm2200: Replace usage deprecated MUX/ENUM macros
  ASoC: wm5100: Replace usage deprecated MUX/ENUM macros
  ASoC: wm5102: Replace usage deprecated MUX/ENUM macros
  ASoC: wm5110: Replace usage deprecated MUX/ENUM macros
  ASoC: wm8988: Replace usage deprecated MUX/ENUM macros
  ASoC: wm5102: Replace usage deprecated SOC_VALUE_ENUM macro
  ASoC: wm8994: Replace usage deprecated MUX/ENUM macros
  ASoC: wm8995: Replace usage deprecated MUX/ENUM macros
  ASoC: wm8997: Replace usage deprecated MUX/ENUM macros
  ASoC: Remove deprecated ENUM/MUX macros

 include/sound/soc-dapm.h    | 12 ------------
 include/sound/soc.h         |  2 --
 sound/soc/codecs/adau1373.c |  7 +++----
 sound/soc/codecs/adav80x.c  |  8 ++++----
 sound/soc/codecs/arizona.h  |  4 ++--
 sound/soc/codecs/max98090.c |  5 ++---
 sound/soc/codecs/mc13783.c  |  8 ++++----
 sound/soc/codecs/pcm512x.c  |  2 +-
 sound/soc/codecs/rt5640.c   |  4 ++--
 sound/soc/codecs/wm2200.c   |  4 ++--
 sound/soc/codecs/wm5100.c   |  4 ++--
 sound/soc/codecs/wm5102.c   | 14 +++++++-------
 sound/soc/codecs/wm5110.c   | 18 +++++++++---------
 sound/soc/codecs/wm8988.c   |  8 ++++----
 sound/soc/codecs/wm8994.c   | 12 ++++++------
 sound/soc/codecs/wm8995.c   | 10 ++++------
 sound/soc/codecs/wm8997.c   | 12 ++++++------
 17 files changed, 58 insertions(+), 76 deletions(-)

-- 
1.8.0
