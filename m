From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/6] ASoC: edma-pcm: Include edma-pcm.h
Date: Sun, 17 Aug 2014 16:18:17 +0200
Message-ID: <1408285102-24538-2-git-send-email-lars@metafoo.de>
References: <1408285102-24538-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-166.synserver.de (smtp-out-166.synserver.de
 [212.40.185.166])
 by alsa0.perex.cz (Postfix) with ESMTP id 104302650DA
 for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2014 16:18:27 +0200 (CEST)
In-Reply-To: <1408285102-24538-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sangbeom Kim <sbkim73@samsung.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lee Jones <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org

edma_pcm_platform_register() is declared in edma-pcm.h and defined in
edma-pcm.c. To make sure that the function signature matches for both
edma-pcm.c should include edma-pcm.h

Fixes the following sparse warning:
	sound/soc/davinci/edma-pcm.c:48:5: warning: symbol
	 'edma_pcm_platform_register' was not declared. Should it be static?

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/davinci/edma-pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/davinci/edma-pcm.c b/sound/soc/davinci/edma-pcm.c
index 605e643..59e588a 100644
--- a/sound/soc/davinci/edma-pcm.c
+++ b/sound/soc/davinci/edma-pcm.c
@@ -25,6 +25,8 @@
 #include <sound/dmaengine_pcm.h>
 #include <linux/edma.h>
 
+#include "edma-pcm.h"
+
 static const struct snd_pcm_hardware edma_pcm_hardware = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
-- 
1.8.0
