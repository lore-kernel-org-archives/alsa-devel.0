From: Zhuohao Lee <zhuohao@chromium.org>
Subject: [PATCH] ASoC: Intel: kbl_da7219_max98927: fix the audio jack button remapping
Date: Mon, 10 Dec 2018 12:32:13 +0800
Message-ID: <20181210043213.243881-1-zhuohao@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Dan Carpenter <dan.carpenter@oracle.com>, Max Chang <changmax@chromium.org>, Oder Chiou <oder_chiou@realtek.com>, Zhuohao Lee <zhuohao@chromium.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

>From the da7219 spec, the button A, B, C and D are remapped to
0, 1, 2 and 3 respectively where button A is KEY_PLAYPAUSE,
B is KEY_VOLUMEUP, C is KEY_VOLUMEDOWN and D is KEY_VOICECOMMAND.

Signed-off-by: Zhuohao Lee <zhuohao@chromium.org>
Signed-off-by: Max Chang  <changmax@chromium.org>
---
 sound/soc/intel/boards/kbl_da7219_max98927.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index 3fa1c3ca6d37..d3531f0eb357 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -262,9 +262,9 @@ static int kabylake_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 
 	jack = &ctx->kabylake_headset;
 	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
 
 	da7219_aad_jack_det(component, &ctx->kabylake_headset);
 
-- 
2.20.0.rc2.403.gdbc3b29805-goog
