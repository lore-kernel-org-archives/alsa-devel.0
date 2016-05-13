From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 5/5] ASoC: arizona: Add event notification on
	voice trigger events
Date: Fri, 13 May 2016 16:45:19 +0100
Message-ID: <1463154319-10070-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1463154319-10070-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id BE440260564
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 17:45:14 +0200 (CEST)
In-Reply-To: <1463154319-10070-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Inform the notifier chain if the DSP recognises a voice trigger.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.h | 3 +++
 sound/soc/codecs/cs47l24.c | 4 ++++
 sound/soc/codecs/wm5110.c  | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index e8d67d0..ef38413 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -63,6 +63,9 @@
 #define ARIZONA_DVFS_SR1_RQ	0x001
 #define ARIZONA_DVFS_ADSP1_RQ	0x100
 
+/* Notifier events */
+#define ARIZONA_NOTIFY_VOICE_TRIGGER   0x1
+
 struct arizona;
 struct wm_adsp;
 
diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 489709d..b4d05cf 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1085,6 +1085,10 @@ static irqreturn_t cs47l24_adsp2_irq(int irq, void *data)
 		ret = wm_adsp_compr_handle_irq(&priv->core.adsp[i]);
 		if (ret != -ENODEV)
 			serviced++;
+		if (ret == WM_ADSP_COMPR_VOICE_TRIGGER)
+			arizona_call_notifiers(arizona,
+					       ARIZONA_NOTIFY_VOICE_TRIGGER,
+					       (void *)i);
 	}
 
 	if (!serviced) {
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 1c8b559..f1b3294 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2240,6 +2240,10 @@ static irqreturn_t wm5110_adsp2_irq(int irq, void *data)
 		ret = wm_adsp_compr_handle_irq(&priv->core.adsp[i]);
 		if (ret != -ENODEV)
 			serviced++;
+		if (ret == WM_ADSP_COMPR_VOICE_TRIGGER)
+			arizona_call_notifiers(arizona,
+					       ARIZONA_NOTIFY_VOICE_TRIGGER,
+					       (void *)i);
 	}
 
 	if (!serviced) {
-- 
2.1.4
