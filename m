From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-mcbsp: Correct CBM_CFS dai format
	configuration
Date: Fri, 16 Jan 2015 11:20:25 +0200
Message-ID: <1421400025-6374-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id C83BE261740
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 10:20:30 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

We should select FSR also to be driven by McBSP, not only FSX.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Clearly the CBM_CFS is not widely used with McBSP, this is why it has not been
noticed I believe.

Peter

 sound/soc/omap/omap-mcbsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 8b79cafab1e2..c7eb9dd67f60 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -434,7 +434,7 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	case SND_SOC_DAIFMT_CBM_CFS:
 		/* McBSP slave. FS clock as output */
 		regs->srgr2	|= FSGM;
-		regs->pcr0	|= FSXM;
+		regs->pcr0	|= FSXM | FSRM;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		/* McBSP slave */
-- 
2.2.1
