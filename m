From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: ASoC: fix raumfeld platform
Date: Tue, 24 May 2011 14:10:32 +0200
Message-ID: <1306239032-7951-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (unknown [212.112.241.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 9034A103809
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 14:10:39 +0200 (CEST)
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
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Commit f0fba2ad (ASoC: multi-component - ASoC Multi-Component Support)
broke support for Raumfeld platforms as it didn't take into account the
different hardware features on individual devices.

In particular, Raumfeld speakers have no S/PDIF output, so the members
of the snd_soc_card struct must be set dynamically.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/pxa/raumfeld.c |   92 +++++++++++++++++++++++++++++-----------------
 1 files changed, 58 insertions(+), 34 deletions(-)

diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
index 2afabaf..1a591f1 100644
--- a/sound/soc/pxa/raumfeld.c
+++ b/sound/soc/pxa/raumfeld.c
@@ -151,13 +151,13 @@ static struct snd_soc_ops raumfeld_cs4270_ops = {
 	.hw_params = raumfeld_cs4270_hw_params,
 };
 
-static int raumfeld_line_suspend(struct snd_soc_card *card)
+static int raumfeld_analog_suspend(struct snd_soc_card *card)
 {
 	raumfeld_enable_audio(false);
 	return 0;
 }
 
-static int raumfeld_line_resume(struct snd_soc_card *card)
+static int raumfeld_analog_resume(struct snd_soc_card *card)
 {
 	raumfeld_enable_audio(true);
 	return 0;
@@ -225,32 +225,53 @@ static struct snd_soc_ops raumfeld_ak4104_ops = {
 	.hw_params = raumfeld_ak4104_hw_params,
 };
 
-static struct snd_soc_dai_link raumfeld_dai[] = {
+#define DAI_LINK_CS4270		\
+{							\
+	.name		= "CS4270",			\
+	.stream_name	= "CS4270",			\
+	.cpu_dai_name	= "pxa-ssp-dai.0",		\
+	.platform_name	= "pxa-pcm-audio",		\
+	.codec_dai_name	= "cs4270-hifi",		\
+	.codec_name	= "cs4270-codec.0-0048",	\
+	.ops		= &raumfeld_cs4270_ops,		\
+}
+
+#define DAI_LINK_AK4104		\
+{							\
+	.name		= "ak4104",			\
+	.stream_name	= "Playback",			\
+	.cpu_dai_name	= "pxa-ssp-dai.1",		\
+	.codec_dai_name	= "ak4104-hifi",		\
+	.platform_name	= "pxa-pcm-audio",		\
+	.ops		= &raumfeld_ak4104_ops,		\
+	.codec_name	= "spi0.0",			\
+}
+
+static struct snd_soc_dai_link snd_soc_raumfeld_connector_dai[] =
 {
-	.name		= "ak4104",
-	.stream_name	= "Playback",
-	.cpu_dai_name	= "pxa-ssp-dai.1",
-	.codec_dai_name	= "ak4104-hifi",
-	.platform_name	= "pxa-pcm-audio",
-	.ops		= &raumfeld_ak4104_ops,
-	.codec_name	= "ak4104-codec.0",
-},
+	DAI_LINK_CS4270,
+	DAI_LINK_AK4104,
+};
+
+static struct snd_soc_dai_link snd_soc_raumfeld_speaker_dai[] =
 {
-	.name		= "CS4270",
-	.stream_name	= "CS4270",
-	.cpu_dai_name	= "pxa-ssp-dai.0",
-	.platform_name	= "pxa-pcm-audio",
-	.codec_dai_name	= "cs4270-hifi",
-	.codec_name	= "cs4270-codec.0-0048",
-	.ops		= &raumfeld_cs4270_ops,
-},};
-
-static struct snd_soc_card snd_soc_raumfeld = {
-	.name		= "Raumfeld",
-	.dai_link	= raumfeld_dai,
-	.suspend_post	= raumfeld_line_suspend,
-	.resume_pre	= raumfeld_line_resume,
-	.num_links	= ARRAY_SIZE(raumfeld_dai),
+	DAI_LINK_CS4270,
+};
+
+static struct snd_soc_card snd_soc_raumfeld_connector = {
+	.name		= "Raumfeld Connector",
+	.dai_link	= snd_soc_raumfeld_connector_dai,
+	.num_links	= ARRAY_SIZE(snd_soc_raumfeld_connector_dai),
+	.suspend_post	= raumfeld_analog_suspend,
+	.resume_pre	= raumfeld_analog_resume,
+};
+
+static struct snd_soc_card snd_soc_raumfeld_speaker = {
+	.name		= "Raumfeld Speaker",
+	.dai_link	= snd_soc_raumfeld_speaker_dai,
+	.num_links	= ARRAY_SIZE(snd_soc_raumfeld_speaker_dai),
+	.suspend_post	= raumfeld_analog_suspend,
+	.resume_pre	= raumfeld_analog_resume,
 };
 
 static struct platform_device *raumfeld_audio_device;
@@ -271,22 +292,25 @@ static int __init raumfeld_audio_init(void)
 
 	set_max9485_clk(MAX9485_MCLK_FREQ_122880);
 
-	/* Register LINE and SPDIF */
+	/* Register analog device */
 	raumfeld_audio_device = platform_device_alloc("soc-audio", 0);
 	if (!raumfeld_audio_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(raumfeld_audio_device,
-			     &snd_soc_raumfeld);
-	ret = platform_device_add(raumfeld_audio_device);
-
-	/* no S/PDIF on Speakers */
 	if (machine_is_raumfeld_speaker())
+		platform_set_drvdata(raumfeld_audio_device,
+				     &snd_soc_raumfeld_speaker);
+
+	if (machine_is_raumfeld_connector())
+		platform_set_drvdata(raumfeld_audio_device,
+				     &snd_soc_raumfeld_connector);
+
+	ret = platform_device_add(raumfeld_audio_device);
+	if (ret < 0)
 		return ret;
 
 	raumfeld_enable_audio(true);
-
-	return ret;
+	return 0;
 }
 
 static void __exit raumfeld_audio_exit(void)
-- 
1.7.5.1
