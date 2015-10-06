From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 09/18] ALSA: hda: move patch_ca0132.c to use
	hdac helpers
Date: Tue,  6 Oct 2015 16:07:46 +0100
Message-ID: <1444144075-28963-10-git-send-email-vinod.koul@intel.com>
References: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id E1DBD265926
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:10:32 +0200 (CEST)
In-Reply-To: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Move patch_ca0132.c to use newly moved snd_hdac_read/write_codec()
APIs.

This was done using coccinelle script

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/patch_ca0132.c | 223 ++++++++++++++++++++++---------------------
 1 file changed, 114 insertions(+), 109 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 186792fe226e..60622c306a6f 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -789,7 +789,7 @@ static unsigned int codec_send_command(struct hda_codec *codec, hda_nid_t nid,
 		unsigned int verb, unsigned int parm, unsigned int *res)
 {
 	unsigned int response;
-	response = snd_hda_codec_read(codec, nid, 0, verb, parm);
+	response = snd_hdac_codec_read(&codec->core, nid, 0, verb, parm);
 	*res = response;
 
 	return ((response == -1) ? -1 : 0);
@@ -823,8 +823,8 @@ static int chipio_send(struct hda_codec *codec,
 
 	/* send bits of data specified by reg */
 	do {
-		res = snd_hda_codec_read(codec, WIDGET_CHIP_CTRL, 0,
-					 reg, data);
+		res = snd_hdac_codec_read(&codec->core, WIDGET_CHIP_CTRL, 0,
+					  reg, data);
 		if (res == VENDOR_STATUS_CHIPIO_OK)
 			return 0;
 		msleep(20);
@@ -923,9 +923,8 @@ static int chipio_read_data(struct hda_codec *codec, unsigned int *data)
 
 	if (res != -EIO) {
 		/* read data */
-		*data = snd_hda_codec_read(codec, WIDGET_CHIP_CTRL, 0,
-					   VENDOR_CHIPIO_HIC_READ_DATA,
-					   0);
+		*data = snd_hdac_codec_read(&codec->core, WIDGET_CHIP_CTRL, 0,
+					    VENDOR_CHIPIO_HIC_READ_DATA, 0);
 	}
 
 	/*If no error encountered, automatically increment the address
@@ -1023,8 +1022,8 @@ static void chipio_set_control_flag(struct hda_codec *codec,
 
 	flag_bit = (flag_state ? 1 : 0);
 	val = (flag_bit << 7) | (flag_id);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_FLAG_SET, val);
+	snd_hdac_codec_write(&codec->core, WIDGET_CHIP_CTRL, 0,
+			     VENDOR_CHIPIO_FLAG_SET, val);
 }
 
 /*
@@ -1038,17 +1037,18 @@ static void chipio_set_control_param(struct hda_codec *codec,
 
 	if ((param_id < 32) && (param_val < 8)) {
 		val = (param_val << 5) | (param_id);
-		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-				    VENDOR_CHIPIO_PARAM_SET, val);
+		snd_hdac_codec_write(&codec->core, WIDGET_CHIP_CTRL, 0,
+				     VENDOR_CHIPIO_PARAM_SET, val);
 	} else {
 		mutex_lock(&spec->chipio_mutex);
 		if (chipio_send(codec, VENDOR_CHIPIO_STATUS, 0) == 0) {
-			snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-					    VENDOR_CHIPIO_PARAM_EX_ID_SET,
-					    param_id);
-			snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-					    VENDOR_CHIPIO_PARAM_EX_VALUE_SET,
-					    param_val);
+			snd_hdac_codec_write(&codec->core, WIDGET_CHIP_CTRL,
+					     0, VENDOR_CHIPIO_PARAM_EX_ID_SET,
+					     param_id);
+			snd_hdac_codec_write(&codec->core, WIDGET_CHIP_CTRL,
+					     0,
+					     VENDOR_CHIPIO_PARAM_EX_VALUE_SET,
+					     param_val);
 		}
 		mutex_unlock(&spec->chipio_mutex);
 	}
@@ -1073,18 +1073,18 @@ static void chipio_enable_clocks(struct hda_codec *codec)
 	struct ca0132_spec *spec = codec->spec;
 
 	mutex_lock(&spec->chipio_mutex);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_PLL_PMU_WRITE, 0xff);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 5);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_PLL_PMU_WRITE, 0x0b);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 6);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_PLL_PMU_WRITE, 0xff);
+	snd_hdac_codec_write(&codec->core, WIDGET_CHIP_CTRL, 0,
+			     VENDOR_CHIPIO_8051_ADDRESS_LOW, 0);
+	snd_hdac_codec_write(&codec->core, WIDGET_CHIP_CTRL, 0,
+			     VENDOR_CHIPIO_PLL_PMU_WRITE, 0xff);
+	snd_hdac_codec_write(&codec->core, WIDGET_CHIP_CTRL, 0,
+			     VENDOR_CHIPIO_8051_ADDRESS_LOW, 5);
+	snd_hdac_codec_write(&codec->core, WIDGET_CHIP_CTRL, 0,
+			     VENDOR_CHIPIO_PLL_PMU_WRITE, 0x0b);
+	snd_hdac_codec_write(&codec->core, WIDGET_CHIP_CTRL, 0,
+			     VENDOR_CHIPIO_8051_ADDRESS_LOW, 6);
+	snd_hdac_codec_write(&codec->core, WIDGET_CHIP_CTRL, 0,
+			     VENDOR_CHIPIO_PLL_PMU_WRITE, 0xff);
 	mutex_unlock(&spec->chipio_mutex);
 }
 
@@ -1099,7 +1099,8 @@ static int dspio_send(struct hda_codec *codec, unsigned int reg,
 
 	/* send bits of data specified by reg to dsp */
 	do {
-		res = snd_hda_codec_read(codec, WIDGET_DSP_CTRL, 0, reg, data);
+		res = snd_hdac_codec_read(&codec->core, WIDGET_DSP_CTRL, 0,
+					  reg, data);
 		if ((res >= 0) && (res != VENDOR_STATUS_DSPIO_BUSY))
 			return res;
 		msleep(20);
@@ -1117,8 +1118,8 @@ static void dspio_write_wait(struct hda_codec *codec)
 	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
 
 	do {
-		status = snd_hda_codec_read(codec, WIDGET_DSP_CTRL, 0,
-						VENDOR_DSPIO_STATUS, 0);
+		status = snd_hdac_codec_read(&codec->core, WIDGET_DSP_CTRL, 0,
+					     VENDOR_DSPIO_STATUS, 0);
 		if ((status == VENDOR_STATUS_DSPIO_OK) ||
 		    (status == VENDOR_STATUS_DSPIO_SCP_RESPONSE_QUEUE_EMPTY))
 			break;
@@ -1148,8 +1149,8 @@ static int dspio_write(struct hda_codec *codec, unsigned int scp_data)
 		goto error;
 
 	/* OK, now check if the write itself has executed*/
-	status = snd_hda_codec_read(codec, WIDGET_DSP_CTRL, 0,
-				    VENDOR_DSPIO_STATUS, 0);
+	status = snd_hdac_codec_read(&codec->core, WIDGET_DSP_CTRL, 0,
+			             VENDOR_DSPIO_STATUS, 0);
 error:
 	mutex_unlock(&spec->chipio_mutex);
 
@@ -1193,8 +1194,8 @@ static int dspio_read(struct hda_codec *codec, unsigned int *data)
 	    status == VENDOR_STATUS_DSPIO_SCP_RESPONSE_QUEUE_EMPTY)
 		return -EIO;
 
-	*data = snd_hda_codec_read(codec, WIDGET_DSP_CTRL, 0,
-				   VENDOR_DSPIO_SCP_READ_DATA, 0);
+	*data = snd_hdac_codec_read(&codec->core, WIDGET_DSP_CTRL, 0,
+				    VENDOR_DSPIO_SCP_READ_DATA, 0);
 
 	return 0;
 }
@@ -1951,20 +1952,18 @@ static int dsp_allocate_router_ports(struct hda_codec *codec,
 	val |= (ports_per_channel - 1) << 4;
 	val |= num_chans - 1;
 
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_PORT_ALLOC_CONFIG_SET,
-			    val);
+	snd_hdac_codec_write(&codec->core, WIDGET_CHIP_CTRL, 0,
+			     VENDOR_CHIPIO_PORT_ALLOC_CONFIG_SET, val);
 
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_PORT_ALLOC_SET,
-			    MEM_CONNID_DSP);
+	snd_hdac_codec_write(&codec->core, WIDGET_CHIP_CTRL, 0,
+			     VENDOR_CHIPIO_PORT_ALLOC_SET, MEM_CONNID_DSP);
 
 	status = chipio_send(codec, VENDOR_CHIPIO_STATUS, 0);
 	if (status < 0)
 		return status;
 
-	res = snd_hda_codec_read(codec, WIDGET_CHIP_CTRL, 0,
-				VENDOR_CHIPIO_PORT_ALLOC_GET, 0);
+	res = snd_hdac_codec_read(&codec->core, WIDGET_CHIP_CTRL, 0,
+				  VENDOR_CHIPIO_PORT_ALLOC_GET, 0);
 
 	*port_map = res;
 
@@ -1982,9 +1981,8 @@ static int dsp_free_router_ports(struct hda_codec *codec)
 	if (status < 0)
 		return status;
 
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_PORT_FREE_SET,
-			    MEM_CONNID_DSP);
+	snd_hdac_codec_write(&codec->core, WIDGET_CHIP_CTRL, 0,
+			     VENDOR_CHIPIO_PORT_FREE_SET, MEM_CONNID_DSP);
 
 	status = chipio_send(codec, VENDOR_CHIPIO_STATUS, 0);
 
@@ -3185,23 +3183,27 @@ static int ca0132_select_out(struct hda_codec *codec)
 			goto exit;
 
 		/* Setup EAPD */
-		snd_hda_codec_write(codec, spec->out_pins[1], 0,
-				    VENDOR_CHIPIO_EAPD_SEL_SET, 0x02);
-		snd_hda_codec_write(codec, spec->out_pins[0], 0,
-				    AC_VERB_SET_EAPD_BTLENABLE, 0x00);
-		snd_hda_codec_write(codec, spec->out_pins[0], 0,
-				    VENDOR_CHIPIO_EAPD_SEL_SET, 0x00);
-		snd_hda_codec_write(codec, spec->out_pins[0], 0,
-				    AC_VERB_SET_EAPD_BTLENABLE, 0x02);
+		snd_hdac_codec_write(&codec->core, spec->out_pins[1], 0,
+				     VENDOR_CHIPIO_EAPD_SEL_SET, 0x02);
+		snd_hdac_codec_write(&codec->core, spec->out_pins[0], 0,
+				     AC_VERB_SET_EAPD_BTLENABLE, 0x00);
+		snd_hdac_codec_write(&codec->core, spec->out_pins[0], 0,
+				     VENDOR_CHIPIO_EAPD_SEL_SET, 0x00);
+		snd_hdac_codec_write(&codec->core, spec->out_pins[0], 0,
+				     AC_VERB_SET_EAPD_BTLENABLE, 0x02);
 
 		/* disable headphone node */
-		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[1], 0,
-					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		pin_ctl = snd_hdac_codec_read(&codec->core, spec->out_pins[1],
+					      0,
+					      AC_VERB_GET_PIN_WIDGET_CONTROL,
+					      0);
 		snd_hda_set_pin_ctl(codec, spec->out_pins[1],
 				    pin_ctl & ~PIN_HP);
 		/* enable speaker node */
-		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[0], 0,
-					     AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		pin_ctl = snd_hdac_codec_read(&codec->core, spec->out_pins[0],
+					      0,
+					      AC_VERB_GET_PIN_WIDGET_CONTROL,
+					      0);
 		snd_hda_set_pin_ctl(codec, spec->out_pins[0],
 				    pin_ctl | PIN_OUT);
 	} else {
@@ -3218,23 +3220,27 @@ static int ca0132_select_out(struct hda_codec *codec)
 			goto exit;
 
 		/* Setup EAPD */
-		snd_hda_codec_write(codec, spec->out_pins[0], 0,
-				    VENDOR_CHIPIO_EAPD_SEL_SET, 0x00);
-		snd_hda_codec_write(codec, spec->out_pins[0], 0,
-				    AC_VERB_SET_EAPD_BTLENABLE, 0x00);
-		snd_hda_codec_write(codec, spec->out_pins[1], 0,
-				    VENDOR_CHIPIO_EAPD_SEL_SET, 0x02);
-		snd_hda_codec_write(codec, spec->out_pins[0], 0,
-				    AC_VERB_SET_EAPD_BTLENABLE, 0x02);
+		snd_hdac_codec_write(&codec->core, spec->out_pins[0], 0,
+				     VENDOR_CHIPIO_EAPD_SEL_SET, 0x00);
+		snd_hdac_codec_write(&codec->core, spec->out_pins[0], 0,
+				     AC_VERB_SET_EAPD_BTLENABLE, 0x00);
+		snd_hdac_codec_write(&codec->core, spec->out_pins[1], 0,
+				     VENDOR_CHIPIO_EAPD_SEL_SET, 0x02);
+		snd_hdac_codec_write(&codec->core, spec->out_pins[0], 0,
+				     AC_VERB_SET_EAPD_BTLENABLE, 0x02);
 
 		/* disable speaker*/
-		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[0], 0,
-					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		pin_ctl = snd_hdac_codec_read(&codec->core, spec->out_pins[0],
+					      0,
+					      AC_VERB_GET_PIN_WIDGET_CONTROL,
+					      0);
 		snd_hda_set_pin_ctl(codec, spec->out_pins[0],
 				    pin_ctl & ~PIN_HP);
 		/* enable headphone*/
-		pin_ctl = snd_hda_codec_read(codec, spec->out_pins[1], 0,
-					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		pin_ctl = snd_hdac_codec_read(&codec->core, spec->out_pins[1],
+					      0,
+					      AC_VERB_GET_PIN_WIDGET_CONTROL,
+					      0);
 		snd_hda_set_pin_ctl(codec, spec->out_pins[1],
 				    pin_ctl | PIN_HP);
 	}
@@ -3476,12 +3482,11 @@ static int ca0132_pe_switch_set(struct hda_codec *codec)
 static int stop_mic1(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
-	unsigned int oldval = snd_hda_codec_read(codec, spec->adcs[0], 0,
+	unsigned int oldval = snd_hdac_codec_read(&codec->core, spec->adcs[0], 0,
 						 AC_VERB_GET_CONV, 0);
 	if (oldval != 0)
-		snd_hda_codec_write(codec, spec->adcs[0], 0,
-				    AC_VERB_SET_CHANNEL_STREAMID,
-				    0);
+		snd_hdac_codec_write(&codec->core, spec->adcs[0], 0,
+				     AC_VERB_SET_CHANNEL_STREAMID, 0);
 	return oldval;
 }
 
@@ -3491,9 +3496,8 @@ static void resume_mic1(struct hda_codec *codec, unsigned int oldval)
 	struct ca0132_spec *spec = codec->spec;
 	/* Restore the previous stream and channel */
 	if (oldval != 0)
-		snd_hda_codec_write(codec, spec->adcs[0], 0,
-				    AC_VERB_SET_CHANNEL_STREAMID,
-				    oldval);
+		snd_hdac_codec_write(&codec->core, spec->adcs[0], 0,
+				     AC_VERB_SET_CHANNEL_STREAMID, oldval);
 }
 
 /*
@@ -4113,13 +4117,13 @@ static void init_output(struct hda_codec *codec, hda_nid_t pin, hda_nid_t dac)
 	if (pin) {
 		snd_hda_set_pin_ctl(codec, pin, PIN_HP);
 		if (get_wcaps(codec, pin) & AC_WCAP_OUT_AMP)
-			snd_hda_codec_write(codec, pin, 0,
-					    AC_VERB_SET_AMP_GAIN_MUTE,
-					    AMP_OUT_UNMUTE);
+			snd_hdac_codec_write(&codec->core, pin, 0,
+				             AC_VERB_SET_AMP_GAIN_MUTE,
+				             AMP_OUT_UNMUTE);
 	}
 	if (dac && (get_wcaps(codec, dac) & AC_WCAP_OUT_AMP))
-		snd_hda_codec_write(codec, dac, 0,
-				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO);
+		snd_hdac_codec_write(&codec->core, dac, 0,
+				     AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO);
 }
 
 static void init_input(struct hda_codec *codec, hda_nid_t pin, hda_nid_t adc)
@@ -4127,13 +4131,14 @@ static void init_input(struct hda_codec *codec, hda_nid_t pin, hda_nid_t adc)
 	if (pin) {
 		snd_hda_set_pin_ctl(codec, pin, PIN_VREF80);
 		if (get_wcaps(codec, pin) & AC_WCAP_IN_AMP)
-			snd_hda_codec_write(codec, pin, 0,
-					    AC_VERB_SET_AMP_GAIN_MUTE,
-					    AMP_IN_UNMUTE(0));
+			snd_hdac_codec_write(&codec->core, pin, 0,
+					     AC_VERB_SET_AMP_GAIN_MUTE,
+					     AMP_IN_UNMUTE(0));
 	}
 	if (adc && (get_wcaps(codec, adc) & AC_WCAP_IN_AMP)) {
-		snd_hda_codec_write(codec, adc, 0, AC_VERB_SET_AMP_GAIN_MUTE,
-				    AMP_IN_UNMUTE(0));
+		snd_hdac_codec_write(&codec->core, adc, 0,
+				     AC_VERB_SET_AMP_GAIN_MUTE,
+				     AMP_IN_UNMUTE(0));
 
 		/* init to 0 dB and unmute. */
 		snd_hda_codec_amp_stereo(codec, adc, HDA_INPUT, 0,
@@ -4173,8 +4178,8 @@ static void ca0132_set_dmic(struct hda_codec *codec, int enable)
 
 		val = spec->dmic_ctl;
 		val |= 0x80;
-		snd_hda_codec_write(codec, spec->input_pins[0], 0,
-				    VENDOR_CHIPIO_DMIC_CTL_SET, val);
+		snd_hdac_codec_write(&codec->core, spec->input_pins[0], 0,
+				     VENDOR_CHIPIO_DMIC_CTL_SET, val);
 
 		if (!(spec->dmic_ctl & 0x20))
 			chipio_set_control_flag(codec, CONTROL_FLAG_DMIC, 1);
@@ -4186,8 +4191,8 @@ static void ca0132_set_dmic(struct hda_codec *codec, int enable)
 		val = spec->dmic_ctl;
 		/* clear bit7 and bit5 to disable dmic */
 		val &= 0x5f;
-		snd_hda_codec_write(codec, spec->input_pins[0], 0,
-				    VENDOR_CHIPIO_DMIC_CTL_SET, val);
+		snd_hdac_codec_write(&codec->core, spec->input_pins[0], 0,
+				     VENDOR_CHIPIO_DMIC_CTL_SET, val);
 
 		if (!(spec->dmic_ctl & 0x20))
 			chipio_set_control_flag(codec, CONTROL_FLAG_DMIC, 0);
@@ -4214,8 +4219,8 @@ static void ca0132_init_dmic(struct hda_codec *codec)
 	 * Bit 7-4: reserved
 	 */
 	val = 0x01;
-	snd_hda_codec_write(codec, spec->input_pins[0], 0,
-			    VENDOR_CHIPIO_DMIC_MCLK_SET, val);
+	snd_hdac_codec_write(&codec->core, spec->input_pins[0], 0,
+			     VENDOR_CHIPIO_DMIC_MCLK_SET, val);
 
 	/* Data1 uses MPIO3. Data2 not use
 	 * Bit 2-0: Data1 MPIO select
@@ -4224,8 +4229,8 @@ static void ca0132_init_dmic(struct hda_codec *codec)
 	 * Bit   7: set disable Data2
 	 */
 	val = 0x83;
-	snd_hda_codec_write(codec, spec->input_pins[0], 0,
-			    VENDOR_CHIPIO_DMIC_PIN_SET, val);
+	snd_hdac_codec_write(&codec->core, spec->input_pins[0], 0,
+			     VENDOR_CHIPIO_DMIC_PIN_SET, val);
 
 	/* Use Ch-0 and Ch-1. Rate is 48K, mode 1. Disable DMic first.
 	 * Bit 3-0: Channel mask
@@ -4237,8 +4242,8 @@ static void ca0132_init_dmic(struct hda_codec *codec)
 	val = 0x23;
 	/* keep a copy of dmic ctl val for enable/disable dmic purpuse */
 	spec->dmic_ctl = val;
-	snd_hda_codec_write(codec, spec->input_pins[0], 0,
-			    VENDOR_CHIPIO_DMIC_CTL_SET, val);
+	snd_hdac_codec_write(&codec->core, spec->input_pins[0], 0,
+			     VENDOR_CHIPIO_DMIC_CTL_SET, val);
 }
 
 /*
@@ -4249,18 +4254,18 @@ static void ca0132_init_analog_mic2(struct hda_codec *codec)
 	struct ca0132_spec *spec = codec->spec;
 
 	mutex_lock(&spec->chipio_mutex);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x20);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x19);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x00);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x2D);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x19);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x00);
+	snd_hdac_codec_write(&codec->core, WIDGET_CHIP_CTRL, 0,
+			     VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x20);
+	snd_hdac_codec_write(&codec->core, WIDGET_CHIP_CTRL, 0,
+			     VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x19);
+	snd_hdac_codec_write(&codec->core, WIDGET_CHIP_CTRL, 0,
+			     VENDOR_CHIPIO_8051_DATA_WRITE, 0x00);
+	snd_hdac_codec_write(&codec->core, WIDGET_CHIP_CTRL, 0,
+			     VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x2D);
+	snd_hdac_codec_write(&codec->core, WIDGET_CHIP_CTRL, 0,
+			     VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x19);
+	snd_hdac_codec_write(&codec->core, WIDGET_CHIP_CTRL, 0,
+			     VENDOR_CHIPIO_8051_DATA_WRITE, 0x00);
 	mutex_unlock(&spec->chipio_mutex);
 }
 
-- 
2.4.3
