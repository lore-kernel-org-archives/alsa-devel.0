From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 06/20] ASoC: davinci-mcasp: Move
	DAVINCI_MCASP_RATE from header to source file
Date: Thu, 14 Nov 2013 11:35:22 +0200
Message-ID: <1384421737-4467-7-git-send-email-peter.ujfalusi@ti.com>
References: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 26F612616E1
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 10:35:52 +0100 (CET)
In-Reply-To: <1384421737-4467-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Michal Bachraty <michal.bachraty@streamunlimited.com>, nsekhar@ti.com, jsarha@ti.com, gururaja.hebbar@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

It is not used outside of the .c file.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 2 ++
 sound/soc/davinci/davinci-mcasp.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 71e14bb3..9763a5d 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -955,6 +955,8 @@ static const struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
 	.set_sysclk	= davinci_mcasp_set_sysclk,
 };
 
+#define DAVINCI_MCASP_RATES	SNDRV_PCM_RATE_8000_192000
+
 #define DAVINCI_MCASP_PCM_FMTS (SNDRV_PCM_FMTBIT_S8 | \
 				SNDRV_PCM_FMTBIT_U8 | \
 				SNDRV_PCM_FMTBIT_S16_LE | \
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index a2e27e1..a84e796 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -23,7 +23,6 @@
 
 #include "davinci-pcm.h"
 
-#define DAVINCI_MCASP_RATES	SNDRV_PCM_RATE_8000_192000
 #define DAVINCI_MCASP_I2S_DAI	0
 #define DAVINCI_MCASP_DIT_DAI	1
 
-- 
1.8.4.2
