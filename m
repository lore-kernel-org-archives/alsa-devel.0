From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 04/10] ASoC: fsl-ssi: Add
	.of_xlate_tdm_slot_mask() support.
Date: Wed, 26 Feb 2014 11:59:29 +0800
Message-ID: <1393387175-15539-5-git-send-email-Li.Xiubo@freescale.com>
References: <1393387175-15539-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 by alsa0.perex.cz (Postfix) with ESMTP id BA9882619F4
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 06:08:15 +0100 (CET)
In-Reply-To: <1393387175-15539-1-git-send-email-Li.Xiubo@freescale.com>
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

This patch add .of_xlate_tdm_slot_mask support for SSI, and this will
generate the TDM slot TX and RX masks.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/fsl/Kconfig   | 1 +
 sound/soc/fsl/fsl_ssi.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 6abb68e..7472308 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -5,6 +5,7 @@ config SND_SOC_FSL_SAI
 
 config SND_SOC_FSL_SSI
 	tristate
+	select SND_SOC_FSL_UTILS
 
 config SND_SOC_FSL_SPDIF
 	tristate "ALSA SoC support for the Freescale SPDIF device"
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 5428a1f..80ca76c 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -53,6 +53,7 @@
 
 #include "fsl_ssi.h"
 #include "imx-pcm.h"
+#include "fsl_utils.h"
 
 #ifdef PPC
 #define read_ssi(addr)			 in_be32(addr)
@@ -1136,6 +1137,7 @@ static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 	.hw_params	= fsl_ssi_hw_params,
 	.set_fmt	= fsl_ssi_set_dai_fmt,
 	.set_sysclk	= fsl_ssi_set_dai_sysclk,
+	.of_xlate_tdm_slot_mask	= fsl_asoc_of_xlate_tdm_slot_mask,
 	.set_tdm_slot	= fsl_ssi_set_dai_tdm_slot,
 	.trigger	= fsl_ssi_trigger,
 };
-- 
1.8.4
