From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 31/53] ALSA: x86: Fix sleep-in-atomic via i915
	notification
Date: Thu,  2 Feb 2017 18:02:45 +0100
Message-ID: <20170202170307.24484-33-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 94FD626758D
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:17 +0100 (CET)
In-Reply-To: <20170202170307.24484-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

i915 notification is executed in a spinlock, thus it must not sleep;
i.e. we can't use kmalloc with GFP_KERNEL or such.

For making it working properly, move the notification handler in a
work, and handle it gracefully.  We have already such a work, and it
was used just at the start.  This can be re-used in a more generic
hotplug handling.

Also, the patch adds the proper call of cancel_work_sync() to the
destructor.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 51 +++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 28eb980d2d2e..ab199b5deaa5 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1857,14 +1857,6 @@ static struct snd_kcontrol_new had_control_iec958 = {
 	.put =          had_iec958_put
 };
 
-static void _had_wq(struct work_struct *work)
-{
-	struct snd_intelhad *ctx =
-		container_of(work, struct snd_intelhad, hdmi_audio_wq);
-
-	had_process_hot_plug(ctx);
-}
-
 static irqreturn_t display_pipe_interrupt_handler(int irq, void *dev_id)
 {
 	struct snd_intelhad *ctx = dev_id;
@@ -1889,21 +1881,28 @@ static irqreturn_t display_pipe_interrupt_handler(int irq, void *dev_id)
 static void notify_audio_lpe(struct platform_device *pdev)
 {
 	struct snd_intelhad *ctx = platform_get_drvdata(pdev);
-	struct intel_hdmi_lpe_audio_pdata *pdata = pdev->dev.platform_data;
-
-	if (pdata->hdmi_connected != true) {
 
-		dev_dbg(&pdev->dev, "%s: Event: HAD_NOTIFY_HOT_UNPLUG\n",
-			__func__);
+	schedule_work(&ctx->hdmi_audio_wq);
+}
 
-		if (ctx->state == hdmi_connector_status_connected) {
+static void had_audio_wq(struct work_struct *work)
+{
+	struct snd_intelhad *ctx =
+		container_of(work, struct snd_intelhad, hdmi_audio_wq);
+	struct intel_hdmi_lpe_audio_pdata *pdata = ctx->dev->platform_data;
 
-			ctx->state = hdmi_connector_status_disconnected;
+	if (!pdata->hdmi_connected) {
+		dev_dbg(ctx->dev, "%s: Event: HAD_NOTIFY_HOT_UNPLUG\n",
+			__func__);
 
-			had_process_hot_unplug(ctx);
-		} else
-			dev_dbg(&pdev->dev, "%s: Already Unplugged!\n",
+		if (ctx->state != hdmi_connector_status_connected) {
+			dev_dbg(ctx->dev, "%s: Already Unplugged!\n",
 				__func__);
+			return;
+		}
+
+		ctx->state = hdmi_connector_status_disconnected;
+		had_process_hot_unplug(ctx);
 
 	} else {
 		struct intel_hdmi_lpe_audio_eld *eld = &pdata->eld;
@@ -1919,7 +1918,7 @@ static void notify_audio_lpe(struct platform_device *pdev)
 			ctx->had_config_offset = AUDIO_HDMI_CONFIG_C;
 			break;
 		default:
-			dev_dbg(&pdev->dev, "Invalid pipe %d\n",
+			dev_dbg(ctx->dev, "Invalid pipe %d\n",
 				eld->pipe_id);
 			break;
 		}
@@ -1930,7 +1929,7 @@ static void notify_audio_lpe(struct platform_device *pdev)
 
 		ctx->state = hdmi_connector_status_connected;
 
-		dev_dbg(&pdev->dev, "%s: HAD_NOTIFY_ELD : port = %d, tmds = %d\n",
+		dev_dbg(ctx->dev, "%s: HAD_NOTIFY_ELD : port = %d, tmds = %d\n",
 			__func__, eld->port_id,	pdata->tmds_clock_speed);
 
 		if (pdata->tmds_clock_speed) {
@@ -1950,6 +1949,8 @@ static void hdmi_lpe_audio_free(struct snd_card *card)
 {
 	struct snd_intelhad *ctx = card->private_data;
 
+	cancel_work_sync(&ctx->hdmi_audio_wq);
+
 	if (ctx->mmio_start)
 		iounmap(ctx->mmio_start);
 	if (ctx->irq >= 0)
@@ -2013,7 +2014,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 
 	ctx->irq = -1;
 	ctx->tmds_clock_speed = DIS_SAMPLE_RATE_148_5;
-	INIT_WORK(&ctx->hdmi_audio_wq, _had_wq);
+	INIT_WORK(&ctx->hdmi_audio_wq, had_audio_wq);
 	ctx->state = hdmi_connector_status_disconnected;
 
 	card->private_free = hdmi_lpe_audio_free;
@@ -2086,17 +2087,13 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 
 	spin_lock_irqsave(&pdata->lpe_audio_slock, flags);
 	pdata->notify_audio_lpe = notify_audio_lpe;
-	if (pdata->notify_pending) {
-
-		dev_dbg(&pdev->dev, "%s: handle pending notification\n", __func__);
-		notify_audio_lpe(pdev);
-		pdata->notify_pending = false;
-	}
+	pdata->notify_pending = false;
 	spin_unlock_irqrestore(&pdata->lpe_audio_slock, flags);
 
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
+	dev_dbg(&pdev->dev, "%s: handle pending notification\n", __func__);
 	schedule_work(&ctx->hdmi_audio_wq);
 
 	return 0;
-- 
2.11.0
