From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: add 5 band graphic equalizer"
	to the asoc tree
Date: Mon, 19 Feb 2018 12:18:21 +0000
Message-ID: <E1enkOj-0002j9-Cl@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E32C2673D6
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 13:18:22 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michal Oleszczyk <oleszczyk.m@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sgtl5000: add 5 band graphic equalizer

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 92a2742f9813ef65da19145a77e8067d6abbc822 Mon Sep 17 00:00:00 2001
From: Michal Oleszczyk <oleszczyk.m@gmail.com>
Date: Mon, 19 Feb 2018 10:03:46 +0100
Subject: [PATCH] ASoC: sgtl5000: add 5 band graphic equalizer

Enable 5-band graphic equalizer which allows manipulation of
gain in range -11.75dB to 12dB for 5 specific sound bands:
115Hz, 330Hz, 990Hz, 3000Hz, 9900Hz.

Signed-off-by: Michal Oleszczyk <oleszczyk.m@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 24 +++++++++++++++++++++---
 sound/soc/codecs/sgtl5000.h |  7 +++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 1724c4622052..7c1d65830c05 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -520,6 +520,9 @@ static const DECLARE_TLV_DB_RANGE(mic_gain_tlv,
 /* tlv for DAP channels, 0% - 100% - 200% */
 static const DECLARE_TLV_DB_SCALE(dap_volume, 0, 1, 0);
 
+/* tlv for bass bands, -11.75db to 12.0db, step .25db */
+static const DECLARE_TLV_DB_SCALE(bass_band, -1175, 25, 0);
+
 /* tlv for hp volume, -51.5db to 12.0db, step .5db */
 static const DECLARE_TLV_DB_SCALE(headphone_volume, -5150, 50, 0);
 
@@ -585,6 +588,21 @@ static const struct snd_kcontrol_new sgtl5000_snd_controls[] = {
 	SOC_SINGLE_EXT_TLV("AVC Threshold Volume", SGTL5000_DAP_AVC_THRESHOLD,
 			0, 96, 0, avc_get_threshold, avc_put_threshold,
 			avc_threshold),
+
+	SOC_SINGLE_TLV("BASS 0", SGTL5000_DAP_EQ_BASS_BAND0,
+	0, 0x5F, 0, bass_band),
+
+	SOC_SINGLE_TLV("BASS 1", SGTL5000_DAP_EQ_BASS_BAND1,
+	0, 0x5F, 0, bass_band),
+
+	SOC_SINGLE_TLV("BASS 2", SGTL5000_DAP_EQ_BASS_BAND2,
+	0, 0x5F, 0, bass_band),
+
+	SOC_SINGLE_TLV("BASS 3", SGTL5000_DAP_EQ_BASS_BAND3,
+	0, 0x5F, 0, bass_band),
+
+	SOC_SINGLE_TLV("BASS 4", SGTL5000_DAP_EQ_BASS_BAND4,
+	0, 0x5F, 0, bass_band),
 };
 
 /* mute the codec used by alsa core */
@@ -1303,11 +1321,11 @@ static int sgtl5000_probe(struct snd_soc_component *component)
 			SGTL5000_BIAS_VOLT_MASK,
 			sgtl5000->micbias_voltage << SGTL5000_BIAS_VOLT_SHIFT);
 	/*
-	 * disable DAP
+	 * enable DAP Graphic EQ
 	 * TODO:
-	 * Enable DAP in kcontrol and dapm.
+	 * Add control for changing between PEQ/Tone Control/GEQ
 	 */
-	snd_soc_component_write(component, SGTL5000_DAP_CTRL, 0);
+	snd_soc_component_write(component, SGTL5000_DAP_AUDIO_EQ, SGTL5000_DAP_SEL_GEQ);
 
 	/* Unmute DAC after start */
 	snd_soc_component_update_bits(component, SGTL5000_CHIP_ADCDAC_CTRL,
diff --git a/sound/soc/codecs/sgtl5000.h b/sound/soc/codecs/sgtl5000.h
index 22f3442af982..28cf637155bb 100644
--- a/sound/soc/codecs/sgtl5000.h
+++ b/sound/soc/codecs/sgtl5000.h
@@ -399,4 +399,11 @@
 #define SGTL5000_SYSCLK				0x00
 #define SGTL5000_LRCLK				0x01
 
+/*
+ * SGTL5000_DAP_AUDIO_EQ
+ */
+#define SGTL5000_DAP_SEL_PEQ			1
+#define SGTL5000_DAP_SEL_TONE_CTRL		2
+#define SGTL5000_DAP_SEL_GEQ			3
+
 #endif
-- 
2.16.1
