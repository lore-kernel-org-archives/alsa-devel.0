From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 04/19] ASoC: mrst_machine: add speaker widget
 to moorestown machine driver
Date: Wed, 04 May 2011 21:45:14 +0800
Message-ID: <20110504134514.32443.76742.stgit@localhost>
References: <20110504133756.32443.6282.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 55909103943
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 15:43:52 +0200 (CEST)
In-Reply-To: <20110504133756.32443.6282.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Koul Vinod <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

This internal speaker needs an extra GPIO to control its power.

Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/mid-x86/mrst_machine.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mid-x86/mrst_machine.c b/sound/soc/mid-x86/mrst_machine.c
index 11163e7..0bce388 100644
--- a/sound/soc/mid-x86/mrst_machine.c
+++ b/sound/soc/mid-x86/mrst_machine.c
@@ -36,8 +36,24 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
+/*
+ * GPIO pin to power on/off Internal Speaker
+ */
+static int mrst_gpio_amp;
+
+static int mrst_speaker_event(struct snd_soc_dapm_widget *widget,
+			      struct snd_kcontrol *control, int event)
+{
+	if (mrst_gpio_amp)
+		gpio_set_value_cansleep(mrst_gpio_amp,
+					SND_SOC_DAPM_EVENT_ON(event));
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget mrst_audio_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_SPK("Speaker", mrst_speaker_event),
 };
 
 static const struct snd_soc_dapm_route mrst_audio_map[] = {
@@ -46,6 +62,9 @@ static const struct snd_soc_dapm_route mrst_audio_map[] = {
 
 	{"Headphone", NULL, "HPOUTL"},
 	{"Headphone", NULL, "HPOUTR"},
+
+	{"Speaker", NULL, "PREOUTL"},
+	{"Speaker", NULL, "PREOUTR"},
 };
 
 static int mrst_audio_init(struct snd_soc_pcm_runtime *runtime)
@@ -72,6 +91,7 @@ static int mrst_audio_init(struct snd_soc_pcm_runtime *runtime)
 	snd_soc_dapm_nc_pin(dapm, "LINEOUTR");
 
 	snd_soc_dapm_enable_pin(dapm, "Headphone");
+	snd_soc_dapm_disable_pin(dapm, "Speaker");
 
 	snd_soc_dapm_sync(dapm);
 
@@ -118,6 +138,13 @@ static int __devinit snd_mrst_audio_probe(struct platform_device *pdev)
 {
 	int ret;
 
+	if (pdev->dev.platform_data) {
+		mrst_gpio_amp = *(int *)pdev->dev.platform_data;
+		if (gpio_request_one(mrst_gpio_amp,
+				     GPIOF_OUT_INIT_LOW, "amp power"))
+			mrst_gpio_amp = 0;
+	}
+
 	snd_soc_card_mrst.dev = &pdev->dev;
 	ret = snd_soc_register_card(&snd_soc_card_mrst);
 	if (ret)
@@ -126,11 +153,15 @@ static int __devinit snd_mrst_audio_probe(struct platform_device *pdev)
 	return 0;
 
 fail_register_card:
+	if (mrst_gpio_amp)
+		gpio_free(mrst_gpio_amp);
 	return ret;
 }
 
 static int __devexit snd_mrst_audio_remove(struct platform_device *pdev)
 {
+	if (mrst_gpio_amp)
+		gpio_free(mrst_gpio_amp);
 	snd_soc_unregister_card(&snd_soc_card_mrst);
 	return 0;
 }
