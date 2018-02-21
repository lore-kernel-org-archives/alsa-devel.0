From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: x86: hdmi: Add single_port option for
	compatible behavior
Date: Wed, 21 Feb 2018 16:53:56 +0100
Message-ID: <20180221155356.22886-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BA7DE2675EE
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 18:49:03 +0100 (CET)
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
Cc: Hubert Mantel <mantel@metadox.de>
List-Id: alsa-devel@alsa-project.org

The recent support for the multiple PCM devices allowed user to use
multiple HDMI/DP outputs, but at the same time, the PCM stream
assignment has been changed, too.  Due to that, the former PCM#0
(there was only one stream in the past) is likely assigned to a
different one (e.g. PCM#2), and it ends up with the regression when
user sticks with the fixed configuration using the device#0.

Although the multiple monitor support shouldn't matter when user
deploys the backend like PulseAudio that checks the jack detection
state, the behavior change isn't always acceptable for some users.

As a mitigation, this patch introduces an option to switch the
behavior back to the old-good-days: when the new option,
single_port=1, is passed, the driver creates only a single PCM device,
and it's assigned to the first connected one, like the earlier
versions did.  The option is turned off as default still to support
the multiple monitors.

Fixes: 8a2d6ae1f737 ("ALSA: x86: Register multiple PCM devices for the LPE audio card")
Reported-and-tested-by: Hubert Mantel <mantel@metadox.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index a0951505c7f5..96115c401292 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -50,6 +50,7 @@
 /*standard module options for ALSA. This module supports only one card*/
 static int hdmi_card_index = SNDRV_DEFAULT_IDX1;
 static char *hdmi_card_id = SNDRV_DEFAULT_STR1;
+static bool single_port;
 
 module_param_named(index, hdmi_card_index, int, 0444);
 MODULE_PARM_DESC(index,
@@ -57,6 +58,9 @@ MODULE_PARM_DESC(index,
 module_param_named(id, hdmi_card_id, charp, 0444);
 MODULE_PARM_DESC(id,
 		"ID string for INTEL Intel HDMI Audio controller.");
+module_param(single_port, bool, 0444);
+MODULE_PARM_DESC(single_port,
+		"Single-port mode (for compatibility)");
 
 /*
  * ELD SA bits in the CEA Speaker Allocation data block
@@ -1579,7 +1583,11 @@ static irqreturn_t display_pipe_interrupt_handler(int irq, void *dev_id)
 static void notify_audio_lpe(struct platform_device *pdev, int port)
 {
 	struct snd_intelhad_card *card_ctx = platform_get_drvdata(pdev);
-	struct snd_intelhad *ctx = &card_ctx->pcm_ctx[port];
+	struct snd_intelhad *ctx;
+
+	ctx = &card_ctx->pcm_ctx[single_port ? 0 : port];
+	if (single_port)
+		ctx->port = port;
 
 	schedule_work(&ctx->hdmi_audio_wq);
 }
@@ -1816,7 +1824,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	init_channel_allocations();
 
 	card_ctx->num_pipes = pdata->num_pipes;
-	card_ctx->num_ports = pdata->num_ports;
+	card_ctx->num_ports = single_port ? 1 : pdata->num_ports;
 
 	for_each_port(card_ctx, port) {
 		struct snd_intelhad *ctx = &card_ctx->pcm_ctx[port];
@@ -1824,7 +1832,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 
 		ctx->card_ctx = card_ctx;
 		ctx->dev = card_ctx->dev;
-		ctx->port = port;
+		ctx->port = single_port ? -1 : port;
 		ctx->pipe = -1;
 
 		INIT_WORK(&ctx->hdmi_audio_wq, had_audio_wq);
-- 
2.16.1
