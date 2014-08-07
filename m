From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: [PATCH V2 0/2] refine esai for tdm support
Date: Thu, 7 Aug 2014 17:33:23 +0800
Message-ID: <cover.1407403727.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, timur@tabi.org, perex@perex.cz, tiwai@suse.de, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, shc_work@mail.ru, fabio.estevam@freescale.com, arnd@arndb.de
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

These patchs is to refine esai for tdm support.

Changes for V2
- update the comments according the reviewer's suggestion
- add init value for slots and change pin to pins.

Shengjiu Wang (2):
  ASoC: fsl_esai: refine esai for TDM support
  Revert "ASoC: fsl-esai: Add .xlate_tdm_slot_mask() support."

 sound/soc/fsl/Kconfig    |    1 -
 sound/soc/fsl/fsl_esai.c |   16 +++++++++++-----
 sound/soc/fsl/fsl_esai.h |    8 ++++----
 3 files changed, 15 insertions(+), 10 deletions(-)

-- 
1.7.9.5
