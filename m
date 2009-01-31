From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] ASoC: Update OMAP3 pandora board file
Date: Sat, 31 Jan 2009 16:29:24 +0200
Message-ID: <1233412164-22206-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.188])
	by alsa0.perex.cz (Postfix) with ESMTP id B68E724341
	for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2009 15:29:31 +0100 (CET)
Received: by fk-out-0910.google.com with SMTP id 26so793485fkx.0
	for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2009 06:29:30 -0800 (PST)
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
Cc: peter.ujfalusi@nokia.com, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

Update pandora board file for recent TWL4030 codec changes.
Also move output related snd_soc_dapm_nc_pin() calls to
omap3pandora_out_init(), where they belong.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 sound/soc/omap/omap3pandora.c |   49 ++++++++++++++++++++++++----------------
 1 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index fcc2f5d..fe282d4 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -143,7 +143,7 @@ static const struct snd_soc_dapm_widget omap3pandora_out_dapm_widgets[] = {
 };
 
 static const struct snd_soc_dapm_widget omap3pandora_in_dapm_widgets[] = {
-	SND_SOC_DAPM_MIC("Mic (Internal)", NULL),
+	SND_SOC_DAPM_MIC("Mic (internal)", NULL),
 	SND_SOC_DAPM_MIC("Mic (external)", NULL),
 	SND_SOC_DAPM_LINE("Line In", NULL),
 };
@@ -155,16 +155,33 @@ static const struct snd_soc_dapm_route omap3pandora_out_map[] = {
 };
 
 static const struct snd_soc_dapm_route omap3pandora_in_map[] = {
-	{"INL", NULL, "Line In"},
-	{"INR", NULL, "Line In"},
-	{"INL", NULL, "Mic (Internal)"},
-	{"INR", NULL, "Mic (external)"},
+	{"AUXL", NULL, "Line In"},
+	{"AUXR", NULL, "Line In"},
+
+	{"MAINMIC", NULL, "Mic Bias 1"},
+	{"Mic Bias 1", NULL, "Mic (internal)"},
+
+	{"SUBMIC", NULL, "Mic Bias 2"},
+	{"Mic Bias 2", NULL, "Mic (external)"},
 };
 
 static int omap3pandora_out_init(struct snd_soc_codec *codec)
 {
 	int ret;
 
+	/* All TWL4030 output pins are floating */
+	snd_soc_dapm_nc_pin(codec, "OUTL");
+	snd_soc_dapm_nc_pin(codec, "OUTR");
+	snd_soc_dapm_nc_pin(codec, "EARPIECE");
+	snd_soc_dapm_nc_pin(codec, "PREDRIVEL");
+	snd_soc_dapm_nc_pin(codec, "PREDRIVER");
+	snd_soc_dapm_nc_pin(codec, "HSOL");
+	snd_soc_dapm_nc_pin(codec, "HSOR");
+	snd_soc_dapm_nc_pin(codec, "CARKITL");
+	snd_soc_dapm_nc_pin(codec, "CARKITR");
+	snd_soc_dapm_nc_pin(codec, "HFL");
+	snd_soc_dapm_nc_pin(codec, "HFR");
+
 	ret = snd_soc_dapm_new_controls(codec, omap3pandora_out_dapm_widgets,
 				ARRAY_SIZE(omap3pandora_out_dapm_widgets));
 	if (ret < 0)
@@ -180,18 +197,11 @@ static int omap3pandora_in_init(struct snd_soc_codec *codec)
 {
 	int ret;
 
-	/* All TWL4030 output pins are floating */
-	snd_soc_dapm_nc_pin(codec, "OUTL"),
-	snd_soc_dapm_nc_pin(codec, "OUTR"),
-	snd_soc_dapm_nc_pin(codec, "EARPIECE"),
-	snd_soc_dapm_nc_pin(codec, "PREDRIVEL"),
-	snd_soc_dapm_nc_pin(codec, "PREDRIVER"),
-	snd_soc_dapm_nc_pin(codec, "HSOL"),
-	snd_soc_dapm_nc_pin(codec, "HSOR"),
-	snd_soc_dapm_nc_pin(codec, "CARKITL"),
-	snd_soc_dapm_nc_pin(codec, "CARKITR"),
-	snd_soc_dapm_nc_pin(codec, "HFL"),
-	snd_soc_dapm_nc_pin(codec, "HFR"),
+	/* Not comnnected */
+	snd_soc_dapm_nc_pin(codec, "HSMIC");
+	snd_soc_dapm_nc_pin(codec, "CARKITMIC");
+	snd_soc_dapm_nc_pin(codec, "DIGIMIC0");
+	snd_soc_dapm_nc_pin(codec, "DIGIMIC1");
 
 	ret = snd_soc_dapm_new_controls(codec, omap3pandora_in_dapm_widgets,
 				ARRAY_SIZE(omap3pandora_in_dapm_widgets));
@@ -251,10 +261,9 @@ static int __init omap3pandora_soc_init(void)
 {
 	int ret;
 
-	if (!machine_is_omap3_pandora()) {
-		pr_debug(PREFIX "Not OMAP3 Pandora\n");
+	if (!machine_is_omap3_pandora())
 		return -ENODEV;
-	}
+
 	pr_info("OMAP3 Pandora SoC init\n");
 
 	ret = gpio_request(OMAP3_PANDORA_DAC_POWER_GPIO, "dac_power");
-- 
1.5.6.3
