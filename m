From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Don't use write sequencer to power
	up WM8903
Date: Thu, 10 Feb 2011 14:44:47 +0000
Message-ID: <1297349088-26820-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1297349088-26820-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 62BE924525
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 15:44:52 +0100 (CET)
In-Reply-To: <1297349088-26820-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The write sequencer sequencer sequence takes longer than is desirable
as it brings up a full playback path which is not required at this
point. Open coding the sequence cuts the startup time by two thirds.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |   73 +++++++++++++++++++++++++++++++++------------
 1 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 9156086..c7faeea 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -302,15 +302,6 @@ static int wm8903_run_sequence(struct snd_soc_codec *codec, unsigned int start)
 	return 0;
 }
 
-static void wm8903_sync_reg_cache(struct snd_soc_codec *codec, u16 *cache)
-{
-	int i;
-
-	/* There really ought to be something better we can do here :/ */
-	for (i = 0; i < ARRAY_SIZE(wm8903_reg_defaults); i++)
-		cache[i] = codec->hw_read(codec, i);
-}
-
 static void wm8903_reset(struct snd_soc_codec *codec)
 {
 	snd_soc_write(codec, WM8903_SW_RESET_AND_ID, 0);
@@ -1147,6 +1138,7 @@ static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		break;
+
 	case SND_SOC_BIAS_PREPARE:
 		snd_soc_update_bits(codec, WM8903_VMID_CONTROL_0,
 				    WM8903_VMID_RES_MASK,
@@ -1155,16 +1147,59 @@ static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
-			snd_soc_write(codec, WM8903_CLOCK_RATES_2,
-				     WM8903_CLK_SYS_ENA);
-
-			/* Change DC servo dither level in startup sequence */
-			snd_soc_write(codec, WM8903_WRITE_SEQUENCER_0, 0x11);
-			snd_soc_write(codec, WM8903_WRITE_SEQUENCER_1, 0x1257);
-			snd_soc_write(codec, WM8903_WRITE_SEQUENCER_2, 0x2);
-
-			wm8903_run_sequence(codec, 0);
-			wm8903_sync_reg_cache(codec, codec->reg_cache);
+			snd_soc_update_bits(codec, WM8903_BIAS_CONTROL_0,
+					    WM8903_POBCTRL | WM8903_ISEL_MASK |
+					    WM8903_STARTUP_BIAS_ENA |
+					    WM8903_BIAS_ENA,
+					    WM8903_POBCTRL |
+					    (2 << WM8903_ISEL_SHIFT) |
+					    WM8903_STARTUP_BIAS_ENA);
+
+			snd_soc_update_bits(codec,
+					    WM8903_ANALOGUE_SPK_OUTPUT_CONTROL_0,
+					    WM8903_SPK_DISCHARGE,
+					    WM8903_SPK_DISCHARGE);
+
+			msleep(33);
+
+			snd_soc_update_bits(codec, WM8903_POWER_MANAGEMENT_5,
+					    WM8903_SPKL_ENA | WM8903_SPKR_ENA,
+					    WM8903_SPKL_ENA | WM8903_SPKR_ENA);
+
+			snd_soc_update_bits(codec,
+					    WM8903_ANALOGUE_SPK_OUTPUT_CONTROL_0,
+					    WM8903_SPK_DISCHARGE, 0);
+
+			snd_soc_update_bits(codec, WM8903_VMID_CONTROL_0,
+					    WM8903_VMID_TIE_ENA |
+					    WM8903_BUFIO_ENA |
+					    WM8903_VMID_IO_ENA |
+					    WM8903_VMID_SOFT_MASK |
+					    WM8903_VMID_RES_MASK |
+					    WM8903_VMID_BUF_ENA,
+					    WM8903_VMID_TIE_ENA |
+					    WM8903_BUFIO_ENA |
+					    WM8903_VMID_IO_ENA |
+					    (2 << WM8903_VMID_SOFT_SHIFT) |
+					    WM8903_VMID_RES_250K |
+					    WM8903_VMID_BUF_ENA);
+
+			msleep(129);
+
+			snd_soc_update_bits(codec, WM8903_POWER_MANAGEMENT_5,
+					    WM8903_SPKL_ENA | WM8903_SPKR_ENA,
+					    0);
+
+			snd_soc_update_bits(codec, WM8903_VMID_CONTROL_0,
+					    WM8903_VMID_SOFT_MASK, 0);
+
+			snd_soc_update_bits(codec, WM8903_VMID_CONTROL_0,
+					    WM8903_VMID_RES_MASK,
+					    WM8903_VMID_RES_50K);
+
+			snd_soc_update_bits(codec, WM8903_BIAS_CONTROL_0,
+					    WM8903_BIAS_ENA | WM8903_POBCTRL,
+					    WM8903_BIAS_ENA);
 
 			/* By default no bypass paths are enabled so
 			 * enable Class W support.
-- 
1.7.2.3
