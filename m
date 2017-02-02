From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 18/53] ALSA: x86: Move dma_mask debug print
	into intel_hdmi_lpe_audio.c
Date: Thu,  2 Feb 2017 18:02:32 +0100
Message-ID: <20170202170307.24484-20-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E22AF267564
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

It belongs to the right place.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c     | 11 -----------
 sound/x86/intel_hdmi_lpe_audio.c |  1 +
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index efc56544af17..49cb95072a88 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1600,8 +1600,6 @@ int hdmi_audio_probe(struct platform_device *devptr,
 
 	pr_debug("Enter %s\n", __func__);
 
-	pr_debug("hdmi_audio_probe dma_mask: %p\n", devptr->dev.dma_mask);
-
 	/* allocate memory for saving internal context and working */
 	intelhaddata = kzalloc(sizeof(*intelhaddata), GFP_KERNEL);
 	if (!intelhaddata)
@@ -1653,15 +1651,6 @@ int hdmi_audio_probe(struct platform_device *devptr,
 	retval = snd_pcm_lib_preallocate_pages_for_all(pcm,
 			SNDRV_DMA_TYPE_DEV, NULL,
 			HAD_MAX_BUFFER, HAD_MAX_BUFFER);
-
-	if (card->dev == NULL)
-		pr_debug("card->dev is NULL!!!!! Should not be this case\n");
-	else if (card->dev->dma_mask == NULL)
-		pr_debug("hdmi_audio_probe dma_mask is NULL!!!!!\n");
-	else
-		pr_debug("hdmi_audio_probe dma_mask is : %p\n",
-				card->dev->dma_mask);
-
 	if (retval)
 		goto err;
 
diff --git a/sound/x86/intel_hdmi_lpe_audio.c b/sound/x86/intel_hdmi_lpe_audio.c
index 53864d372861..6f823d4278bb 100644
--- a/sound/x86/intel_hdmi_lpe_audio.c
+++ b/sound/x86/intel_hdmi_lpe_audio.c
@@ -315,6 +315,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	};
 
 	dev_dbg(&pdev->dev, "Enter %s\n", __func__);
+	dev_dbg(&pdev->dev, "dma_mask: %p\n", pdev->dev.dma_mask);
 
 	/* get resources */
 	irq = platform_get_irq(pdev, 0);
-- 
2.11.0
