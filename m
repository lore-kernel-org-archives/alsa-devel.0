From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 21/53] ALSA: x86: Check platform_data earlier
Date: Thu,  2 Feb 2017 18:02:35 +0100
Message-ID: <20170202170307.24484-23-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B02192668F0
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

Just a minor optimization; check the presence of platform_data earlier
in the probe function before actually starting allocation, which makes
the error path easier.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_lpe_audio.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/x86/intel_hdmi_lpe_audio.c b/sound/x86/intel_hdmi_lpe_audio.c
index b84f7d92ed24..8789f55724da 100644
--- a/sound/x86/intel_hdmi_lpe_audio.c
+++ b/sound/x86/intel_hdmi_lpe_audio.c
@@ -310,6 +310,12 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "Enter %s\n", __func__);
 	dev_dbg(&pdev->dev, "dma_mask: %p\n", pdev->dev.dma_mask);
 
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "%s: quit: pdata not allocated by i915!!\n", __func__);
+		return -EINVAL;
+	}
+
 	/* get resources */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -352,14 +358,6 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	/* assume pipe A as default */
 	ctx->had_config_offset = AUDIO_HDMI_CONFIG_A;
 
-	pdata = pdev->dev.platform_data;
-
-	if (pdata == NULL) {
-		dev_err(&pdev->dev, "%s: quit: pdata not allocated by i915!!\n", __func__);
-		ret = -ENOMEM;
-		goto error_irq;
-	}
-
 	platform_set_drvdata(pdev, ctx);
 
 	/* setup interrupt handler */
-- 
2.11.0
