From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/53] ALSA: x86: Handle the error from
	hdmi_audio_probe() properly
Date: Thu,  2 Feb 2017 18:02:22 +0100
Message-ID: <20170202170307.24484-10-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 834E32667E0
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

The error from hdmi_audio_probe() wasn't handled properly, and it may
leave some resources leaked or mapped.  Fix it and also clean up the
error paths.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_lpe_audio.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/sound/x86/intel_hdmi_lpe_audio.c b/sound/x86/intel_hdmi_lpe_audio.c
index 18a2ae6796b8..0c11d82eb99b 100644
--- a/sound/x86/intel_hdmi_lpe_audio.c
+++ b/sound/x86/intel_hdmi_lpe_audio.c
@@ -422,16 +422,14 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 			NULL);
 	if (ret < 0) {
 		dev_err(&hlpe_pdev->dev, "request_irq failed\n");
-		iounmap(mmio_start);
-		return -ENODEV;
+		goto error_irq;
 	}
 
 	/* alloc and save context */
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (ctx == NULL) {
-		free_irq(irq, NULL);
-		iounmap(mmio_start);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto error_ctx;
 	}
 
 	ctx->irq = irq;
@@ -454,15 +452,16 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 
 	if (pdata == NULL) {
 		dev_err(&hlpe_pdev->dev, "%s: quit: pdata not allocated by i915!!\n", __func__);
-		kfree(ctx);
-		free_irq(irq, NULL);
-		iounmap(mmio_start);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto error_probe;
 	}
 
 	platform_set_drvdata(pdev, ctx);
 
 	ret = hdmi_audio_probe(pdev, &ctx->had);
+	if (ret < 0)
+		goto error_probe;
+
 	dev_dbg(&hlpe_pdev->dev, "hdmi lpe audio: setting pin eld notify callback\n");
 
 	/* The Audio driver is loading now and we need to notify
@@ -483,6 +482,14 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	spin_unlock_irqrestore(&pdata->lpe_audio_slock, flag_irq);
 
 	return ret;
+
+ error_probe:
+	kfree(ctx);
+ error_ctx:
+	free_irq(irq, NULL);
+ error_irq:
+	iounmap(mmio_start);
+	return ret;
 }
 
 /**
-- 
2.11.0
