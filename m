From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_hubs: Push check for idle_bias_off
	out into drivers
Date: Tue, 31 Jan 2012 16:17:22 +0000
Message-ID: <1328026642-23291-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A8B69246BD
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 17:17:43 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

For later wm_hubs devices we have much less need to keep the biases up
even when using single ended line outputs so flag idle_bias_off for
everything except the WM8993 and WM8994.
---
 sound/soc/codecs/wm8993.c  |    6 ++++++
 sound/soc/codecs/wm8994.c  |    8 ++++++++
 sound/soc/codecs/wm_hubs.c |    6 ------
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8993.c b/sound/soc/codecs/wm8993.c
index 474dc72..db51007 100644
--- a/sound/soc/codecs/wm8993.c
+++ b/sound/soc/codecs/wm8993.c
@@ -1622,6 +1622,12 @@ static int wm8993_probe(struct snd_soc_codec *codec)
 	wm_hubs_add_analogue_routes(codec, wm8993->pdata.lineout1_diff,
 				    wm8993->pdata.lineout2_diff);
 
+	/* If the line outputs are differential then we aren't presenting
+	 * VMID as an output and can disable it.
+	 */
+	if (wm8993->pdata.lineout1_diff && wm8993->pdata.lineout2_diff)
+		codec->dapm.idle_bias_off = 1;
+
 	return 0;
 
 }
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index ca2db79..09641d7 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3368,10 +3368,18 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	pm_runtime_enable(codec->dev);
 	pm_runtime_resume(codec->dev);
 
+	/* By default use idle_bias_off, will override for WM8994 */
+	codec->dapm.idle_bias_off = 1;
+
 	/* Set revision-specific configuration */
 	wm8994->revision = snd_soc_read(codec, WM8994_CHIP_REVISION);
 	switch (control->type) {
 	case WM8994:
+		/* Single ended line outputs should have VMID on. */
+		if (!wm8994->pdata->lineout1_diff ||
+		    !wm8994->pdata->lineout2_diff)
+			codec->dapm.idle_bias_off = 0;
+
 		switch (wm8994->revision) {
 		case 2:
 		case 3:
diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index c1a3f8c..57514dd2 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -958,12 +958,6 @@ int wm_hubs_handle_analogue_pdata(struct snd_soc_codec *codec,
 				    WM8993_LINEOUT2_MODE,
 				    WM8993_LINEOUT2_MODE);
 
-	/* If the line outputs are differential then we aren't presenting
-	 * VMID as an output and can disable it.
-	 */
-	if (lineout1_diff && lineout2_diff)
-		codec->dapm.idle_bias_off = 1;
-
 	if (lineout1fb)
 		snd_soc_update_bits(codec, WM8993_ADDITIONAL_CONTROL,
 				    WM8993_LINEOUT1_FB, WM8993_LINEOUT1_FB);
-- 
1.7.9.rc1
