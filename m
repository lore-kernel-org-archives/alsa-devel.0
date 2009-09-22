From: miguel.aguilar@ridgerun.com
Subject: [PATCH 4/4] DaVinci: DM365: Add voice codec support
	for DM365 EVM
Date: Tue, 22 Sep 2009 13:30:49 -0600
Message-ID: <1253647849-32727-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 750AF103893
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Sep 2009 21:30:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: nsnehaprabha@ti.com, davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org
Cc: santiago.nunez@ridgerun.com, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, Miguel Aguilar <miguel.aguilar@ridgerun.com>
List-Id: alsa-devel@alsa-project.org

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

This patch enables the voice codec support for the DM365 EVM.

For the DM365 EVM only one codec is able to be enabled at time,
external (AIC3101) or internal (Voice Codec CQ0093). Either internal
or external codec can be selected in the configuration menu.

This patch was created based on the temp/asoc branch of the DaVinci
git and it assumes that the patch "[PATCH v4 2/2] ASoC: Davinci:
Add audio codec support for DM365 EVM" is applied.

This patch was tested on the DM365 EVM rev C.

Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 arch/arm/mach-davinci/board-dm365-evm.c |    4 +++
 sound/soc/davinci/davinci-evm.c         |   42 +++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
index 77f815c..083b8d7 100644
--- a/arch/arm/mach-davinci/board-dm365-evm.c
+++ b/arch/arm/mach-davinci/board-dm365-evm.c
@@ -482,7 +482,11 @@ static __init void dm365_evm_init(void)
 	/* maybe setup mmc1/etc ... _after_ mmc0 */
 	evm_init_cpld();
 
+#if defined(CONFIG_SND_DM365_EXTERNAL_CODEC)
 	dm365_init_asp(&dm365_evm_snd_data);
+#elif defined(CONFIG_SND_DM365_INTERNAL_CODEC)
+	dm365_init_vcif(&dm365_evm_snd_data);
+#endif
 }
 
 static __init void dm365_evm_irq_init(void)
diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 7ccbe66..e826a80 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -28,9 +28,11 @@
 #include <mach/mux.h>
 
 #include "../codecs/tlv320aic3x.h"
+#include "../codecs/cq93vc.h"
 #include "../codecs/spdif_transciever.h"
 #include "davinci-pcm.h"
 #include "davinci-i2s.h"
+#include "davinci-vcif.h"
 #include "davinci-mcasp.h"
 
 #define AUDIO_FORMAT (SND_SOC_DAIFMT_DSP_B | \
@@ -151,6 +153,15 @@ static struct snd_soc_dai_link evm_dai = {
 	.ops = &evm_ops,
 };
 
+#ifdef CONFIG_SND_DM365_INTERNAL_CODEC
+static struct snd_soc_dai_link cq93vc_evm_dai = {
+	.name = "CQ93VC",
+	.stream_name = "CQ93",
+	.cpu_dai = &davinci_vcif_dai,
+	.codec_dai = &cq93vc_dai,
+};
+#endif
+
 static struct snd_soc_dai_link dm6467_evm_dai[] = {
 	{
 		.name = "TLV320AIC3X",
@@ -177,7 +188,7 @@ static struct snd_soc_dai_link da8xx_evm_dai = {
 	.ops = &evm_ops,
 };
 
-/* davinci dm6446, dm355 or dm365 evm audio machine driver */
+/* davinci dm6446, dm355 evm audio machine driver */
 static struct snd_soc_card snd_soc_card_evm = {
 	.name = "DaVinci EVM",
 	.platform = &davinci_soc_platform,
@@ -185,6 +196,19 @@ static struct snd_soc_card snd_soc_card_evm = {
 	.num_links = 1,
 };
 
+/* davinci dm365 evm audio machine driver external or internal */
+static struct snd_soc_card dm365_snd_soc_card_evm = {
+#if defined(CONFIG_SND_DM365_EXTERNAL_CODEC)
+	.name = "DaVinci DM365 EVM",
+	.dai_link = &evm_dai,
+#elif defined(CONFIG_SND_DM365_INTERNAL_CODEC)
+	.name = "On-chip Voice Codec",
+	.dai_link = &cq93vc_evm_dai,
+#endif
+	.platform = &davinci_soc_platform,
+	.num_links = 1,
+};
+
 /* davinci dm6467 evm audio machine driver */
 static struct snd_soc_card dm6467_snd_soc_card_evm = {
 	.name = "DaVinci DM6467 EVM",
@@ -217,6 +241,17 @@ static struct snd_soc_device evm_snd_devdata = {
 };
 
 /* evm audio subsystem */
+static struct snd_soc_device dm365_evm_snd_devdata = {
+	.card = &dm365_snd_soc_card_evm,
+#if defined(CONFIG_SND_DM365_EXTERNAL_CODEC)
+	.codec_dev = &soc_codec_dev_aic3x,
+	.codec_data = &aic3x_setup,
+#elif defined(CONFIG_SND_DM365_INTERNAL_CODEC)
+	.codec_dev = &soc_codec_dev_cq93vc,
+#endif
+};
+
+/* evm audio subsystem */
 static struct snd_soc_device dm6467_evm_snd_devdata = {
 	.card = &dm6467_snd_soc_card_evm,
 	.codec_dev = &soc_codec_dev_aic3x,
@@ -244,12 +279,15 @@ static int __init evm_init(void)
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
