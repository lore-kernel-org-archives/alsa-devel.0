From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 07/15] ASoC: hdac_hdmi: Apply constraints based
	on ELD
Date: Tue,  1 Dec 2015 23:17:03 +0530
Message-ID: <1448992031-8271-7-git-send-email-subhransu.s.prusty@intel.com>
References: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A70B265CDB
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 13:16:41 +0100 (CET)
In-Reply-To: <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Uses the drm eld core framework to apply rate, channel and
format constraint.

Even though the channel constraint is based on ELD, infoframe
is set with stereo only. Multichannel support will be added
later.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/Kconfig     | 1 +
 sound/soc/codecs/hdac_hdmi.c | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 8bba374..3c26df3 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -472,6 +472,7 @@ config SND_SOC_GTM601
 config SND_SOC_HDAC_HDMI
 	tristate
 	select SND_HDA_EXT_CORE
+	select SND_PCM_ELD
 	select HDMI
 
 config SND_SOC_ICS43432
diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 203c99f..55db686 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -26,6 +26,7 @@
 #include <sound/soc.h>
 #include <sound/hdaudio_ext.h>
 #include <sound/hda_i915.h>
+#include <sound/pcm_drm_eld.h>
 #include "../../hda/local.h"
 
 #define AMP_OUT_MUTE		0xb080
@@ -281,10 +282,8 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 	snd_hdac_codec_write(&hdac->hdac, dai_map->pin->nid, 0,
 			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
 
-	snd_pcm_hw_constraint_step(substream->runtime, 0,
-				   SNDRV_PCM_HW_PARAM_CHANNELS, 2);
-
-	return 0;
+	return snd_pcm_hw_constraint_eld(substream->runtime,
+			dai_map->pin->eld.eld_buffer);
 }
 
 static void hdac_hdmi_pcm_close(struct snd_pcm_substream *substream,
-- 
1.9.1
