From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/53] ALSA: x86: Fix possible stale interrupt
	calls
Date: Thu,  2 Feb 2017 18:02:25 +0100
Message-ID: <20170202170307.24484-13-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BB8922668C6
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:15 +0100 (CET)
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

Registering the irq handler at the too early place may cause a system
stall because the irq handler may be triggered before the other
initializations.  Move the irq handler registration to the later point.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_lpe_audio.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/x86/intel_hdmi_lpe_audio.c b/sound/x86/intel_hdmi_lpe_audio.c
index 54cc30f034f3..f5249b0a4ce4 100644
--- a/sound/x86/intel_hdmi_lpe_audio.c
+++ b/sound/x86/intel_hdmi_lpe_audio.c
@@ -400,16 +400,6 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 		return -EACCES;
 	}
 
-	/* setup interrupt handler */
-	ret = request_irq(irq, display_pipe_interrupt_handler,
-			0,
-			pdev->name,
-			NULL);
-	if (ret < 0) {
-		dev_err(&hlpe_pdev->dev, "request_irq failed\n");
-		goto error_irq;
-	}
-
 	/* alloc and save context */
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (ctx == NULL) {
@@ -438,11 +428,21 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	if (pdata == NULL) {
 		dev_err(&hlpe_pdev->dev, "%s: quit: pdata not allocated by i915!!\n", __func__);
 		ret = -ENOMEM;
-		goto error_probe;
+		goto error_irq;
 	}
 
 	platform_set_drvdata(pdev, ctx);
 
+	/* setup interrupt handler */
+	ret = request_irq(irq, display_pipe_interrupt_handler,
+			0,
+			pdev->name,
+			NULL);
+	if (ret < 0) {
+		dev_err(&hlpe_pdev->dev, "request_irq failed\n");
+		goto error_irq;
+	}
+
 	ret = hdmi_audio_probe(pdev, &ctx->had);
 	if (ret < 0)
 		goto error_probe;
@@ -469,10 +469,10 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	return ret;
 
  error_probe:
-	kfree(ctx);
- error_ctx:
 	free_irq(irq, NULL);
  error_irq:
+	kfree(ctx);
+ error_ctx:
 	iounmap(mmio_start);
 	return ret;
 }
-- 
2.11.0
