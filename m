From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/53] ALSA: x86: Drop global hlpe_state
Date: Thu,  2 Feb 2017 18:02:28 +0100
Message-ID: <20170202170307.24484-16-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A69182668DD
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:16 +0100 (CET)
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

Now it's the turn to drop the global hlpe_state variable.  It can be
gracefully embedded in hdmi_lpe_audio_ctx struct.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_lpe_audio.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/sound/x86/intel_hdmi_lpe_audio.c b/sound/x86/intel_hdmi_lpe_audio.c
index 09c21346071c..775a8b947213 100644
--- a/sound/x86/intel_hdmi_lpe_audio.c
+++ b/sound/x86/intel_hdmi_lpe_audio.c
@@ -37,7 +37,6 @@
 #include "intel_hdmi_audio.h"
 
 /* globals*/
-static int hlpe_state;
 static union otm_hdmi_eld_t hlpe_eld;
 
 struct hdmi_lpe_audio_ctx {
@@ -51,6 +50,7 @@ struct hdmi_lpe_audio_ctx {
 	unsigned int had_config_offset;
 	int hdmi_audio_interrupt_mask;
 	struct work_struct hdmi_audio_wq;
+	int state; /* connection state */
 };
 
 static void hdmi_set_eld(void *eld)
@@ -263,10 +263,9 @@ static void notify_audio_lpe(struct platform_device *pdev)
 		dev_dbg(&pdev->dev, "%s: Event: HAD_NOTIFY_HOT_UNPLUG\n",
 			__func__);
 
-		if (hlpe_state == hdmi_connector_status_connected) {
+		if (ctx->state == hdmi_connector_status_connected) {
 
-			hlpe_state =
-				hdmi_connector_status_disconnected;
+			ctx->state = hdmi_connector_status_disconnected;
 
 			mid_hdmi_audio_signal_event(pdev,
 				HAD_EVENT_HOT_UNPLUG);
@@ -297,7 +296,7 @@ static void notify_audio_lpe(struct platform_device *pdev)
 
 		mid_hdmi_audio_signal_event(pdev, HAD_EVENT_HOT_PLUG);
 
-		hlpe_state = hdmi_connector_status_connected;
+		ctx->state = hdmi_connector_status_connected;
 
 		dev_dbg(&pdev->dev, "%s: HAD_NOTIFY_ELD : port = %d, tmds = %d\n",
 			__func__, eld->port_id,	pdata->tmds_clock_speed);
@@ -338,9 +337,6 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "Enter %s\n", __func__);
 
-	/*TBD:remove globals*/
-	hlpe_state = hdmi_connector_status_disconnected;
-
 	/* get resources */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -378,6 +374,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	ctx->mmio_start = mmio_start;
 	ctx->tmds_clock_speed = DIS_SAMPLE_RATE_148_5;
 	INIT_WORK(&ctx->hdmi_audio_wq, _had_wq);
+	ctx->state = hdmi_connector_status_disconnected;
 
 	if (pci_dev_present(cherryview_ids))
 		dev_dbg(&pdev->dev, "%s: Cherrytrail LPE - Detected\n",
@@ -468,9 +465,9 @@ static int hdmi_lpe_audio_suspend(struct platform_device *pdev,
 {
 	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
 
-	dev_dbg(&pdev->dev, "%s: hlpe_state %d",  __func__, hlpe_state);
+	dev_dbg(&pdev->dev, "%s: state %d",  __func__, ctx->state);
 	/* HDMI is not connected, assuming audio device is suspended already */
-	if (hlpe_state != hdmi_connector_status_disconnected)
+	if (ctx->state != hdmi_connector_status_disconnected)
 		hdmi_audio_suspend(ctx->had);
 	return 0;
 }
@@ -479,9 +476,9 @@ static int hdmi_lpe_audio_resume(struct platform_device *pdev)
 {
 	struct hdmi_lpe_audio_ctx *ctx = platform_get_drvdata(pdev);
 
-	dev_dbg(&pdev->dev, "%s: hlpe_state %d",  __func__, hlpe_state);
+	dev_dbg(&pdev->dev, "%s: state %d",  __func__, ctx->state);
 	/* HDMI is not connected, there is no need to resume audio device */
-	if (hlpe_state != hdmi_connector_status_disconnected)
+	if (ctx->state != hdmi_connector_status_disconnected)
 		hdmi_audio_resume(ctx->had);
 	return 0;
 }
-- 
2.11.0
