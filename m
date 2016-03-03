From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: pcm3168a: remove unused variable
Date: Thu,  3 Mar 2016 19:07:49 +0530
Message-ID: <1457012269-30481-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

While building we were getting build warning about:
sound/soc/codecs/pcm3168a.c:403:21: warning: variable 'channels' set but not used

The variable channels were being assigned some value but that was never
reused.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

Its upto you now. If you dont want to accept then I will add an extra
From: in the commit. But since that will not be a part of my scripts so
there will be chances of error. If you are worried about missing signoff,
then I can assure you that my scripts will catch that before i can send
it.

 sound/soc/codecs/pcm3168a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 0c7248a..992a77e 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -400,13 +400,12 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 	struct pcm3168a_priv *pcm3168a = snd_soc_codec_get_drvdata(codec);
 	bool tx, master_mode;
 	u32 val, mask, shift, reg;
-	unsigned int rate, channels, fmt, ratio, max_ratio;
+	unsigned int rate, fmt, ratio, max_ratio;
 	int i, min_frame_size;
 	snd_pcm_format_t format;
 
 	rate = params_rate(params);
 	format = params_format(params);
-	channels = params_channels(params);
 
 	ratio = pcm3168a->sysclk / rate;
 
-- 
1.9.1
