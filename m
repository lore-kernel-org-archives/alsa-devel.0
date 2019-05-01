From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 2/2] ASoC: wm_adsp: Use DSP ops pointers to
	stop watchdog in error handlers
Date: Wed, 1 May 2019 11:13:32 +0100
Message-ID: <20190501101332.31190-2-ckeepax@opensource.cirrus.com>
References: <20190501101332.31190-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7BD7DF8075A
 for <alsa-devel@alsa-project.org>; Wed,  1 May 2019 12:13:35 +0200 (CEST)
In-Reply-To: <20190501101332.31190-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Whilst this isn't strictly necessary as the code is already DSP specific
better to use the pointers to avoid potential issues in the future if
one core ends up having multiple methods of stopping the watchdog.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f3c28e54d6d6e..b26e6b825a900 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -4285,7 +4285,7 @@ irqreturn_t wm_adsp2_bus_error(struct wm_adsp *dsp)
 
 	if (val & ADSP2_WDT_TIMEOUT_STS_MASK) {
 		adsp_err(dsp, "watchdog timeout error\n");
-		wm_adsp_stop_watchdog(dsp);
+		dsp->ops->stop_watchdog(dsp);
 		wm_adsp_fatal_error(dsp);
 	}
 
@@ -4396,7 +4396,7 @@ irqreturn_t wm_halo_wdt_expire(int irq, void *data)
 	mutex_lock(&dsp->pwr_lock);
 
 	adsp_warn(dsp, "WDT Expiry Fault\n");
-	wm_halo_stop_watchdog(dsp);
+	dsp->ops->stop_watchdog(dsp);
 	wm_adsp_fatal_error(dsp);
 
 	mutex_unlock(&dsp->pwr_lock);
-- 
2.11.0
