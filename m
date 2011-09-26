From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 03/10] ASoC: twl6040: Move delayed_work struct
	inside twl6040_output for HS/HF
Date: Mon, 26 Sep 2011 16:26:26 +0300
Message-ID: <1317043593-27202-4-git-send-email-peter.ujfalusi@ti.com>
References: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 176FA243A9
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 15:26:49 +0200 (CEST)
Received: by mail-bw0-f41.google.com with SMTP id zs2so5836740bkb.28
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 06:26:49 -0700 (PDT)
In-Reply-To: <1317043593-27202-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

The delayed works for the output can be moved within the
twl6040_output struct (from the twl6040_data) to be better
organized.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 0fd8719..c5232ce 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -72,6 +72,7 @@ struct twl6040_output {
 	u16 right_step;
 	unsigned int step_delay;
 	u16 ramp;
+	struct delayed_work work;
 	struct completion ramp_done;
 };
 
@@ -104,8 +105,6 @@ struct twl6040_data {
 	struct twl6040_output handsfree;
 	struct workqueue_struct *hf_workqueue;
 	struct workqueue_struct *hs_workqueue;
-	struct delayed_work hs_delayed_work;
-	struct delayed_work hf_delayed_work;
 };
 
 /*
@@ -489,7 +488,7 @@ static inline int twl6040_hf_ramp_step(struct snd_soc_codec *codec,
 static void twl6040_pga_hs_work(struct work_struct *work)
 {
 	struct twl6040_data *priv =
-		container_of(work, struct twl6040_data, hs_delayed_work.work);
+		container_of(work, struct twl6040_data, headset.work.work);
 	struct snd_soc_codec *codec = priv->codec;
 	struct twl6040_output *headset = &priv->headset;
 	unsigned int delay = headset->step_delay;
@@ -532,7 +531,7 @@ static void twl6040_pga_hs_work(struct work_struct *work)
 static void twl6040_pga_hf_work(struct work_struct *work)
 {
 	struct twl6040_data *priv =
-		container_of(work, struct twl6040_data, hf_delayed_work.work);
+		container_of(work, struct twl6040_data, handsfree.work.work);
 	struct snd_soc_codec *codec = priv->codec;
 	struct twl6040_output *handsfree = &priv->handsfree;
 	unsigned int delay = handsfree->step_delay;
@@ -585,7 +584,6 @@ static int out_drv_event(struct snd_soc_dapm_widget *w,
 	case 2:
 	case 3:
 		out = &priv->headset;
-		work = &priv->hs_delayed_work;
 		queue = priv->hs_workqueue;
 		out->left_step = priv->hs_left_step;
 		out->right_step = priv->hs_right_step;
@@ -593,7 +591,6 @@ static int out_drv_event(struct snd_soc_dapm_widget *w,
 		break;
 	case 4:
 		out = &priv->handsfree;
-		work = &priv->hf_delayed_work;
 		queue = priv->hf_workqueue;
 		out->left_step = priv->hf_left_step;
 		out->right_step = priv->hf_right_step;
@@ -607,6 +604,8 @@ static int out_drv_event(struct snd_soc_dapm_widget *w,
 		return -1;
 	}
 
+	work = &out->work;
+
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		if (out->active)
@@ -1625,8 +1624,8 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 		goto hswq_err;
 	}
 
-	INIT_DELAYED_WORK(&priv->hs_delayed_work, twl6040_pga_hs_work);
-	INIT_DELAYED_WORK(&priv->hf_delayed_work, twl6040_pga_hf_work);
+	INIT_DELAYED_WORK(&priv->headset.work, twl6040_pga_hs_work);
+	INIT_DELAYED_WORK(&priv->handsfree.work, twl6040_pga_hf_work);
 
 	ret = request_threaded_irq(priv->plug_irq, NULL, twl6040_audio_handler,
 				   0, "twl6040_irq_plug", codec);
-- 
1.7.6.1
