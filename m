From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 49/53] ALSA: x86: Create ELD control element
Date: Thu,  2 Feb 2017 18:03:03 +0100
Message-ID: <20170202170307.24484-51-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B00CB2675AB
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:18 +0100 (CET)
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

Like other drivers, expose the ELD bytes via a control element so that
user-space can parse it.

For the simplicity, the code to register the ctl elements is
refactored using an array.  Also, since ELD ctl read copies the bytes
also during disconnection, clear the ELD bytes at hot-unplug, in order
to avoid the leak of the previous bogus ELD.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 72 +++++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 21 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 82f48fbcd74b..f49520117dd6 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1669,22 +1669,52 @@ static int had_iec958_put(struct snd_kcontrol *kcontrol,
 	return changed;
 }
 
-static struct snd_kcontrol_new had_control_iec958_mask = {
-	.access =   SNDRV_CTL_ELEM_ACCESS_READ,
-	.iface =    SNDRV_CTL_ELEM_IFACE_PCM,
-	.name =     SNDRV_CTL_NAME_IEC958("", PLAYBACK, MASK),
-	.info =     had_iec958_info, /* shared */
-	.get =      had_iec958_mask_get,
-};
+static int had_ctl_eld_info(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	uinfo->count = HDMI_MAX_ELD_BYTES;
+	return 0;
+}
 
-static struct snd_kcontrol_new had_control_iec958 = {
-	.iface =    SNDRV_CTL_ELEM_IFACE_PCM,
-	.name =         SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
-	.info =         had_iec958_info,
-	.get =          had_iec958_get,
-	.put =          had_iec958_put
+static int had_ctl_eld_get(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_intelhad *intelhaddata = snd_kcontrol_chip(kcontrol);
+
+	mutex_lock(&intelhaddata->mutex);
+	memcpy(ucontrol->value.bytes.data, intelhaddata->eld,
+	       HDMI_MAX_ELD_BYTES);
+	mutex_unlock(&intelhaddata->mutex);
+	return 0;
+}
+
+static struct snd_kcontrol_new had_controls[] = {
+	{
+		.access = SNDRV_CTL_ELEM_ACCESS_READ,
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, MASK),
+		.info = had_iec958_info, /* shared */
+		.get = had_iec958_mask_get,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
+		.info = had_iec958_info,
+		.get = had_iec958_get,
+		.put = had_iec958_put,
+	},
+	{
+		.access = (SNDRV_CTL_ELEM_ACCESS_READ |
+			   SNDRV_CTL_ELEM_ACCESS_VOLATILE),
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = "ELD",
+		.info = had_ctl_eld_info,
+		.get = had_ctl_eld_get,
+	},
 };
 
+
 static irqreturn_t display_pipe_interrupt_handler(int irq, void *dev_id)
 {
 	struct snd_intelhad *ctx = dev_id;
@@ -1724,6 +1754,7 @@ static void had_audio_wq(struct work_struct *work)
 	if (!pdata->hdmi_connected) {
 		dev_dbg(ctx->dev, "%s: Event: HAD_NOTIFY_HOT_UNPLUG\n",
 			__func__);
+		memset(ctx->eld, 0, sizeof(ctx->eld)); /* clear the old ELD */
 		had_process_hot_unplug(ctx);
 	} else {
 		struct intel_hdmi_lpe_audio_eld *eld = &pdata->eld;
@@ -1826,7 +1857,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	struct intel_hdmi_lpe_audio_pdata *pdata;
 	int irq;
 	struct resource *res_mmio;
-	int ret;
+	int i, ret;
 
 	dev_dbg(&pdev->dev, "dma_mask: %p\n", pdev->dev.dma_mask);
 
@@ -1918,13 +1949,12 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 			SNDRV_DMA_TYPE_DEV, NULL,
 			HAD_MAX_BUFFER, HAD_MAX_BUFFER);
 
-	/* IEC958 controls */
-	ret = snd_ctl_add(card, snd_ctl_new1(&had_control_iec958_mask, ctx));
-	if (ret < 0)
-		goto err;
-	ret = snd_ctl_add(card, snd_ctl_new1(&had_control_iec958, ctx));
-	if (ret < 0)
-		goto err;
+	/* create controls */
+	for (i = 0; i < ARRAY_SIZE(had_controls); i++) {
+		ret = snd_ctl_add(card, snd_ctl_new1(&had_controls[i], ctx));
+		if (ret < 0)
+			goto err;
+	}
 
 	init_channel_allocations();
 
-- 
2.11.0
