From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCHv2 00/11] Remove set_cache_io entirely from ASoC
	probe
Date: Wed, 26 Mar 2014 13:40:22 +0800
Message-ID: <1395812433-26410-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 by alsa0.perex.cz (Postfix) with ESMTP id D4F182650E1
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 07:27:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, shc_work@mail.ru, tiwai@suse.de, viresh.kumar@linaro.org, patches@opensource.wolfsonmicro.com, andrew.smirnov@gmail.com, Xiubo Li <Li.Xiubo@freescale.com>, akpm@linux-foundation.org, s.trumtrar@pengutronix.de, rf@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

Change in v2:
- Add .get_regmap() support for struct snd_soc_codec_driver.


Xiubo Li (11):
  ASoC: core: Move the default regmap I/O setting to
    snd_soc_register_codec()
  ASoc: 88pm860x: Remove the set_cache_io() entirely from ASoC probe.
  ASoc: cq93vc: Remove the set_cache_io() entirely from ASoC probe.
  ASoc: mc13783: Remove the set_cache_io() entirely from ASoC probe.
  ASoc: si476x: Remove the set_cache_io() entirely from ASoC probe.
  ASoc: wm5102: Remove the set_cache_io() entirely from ASoC probe.
  ASoc: wm5110: Remove the set_cache_io() entirely from ASoC probe.
  ASoc: wm8350: Remove the set_cache_io() entirely from ASoC probe.
  ASoc: wm8400: Remove the set_cache_io() entirely from ASoC probe.
  ASoc: wm8994: Remove the set_cache_io() entirely from ASoC probe.
  ASoc: wm8997: Remove the set_cache_io() entirely from ASoC probe.

 include/sound/soc.h               |  1 +
 sound/soc/codecs/88pm860x-codec.c | 12 ++++++++----
 sound/soc/codecs/cq93vc.c         | 10 ++++++++--
 sound/soc/codecs/mc13783.c        | 14 ++++++--------
 sound/soc/codecs/si476x.c         | 14 ++++++--------
 sound/soc/codecs/wm5102.c         | 12 ++++++++----
 sound/soc/codecs/wm5110.c         | 12 ++++++++----
 sound/soc/codecs/wm8350.c         | 10 ++++++++--
 sound/soc/codecs/wm8400.c         | 10 ++++++++--
 sound/soc/codecs/wm8994.c         | 10 ++++++++--
 sound/soc/codecs/wm8997.c         | 13 ++++++++-----
 sound/soc/soc-core.c              | 28 ++++++++++++++++++----------
 sound/soc/soc-io.c                |  9 +++------
 13 files changed, 98 insertions(+), 57 deletions(-)

-- 
1.8.4
