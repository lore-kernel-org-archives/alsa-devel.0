From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH] ASoC: soc-pcm: Use delay set in pointer function
Date: Fri, 27 Jul 2018 18:13:42 +0800
Message-ID: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

There are cases where a pointer function populates
runtime->delay, such as:
./sound/pci/hda/hda_controller.c
./sound/soc/intel/atom/sst-mfld-platform-pcm.c

Also, in some cases cpu dai used is generic and the pcm
driver needs to set delay.

This delay was getting lost and was overwritten by delays
from codec or cpu dai delay function if exposed.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/soc-pcm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 98be04b..b1a2bc2 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1179,6 +1179,9 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	snd_pcm_sframes_t codec_delay = 0;
 	int i;
 
+	/* clearing the previous delay */
+	runtime->delay = 0;
+
 	for_each_rtdcom(rtd, rtdcom) {
 		component = rtdcom->component;
 
@@ -1203,7 +1206,7 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	}
 	delay += codec_delay;
 
-	runtime->delay = delay;
+	runtime->delay += delay;
 
 	return offset;
 }
-- 
1.9.1
