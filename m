From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/3] imx-ssi: Use a hrtimer in FIQ mode
Date: Thu,  8 Apr 2010 11:31:26 +0200
Message-ID: <1270719086-23453-4-git-send-email-s.hauer@pengutronix.de>
References: <1270719086-23453-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 1F77110382B
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 11:31:29 +0200 (CEST)
In-Reply-To: <1270719086-23453-1-git-send-email-s.hauer@pengutronix.de>
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Valentin Longchamp <valentin.longchamp@epfl.ch>
List-Id: alsa-devel@alsa-project.org

Using a regular timer results in poll times < 1 jiffie with small
buffers, so we loaded the timer with the actual jiffie value. We can
be more accurate using a hrtimer. Also, we have to call
snd_pcm_period_elapsed after playing period_bytes and not
runtime->period_size (which is in samples and not in bytes).

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/imx-pcm-fiq.c |   45 ++++++++++++++++++++----------------------
 1 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-fiq.c b/sound/soc/imx/imx-pcm-fiq.c
index f96a373..2646e05 100644
--- a/sound/soc/imx/imx-pcm-fiq.c
+++ b/sound/soc/imx/imx-pcm-fiq.c
@@ -39,20 +39,17 @@ struct imx_pcm_runtime_data {
 	unsigned long offset;
 	unsigned long last_offset;
 	unsigned long size;
-	struct timer_list timer;
-	int poll_time;
+	struct hrtimer hrt;
+	int poll_time_ns;
+	struct snd_pcm_substream *substream;
 };
 
-static inline void imx_ssi_set_next_poll(struct imx_pcm_runtime_data *iprtd)
+static enum hrtimer_restart snd_hrtimer_callback(struct hrtimer *hrt)
 {
-	iprtd->timer.expires = jiffies + iprtd->poll_time;
-}
-
-static void imx_ssi_timer_callback(unsigned long data)
-{
-	struct snd_pcm_substream *substream = (void *)data;
+	struct imx_pcm_runtime_data *iprtd =
+		container_of(hrt, struct imx_pcm_runtime_data, hrt);
+	struct snd_pcm_substream *substream = iprtd->substream;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
 	struct pt_regs regs;
 	unsigned long delta;
 
@@ -72,16 +69,14 @@ static void imx_ssi_timer_callback(unsigned long data)
 
 	/* If we've transferred at least a period then report it and
 	 * reset our poll time */
-	if (delta >= runtime->period_size) {
+	if (delta >= iprtd->period) {
 		snd_pcm_period_elapsed(substream);
 		iprtd->last_offset = iprtd->offset;
-
-		imx_ssi_set_next_poll(iprtd);
 	}
 
-	/* Restart the timer; if we didn't report we'll run on the next tick */
-	add_timer(&iprtd->timer);
+	hrtimer_forward_now(hrt, ns_to_ktime(iprtd->poll_time_ns));
 
+	return HRTIMER_RESTART;
 }
 
 static struct fiq_handler fh = {
@@ -99,8 +94,8 @@ static int snd_imx_pcm_hw_params(struct snd_pcm_substream *substream,
 	iprtd->period = params_period_bytes(params) ;
 	iprtd->offset = 0;
 	iprtd->last_offset = 0;
-	iprtd->poll_time = HZ / (params_rate(params) / params_period_size(params));
-
+	iprtd->poll_time_ns = 1000000000 / params_rate(params) *
+				params_period_size(params);
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 
 	return 0;
@@ -135,8 +130,8 @@ static int snd_imx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		imx_ssi_set_next_poll(iprtd);
-		add_timer(&iprtd->timer);
+		hrtimer_start(&iprtd->hrt, ns_to_ktime(iprtd->poll_time_ns),
+		      HRTIMER_MODE_REL);
 		if (++fiq_enable == 1)
 			enable_fiq(imx_pcm_fiq);
 
@@ -145,7 +140,7 @@ static int snd_imx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		del_timer(&iprtd->timer);
+		hrtimer_cancel(&iprtd->hrt);
 		if (--fiq_enable == 0)
 			disable_fiq(imx_pcm_fiq);
 
@@ -194,9 +189,10 @@ static int snd_imx_open(struct snd_pcm_substream *substream)
 	iprtd = kzalloc(sizeof(*iprtd), GFP_KERNEL);
 	runtime->private_data = iprtd;
 
-	init_timer(&iprtd->timer);
-	iprtd->timer.data = (unsigned long)substream;
-	iprtd->timer.function = imx_ssi_timer_callback;
+	iprtd->substream = substream;
+
+	hrtimer_init(&iprtd->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	iprtd->hrt.function = snd_hrtimer_callback;
 
 	ret = snd_pcm_hw_constraint_integer(substream->runtime,
 			SNDRV_PCM_HW_PARAM_PERIODS);
@@ -212,7 +208,8 @@ static int snd_imx_close(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
 
-	del_timer_sync(&iprtd->timer);
+	hrtimer_cancel(&iprtd->hrt);
+
 	kfree(iprtd);
 
 	return 0;
-- 
1.7.0
