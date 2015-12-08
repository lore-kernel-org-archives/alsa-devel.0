From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 06/13] ASoC: wm5110: Provide basic hookup for
	voice control
Date: Tue, 8 Dec 2015 16:08:30 +0000
Message-ID: <1449590917-21170-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1449590917-21170-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id E50992604FA
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 17:09:08 +0100 (CET)
In-Reply-To: <1449590917-21170-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Register a platform driver for the CODEC and add DAIs that will be used
to connect a compressed record path for the voice control functionality.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.h |  2 +-
 sound/soc/codecs/wm5110.c  | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index b4f1867..8b6adb5 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -57,7 +57,7 @@
 #define ARIZONA_CLK_98MHZ  5
 #define ARIZONA_CLK_147MHZ 6
 
-#define ARIZONA_MAX_DAI  6
+#define ARIZONA_MAX_DAI  8
 #define ARIZONA_MAX_ADSP 4
 
 #define ARIZONA_DVFS_SR1_RQ	0x001
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index e93e542..67d5651 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1810,6 +1810,9 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	{ "Slim2 Capture", NULL, "SYSCLK" },
 	{ "Slim3 Capture", NULL, "SYSCLK" },
 
+	{ "Voice Control DSP", NULL, "DSP3" },
+	{ "Voice Control DSP", NULL, "SYSCLK" },
+
 	{ "IN1L PGA", NULL, "IN1L" },
 	{ "IN1R PGA", NULL, "IN1R" },
 
@@ -2132,6 +2135,27 @@ static struct snd_soc_dai_driver wm5110_dai[] = {
 		 },
 		.ops = &arizona_simple_dai_ops,
 	},
+	{
+		.name = "wm5110-cpu-voicectrl",
+		.capture = {
+			.stream_name = "Voice Control CPU",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = WM5110_RATES,
+			.formats = WM5110_FORMATS,
+		},
+		.compress_new = snd_soc_new_compress,
+	},
+	{
+		.name = "wm5110-dsp-voicectrl",
+		.capture = {
+			.stream_name = "Voice Control DSP",
+			.channels_min = 1,
+			.channels_max = 1,
+			.rates = WM5110_RATES,
+			.formats = WM5110_FORMATS,
+		},
+	},
 };
 
 static int wm5110_codec_probe(struct snd_soc_codec *codec)
@@ -2224,6 +2248,13 @@ static struct snd_soc_codec_driver soc_codec_dev_wm5110 = {
 	.num_dapm_routes = ARRAY_SIZE(wm5110_dapm_routes),
 };
 
+static struct snd_compr_ops wm5110_compr_ops = {
+};
+
+static struct snd_soc_platform_driver wm5110_compr_platform = {
+	.compr_ops = &wm5110_compr_ops,
+};
+
 static int wm5110_probe(struct platform_device *pdev)
 {
 	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
@@ -2284,8 +2315,21 @@ static int wm5110_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_idle(&pdev->dev);
 
-	return snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm5110,
+	ret = snd_soc_register_platform(&pdev->dev, &wm5110_compr_platform);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register platform: %d\n", ret);
+		goto error;
+	}
+
+	ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_wm5110,
 				      wm5110_dai, ARRAY_SIZE(wm5110_dai));
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register codec: %d\n", ret);
+		snd_soc_unregister_platform(&pdev->dev);
+	}
+
+error:
+	return ret;
 }
 
 static int wm5110_remove(struct platform_device *pdev)
-- 
2.1.4
