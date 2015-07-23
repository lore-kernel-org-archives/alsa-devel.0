From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: [PATCH] ASoC: xtensa: Remove unnecessary
 snd_pcm_lib_preallocate_free_for_all()
Date: Thu, 23 Jul 2015 22:09:15 +0530
Message-ID: <20150723163914.GA4050@vaishali-Ideapad-Z570>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-xtensa@linux-xtensa.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The ALSA core takes care that all preallocated memory is freed
when the PCM itself is freed. There is no need to do this
manually in the driver.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 sound/soc/xtensa/xtfpga-i2s.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/xtensa/xtfpga-i2s.c b/sound/soc/xtensa/xtfpga-i2s.c
index 1cfb19e..039f65e 100644
--- a/sound/soc/xtensa/xtfpga-i2s.c
+++ b/sound/soc/xtensa/xtfpga-i2s.c
@@ -474,11 +474,6 @@ static int xtfpga_pcm_new(struct snd_soc_pcm_runtime *rtd)
 						     card->dev, size, size);
 }
 
-static void xtfpga_pcm_free(struct snd_pcm *pcm)
-{
-	snd_pcm_lib_preallocate_free_for_all(pcm);
-}
-
 static const struct snd_pcm_ops xtfpga_pcm_ops = {
 	.open		= xtfpga_pcm_open,
 	.close		= xtfpga_pcm_close,
@@ -490,7 +485,6 @@ static const struct snd_pcm_ops xtfpga_pcm_ops = {
 
 static const struct snd_soc_platform_driver xtfpga_soc_platform = {
 	.pcm_new	= xtfpga_pcm_new,
-	.pcm_free	= xtfpga_pcm_free,
 	.ops		= &xtfpga_pcm_ops,
 };
 
-- 
1.9.1
