From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Remove a unused variables from i.MX
	FIQ runtime data
Date: Thu, 25 Feb 2010 12:52:09 +0000
Message-ID: <1267102330-13294-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A617D10396C
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 13:52:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/imx/imx-pcm-fiq.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-fiq.c b/sound/soc/imx/imx-pcm-fiq.c
index 5532579..a1c4ce6 100644
--- a/sound/soc/imx/imx-pcm-fiq.c
+++ b/sound/soc/imx/imx-pcm-fiq.c
@@ -35,12 +35,8 @@
 struct imx_pcm_runtime_data {
 	int period;
 	int periods;
-	unsigned long dma_addr;
-	int dma;
 	unsigned long offset;
 	unsigned long size;
-	unsigned long period_cnt;
-	void *buf;
 	struct timer_list timer;
 	int period_time;
 };
-- 
1.7.0
