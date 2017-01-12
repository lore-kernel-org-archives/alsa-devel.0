From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ASoC: rt5659: use msleep() for long delays
Date: Thu, 12 Jan 2017 14:14:20 +0100
Message-ID: <1484226860-5620-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: alsa-devel@alsa-project.org

ulseep_range() uses hrtimers and provides no advantage over msleep()
for larger delays. For this large delay msleep() is preferable.

Fixes: commit d3cb2de2479b ("ASoC: rt5659: add rt5659 codec driver")
Link: http://lkml.org/lkml/2017/1/11/377
Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem was found by cocinelle script.

Patch was compile tested with: x86_64_defconfig + CONFIG_COMPILE_TEST=y
SND_SOC=m + SND_SOC_ALL_CODECS=m (implies SND_SOC_RT5659=m)
(44 sparse warnings - fixed in a seperate patches)

Patch is aginast 4.10-rc3 (localversion-next is next-20170112)

 sound/soc/codecs/rt5659.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index db54550..a57f67b 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -4018,7 +4018,7 @@ static int rt5659_i2c_probe(struct i2c_client *i2c,
 							GPIOD_OUT_HIGH);
 
 	/* Sleep for 300 ms miniumum */
-	usleep_range(300000, 350000);
+	msleep(300);
 
 	rt5659->regmap = devm_regmap_init_i2c(i2c, &rt5659_regmap);
 	if (IS_ERR(rt5659->regmap)) {
-- 
2.1.4
