From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 32/53] ALSA: x86: Remove superfluous check at
	resume
Date: Thu,  2 Feb 2017 18:02:46 +0100
Message-ID: <20170202170307.24484-34-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 74912267588
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

The had_get_hwstate() is identical with drv_status==DISCONECTED, which
was already checked before the call.  And, returning an error at
resume is simply bad.  That is, we should just kill this check.

Also, spewing an error at resume for drv_status!=SUSPENDED is also
annoying, as this is the normal case when the suspend was called
without the monitor connection.  Make it debug, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index ab199b5deaa5..835e0f2c4f0b 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1454,7 +1454,6 @@ static int hdmi_lpe_audio_suspend(struct platform_device *pdev,
 		return -EAGAIN;
 	}
 
-
 	spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
 	if (intelhaddata->drv_status == HAD_DRV_DISCONNECTED) {
 		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
@@ -1500,17 +1499,10 @@ static int hdmi_lpe_audio_resume(struct platform_device *pdev)
 
 	if (intelhaddata->drv_status != HAD_DRV_SUSPENDED) {
 		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-		dev_err(intelhaddata->dev, "had is not in suspended state\n");
+		dev_dbg(intelhaddata->dev, "had is not in suspended state\n");
 		return 0;
 	}
 
-	if (had_get_hwstate(intelhaddata)) {
-		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
-		dev_err(intelhaddata->dev,
-			"Failed to resume. Device not accessible\n");
-		return -ENODEV;
-	}
-
 	intelhaddata->drv_status = HAD_DRV_CONNECTED;
 	dev_dbg(intelhaddata->dev,
 		"%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_DISCONNECTED\n",
-- 
2.11.0
