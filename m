From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 00/15] Update locking for snd_soc_dapm_xxxx_pin
	functions
Date: Mon, 17 Feb 2014 16:51:28 +0000
Message-ID: <1392655903-24537-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E7A3E264EFA
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 17:59:57 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, eric.y.miao@gmail.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com, patches@opensource.wolfsonmicro.com, linux@arm.linux.org.uk, jarkko.nikula@bitmer.com
List-Id: alsa-devel@alsa-project.org

This patchset updates the locking around the
snd_soc_dapm_xxxx_pin functions. First we add a locked
version of the functions and add locking to the standard
call, this also requires us to remove the few places where
these functions are externally locked. Then we patch usages
of the functions that look like they are expecting to do an
atomic update to do so.

Thanks,
Charles

Charles Keepax (15):
  Input - arizona-haptics: Fix double lock of dapm_mutex
  ASoC: dapm: Add locked version of snd_soc_dapm_xxxx_pin functions
  ASoC: adav80x: Update locking around use of DAPM pin API
  ASoC: wm5100: Update locking around use of DAPM pin API
  ASoC: wm8962: Update locking around use of DAPM pin API
  ASoC: wm8994: Update locking around use of DAPM pin API
  ASoC: wm8996: Update locking around use of DAPM pin API
  ASoC: mfld_machine: Update locking around use of DAPM pin API
  ASoC: ams-delta: Update locking around use of DAPM pin API
  ASoC: omap: n810: Update locking around use of DAPM pin API
  ASoC: omap: rx51: Update locking around use of DAPM pin API
  ASoC: pxa: corgi: Update locking around use of DAPM pin API
  ASoC: pxa: magician: Update locking around use of DAPM pin API
  ASoC: pxa: spitz: Update locking around use of DAPM pin API
  ASoC: pxa: tosa: Update locking around use of DAPM pin API

 drivers/extcon/extcon-arizona.c      |   12 ---
 drivers/input/misc/arizona-haptics.c |   19 -----
 include/sound/soc-dapm.h             |    8 ++
 sound/soc/codecs/adav80x.c           |   14 +++-
 sound/soc/codecs/wm5100.c            |    9 ++-
 sound/soc/codecs/wm8962.c            |   12 ++-
 sound/soc/codecs/wm8994.c            |   40 ++++++----
 sound/soc/codecs/wm8996.c            |    8 ++-
 sound/soc/intel/mfld_machine.c       |   43 ++++++++----
 sound/soc/omap/ams-delta.c           |   38 ++++++----
 sound/soc/omap/n810.c                |   20 +++--
 sound/soc/omap/rx51.c                |   20 +++--
 sound/soc/pxa/corgi.c                |   40 ++++++-----
 sound/soc/pxa/magician.c             |   20 +++--
 sound/soc/pxa/spitz.c                |   49 +++++++------
 sound/soc/pxa/tosa.c                 |   26 ++++---
 sound/soc/soc-dapm.c                 |  133 +++++++++++++++++++++++++++++++---
 17 files changed, 338 insertions(+), 173 deletions(-)

-- 
1.7.2.5
