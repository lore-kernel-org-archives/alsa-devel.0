From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 22/53] ALSA: x86: Call snd_card_register() at
	the end
Date: Thu,  2 Feb 2017 18:02:36 +0100
Message-ID: <20170202170307.24484-24-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E651526758F
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

The card registration should be done at the last stage of the probe
procedure.  Otherwise user-space may access to the device before the
whole initialization is done.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index dfc4452afee1..82f42a6c363c 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1586,6 +1586,7 @@ int hdmi_audio_probe(struct platform_device *devptr,
 	pr_debug("%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_DISCONNECTED\n",
 			__func__, __LINE__);
 
+	intelhaddata->dev = &devptr->dev;
 	intelhaddata->card = card;
 	intelhaddata->card_id = hdmi_card_id;
 	intelhaddata->card_index = card->number;
@@ -1617,10 +1618,6 @@ int hdmi_audio_probe(struct platform_device *devptr,
 	if (retval)
 		goto err;
 
-	retval = snd_card_register(card);
-	if (retval)
-		goto err;
-
 	/* IEC958 controls */
 	retval = snd_ctl_add(card, snd_ctl_new1(&had_control_iec958_mask,
 						intelhaddata));
@@ -1638,7 +1635,10 @@ int hdmi_audio_probe(struct platform_device *devptr,
 	if (retval < 0)
 		goto err;
 
-	intelhaddata->dev = &devptr->dev;
+	retval = snd_card_register(card);
+	if (retval)
+		goto err;
+
 	pm_runtime_set_active(intelhaddata->dev);
 	pm_runtime_enable(intelhaddata->dev);
 
-- 
2.11.0
