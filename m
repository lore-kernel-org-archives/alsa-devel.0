From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] soc - neo1973_wm8753.c cleanup checkpatch
	issues
Date: Wed, 30 Apr 2008 15:19:03 +0100
Message-ID: <1209565146-32393-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6212C245F2
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Apr 2008 16:19:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Graeme Gregory <graeme@openmoko.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Graeme Gregory <graeme@openmoko.org>

Clean up a few issues with the file that checkpatch noted, no functionality
changes.

Signed-off-by: Graeme Gregory <graeme@openmoko.org>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/neo1973_wm8753.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/s3c24xx/neo1973_wm8753.c b/sound/soc/s3c24xx/neo1973_wm8753.c
index 962cc20..e2339b9 100644
--- a/sound/soc/s3c24xx/neo1973_wm8753.c
+++ b/sound/soc/s3c24xx/neo1973_wm8753.c
@@ -33,7 +33,7 @@
 #include <asm/arch/regs-gpio.h>
 #include <asm/hardware.h>
 #include <asm/arch/audio.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/arch/spi-gpio.h>
 
 #include <asm/plat-s3c24xx/regs-iis.h>
@@ -122,7 +122,7 @@ static int neo1973_hifi_hw_params(struct snd_pcm_substream *substream,
 
 	/* set MCLK division for sample rate */
 	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai, S3C24XX_DIV_MCLK,
-		S3C2410_IISMOD_32FS );
+		S3C2410_IISMOD_32FS);
 	if (ret < 0)
 		return ret;
 
@@ -133,7 +133,7 @@ static int neo1973_hifi_hw_params(struct snd_pcm_substream *substream,
 
 	/* set prescaler division for sample rate */
 	ret = cpu_dai->dai_ops.set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
-		S3C24XX_PRESCALE(4,4));
+		S3C24XX_PRESCALE(4, 4));
 	if (ret < 0)
 		return ret;
 
@@ -222,7 +222,7 @@ static struct snd_soc_ops neo1973_voice_ops = {
 	.hw_free = neo1973_voice_hw_free,
 };
 
-static int neo1973_scenario = 0;
+static int neo1973_scenario;
 
 static int neo1973_get_scenario(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
@@ -233,7 +233,7 @@ static int neo1973_get_scenario(struct snd_kcontrol *kcontrol,
 
 static int set_scenario_endpoints(struct snd_soc_codec *codec, int scenario)
 {
-	switch(neo1973_scenario) {
+	switch (neo1973_scenario) {
 	case NEO_AUDIO_OFF:
 		snd_soc_dapm_set_endpoint(codec, "Audio Out",    0);
 		snd_soc_dapm_set_endpoint(codec, "GSM Line Out", 0);
@@ -334,7 +334,7 @@ static void lm4857_write_regs(void)
 static int lm4857_get_reg(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	int reg=kcontrol->private_value & 0xFF;
+	int reg = kcontrol->private_value & 0xFF;
 	int shift = (kcontrol->private_value >> 8) & 0x0F;
 	int mask = (kcontrol->private_value >> 16) & 0xFF;
 
@@ -349,11 +349,11 @@ static int lm4857_set_reg(struct snd_kcontrol *kcontrol,
 	int shift = (kcontrol->private_value >> 8) & 0x0F;
 	int mask = (kcontrol->private_value >> 16) & 0xFF;
 
-	if (((lm4857_regs[reg] >> shift ) & mask) ==
+	if (((lm4857_regs[reg] >> shift) & mask) ==
 		ucontrol->value.integer.value[0])
 		return 0;
 
-	lm4857_regs[reg] &= ~ (mask << shift);
+	lm4857_regs[reg] &= ~(mask << shift);
 	lm4857_regs[reg] |= ucontrol->value.integer.value[0] << shift;
 	lm4857_write_regs();
 	return 1;
@@ -398,7 +398,7 @@ static const struct snd_soc_dapm_widget wm8753_dapm_widgets[] = {
 
 
 /* example machine audio_mapnections */
-static const char* audio_map[][3] = {
+static const char *audio_map[][3] = {
 
 	/* Connections to the lm4857 amp */
 	{"Audio Out", NULL, "LOUT1"},
@@ -450,7 +450,7 @@ static const char *neo_scenarios[] = {
 };
 
 static const struct soc_enum neo_scenario_enum[] = {
-	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(neo_scenarios),neo_scenarios),
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(neo_scenarios), neo_scenarios),
 };
 
 static const struct snd_kcontrol_new wm8753_neo1973_controls[] = {
@@ -521,8 +521,8 @@ static int neo1973_wm8753_init(struct snd_soc_codec *codec)
 /*
  * BT Codec DAI
  */
-static struct snd_soc_cpu_dai bt_dai =
-{	.name = "Bluetooth",
+static struct snd_soc_cpu_dai bt_dai = {
+	.name = "Bluetooth",
 	.id = 0,
 	.type = SND_SOC_DAI_PCM,
 	.playback = {
-- 
1.5.5.1
