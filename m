From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH] Sound WM8958 DSP2: Use correct format string in dev_err()
 call
Date: Mon, 23 Jan 2012 21:15:48 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1201232113400.8772@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lrg@ti.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Ian Lartey <ian@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

To print a value of type size_t one should use %zd, not %d.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 sound/soc/codecs/wm8958-dsp2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index 8d4ea43..40ac888 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -55,7 +55,7 @@ static int wm8958_dsp2_fw(struct snd_soc_codec *codec, const char *name,
 		return 0;
 
 	if (fw->size < 32) {
-		dev_err(codec->dev, "%s: firmware too short (%d bytes)\n",
+		dev_err(codec->dev, "%s: firmware too short (%zd bytes)\n",
 			name, fw->size);
 		goto err;
 	}
-- 
1.7.8.4


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
