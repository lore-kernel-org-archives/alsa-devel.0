From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH v2] ASoC: soc-pcm: Use delay set in component pointer function
Date: Wed,  1 Aug 2018 15:37:33 +0530
Message-ID: <1533118054-14509-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Take into account the base delay set in pointer callback.

There are cases where a pointer function populates
runtime->delay, such as:
./sound/pci/hda/hda_controller.c
./sound/soc/intel/atom/sst-mfld-platform-pcm.c

This delay was getting lost and was overwritten by delays
from codec or cpu dai delay function if exposed.

Now,
Total delay = base delay + cpu_dai delay + codec_dai delay

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/soc-pcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 98be04b..e8b98bfd 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1179,6 +1179,9 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	snd_pcm_sframes_t codec_delay = 0;
 	int i;
 
+	/* clearing the previous total delay */
+	runtime->delay = 0;
+
 	for_each_rtdcom(rtd, rtdcom) {
 		component = rtdcom->component;
 
@@ -1190,6 +1193,8 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 		offset = component->driver->ops->pointer(substream);
 		break;
 	}
+	/* base delay if assigned in pointer callback */
+	delay = runtime->delay;
 
 	if (cpu_dai->driver->ops->delay)
 		delay += cpu_dai->driver->ops->delay(substream, cpu_dai);
-- 
1.9.1
