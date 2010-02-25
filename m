From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Check progress when reporting
	periods from i.MX FIQ handler
Date: Thu, 25 Feb 2010 12:52:10 +0000
Message-ID: <1267102330-13294-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1267102330-13294-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BC5BA10397F
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 13:52:19 +0100 (CET)
In-Reply-To: <1267102330-13294-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Currently the i.MX FIQ handler is reporting periods as elapsed based
purely on a timer running in the CPU. This means that any clock
mismatch between the CPU and the audio subsystem can result in the
status reported to applications drifting away from the actual status
of the hardware. This is particularly likely at present since the
SSI driver is only capable of operating in slave mode so it's very
likely that the interface will be clocked from a different source.

Instead check the offset reported by the FIQ and only notify when we
have transferred at least one period, re-firing the timer if we didn't
do so. Also factor out the calculation of the timer expiry time for
make it a bit easier to experiment with.

Note that this only improves the situation, problems can still be
triggered.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/imx/imx-pcm-fiq.c |   36 ++++++++++++++++++++++++++++++------
 1 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-fiq.c b/sound/soc/imx/imx-pcm-fiq.c
index a1c4ce6..d9cb984 100644
--- a/sound/soc/imx/imx-pcm-fiq.c
+++ b/sound/soc/imx/imx-pcm-fiq.c
@@ -36,17 +36,24 @@ struct imx_pcm_runtime_data {
 	int period;
 	int periods;
 	unsigned long offset;
+	unsigned long last_offset;
 	unsigned long size;
 	struct timer_list timer;
-	int period_time;
+	int poll_time;
 };
 
+static inline void imx_ssi_set_next_poll(struct imx_pcm_runtime_data *iprtd)
+{
+	iprtd->timer.expires = jiffies + iprtd->poll_time;
+}
+
 static void imx_ssi_timer_callback(unsigned long data)
 {
 	struct snd_pcm_substream *substream = (void *)data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct imx_pcm_runtime_data *iprtd = runtime->private_data;
 	struct pt_regs regs;
+	unsigned long delta;
 
 	get_fiq_regs(&regs);
 
@@ -55,9 +62,25 @@ static void imx_ssi_timer_callback(unsigned long data)
 	else
 		iprtd->offset = regs.ARM_r9 & 0xffff;
 
-	iprtd->timer.expires = jiffies + iprtd->period_time;
+	/* How much data have we transferred since the last period report? */
+	if (iprtd->offset >= iprtd->last_offset)
+		delta = iprtd->offset - iprtd->last_offset;
+	else
+		delta = runtime->buffer_size + iprtd->offset
+			- iprtd->last_offset;
+
+	/* If we've transferred at least a period then report it and
+	 * reset our poll time */
+	if (delta >= runtime->period_size) {
+		snd_pcm_period_elapsed(substream);
+		iprtd->last_offset = iprtd->offset;
+
+		imx_ssi_set_next_poll(iprtd);
+	}
+
+	/* Restart the timer; if we didn't report we'll run on the next tick */
 	add_timer(&iprtd->timer);
-	snd_pcm_period_elapsed(substream);
+
 }
 
 static struct fiq_handler fh = {
@@ -72,9 +95,10 @@ static int snd_imx_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	iprtd->size = params_buffer_bytes(params);
 	iprtd->periods = params_periods(params);
-	iprtd->period = params_period_bytes(params);
+	iprtd->period = params_period_bytes(params) ;
 	iprtd->offset = 0;
-	iprtd->period_time = HZ / (params_rate(params) / params_period_size(params));
+	iprtd->last_offset = 0;
+	iprtd->poll_time = HZ / (params_rate(params) / params_period_size(params));
 
 	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
 
@@ -110,7 +134,7 @@ static int snd_imx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		iprtd->timer.expires = jiffies + iprtd->period_time;
+		imx_ssi_set_next_poll(iprtd);
 		add_timer(&iprtd->timer);
 		if (++fiq_enable == 1)
 			enable_fiq(imx_pcm_fiq);
-- 
1.7.0
