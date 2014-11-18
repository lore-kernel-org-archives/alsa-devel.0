From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm_adsp: Move core_ena to be co-located
	with start bit
Date: Tue, 18 Nov 2014 16:25:27 +0000
Message-ID: <1416327927-8559-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 93DFB26047F
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 17:33:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Many firmwares do not wait for the start bit before they begin
processing audio, whilst this is a bug on the firmware side there are
too many such firmwares in the wild to ignore the situation. This patch
moves the core enable to happen at same time as the start, the firmware
looses the ability to overlap its own startup with the audio path bring
up but we ensure that all firmwares behave.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index e54d7b5..720d6e8 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1593,13 +1593,6 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 	if (ret != 0)
 		goto err;
 
-	ret = regmap_update_bits_async(dsp->regmap,
-				       dsp->base + ADSP2_CONTROL,
-				       ADSP2_CORE_ENA,
-				       ADSP2_CORE_ENA);
-	if (ret != 0)
-		goto err;
-
 	dsp->running = true;
 
 	return;
@@ -1649,8 +1642,8 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 
 		ret = regmap_update_bits(dsp->regmap,
 					 dsp->base + ADSP2_CONTROL,
-					 ADSP2_START,
-					 ADSP2_START);
+					 ADSP2_CORE_ENA | ADSP2_START,
+					 ADSP2_CORE_ENA | ADSP2_START);
 		if (ret != 0)
 			goto err;
 		break;
-- 
1.7.2.5
