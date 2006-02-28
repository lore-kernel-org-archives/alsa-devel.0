From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH] HDA/ALC260: 7/7 - add SPDIF enable to test model
Date: Tue, 28 Feb 2006 10:54:05 +1030 (CST)
Message-ID: <200602280024.k1S0O5ZV017334@auster.physics.adelaide.edu.au>
References: <s5hlkvxt57f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlkvxt57f.wl%tiwai@suse.de> from "Takashi Iwai" at Feb 27, 2006 12:24:20 PM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi

This patch adds mixer controls to the "test" ALC260 model which allow the
user to selectively enable or disable the SPDIF output pins.  This should
assist people identify digital outputs on machines which bring them to the
outside world.

Note that while the patch *should* work, I cannot personally verify it since
my laptop doesn't bring the SPDIF lines out.

As for the GPIO switches added in patch 4, these controls are currently
only compiled in if debug mode is selected.

Regards
  jonathan


--- patch_realtek.c-06-fujitsu+test_model_tweaks	2006-02-28 00:17:29.000000000 +1030
+++ patch_realtek.c-all_01-06	2006-02-28 00:32:07.000000000 +1030
@@ -395,6 +395,60 @@
 	  .private_value = nid | (mask<<16) }
 #endif   /* CONFIG_SND_DEBUG */
 
+/* A switch control to allow the enabling of the digital IO pins on the
+ * ALC260.  This is incredibly simplistic; the intention of this control is
+ * to provide something in the test model allowing digital outputs to be
+ * identified if present.  If models are found which can utilise these
+ * outputs a more complete mixer control can be devised for those models if
+ * necessary.
+ */
+#ifdef CONFIG_SND_DEBUG
+static int alc_spdif_ctrl_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}                                
+static int alc_spdif_ctrl_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	hda_nid_t nid = kcontrol->private_value & 0xffff;
+	unsigned char mask = (kcontrol->private_value >> 16) & 0xff;
+	long *valp = ucontrol->value.integer.value;
+	unsigned int val = snd_hda_codec_read(codec,nid,0,AC_VERB_GET_DIGI_CONVERT,0x00);
+
+	*valp = (val & mask) != 0;
+	return 0;
+}
+static int alc_spdif_ctrl_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	signed int change;
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	hda_nid_t nid = kcontrol->private_value & 0xffff;
+	unsigned char mask = (kcontrol->private_value >> 16) & 0xff;
+	long val = *ucontrol->value.integer.value;
+	unsigned int ctrl_data = snd_hda_codec_read(codec,nid,0,AC_VERB_GET_DIGI_CONVERT,0x00);
+
+	/* Set/unset the masked control bit(s) as needed */
+	change = (val==0?0:mask) != (ctrl_data & mask);
+	if (val==0)
+		ctrl_data &= ~mask;
+	else
+		ctrl_data |= mask;
+	snd_hda_codec_write(codec,nid,0,AC_VERB_SET_DIGI_CONVERT_1,ctrl_data);
+
+	return change;
+}
+#define ALC_SPDIF_CTRL_SWITCH(xname, nid, mask) \
+	{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .index = 0,  \
+	  .info = alc_spdif_ctrl_info, \
+	  .get = alc_spdif_ctrl_get, \
+	  .put = alc_spdif_ctrl_put, \
+	  .private_value = nid | (mask<<16) }
+#endif   /* CONFIG_SND_DEBUG */
+
 /*
  * set up from the preset table
  */
@@ -3048,6 +3102,13 @@
 	ALC_GPIO_DATA_SWITCH("GPIO pin 2", 0x01, 0x04),
 	ALC_GPIO_DATA_SWITCH("GPIO pin 3", 0x01, 0x08),
 
+	/* Switches to allow the digital IO pins to be enabled.  The datasheet
+	 * is ambigious as to which NID is which; testing on laptops which
+	 * make this output available should provide clarification. 
+	 */
+	ALC_SPDIF_CTRL_SWITCH("SPDIF Playback Switch", 0x03, 0x01),
+	ALC_SPDIF_CTRL_SWITCH("SPDIF Capture Switch", 0x06, 0x01),
+
 	{ } /* end */
 };
 static struct hda_verb alc260_test_init_verbs[] = {
@@ -3064,7 +3125,12 @@
 	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	{0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 
-	/* Disable digital (SPDIF) pins for now */
+	/* Disable digital (SPDIF) pins initially, but users can enable
+	 * them via a mixer switch.  In the case of SPDIF-out, this initverb
+	 * payload also sets the generation to 0, output to be in "consumer"
+	 * PCM format, copyright asserted, no pre-emphasis and no validity
+	 * control.
+	 */
 	{0x03, AC_VERB_SET_DIGI_CONVERT_1, 0},
 	{0x06, AC_VERB_SET_DIGI_CONVERT_1, 0},
 


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
