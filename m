From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/53] ALSA: x86: Drop useless mutex at probe
Date: Thu,  2 Feb 2017 18:02:23 +0100
Message-ID: <20170202170307.24484-11-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BB2CF2668B6
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

had_mutex is (supposedly) used to protect the concurrent calls of
hdmi_audio_probe().  But we may have only one device at most, so it's
utterly useless.  Drop it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 45ba16e27323..7165f14d5229 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -37,8 +37,6 @@
 #include <sound/initval.h>
 #include "intel_hdmi_audio.h"
 
-static DEFINE_MUTEX(had_mutex);
-
 /*standard module options for ALSA. This module supports only one card*/
 static int hdmi_card_index = SNDRV_DEFAULT_IDX1;
 static char *hdmi_card_id = SNDRV_DEFAULT_STR1;
@@ -1621,7 +1619,7 @@ int hdmi_audio_probe(struct platform_device *devptr,
 		pr_err("querying display driver APIs failed %#x\n", retval);
 		goto free_hadstream;
 	}
-	mutex_lock(&had_mutex);
+
 	spin_lock_init(&intelhaddata->had_spinlock);
 	intelhaddata->drv_status = HAD_DRV_DISCONNECTED;
 	pr_debug("%s @ %d:DEBUG PLUG/UNPLUG : HAD_DRV_DISCONNECTED\n",
@@ -1632,7 +1630,7 @@ int hdmi_audio_probe(struct platform_device *devptr,
 				THIS_MODULE, 0, &card);
 
 	if (retval)
-		goto unlock_mutex;
+		goto free_hadstream;
 	intelhaddata->card = card;
 	intelhaddata->card_id = hdmi_card_id;
 	intelhaddata->card_index = card->number;
@@ -1705,16 +1703,12 @@ int hdmi_audio_probe(struct platform_device *devptr,
 	pm_runtime_set_active(intelhaddata->dev);
 	pm_runtime_enable(intelhaddata->dev);
 
-	mutex_unlock(&had_mutex);
-
 	intelhaddata->hw_silence = 1;
 	*had_ret = intelhaddata;
 
 	return 0;
 err:
 	snd_card_free(card);
-unlock_mutex:
-	mutex_unlock(&had_mutex);
 free_hadstream:
 	kfree(had_stream);
 	pm_runtime_disable(intelhaddata->dev);
-- 
2.11.0
