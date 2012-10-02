From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-abe-twl6040: Fix typo of Vibrator
Date: Tue,  2 Oct 2012 15:31:16 +0300
Message-ID: <1349181076-31402-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog117.obsmtp.com (na3sys009aog117.obsmtp.com
 [74.125.149.242])
 by alsa0.perex.cz (Postfix) with ESMTP id E9E1F261600
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2012 14:30:16 +0200 (CEST)
Received: by obblz20 with SMTP id lz20so6280792obb.38
 for <alsa-devel@alsa-project.org>; Tue, 02 Oct 2012 05:30:15 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It is not Vinrator but Vibrator.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-abe-twl6040.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
index be525df..750d595 100644
--- a/sound/soc/omap/omap-abe-twl6040.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -220,7 +220,7 @@ static int omap_abe_twl6040_init(struct snd_soc_pcm_runtime *rtd)
 	twl6040_disconnect_pin(dapm, pdata->has_hf, "Ext Spk");
 	twl6040_disconnect_pin(dapm, pdata->has_ep, "Earphone Spk");
 	twl6040_disconnect_pin(dapm, pdata->has_aux, "Line Out");
-	twl6040_disconnect_pin(dapm, pdata->has_vibra, "Vinrator");
+	twl6040_disconnect_pin(dapm, pdata->has_vibra, "Vibrator");
 	twl6040_disconnect_pin(dapm, pdata->has_hsmic, "Headset Mic");
 	twl6040_disconnect_pin(dapm, pdata->has_mainmic, "Main Handset Mic");
 	twl6040_disconnect_pin(dapm, pdata->has_submic, "Sub Handset Mic");
-- 
1.7.12
