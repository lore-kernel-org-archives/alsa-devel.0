From: Seungwhan Youn <sw.youn@samsung.com>
Subject: [RFC] [ALSA] ASoC documentation updates
Date: Thu, 13 Jan 2011 11:08:21 +0900
Message-ID: <1294884501-25880-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 66D8F244D5
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 03:32:26 +0100 (CET)
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
Cc: Seungwhan Youn <sw.youn@samsung.com>, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This patch is only for RFC purpose of ASoC documentation updates which
match with current ASoC codes with documents. Mostly modify features
are modified to be sync with changes after multi-component patches.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
To Mr. Liam Girdwood and Mark Brown

I think this modification is not enough to cover current ASoC features,
and I hope that it will be a good time to introduce recently changes, e.g.
multi-component model, new linkage system of ASoC DAIs, and so on. But
if you have some other idea, or other reason to delay this, please ignore
this RFC. And also if there are something that I can help, please let me
know.

Thanks,
Claude
---
 Documentation/sound/alsa/soc/codec.txt    |   45 +++++++++++++---------------
 Documentation/sound/alsa/soc/machine.txt  |   38 ++++++------------------
 Documentation/sound/alsa/soc/platform.txt |   12 ++++++-
 3 files changed, 40 insertions(+), 55 deletions(-)

diff --git a/Documentation/sound/alsa/soc/codec.txt b/Documentation/sound/alsa/soc/codec.txt
index 37ba3a7..bce23a4 100644
--- a/Documentation/sound/alsa/soc/codec.txt
+++ b/Documentation/sound/alsa/soc/codec.txt
@@ -27,42 +27,38 @@ ASoC Codec driver breakdown
 
 1 - Codec DAI and PCM configuration
 -----------------------------------
-Each codec driver must have a struct snd_soc_codec_dai to define its DAI and
+Each codec driver must have a struct snd_soc_dai_driver to define its DAI and
 PCM capabilities and operations. This struct is exported so that it can be
 registered with the core by your machine driver.
 
 e.g.
 
-struct snd_soc_codec_dai wm8731_dai = {
-	.name = "WM8731",
-	/* playback capabilities */
+static struct snd_soc_dai_ops wm8731_dai_ops = {
+	.prepare	= wm8731_pcm_prepare,
+	.hw_params	= wm8731_hw_params,
+	.shutdown	= wm8731_shutdown,
+	.digital_mute	= wm8731_mute,
+	.set_sysclk	= wm8731_set_dai_sysclk,
+	.set_fmt	= wm8731_set_dai_fmt,
+};
+
+struct snd_soc_dai_driver wm8731_dai = {
+	.name = "wm8731-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = WM8731_RATES,
 		.formats = WM8731_FORMATS,},
-	/* capture capabilities */
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = WM8731_RATES,
 		.formats = WM8731_FORMATS,},
-	/* pcm operations - see section 4 below */
-	.ops = {
-		.prepare = wm8731_pcm_prepare,
-		.hw_params = wm8731_hw_params,
-		.shutdown = wm8731_shutdown,
-	},
-	/* DAI operations - see DAI.txt */
-	.dai_ops = {
-		.digital_mute = wm8731_mute,
-		.set_sysclk = wm8731_set_dai_sysclk,
-		.set_fmt = wm8731_set_dai_fmt,
-	}
+	.ops = &wm8731_dai_ops,
+	.symmetric_rates = 1,
 };
-EXPORT_SYMBOL_GPL(wm8731_dai);
 
 
 2 - Codec control IO
@@ -186,13 +182,14 @@ when the mute is applied or freed.
 
 i.e.
 
-static int wm8974_mute(struct snd_soc_codec *codec,
-	struct snd_soc_codec_dai *dai, int mute)
+static int wm8974_mute(struct snd_soc_dai *dai, int mute)
 {
-	u16 mute_reg = wm8974_read_reg_cache(codec, WM8974_DAC) & 0xffbf;
-	if(mute)
-		wm8974_write(codec, WM8974_DAC, mute_reg | 0x40);
+	struct snd_soc_codec *codec = dai->codec;
+	u16 mute_reg = snd_soc_read(codec, WM8974_DAC) & 0xffbf;
+
+	if (mute)
+		snd_soc_write(codec, WM8974_DAC, mute_reg | 0x40);
 	else
-		wm8974_write(codec, WM8974_DAC, mute_reg);
+		snd_soc_write(codec, WM8974_DAC, mute_reg);
 	return 0;
 }
diff --git a/Documentation/sound/alsa/soc/machine.txt b/Documentation/sound/alsa/soc/machine.txt
index 2524c75..3e2ec9c 100644
--- a/Documentation/sound/alsa/soc/machine.txt
+++ b/Documentation/sound/alsa/soc/machine.txt
@@ -12,6 +12,8 @@ the following struct:-
 struct snd_soc_card {
 	char *name;
 
+	...
+
 	int (*probe)(struct platform_device *pdev);
 	int (*remove)(struct platform_device *pdev);
 
@@ -22,12 +24,13 @@ struct snd_soc_card {
 	int (*resume_pre)(struct platform_device *pdev);
 	int (*resume_post)(struct platform_device *pdev);
 
-	/* machine stream operations */
-	struct snd_soc_ops *ops;
+	...
 
 	/* CPU <--> Codec DAI links  */
 	struct snd_soc_dai_link *dai_link;
 	int num_links;
+
+	...
 };
 
 probe()/remove()
@@ -42,11 +45,6 @@ of any machine audio tasks that have to be done before or after the codec, DAIs
 and DMA is suspended and resumed. Optional.
 
 
-Machine operations
-------------------
-The machine specific audio operations can be set here. Again this is optional.
-
-
 Machine DAI Configuration
 -------------------------
 The machine DAI configuration glues all the codec and CPU DAIs together. It can
@@ -61,8 +59,10 @@ struct snd_soc_dai_link is used to set up each DAI in your machine. e.g.
 static struct snd_soc_dai_link corgi_dai = {
 	.name = "WM8731",
 	.stream_name = "WM8731",
-	.cpu_dai = &pxa_i2s_dai,
-	.codec_dai = &wm8731_dai,
+	.cpu_dai_name = "pxa-is2-dai",
+	.codec_dai_name = "wm8731-hifi",
+	.platform_name = "pxa-pcm-audio",
+	.codec_name = "wm8713-codec.0-001a",
 	.init = corgi_wm8731_init,
 	.ops = &corgi_ops,
 };
@@ -77,26 +77,6 @@ static struct snd_soc_card snd_soc_corgi = {
 };
 
 
-Machine Audio Subsystem
------------------------
-
-The machine soc device glues the platform, machine and codec driver together.
-Private data can also be set here. e.g.
-
-/* corgi audio private data */
-static struct wm8731_setup_data corgi_wm8731_setup = {
-	.i2c_address = 0x1b,
-};
-
-/* corgi audio subsystem */
-static struct snd_soc_device corgi_snd_devdata = {
-	.machine = &snd_soc_corgi,
-	.platform = &pxa2xx_soc_platform,
-	.codec_dev = &soc_codec_dev_wm8731,
-	.codec_data = &corgi_wm8731_setup,
-};
-
-
 Machine Power Map
 -----------------
 
diff --git a/Documentation/sound/alsa/soc/platform.txt b/Documentation/sound/alsa/soc/platform.txt
index 06d8359..d57efad 100644
--- a/Documentation/sound/alsa/soc/platform.txt
+++ b/Documentation/sound/alsa/soc/platform.txt
@@ -20,9 +20,10 @@ struct snd_soc_ops {
 	int (*trigger)(struct snd_pcm_substream *, int);
 };
 
-The platform driver exports its DMA functionality via struct snd_soc_platform:-
+The platform driver exports its DMA functionality via struct
+snd_soc_platform_driver:-
 
-struct snd_soc_platform {
+struct snd_soc_platform_driver {
 	char *name;
 
 	int (*probe)(struct platform_device *pdev);
@@ -34,6 +35,13 @@ struct snd_soc_platform {
 	int (*pcm_new)(struct snd_card *, struct snd_soc_codec_dai *, struct snd_pcm *);
 	void (*pcm_free)(struct snd_pcm *);
 
+	/*
+	 * For platform caused delay reporting.
+	 * Optional.
+	 */
+	snd_pcm_sframes_t (*delay)(struct snd_pcm_substream *,
+		struct snd_soc_dai *);
+
 	/* platform stream ops */
 	struct snd_pcm_ops *pcm_ops;
 };
-- 
1.6.2.5
