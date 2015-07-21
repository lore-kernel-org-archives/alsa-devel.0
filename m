From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/7] ASoC: ad1980: Use core AC'97 reset helper
Date: Tue, 21 Jul 2015 21:53:02 +0200
Message-ID: <1437508386-13828-4-git-send-email-lars@metafoo.de>
References: <1437508386-13828-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-102.synserver.de (smtp-out-102.synserver.de
 [212.40.185.102])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A65C26512B
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 21:53:22 +0200 (CEST)
In-Reply-To: <1437508386-13828-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Use the new snd_ac97_reset() helper function to perform the reset and
verify the device ID.

Unfortunately the reset can't be done in snd_soc_new_ac97_codec() due to
the special requirements in order to support the non-standard 16-bit slot
mode of the ad1980.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/ad1980.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index d9cb81d..9ef20db 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -202,19 +202,21 @@ static struct snd_soc_dai_driver ad1980_dai = {
 		.formats = SND_SOC_STD_AC97_FMTS, },
 };
 
+#define AD1980_VENDOR_ID 0x41445300
+#define AD1980_VENDOR_MASK 0xffffff00
+
 static int ad1980_reset(struct snd_soc_codec *codec, int try_warm)
 {
 	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
 	unsigned int retry_cnt = 0;
+	int ret;
 
 	do {
-		if (try_warm && soc_ac97_ops->warm_reset) {
-			soc_ac97_ops->warm_reset(ac97);
-			if (snd_soc_read(codec, AC97_RESET) == 0x0090)
-				return 1;
-		}
+		ret = snd_ac97_reset(ac97, true, AD1980_VENDOR_ID,
+			AD1980_VENDOR_MASK);
+		if (ret >= 0)
+			return 0;
 
-		soc_ac97_ops->reset(ac97);
 		/*
 		 * Set bit 16slot in register 74h, then every slot will has only
 		 * 16 bits. This command is sent out in 20bit mode, in which
@@ -223,8 +225,6 @@ static int ad1980_reset(struct snd_soc_codec *codec, int try_warm)
 		 */
 		snd_soc_write(codec, AC97_AD_SERIAL_CFG, 0x9900);
 
-		if (snd_soc_read(codec, AC97_RESET)  == 0x0090)
-			return 0;
 	} while (retry_cnt++ < 10);
 
 	dev_err(codec->dev, "Failed to reset: AC97 link error\n");
@@ -260,22 +260,10 @@ static int ad1980_soc_probe(struct snd_soc_codec *codec)
 	if (ret < 0)
 		goto reset_err;
 
-	/* Read out vendor ID to make sure it is ad1980 */
-	if (snd_soc_read(codec, AC97_VENDOR_ID1) != 0x4144) {
-		ret = -ENODEV;
-		goto reset_err;
-	}
-
 	vendor_id2 = snd_soc_read(codec, AC97_VENDOR_ID2);
-
-	if (vendor_id2 != 0x5370) {
-		if (vendor_id2 != 0x5374) {
-			ret = -ENODEV;
-			goto reset_err;
-		} else {
-			dev_warn(codec->dev,
-				"Found AD1981 - only 2/2 IN/OUT Channels supported\n");
-		}
+	if (vendor_id2 == 0x5374) {
+		dev_warn(codec->dev,
+			"Found AD1981 - only 2/2 IN/OUT Channels supported\n");
 	}
 
 	/* unmute captures and playbacks volume */
-- 
2.1.4
