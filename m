From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 0/4] Add fsl_asoc_xlate_tdm_slot_mask()
Date: Fri, 21 Mar 2014 14:17:11 +0800
Message-ID: <1395382635-16349-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B7DEE26167A
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 08:01:09 +0100 (CET)
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
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, Xiubo Li <Li.Xiubo@freescale.com>, Guangyu.Chen@freescale.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org



Xiubo Li (4):
  ASoC: core: remove the 'of_' prefix of of_xlate_tdm_slot_mask.
  ASoC: fsl-utils: Add fsl_asoc_xlate_tdm_slot_mask() support.
  ASoC: fsl-esai: Add .xlate_tdm_slot_mask() support.
  ASoC: imx-ssi: Add .xlate_tdm_slot_mask() support.

 include/sound/soc-dai.h   |  2 +-
 sound/soc/fsl/Kconfig     |  2 ++
 sound/soc/fsl/fsl_esai.c  |  2 ++
 sound/soc/fsl/fsl_utils.c | 27 +++++++++++++++++++++++++++
 sound/soc/fsl/fsl_utils.h |  4 +++-
 sound/soc/fsl/imx-ssi.c   |  2 ++
 sound/soc/soc-core.c      | 10 +++++-----
 7 files changed, 42 insertions(+), 7 deletions(-)

-- 
1.8.4
