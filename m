From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 0/8] ASoC: arizona: Add support for directly
	setting the FLL REFCLK
Date: Wed, 20 Feb 2013 16:09:31 +0000
Message-ID: <1361376579-29051-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 087732616DD
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2013 17:12:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This patch series adds support for specifying the source of
REFCLK directly for Wolfson Arizona based devices. This should
allow for improved performance by using the highest available
REFCLK source. Should the REFCLK source not be directly specified
then the patches will default to the older behaviour of using the
32kHz clock for REFCLK.

REFCLK is configured using a call to snd_soc_codec_set_pll
specifying one of the new WM51xx_FLLx_REFCLK defines as the
pll_id. It is valid to clear the SYNCCLK source by setting the
source to ARIZONA_FLL_SRC_NONE, however once a REFCLK source it
can only be replaced with another valid REFCLK source.

Charles Keepax (8):
  ASoC: arizona: Move selection of FLL REFCLK into init
  ASoC: arizona: Tidy up SYNCCLK selection and cache values
  ASoC: arizona: Factor out check for enabled FLL
  ASoC: arizona: Factor out FLL disable
  ASoC: arizona: Factor out FLL enable
  ASoC: arizona: Improve suppression of noop FLL updates
  ASoC: arizona: Add support for directly setting the FLL REFCLK
  ASoC: arizona: Add convience define for clearing SYNCCLK

 sound/soc/codecs/arizona.c |  191 ++++++++++++++++++++++++++++++--------------
 sound/soc/codecs/arizona.h |    9 ++-
 sound/soc/codecs/wm5102.c  |    6 ++
 sound/soc/codecs/wm5102.h  |    6 +-
 sound/soc/codecs/wm5110.c  |    6 ++
 sound/soc/codecs/wm5110.h  |    6 +-
 6 files changed, 158 insertions(+), 66 deletions(-)

-- 
1.7.2.5
