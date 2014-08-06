From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: [PATCH V1 0/2] refine esai for tdm support
Date: Wed, 6 Aug 2014 18:23:02 +0800
Message-ID: <cover.1407320232.git.shengjiu.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, timur@tabi.org, perex@perex.cz, tiwai@suse.de, nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, shc_work@mail.ru, fabio.estevam@freescale.com, arnd@arndb.de
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

refine esai for tdm support.

Shengjiu Wang (2):
  ASoC: fsl: esai: refine esai for tdm support
  Revert "ASoC: fsl-esai: Add .xlate_tdm_slot_mask() support."

 sound/soc/fsl/Kconfig    |    1 -
 sound/soc/fsl/fsl_esai.c |   12 +++++++-----
 sound/soc/fsl/fsl_esai.h |    8 ++++----
 3 files changed, 11 insertions(+), 10 deletions(-)

-- 
1.7.9.5
