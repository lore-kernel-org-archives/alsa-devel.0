From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 17/53] ALSA: x86: Drop unused hw_silence field
Date: Thu,  2 Feb 2017 18:02:31 +0100
Message-ID: <20170202170307.24484-19-tiwai@suse.de>
References: <20170202170307.24484-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B0E7267585
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

It's nowhere used.  Let's drop it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 1 -
 sound/x86/intel_hdmi_audio.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index e08691110a48..efc56544af17 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1696,7 +1696,6 @@ int hdmi_audio_probe(struct platform_device *devptr,
 	pm_runtime_set_active(intelhaddata->dev);
 	pm_runtime_enable(intelhaddata->dev);
 
-	intelhaddata->hw_silence = 1;
 	*had_ret = intelhaddata;
 
 	return 0;
diff --git a/sound/x86/intel_hdmi_audio.h b/sound/x86/intel_hdmi_audio.h
index da0a927d37fe..32a2fb766e47 100644
--- a/sound/x86/intel_hdmi_audio.h
+++ b/sound/x86/intel_hdmi_audio.h
@@ -118,7 +118,6 @@ struct had_pvt_data {
  * @kctl: holds kctl ptrs used for channel map
  * @chmap: holds channel map info
  * @audio_reg_base: hdmi audio register base offset
- * @hw_silence: flag indicates SoC support for HW silence/Keep alive
  * @underrun_count: PCM stream underrun counter
  */
 struct snd_intelhad {
@@ -142,7 +141,6 @@ struct snd_intelhad {
 	struct snd_pcm_chmap *chmap;
 	unsigned int	*audio_reg_base;
 	unsigned int	audio_cfg_offset;
-	bool		hw_silence;
 	int underrun_count;
 };
 
-- 
2.11.0
