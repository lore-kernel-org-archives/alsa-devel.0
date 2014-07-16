From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/3] ASoC: edma-pcm: Add empty functions for
	!CONFIG_SND_EDMA_SOC builds
Date: Wed, 16 Jul 2014 15:12:03 +0300
Message-ID: <1405512724-23628-3-git-send-email-peter.ujfalusi@ti.com>
References: <1405512724-23628-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 874FB2652DA
 for <alsa-devel@alsa-project.org>; Wed, 16 Jul 2014 14:12:12 +0200 (CEST)
In-Reply-To: <1405512724-23628-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

So drivers mixing with other platform drivers, like davinci-mcasp do not
need to fiddle with CONFIG_SND_EDMA_SOC in their code.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/edma-pcm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/davinci/edma-pcm.h b/sound/soc/davinci/edma-pcm.h
index 894c378c0f74..b0957744851c 100644
--- a/sound/soc/davinci/edma-pcm.h
+++ b/sound/soc/davinci/edma-pcm.h
@@ -20,6 +20,13 @@
 #ifndef __EDMA_PCM_H__
 #define __EDMA_PCM_H__
 
+#if IS_ENABLED(CONFIG_SND_EDMA_SOC)
 int edma_pcm_platform_register(struct device *dev);
+#else
+static inline int edma_pcm_platform_register(struct device *dev)
+{
+	return 0;
+}
+#endif /* CONFIG_SND_EDMA_SOC */
 
 #endif /* __EDMA_PCM_H__ */
-- 
2.0.0
