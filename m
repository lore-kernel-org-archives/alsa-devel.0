From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] echoaudio 1/2
Date: Sat, 26 Mar 2005 23:31:46 +0100
Message-ID: <20050326233146.26742a97.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


- Export the digital input automute switch.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

diff -du alsa-driver__orig/pci/echoaudio/echoaudio.c alsa-driver/pci/echoaudio/echoaudio.c
--- alsa-driver__orig/pci/echoaudio/echoaudio.c	Sat Mar 26 18:53:32 2005
+++ alsa-driver/pci/echoaudio/echoaudio.c	Sat Mar 26 21:33:09 2005
@@ -1500,6 +1500,54 @@
 
 
 
+#ifdef ECHOCARD_HAS_DIGITAL_IN_AUTOMUTE
+
+/******************* Digital input automute switch *******************/
+static int snd_echo_automute_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int snd_echo_automute_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	echoaudio_t *chip = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = chip->digital_in_automute;
+	return 0;
+}
+
+static int snd_echo_automute_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
+{
+	echoaudio_t *chip = snd_kcontrol_chip(kcontrol);
+	int automute, changed = 0;
+
+	automute = !!ucontrol->value.integer.value[0];
+	if (chip->digital_in_automute != automute) {
+		spin_lock_irq(&chip->lock);
+		changed = set_input_auto_mute(chip, automute);
+		spin_unlock_irq(&chip->lock);
+		if (changed == 0)
+			changed = 1;	/* no errors */
+	}
+	return changed;
+}
+
+static snd_kcontrol_new_t snd_echo_automute_switch __devinitdata = {
+	.name = "Digital Capture Switch (automute)",
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.info = snd_echo_automute_info,
+	.get = snd_echo_automute_get,
+	.put = snd_echo_automute_put,
+};
+
+#endif /* ECHOCARD_HAS_DIGITAL_IN_AUTOMUTE */
+
+
+
 /******************* VU-meters switch *******************/
 static int snd_echo_vumeters_switch_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t *uinfo)
 {
@@ -1884,7 +1932,8 @@
 #endif
 
 #ifdef ECHOCARD_HAS_DIGITAL_IN_AUTOMUTE
-	set_input_auto_mute(chip, 1);	/* Enable automute if supported */
+	if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_echo_automute_switch, chip))) < 0)
+		goto ctl_error;
 #endif
 
 	if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_echo_channels_info, chip))) < 0)
diff -du alsa-driver__orig/pci/echoaudio/echoaudio_gml.c alsa-driver/pci/echoaudio/echoaudio_gml.c
--- alsa-driver__orig/pci/echoaudio/echoaudio_gml.c	Sat Mar 26 18:53:32 2005
+++ alsa-driver/pci/echoaudio/echoaudio_gml.c	Sat Mar 26 18:48:33 2005
@@ -66,14 +66,14 @@
 */
 static int write_control_reg(echoaudio_t *chip, u32 value, char force)
 {
-	DE_ACT(("write_control_reg: 0x%x\n", value));
-
 	/* Handle the digital input auto-mute */
 	if (chip->digital_in_automute)
 		value |= GML_DIGITAL_IN_AUTO_MUTE;
 	else
 		value &= ~GML_DIGITAL_IN_AUTO_MUTE;
 
+	DE_ACT(("write_control_reg: 0x%x\n", value));
+
 	/* Write the control register */
 	value = cpu_to_le32(value);
 	if (value != chip->comm_page->control_register || force) {
diff -du alsa-driver__orig/pci/echoaudio/gina24_dsp.c alsa-driver/pci/echoaudio/gina24_dsp.c
--- alsa-driver__orig/pci/echoaudio/gina24_dsp.c	Sat Mar 26 18:53:32 2005
+++ alsa-driver/pci/echoaudio/gina24_dsp.c	Sat Mar 26 18:33:33 2005
@@ -57,6 +57,7 @@
 					ECHO_CLOCK_BIT_ESYNC | ECHO_CLOCK_BIT_ESYNC96 |
 					ECHO_CLOCK_BIT_ADAT;
 	chip->professional_spdif = FALSE;
+	chip->digital_in_automute = TRUE;
 	chip->digital_mode = DIGITAL_MODE_SPDIF_RCA;
 
 	/* Gina24 comes in both '301 and '361 flavors */
diff -du alsa-driver__orig/pci/echoaudio/layla24_dsp.c alsa-driver/pci/echoaudio/layla24_dsp.c
--- alsa-driver__orig/pci/echoaudio/layla24_dsp.c	Sat Mar 26 18:53:32 2005
+++ alsa-driver/pci/echoaudio/layla24_dsp.c	Sat Mar 26 18:31:25 2005
@@ -62,6 +62,7 @@
 					ECHOCAPS_HAS_DIGITAL_MODE_ADAT;
 	chip->digital_mode =		DIGITAL_MODE_SPDIF_RCA;
 	chip->professional_spdif = FALSE;
+	chip->digital_in_automute = TRUE;
 
 	/* Load the DSP and the ASIC on the PCI card */
 	if ((err = load_firmware(chip)) < 0)
diff -du alsa-driver__orig/pci/echoaudio/mona_dsp.c alsa-driver/pci/echoaudio/mona_dsp.c
--- alsa-driver__orig/pci/echoaudio/mona_dsp.c	Sat Mar 26 18:53:32 2005
+++ alsa-driver/pci/echoaudio/mona_dsp.c	Sat Mar 26 18:31:24 2005
@@ -66,6 +66,7 @@
 
 	chip->digital_mode = DIGITAL_MODE_SPDIF_RCA;
 	chip->professional_spdif = FALSE;
+	chip->digital_in_automute = TRUE;
 
 	/* Load the DSP and the ASIC on the PCI card */
 	if ((err = load_firmware(chip)) < 0)



--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
