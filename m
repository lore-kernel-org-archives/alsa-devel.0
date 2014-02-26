From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 00/10] Simplify the code of TDM slot setting
Date: Wed, 26 Feb 2014 11:59:25 +0800
Message-ID: <1393387175-15539-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B4AF2619F4
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 06:06:45 +0100 (CET)
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
Cc: fabio.estevam@freescale.com, moinejf@free.fr, alsa-devel@alsa-project.org, lars@metafoo.de, kuninori.morimoto.gx@renesas.com, tiwai@suse.de, s.hauer@pengutronix.de, timur@tabi.org, linux-kernel@vger.kernel.org, denis@eukrea.com, Xiubo Li <Li.Xiubo@freescale.com>, Guangyu.Chen@freescale.com, mpa@pengutronix.de, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


Xiubo Li (10):
  ASoC: core: Add snd_soc_dai_set_tdm_slot_xlate().
  ASoC: fsl-utils: Add fsl_asoc_of_xlate_tdm_slot_mask() support.
  ASoC: fsl-esai: Add .of_xlate_tdm_slot_mask() support.
  ASoC: fsl-ssi: Add .of_xlate_tdm_slot_mask() support.
  ASoC: imx-ssi: Add .of_xlate_tdm_slot_mask() support.
  ASoC: simple-card: Use snd_soc_dai_set_tdm_slot_xlate()
  ASoC: blackfin: bf5xx-ad1836: Use snd_soc_dai_set_tdm_slot_xlate()
  ASoC: blackfin: bf5xx-ad193x: Use snd_soc_dai_set_tdm_slot_xlate()
  ASoC: fsl: eukrea-tlv320: Use snd_soc_dai_set_tdm_slot_xlate()
  ASoC: fsl: wm1133-ev1: Use snd_soc_dai_set_tdm_slot_xlate()

 include/sound/soc-dai.h           |  3 +++
 sound/soc/blackfin/bf5xx-ad1836.c |  2 +-
 sound/soc/blackfin/bf5xx-ad193x.c |  4 ++--
 sound/soc/fsl/Kconfig             |  3 +++
 sound/soc/fsl/eukrea-tlv320.c     |  2 +-
 sound/soc/fsl/fsl_esai.c          |  2 ++
 sound/soc/fsl/fsl_ssi.c           |  2 ++
 sound/soc/fsl/fsl_utils.c         | 27 +++++++++++++++++++++++++++
 sound/soc/fsl/fsl_utils.h         |  4 +++-
 sound/soc/fsl/imx-ssi.c           |  2 ++
 sound/soc/fsl/wm1133-ev1.c        | 11 +----------
 sound/soc/generic/simple-card.c   |  7 +++----
 sound/soc/soc-core.c              | 33 ++++++++++++++++++++++++++++-----
 13 files changed, 78 insertions(+), 24 deletions(-)

-- 
1.8.4
