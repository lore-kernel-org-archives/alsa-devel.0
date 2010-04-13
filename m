From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/2] imx-ssi: do not call hrtimer_disable in
	trigger function
Date: Tue, 13 Apr 2010 16:38:08 +0200
Message-ID: <1271169489-339-2-git-send-email-s.hauer@pengutronix.de>
References: <1271169489-339-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id EBF001037FF
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 16:38:13 +0200 (CEST)
In-Reply-To: <1271169489-339-1-git-send-email-s.hauer@pengutronix.de>
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

This causes a deadlock.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/imx-pcm-fiq.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-fiq.c b/sound/soc/imx/imx-pcm-fiq.c
index 64df813..4b694d5 100644
--- a/sound/soc/imx/imx-pcm-fiq.c
+++ b/sound/soc/imx/imx-pcm-fiq.c
@@ -41,6 +41,7 @@ struct imx_pcm_runtime_data {
 	struct hrtimer hrt;
 	int poll_time_ns;
 	struct snd_pcm_substream *substream;
+	atomic_t running;
 };
 
 static enum hrtimer_restart snd_hrtimer_callback(struct hrtimer *hrt)
@@ -52,6 +53,9 @@ static enum hrtimer_restart snd_hrtimer_callback(struct hrtimer *hrt)
 	struct pt_regs regs;
 	unsigned long delta;
 
+	if (!atomic_read(&iprtd->running))
+		return HRTIMER_NORESTART;
+
 	get_fiq_regs(&regs);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -129,6 +133,7 @@ static int snd_imx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		atomic_set(&iprtd->running, 1);
 		hrtimer_start(&iprtd->hrt, ns_to_ktime(iprtd->poll_time_ns),
 		      HRTIMER_MODE_REL);
 		if (++fiq_enable == 1)
@@ -139,11 +144,11 @@ static int snd_imx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		hrtimer_cancel(&iprtd->hrt);
+		atomic_set(&iprtd->running, 0);
+
 		if (--fiq_enable == 0)
 			disable_fiq(imx_pcm_fiq);
 
-
 		break;
 	default:
 		return -EINVAL;
@@ -190,6 +195,7 @@ static int snd_imx_open(struct snd_pcm_substream *substream)
 
 	iprtd->substream = substream;
 
+	atomic_set(&iprtd->running, 0);
 	hrtimer_init(&iprtd->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	iprtd->hrt.function = snd_hrtimer_callback;
 
-- 
1.7.0
