From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 1/4] ASoC: twl6040: One workqueue should be
	enough
Date: Thu, 29 Sep 2011 15:22:34 +0300
Message-ID: <1317298957-30366-2-git-send-email-peter.ujfalusi@ti.com>
References: <1317298957-30366-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 4652F244FB
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Sep 2011 14:22:43 +0200 (CEST)
Received: by mail-bw0-f45.google.com with SMTP id zv15so840950bkb.18
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2011 05:22:43 -0700 (PDT)
In-Reply-To: <1317298957-30366-1-git-send-email-peter.ujfalusi@ti.com>
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

It is a bit overkill to have three (3) separate
workqueue for a single driver.
We can manage things with one workqueue nicely.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl6040.c |   33 +++++----------------------------
 1 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 5bf305b..91242de 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -103,8 +103,6 @@ struct twl6040_data {
 	struct mutex mutex;
 	struct twl6040_output headset;
 	struct twl6040_output handsfree;
-	struct workqueue_struct *hf_workqueue;
-	struct workqueue_struct *hs_workqueue;
 };
 
 /*
@@ -562,20 +560,17 @@ static int out_drv_event(struct snd_soc_dapm_widget *w,
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 	struct twl6040_output *out;
 	struct delayed_work *work;
-	struct workqueue_struct *queue;
 
 	switch (w->shift) {
 	case 2:
 	case 3:
 		out = &priv->headset;
-		queue = priv->hs_workqueue;
 		out->left_step = priv->hs_left_step;
 		out->right_step = priv->hs_right_step;
 		out->step_delay = 5;	/* 5 ms between volume ramp steps */
 		break;
 	case 4:
 		out = &priv->handsfree;
-		queue = priv->hf_workqueue;
 		out->left_step = priv->hf_left_step;
 		out->right_step = priv->hf_right_step;
 		out->step_delay = 5;	/* 5 ms between volume ramp steps */
@@ -601,7 +596,7 @@ static int out_drv_event(struct snd_soc_dapm_widget *w,
 
 		if (!delayed_work_pending(work)) {
 			out->ramp = TWL6040_RAMP_UP;
-			queue_delayed_work(queue, work,
+			queue_delayed_work(priv->workqueue, work,
 					msecs_to_jiffies(1));
 		}
 		break;
@@ -615,7 +610,7 @@ static int out_drv_event(struct snd_soc_dapm_widget *w,
 			out->ramp = TWL6040_RAMP_DOWN;
 			INIT_COMPLETION(out->ramp_done);
 
-			queue_delayed_work(queue, work,
+			queue_delayed_work(priv->workqueue, work,
 					msecs_to_jiffies(1));
 
 			wait_for_completion_timeout(&out->ramp_done,
@@ -1584,33 +1579,21 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 		goto work_err;
 	}
 
-	priv->workqueue = create_singlethread_workqueue("twl6040-codec");
+	priv->workqueue = alloc_workqueue("twl6040-codec", 0, 0);
 	if (!priv->workqueue) {
 		ret = -ENOMEM;
 		goto work_err;
 	}
 
 	INIT_DELAYED_WORK(&priv->hs_jack.work, twl6040_accessory_work);
+	INIT_DELAYED_WORK(&priv->headset.work, twl6040_pga_hs_work);
+	INIT_DELAYED_WORK(&priv->handsfree.work, twl6040_pga_hf_work);
 
 	mutex_init(&priv->mutex);
 
 	init_completion(&priv->headset.ramp_done);
 	init_completion(&priv->handsfree.ramp_done);
 
-	priv->hf_workqueue = create_singlethread_workqueue("twl6040-hf");
-	if (priv->hf_workqueue == NULL) {
-		ret = -ENOMEM;
-		goto hfwq_err;
-	}
-	priv->hs_workqueue = create_singlethread_workqueue("twl6040-hs");
-	if (priv->hs_workqueue == NULL) {
-		ret = -ENOMEM;
-		goto hswq_err;
-	}
-
-	INIT_DELAYED_WORK(&priv->headset.work, twl6040_pga_hs_work);
-	INIT_DELAYED_WORK(&priv->handsfree.work, twl6040_pga_hf_work);
-
 	ret = request_threaded_irq(priv->plug_irq, NULL, twl6040_audio_handler,
 				   0, "twl6040_irq_plug", codec);
 	if (ret) {
@@ -1634,10 +1617,6 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 bias_err:
 	free_irq(priv->plug_irq, codec);
 plugirq_err:
-	destroy_workqueue(priv->hs_workqueue);
-hswq_err:
-	destroy_workqueue(priv->hf_workqueue);
-hfwq_err:
 	destroy_workqueue(priv->workqueue);
 work_err:
 	kfree(priv);
@@ -1651,8 +1630,6 @@ static int twl6040_remove(struct snd_soc_codec *codec)
 	twl6040_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	free_irq(priv->plug_irq, codec);
 	destroy_workqueue(priv->workqueue);
-	destroy_workqueue(priv->hf_workqueue);
-	destroy_workqueue(priv->hs_workqueue);
 	kfree(priv);
 
 	return 0;
-- 
1.7.6.1
