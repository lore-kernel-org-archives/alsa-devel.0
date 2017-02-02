From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 20/53] ALSA: x86: Drop superfluous CHT PCI ID
	check
Date: Thu,  2 Feb 2017 18:02:34 +0100
Message-ID: <20170202170307.24484-22-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 26FF8267584
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

Since the config base offset is now set per pipe id, we don't have to
check Cherry Trail PCI IDs any longer.  Currently it's used only for
debug prints.  Let's drop it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_lpe_audio.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/sound/x86/intel_hdmi_lpe_audio.c b/sound/x86/intel_hdmi_lpe_audio.c
index 6f823d4278bb..b84f7d92ed24 100644
--- a/sound/x86/intel_hdmi_lpe_audio.c
+++ b/sound/x86/intel_hdmi_lpe_audio.c
@@ -306,13 +306,6 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	void __iomem *mmio_start;
 	int ret = 0;
 	unsigned long flag_irq;
-	static const struct pci_device_id cherryview_ids[] = {
-		{PCI_DEVICE(0x8086, 0x22b0)},
-		{PCI_DEVICE(0x8086, 0x22b1)},
-		{PCI_DEVICE(0x8086, 0x22b2)},
-		{PCI_DEVICE(0x8086, 0x22b3)},
-		{}
-	};
 
 	dev_dbg(&pdev->dev, "Enter %s\n", __func__);
 	dev_dbg(&pdev->dev, "dma_mask: %p\n", pdev->dev.dma_mask);
@@ -356,13 +349,6 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	INIT_WORK(&ctx->hdmi_audio_wq, _had_wq);
 	ctx->state = hdmi_connector_status_disconnected;
 
-	if (pci_dev_present(cherryview_ids))
-		dev_dbg(&pdev->dev, "%s: Cherrytrail LPE - Detected\n",
-				__func__);
-	else
-		dev_dbg(&pdev->dev, "%s: Baytrail LPE - Assume\n",
-				__func__);
-
 	/* assume pipe A as default */
 	ctx->had_config_offset = AUDIO_HDMI_CONFIG_A;
 
-- 
2.11.0
