From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/5] ASoC: davinci: Select SND_EDMA_SOC when
	SND_DAVINCI_SOC is enabled
Date: Tue, 3 Mar 2015 16:45:17 +0200
Message-ID: <1425393921-14219-2-git-send-email-peter.ujfalusi@ti.com>
References: <1425393921-14219-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 38650261543
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 15:45:33 +0100 (CET)
In-Reply-To: <1425393921-14219-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, khilman@deeprootsystems.com, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, zonque@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

edma-pcm going to replace davinci-pcm as platform driver for daVinci
platform.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 4a328ddfa5bd..7acce887b073 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -1,10 +1,11 @@
 config SND_DAVINCI_SOC
 	tristate "SoC Audio for TI DAVINCI"
 	depends on ARCH_DAVINCI
+	select SND_EDMA_SOC
 
 config SND_EDMA_SOC
 	tristate "SoC Audio for Texas Instruments chips using eDMA (AM33XX/43XX)"
-	depends on SOC_AM33XX || SOC_AM43XX
+	depends on SOC_AM33XX || SOC_AM43XX || ARCH_DAVINCI
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M here if you want audio support for TI SoC which uses eDMA.
-- 
2.3.0
