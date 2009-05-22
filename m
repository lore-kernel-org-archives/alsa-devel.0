From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/2] ASoC: TWL4030: Add support for platform
	dependent configuration
Date: Fri, 22 May 2009 09:14:35 +0300
Message-ID: <1242972876-31089-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1242972876-31089-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 8088A2436D
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 08:14:50 +0200 (CEST)
In-Reply-To: <1242972876-31089-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sakoman@gmail.com, anuj.aggarwal@ti.com, getarunks@gmail.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

twl4030_setup_data structure can be passed from platform drivers to
the codec via the snd_soc_device->codec_data pointer.

Currently the setup data has support for the Headset pop-removal
related configuration, which differs from board to board.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   22 +++++++++++++++++++---
 sound/soc/codecs/twl4030.h |    5 +++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index f554672..4cc35fd 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1997,6 +1997,8 @@ static int twl4030_resume(struct platform_device *pdev)
 static int twl4030_init(struct snd_soc_device *socdev)
 {
 	struct snd_soc_codec *codec = socdev->card->codec;
+	struct twl4030_setup_data *setup = socdev->codec_data;
+	struct twl4030_priv *twl4030 = codec->private_data;
 	int ret = 0;
 
 	printk(KERN_INFO "TWL4030 Audio Codec init \n");
@@ -2014,6 +2016,23 @@ static int twl4030_init(struct snd_soc_device *socdev)
 	if (codec->reg_cache == NULL)
 		return -ENOMEM;
 
+	/* Configuration for headset ramp delay from setup data */
+	if (setup) {
+		unsigned char hs_pop;
+
+		if (setup->sysclk)
+			twl4030->sysclk = setup->sysclk;
+		else
+			twl4030->sysclk = 26000;
+
+		hs_pop = twl4030_read_reg_cache(codec, TWL4030_REG_HS_POPN_SET);
+		hs_pop &= ~TWL4030_RAMP_DELAY;
+		hs_pop |= (twl4030->ramp_delay_value << 2);
+		twl4030_write_reg_cache(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
+	} else {
+		twl4030->sysclk = 26000;
+	}
+
 	/* register pcms */
 	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
 	if (ret < 0) {
@@ -2063,9 +2082,6 @@ static int twl4030_probe(struct platform_device *pdev)
 		kfree(codec);
 		return -ENOMEM;
 	}
-	/* Set default sysclk (used by the headsetl/rpga_event callback for
-	 * pop-attenuation) */
-	twl4030->sysclk = 26000;
 
 	codec->private_data = twl4030;
 	socdev->card->codec = codec;
diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
index 9668bdf..48326e2 100644
--- a/sound/soc/codecs/twl4030.h
+++ b/sound/soc/codecs/twl4030.h
@@ -266,4 +266,9 @@
 extern struct snd_soc_dai twl4030_dai[2];
 extern struct snd_soc_codec_device soc_codec_dev_twl4030;
 
+struct twl4030_setup_data {
+	unsigned int ramp_delay_value;
+	unsigned int sysclk;
+};
+
 #endif	/* End of __TWL4030_AUDIO_H__ */
-- 
1.6.3
