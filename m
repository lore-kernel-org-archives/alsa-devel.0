From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH RFC] ASoC: rt5663: use msleep() for long delay loop
Date: Wed, 11 Jan 2017 16:03:13 +0100
Message-ID: <1484146993-25429-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: alsa-devel@alsa-project.org

As the overall delay is in range of seconds and the wait granularity
is 10ms msleep() seems more reasonable than to put load on the highres
timer subsystem.

Fixes: commit df7c52168ee1 ("ASoC: add rt5663 codec driver")
Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---
Problem was found by cocinelle script.

This does throw a checkpatch warning with:
WARNING: msleep < 20ms can sleep for up to 20ms;"
but since this is in a loop and the intended granularity is
10ms with up to 2 seconds total delay this seems ok.

Patch was compile tested with: x86_64_defconfig + CONFIG_COMPILE_TEST=y
SND_SOC=m + SND_SOC_ALL_CODECS=m (implies SND_SOC_RT5663=m)

Patch is aginast 4.10-rc3 (localversion-next is next-20170111)

 sound/soc/codecs/rt5663.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index a32508d..3bdb62b 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -2982,7 +2982,8 @@ static void rt5663_v2_calibrate(struct rt5663_priv *rt5663)
 
 static void rt5663_calibrate(struct rt5663_priv *rt5663)
 {
-	int value, count;
+	int value;
+	unsigned long timeout;
 
 	regmap_write(rt5663->regmap, RT5663_RC_CLK, 0x0280);
 	regmap_write(rt5663->regmap, RT5663_GLB_CLK, 0x8000);
@@ -3025,17 +3026,15 @@ static void rt5663_calibrate(struct rt5663_priv *rt5663)
 	regmap_write(rt5663->regmap, RT5663_HP_CALIB_3, 0x06c2);
 	regmap_write(rt5663->regmap, RT5663_HP_CALIB_1_1, 0x7b00);
 	regmap_write(rt5663->regmap, RT5663_HP_CALIB_1_1, 0xfb00);
-	count = 0;
-	while (true) {
+
+	/* allow the write completion to take up to 2s */
+	timeout = jiffies + msecs_to_jiffies(2000);
+	while (time_is_after_jiffies(timeout)) {
 		regmap_read(rt5663->regmap, RT5663_HP_CALIB_1_1, &value);
 		if (value & 0x8000)
-			usleep_range(10000, 10005);
+			msleep(10);
 		else
 			break;
-
-		if (count > 200)
-			return;
-		count++;
 	}
 }
 
-- 
2.1.4
