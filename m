From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 2/3] ASoC: wm0010: fix memory leak
Date: Fri, 18 Sep 2015 16:02:20 +0530
Message-ID: <1442572341-28201-2-git-send-email-sudipm.mukherjee@gmail.com>
References: <1442572341-28201-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442572341-28201-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

We have requested for the firmware but we have missed releasing it both
on success and on error path.
While checking the code it turned out that the requested firmware is not
even used. More over the same firmware is being loaded by
wm0010_stage2_load().

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/soc/codecs/wm0010.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 79a7cd3..4947be5 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -577,7 +577,6 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 	struct wm0010_priv *wm0010 = snd_soc_codec_get_drvdata(codec);
 	unsigned long flags;
 	int ret;
-	const struct firmware *fw;
 	struct spi_message m;
 	struct spi_transfer t;
 	struct dfw_pllrec pll_rec;
@@ -623,14 +622,6 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 	wm0010->state = WM0010_OUT_OF_RESET;
 	spin_unlock_irqrestore(&wm0010->irq_lock, flags);
 
-	/* First the bootloader */
-	ret = request_firmware(&fw, "wm0010_stage2.bin", codec->dev);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request stage2 loader: %d\n",
-			ret);
-		goto abort;
-	}
-
 	if (!wait_for_completion_timeout(&wm0010->boot_completion,
 					 msecs_to_jiffies(20)))
 		dev_err(codec->dev, "Failed to get interrupt from DSP\n");
-- 
1.9.1
