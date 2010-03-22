From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v2] ASoC: TWL4030: PM fix for output amplifiers
Date: Mon, 22 Mar 2010 17:46:37 +0200
Message-ID: <1269272797-3471-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 03ABA2444C
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 16:47:10 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Gain controls on outputs affect the power consumption
when the gain is set to non 0 value.

Outputs with amps have one register to configure the
routing and the gain:
PREDL_CTL (0x25):
bit 0: Voice enable
bit 1: Audio L1 enable
bit 2: Audio L2 enable
bit 3: Audio R2 enable
bit 4-5: Gain (0x0 - power down, 0x1 - 6dB, 0x2 - 0dB, 0x3 - -6dB)

bit 0 - 3: is handled in DAPM domain (DAPM_MIXER)
bit 4 - 5: has simple volume control

If there is no audio activity (BIAS_STANDBY), and
user changes the volume, than the output amplifier will
be enabled.
If the user changes the routing (but the codec remains in
BIAS_STANDBY), than the cached gain value also be written
to the register, which enables the amplifier.

The existing workaround for this is to have virtual
PGAs associated with the outputs, and whit DAPM PMD
the gain on the output will be forced to 0 (off) by
bypassing the regcache.
This failed to disable the amplifiers in several
scenario (as mentioned above).

Also if the codec is in BIAS_ON state, and user modifies
a volume control, which path is actually not enabled, than
that amplifier will be enabled as well, but it will
be not turned off, since there is no DAPM path, which
would make mute it.

To prevent amps being enabled, when they are not
needed, introduce the following workaround:
Track the state of each of this type of output.
In twl4030_write only allow actual write, when the
given output is enabled, otherwise only update
the reg_cache.
The PGA event handlers on power up will write the cached
value to the chip (restoring gain, routing selection).
On power down 0 is written to the register (disabling
the amp, and also just in case clearing the routing).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/twl4030.c |   72 ++++++++++++++++++++++++++++++++++----------
 1 files changed, 56 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 6f5d4af..bf59b8a 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -135,9 +135,11 @@ struct twl4030_priv {
 
 	unsigned int sysclk;
 
-	/* Headset output state handling */
-	unsigned int hsl_enabled;
-	unsigned int hsr_enabled;
+	/* Output (with associated amp) states */
+	u8 hsl_enabled, hsr_enabled;
+	u8 earpiece_enabled;
+	u8 predrivel_enabled, predriver_enabled;
+	u8 carkitl_enabled, carkitr_enabled;
 };
 
 /*
@@ -173,12 +175,47 @@ static inline void twl4030_write_reg_cache(struct snd_soc_codec *codec,
 static int twl4030_write(struct snd_soc_codec *codec,
 			unsigned int reg, unsigned int value)
 {
+	struct twl4030_priv *twl4030 = codec->private_data;
+	int write_to_reg = 0;
+
 	twl4030_write_reg_cache(codec, reg, value);
-	if (likely(reg < TWL4030_REG_SW_SHADOW))
-		return twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE, value,
-					    reg);
-	else
-		return 0;
+	if (likely(reg < TWL4030_REG_SW_SHADOW)) {
+		/* Decide if the given register can be written */
+		switch (reg) {
+		case TWL4030_REG_EAR_CTL:
+			if (twl4030->earpiece_enabled)
+				write_to_reg = 1;
+			break;
+		case TWL4030_REG_PREDL_CTL:
+			if (twl4030->predrivel_enabled)
+				write_to_reg = 1;
+			break;
+		case TWL4030_REG_PREDR_CTL:
+			if (twl4030->predriver_enabled)
+				write_to_reg = 1;
+			break;
+		case TWL4030_REG_PRECKL_CTL:
+			if (twl4030->carkitl_enabled)
+				write_to_reg = 1;
+			break;
+		case TWL4030_REG_PRECKR_CTL:
+			if (twl4030->carkitr_enabled)
+				write_to_reg = 1;
+			break;
+		case TWL4030_REG_HS_GAIN_SET:
+			if (twl4030->hsl_enabled || twl4030->hsr_enabled)
+				write_to_reg = 1;
+			break;
+		default:
+			/* All other register can be written */
+			write_to_reg = 1;
+			break;
+		}
+		if (write_to_reg)
+			return twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
+						    value, reg);
+	}
+	return 0;
 }
 
 static void twl4030_codec_enable(struct snd_soc_codec *codec, int enable)
@@ -525,26 +562,26 @@ static int micpath_event(struct snd_soc_dapm_widget *w,
  * Output PGA builder:
  * Handle the muting and unmuting of the given output (turning off the
  * amplifier associated with the output pin)
- * On mute bypass the reg_cache and mute the volume
- * On unmute: restore the register content
+ * On mute bypass the reg_cache and write 0 to the register
+ * On unmute: restore the register content from the reg_cache
  * Outputs handled in this way:  Earpiece, PreDrivL/R, CarkitL/R
  */
 #define TWL4030_OUTPUT_PGA(pin_name, reg, mask)				\
 static int pin_name##pga_event(struct snd_soc_dapm_widget *w,		\
 		struct snd_kcontrol *kcontrol, int event)		\
 {									\
-	u8 reg_val;							\
+	struct twl4030_priv *twl4030 = w->codec->private_data;		\
 									\
 	switch (event) {						\
 	case SND_SOC_DAPM_POST_PMU:					\
+		twl4030->pin_name##_enabled = 1;			\
 		twl4030_write(w->codec, reg,				\
 			twl4030_read_reg_cache(w->codec, reg));		\
 		break;							\
 	case SND_SOC_DAPM_POST_PMD:					\
-		reg_val = twl4030_read_reg_cache(w->codec, reg);	\
-		twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,	\
-					reg_val & (~mask),		\
-					reg);				\
+		twl4030->pin_name##_enabled = 0;			\
+		twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,		\
+					0, reg);			\
 		break;							\
 	}								\
 	return 0;							\
@@ -664,7 +701,10 @@ static void headset_ramp(struct snd_soc_codec *codec, int ramp)
 		/* Headset ramp-up according to the TRM */
 		hs_pop |= TWL4030_VMID_EN;
 		twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
-		twl4030_write(codec, TWL4030_REG_HS_GAIN_SET, hs_gain);
+		/* Actually write to the register */
+		twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
+					hs_gain,
+					TWL4030_REG_HS_GAIN_SET);
 		hs_pop |= TWL4030_RAMP_EN;
 		twl4030_write(codec, TWL4030_REG_HS_POPN_SET, hs_pop);
 		/* Wait ramp delay time + 1, so the VMID can settle */
-- 
1.7.0.2
