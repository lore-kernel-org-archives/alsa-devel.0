From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/8] ASoC: Replace remaining users of the CODEC
	mutex
Date: Sun,  9 Nov 2014 17:00:56 +0100
Message-ID: <1415548864-27203-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-182.synserver.de
 [212.40.185.182])
 by alsa0.perex.cz (Postfix) with ESMTP id EDDC0260545
 for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2014 17:01:03 +0100 (CET)
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Tushar Behera <tushar.behera@linaro.org>
List-Id: alsa-devel@alsa-project.org

We've stopped using the snd_soc_codec mutex in the ASoC core itself a while
ago. There is still a handful of drivers which use the mutex to protect some
of their data structures. This patch moves the lock for the remaining users
to the drivers private data struct and then removes it from the
snd_soc_codec struct.

- Lars

Lars-Peter Clausen (8):
  ASoC: ab8500-codec: Move control lock to the driver level
  ASoC: max98095: Move mutex to the driver level
  ASoC: wm5102: Move ultrasonic response settings lock to the driver
    level
  ASoC: wm8731: Move the deemph lock to the driver level
  ASoC: wm8903: Move the deemph lock to the driver level
  ASoC: wm8958: Move DSP firmware lock to driver level
  ASoC: wm8962: Move DSP enable lock to the driver level
  ASoC: Remove CODEC mutex

 include/linux/mfd/arizona/core.h |  1 +
 include/sound/soc.h              |  1 -
 sound/soc/codecs/ab8500-codec.c  | 32 ++++++++++++++++----------------
 sound/soc/codecs/arizona.c       |  4 ++--
 sound/soc/codecs/max98095.c      | 12 ++++++++----
 sound/soc/codecs/wm5102.c        | 16 ++++++++--------
 sound/soc/codecs/wm8731.c        |  9 +++++++--
 sound/soc/codecs/wm8903.c        |  8 ++++++--
 sound/soc/codecs/wm8958-dsp2.c   | 12 ++++++------
 sound/soc/codecs/wm8962.c        |  8 ++++++--
 sound/soc/codecs/wm8994.c        |  2 ++
 sound/soc/codecs/wm8994.h        |  2 ++
 sound/soc/soc-core.c             |  1 -
 13 files changed, 64 insertions(+), 44 deletions(-)

-- 
1.8.0
