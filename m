From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/53] ALSA: x86: Don't set PCM state to
	DISCONNECTED
Date: Thu,  2 Feb 2017 18:02:14 +0100
Message-ID: <20170202170307.24484-2-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 35A13265AF3
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 18:03:13 +0100 (CET)
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

Theoretically setting the state to SNDRV_PCM_STATE_DISCONNECTED is
correct.  But, unfortunately, PA gets confused by this action, and it
won't re-probe the device after HDMI/DP is re-plugged.  (It reprobes
only when the card itself is recreated.)

As a workaround, set SNDRV_PCM_STATE_SETUP instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/x86/intel_hdmi_audio_if.c b/sound/x86/intel_hdmi_audio_if.c
index 9ae242d62eb2..30b4b25acb24 100644
--- a/sound/x86/intel_hdmi_audio_if.c
+++ b/sound/x86/intel_hdmi_audio_if.c
@@ -464,7 +464,7 @@ int had_process_hot_unplug(struct snd_intelhad *intelhaddata)
 		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flag_irqs);
 		pr_debug("%s: unlock -> sending pcm_stop -> lock\n", __func__);
 		snd_pcm_stop(intelhaddata->stream_info.had_substream,
-				SNDRV_PCM_STATE_DISCONNECTED);
+				SNDRV_PCM_STATE_SETUP);
 		spin_lock_irqsave(&intelhaddata->had_spinlock, flag_irqs);
 	}
 
-- 
2.11.0
