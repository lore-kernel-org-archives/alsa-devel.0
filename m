From: miguel.aguilar@ridgerun.com
Subject: [PATCH 5/5] DaVinci: DM365: Voice Codec support for
	the DM365 EVM
Date: Thu, 11 Mar 2010 09:33:40 -0600
Message-ID: <1268321620-19074-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id ED20B1039BE
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 16:33:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, broonie@opensource.wolfsonmicro.com, diego.dompe@ridgerun.com, todd.fischer@ridgerun.com, Miguel Aguilar <miguel.aguilar@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

The DM365 EVM has two codecs: the Audio Codec (AIC3x) and the Voice Codec,
the idea is to have both enabled in the same kernel simultaneously. However,
the current soc-core doesn't support simultaneous codecs, once that
support will have added, a patch will be posted to enable both codecs in
the DM365 EVM.

Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c |    4 +++
 sound/soc/davinci/Kconfig               |   24 +++++++++++++++-
 sound/soc/davinci/davinci-evm.c         |   45 +++++++++++++++++++++++++++++-
 3 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 5c2636c..865d06a 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -516,7 +516,11 @@ static __init void dm365_evm_init(void)
 	/* maybe setup mmc1/etc ... _after_ mmc0 */
 	evm_init_cpld();
 
+#ifdef CONFIG_SND_DM365_AIC3X_CODEC
 	dm365_init_asp(&dm365_evm_snd_data);
+#elif defined(CONFIG_SND_DM365_VOICE_CODEC)
+	dm365_init_vc(&dm365_evm_snd_data);
+#endif
 	dm365_init_rtc();
 	dm365_init_ks(&dm365evm_ks_data);
 }
diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index 47e7cce..6bbf001 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -18,12 +18,32 @@ config SND_DAVINCI_SOC_VCIF
 config SND_DAVINCI_SOC_EVM
 	tristate "SoC Audio support for DaVinci DM6446, DM355 or DM365 EVM"
 	depends on SND_DAVINCI_SOC
-	depends on MACH_DAVINCI_EVM || MACH_DAVINCI_DM355_EVM  || MACH_DAVINCI_DM365_EVM
+	depends on MACH_DAVINCI_EVM || MACH_DAVINCI_DM355_EVM || MACH_DAVINCI_DM365_EVM
 	select SND_DAVINCI_SOC_I2S
 	select SND_SOC_TLV320AIC3X
 	help
 	  Say Y if you want to add support for SoC audio on TI
-	  DaVinci DM6446 or DM355 EVM platforms.
+	  DaVinci DM6446, DM355 or DM365 EVM platforms.
+
+choice
+	prompt "DM365 codec select"
+	depends on SND_DAVINCI_SOC_EVM
+	depends on MACH_DAVINCI_DM365_EVM
+	default SND_DM365_EXTERNAL_CODEC
+
+config SND_DM365_AIC3X_CODEC
+	bool "Audio Codec - AIC3101"
+	help
+	  Say Y if you want to add support for AIC3101 audio codec
+
+config SND_DM365_VOICE_CODEC
+	bool "Voice Codec - CQ93VC"
+	select MFD_DAVINCI_VOICECODEC
+	select SND_DAVINCI_SOC_VCIF
+	select SND_SOC_CQ0093VC
+	help
+	  Say Y if you want to add support for SoC On-chip voice codec
+endchoice
 
 config  SND_DM6467_SOC_EVM
 	tristate "SoC Audio support for DaVinci DM6467 EVM"
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 7ccbe66..ef63096 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -28,10 +28,12 @@
 #include <mach/mux.h>
 
 #include "../codecs/tlv320aic3x.h"
+#include "../codecs/cq93vc.h"
 #include "../codecs/spdif_transciever.h"
 #include "davinci-pcm.h"
 #include "davinci-i2s.h"
 #include "davinci-mcasp.h"
+#include "davinci-vcif.h"
 
 #define AUDIO_FORMAT (SND_SOC_DAIFMT_DSP_B | \
 		SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_IB_NF)
@@ -151,6 +153,22 @@ static struct snd_soc_dai_link evm_dai = {
 	.ops = &evm_ops,
 };
 
+static struct snd_soc_dai_link dm365_evm_dai = {
+#ifdef CONFIG_SND_DM365_AIC3X_CODEC
+	.name = "TLV320AIC3X",
+	.stream_name = "AIC3X",
+	.cpu_dai = &davinci_i2s_dai,
+	.codec_dai = &aic3x_dai,
+	.init = evm_aic3x_init,
+	.ops = &evm_ops,
+#elif defined(CONFIG_SND_DM365_VOICE_CODEC)
+	.name = "Voice Codec - CQ93VC",
+	.stream_name = "CQ93",
+	.cpu_dai = &davinci_vcif_dai,
+	.codec_dai = &cq93vc_dai,
+#endif
+};
+
 static struct snd_soc_dai_link dm6467_evm_dai[] = {
 	{
 		.name = "TLV320AIC3X",
@@ -177,7 +195,7 @@ static struct snd_soc_dai_link da8xx_evm_dai = {
 	.ops = &evm_ops,
 };
 
-/* davinci dm6446, dm355 or dm365 evm audio machine driver */
+/* davinci dm6446, dm355 evm audio machine driver */
 static struct snd_soc_card snd_soc_card_evm = {
 	.name = "DaVinci EVM",
 	.platform = &davinci_soc_platform,
@@ -185,6 +203,15 @@ static struct snd_soc_card snd_soc_card_evm = {
 	.num_links = 1,
 };
 
+/* davinci dm365 evm audio machine driver */
+static struct snd_soc_card dm365_snd_soc_card_evm = {
+	.name = "DaVinci DM365 EVM",
+	.platform = &davinci_soc_platform,
+	.dai_link = &dm365_evm_dai,
+	.num_links = 1,
+};
+
+
 /* davinci dm6467 evm audio machine driver */
 static struct snd_soc_card dm6467_snd_soc_card_evm = {
 	.name = "DaVinci DM6467 EVM",
@@ -217,6 +244,17 @@ static struct snd_soc_device evm_snd_devdata = {
 };
 
 /* evm audio subsystem */
+static struct snd_soc_device dm365_evm_snd_devdata = {
+	.card = &dm365_snd_soc_card_evm,
+#ifdef CONFIG_SND_DM365_AIC3X_CODEC
+	.codec_dev = &soc_codec_dev_aic3x,
+	.codec_data = &aic3x_setup,
+#elif defined(CONFIG_SND_DM365_VOICE_CODEC)
+	.codec_dev = &soc_codec_dev_cq93vc,
+#endif
+};
+
+/* evm audio subsystem */
 static struct snd_soc_device dm6467_evm_snd_devdata = {
 	.card = &dm6467_snd_soc_card_evm,
 	.codec_dev = &soc_codec_dev_aic3x,
@@ -244,12 +282,15 @@ static int __init evm_init(void)
 	int index;
 	int ret;
 
-	if (machine_is_davinci_evm() || machine_is_davinci_dm365_evm()) {
+	if (machine_is_davinci_evm()) {
 		evm_snd_dev_data = &evm_snd_devdata;
 		index = 0;
 	} else if (machine_is_davinci_dm355_evm()) {
 		evm_snd_dev_data = &evm_snd_devdata;
 		index = 1;
+	} else if (machine_is_davinci_dm365_evm()) {
+		evm_snd_dev_data = &dm365_evm_snd_devdata;
+		index = 0;
 	} else if (machine_is_davinci_dm6467_evm()) {
 		evm_snd_dev_data = &dm6467_evm_snd_devdata;
 		index = 0;
-- 
1.6.0.4
