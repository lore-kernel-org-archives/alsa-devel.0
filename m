From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 3/3] ASoC: davinci-pcm: Add empty functions
	for !CONFIG_SND_DAVINCI_SOC builds
Date: Tue, 18 Mar 2014 15:20:37 +0200
Message-ID: <1395148837-20850-4-git-send-email-peter.ujfalusi@ti.com>
References: <1395148837-20850-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 748322610B4
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 14:20:49 +0100 (CET)
In-Reply-To: <1395148837-20850-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, nsekhar@ti.com, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

To save drivers using davinci-pcm and edma-pcm the need to fiddle with
!CONFIG_SND_DAVINCI_SOC in their code.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-pcm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
index fbb710c76c08..5fd4737ab398 100644
--- a/sound/soc/davinci/davinci-pcm.h
+++ b/sound/soc/davinci/davinci-pcm.h
@@ -29,7 +29,17 @@ struct davinci_pcm_dma_params {
 	unsigned int fifo_level;
 };
 
+#if IS_ENABLED(CONFIG_SND_DAVINCI_SOC)
 int davinci_soc_platform_register(struct device *dev);
 void davinci_soc_platform_unregister(struct device *dev);
+#else
+static inline int davinci_soc_platform_register(struct device *dev)
+{
+	return 0;
+}
+static inline void davinci_soc_platform_unregister(struct device *dev)
+{
+}
+#endif /* CONFIG_SND_DAVINCI_SOC */
 
 #endif
-- 
1.9.0
