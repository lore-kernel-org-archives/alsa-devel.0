From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/8] ASoC: Support the sub speaker driver on
	Speyside
Date: Tue, 12 Apr 2011 23:06:07 -0700
Message-ID: <1302674771-17169-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1302674771-17169-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3DE9C1038D3
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 08:07:42 +0200 (CEST)
In-Reply-To: <1302674771-17169-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Speyside includes a WM9081 configured as an external speaker driver taking
an analogue input from HPOUT2 on the WM8915 on the system. Add support for
this to the driver, using a prefix of "Sub" for the WM9081 controls to
ensure we avoid collisions with controls on the WM8915.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/Kconfig    |    1 +
 sound/soc/samsung/speyside.c |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 726af2e..459566b 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -176,3 +176,4 @@ config SND_SOC_SPEYSIDE
 	depends on SND_SOC_SAMSUNG && MACH_WLF_CRAGG_6410
 	select SND_SAMSUNG_I2S
 	select SND_SOC_WM8915
+	select SND_SOC_WM9081
diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 1e51750..0adaf7f 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -13,6 +13,7 @@
 #include <sound/soc-dapm.h>
 
 #include "../codecs/wm8915.h"
+#include "../codecs/wm9081.h"
 
 static int speyside_set_bias_level(struct snd_soc_card *card,
 				   enum snd_soc_bias_level level)
@@ -98,6 +99,30 @@ static struct snd_soc_dai_link speyside_dai[] = {
 	},
 };
 
+static int speyside_wm9081_init(struct snd_soc_dapm_context *dapm)
+{
+	snd_soc_dapm_nc_pin(dapm, "LINEOUT");
+
+	/* At any time the WM9081 is active it will have this clock */
+	return snd_soc_codec_set_sysclk(dapm->codec, WM9081_SYSCLK_MCLK,
+					48000 * 256, 0);
+}
+
+static struct snd_soc_aux_dev speyside_aux_dev[] = {
+	{
+		.name = "wm9081",
+		.codec_name = "wm9081.1-006c",
+		.init = speyside_wm9081_init,
+	},
+};
+
+static struct snd_soc_codec_conf speyside_codec_conf[] = {
+	{
+		.dev_name = "wm9081.1-006c",
+		.name_prefix = "Sub",
+	},
+};
+
 static struct snd_soc_dapm_widget widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 
@@ -118,6 +143,11 @@ static struct snd_soc_dapm_route audio_paths[] = {
 	{ "Headphone", NULL, "HPOUT1L" },
 	{ "Headphone", NULL, "HPOUT1R" },
 
+	{ "Sub IN1", NULL, "HPOUT2L" },
+	{ "Sub IN2", NULL, "HPOUT2R" },
+
+	{ "Main Speaker", NULL, "Sub SPKN" },
+	{ "Main Speaker", NULL, "Sub SPKP" },
 	{ "Main Speaker", NULL, "SPKDAT" },
 };
 
@@ -125,6 +155,10 @@ static struct snd_soc_card speyside = {
 	.name = "Speyside",
 	.dai_link = speyside_dai,
 	.num_links = ARRAY_SIZE(speyside_dai),
+	.aux_dev = speyside_aux_dev,
+	.num_aux_devs = ARRAY_SIZE(speyside_aux_dev),
+	.codec_conf = speyside_codec_conf,
+	.num_configs = ARRAY_SIZE(speyside_codec_conf),
 
 	.set_bias_level = speyside_set_bias_level,
 
-- 
1.7.4.1
