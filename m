From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Error: firmware not found
Date: Sat, 29 Jan 2005 16:46:09 +0100
Message-ID: <20050129164609.6b904957.pochini@shiny.it>
References: <s5hvf9lplgh.wl@alsa2.suse.de>
	<XFMail.20050126182942.pochini@shiny.it>
	<s5hpszrrxm7.wl@alsa2.suse.de>
	<Pine.LNX.4.58.0501281713050.30185@denise.shiny.it>
	<m2pszpijzg.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m2pszpijzg.fsf@vador.mandrakesoft.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thierry Vignaud <tvignaud@mandrakesoft.com>
Cc: tiwai@suse.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 28 Jan 2005 17:41:55 +0100
Thierry Vignaud <tvignaud@mandrakesoft.com> wrote:

> Giuliano Pochini <pochini@denise.shiny.it> writes:
> 
> > Ok, but I don't want to keep all that duplicated code loaded when
> > only half of it is needed. I would prefer a tiny "loader" module
> > that does the same work of "modprobe snd-layla3g snd-gina3g". I'll
> > also search for other similar cases to see if someone has a better
> > idea.
> 
> look at the DVB sub-system

Well, I didn't find anything really useful there. They use the module
interface like is was a plugin loader. It does not neither save me work nor
make the driver look very good. I just finished the first attempt to solve
the problem and it works fine here, although I don't have a Layla3G to test.

It changes the Gina3G driver so it works with the Layla3G, too. I'm not very
proud of those #define hacks in gina3g.c and some details are missing, but
it's overall a simple patch. For testing only:



diff -du alsa-driver_orig/pci/echoaudio/echoaudio.c alsa-driver/pci/echoaudio/echoaudio.c
--- alsa-driver_orig/pci/echoaudio/echoaudio.c	Sat Jan 29 16:31:53 2005
+++ alsa-driver/pci/echoaudio/echoaudio.c	Sat Jan 29 16:19:29 2005
@@ -522,6 +522,9 @@
 
 static int pcm_analog_in_hw_params(snd_pcm_substream_t *substream, snd_pcm_hw_params_t *hw_params)
 {
+	echoaudio_t *chip;
+
+	chip = snd_pcm_substream_chip(substream);
 	return init_engine(substream, hw_params, PX_ANALOG_IN + substream->number, params_channels(hw_params));
 }
 
@@ -539,6 +542,9 @@
 
 static int pcm_digital_in_hw_params(snd_pcm_substream_t *substream, snd_pcm_hw_params_t *hw_params)
 {
+	echoaudio_t *chip;
+
+	chip = snd_pcm_substream_chip(substream);
 	return init_engine(substream, hw_params, PX_DIGITAL_IN + substream->number, params_channels(hw_params));
 }
 
@@ -547,6 +553,9 @@
 #ifndef ECHOCARD_HAS_VMIXER	/* See the note in snd_echo_new_pcm() */
 static int pcm_digital_out_hw_params(snd_pcm_substream_t *substream, snd_pcm_hw_params_t *hw_params)
 {
+	echoaudio_t *chip;
+
+	chip = snd_pcm_substream_chip(substream);
 	return init_engine(substream, hw_params, PX_DIGITAL_OUT + substream->number, params_channels(hw_params));
 }
 #endif /* !ECHOCARD_HAS_VMIXER */
@@ -1167,7 +1176,7 @@
 static snd_kcontrol_new_t snd_echo_monitor_mixer __devinitdata = {
 	.name = "Monitor Mixer Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.count = NUM_BUSSES_IN * NUM_BUSSES_OUT,
+//	.count = NUM_BUSSES_IN * NUM_BUSSES_OUT,
 	.info = snd_echo_mixer_info,
 	.get = snd_echo_mixer_get,
 	.put = snd_echo_mixer_put,
@@ -1879,6 +1888,7 @@
 		goto ctl_error;
 
 #ifdef ECHOCARD_HAS_MONITOR
+	snd_echo_monitor_mixer.count = NUM_BUSSES_IN * NUM_BUSSES_OUT;
 	if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_echo_monitor_mixer, chip))) < 0)
 		goto ctl_error;
 #endif
@@ -1921,8 +1931,9 @@
 #endif
 
 #ifdef ECHOCARD_HAS_PHANTOM_POWER
-	if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_echo_phantom_power_switch, chip))) < 0)
-		goto ctl_error;
+	if (chip->has_phantom_power)
+		if ((err = snd_ctl_add(chip->card, snd_ctl_new1(&snd_echo_phantom_power_switch, chip))) < 0)
+			goto ctl_error;
 #endif
 
 	if ((err = snd_card_register(card)) < 0) {
diff -du alsa-driver_orig/pci/echoaudio/echoaudio.h alsa-driver/pci/echoaudio/echoaudio.h
--- alsa-driver_orig/pci/echoaudio/echoaudio.h	Sat Jan 29 16:31:53 2005
+++ alsa-driver/pci/echoaudio/echoaudio.h	Sat Jan 29 16:14:33 2005
@@ -356,6 +356,7 @@
 	struct resource *iores;
 	struct snd_dma_buffer commpage_dma_buf;
 	int irq;
+	u8 px_digital_out, px_analog_in, px_digital_in, px_num;
 #ifdef ECHOCARD_HAS_MIDI
 	snd_rawmidi_t *rmidi;
 	snd_rawmidi_substream_t *midi_in, *midi_out;
@@ -376,6 +377,7 @@
 	u8 clock_state;				/* Gina20, Darla20, Darla24 - only */
 	u8 input_clock;				/* Currently selected sample clock source */
 	u8 output_clock;			/* Layla20 only */
+	u8 e3g_box_type;			/* The loaded fw supports this box type */
 
 	unsigned int meters_enabled : 1;	/* VU-meters status */
 	unsigned int asic_loaded : 1;		/* Set TRUE when ASIC loaded */
@@ -386,6 +388,7 @@
 	unsigned int phantom_power : 1;		/* Gina3G - only */
 	unsigned int has_midi : 1;
 	unsigned int midi_input_enabled : 1;
+	unsigned int has_phantom_power : 1;
 
 	char nominal_level[ECHO_MAXAUDIOPIPES];	/* True == -10dBV  False == +4dBu */
 	s8 input_gain[ECHO_MAXAUDIOINPUTS];	/* Input level -50..+50 unit is 0.5dB */
diff -du alsa-driver_orig/pci/echoaudio/echoaudio_3g.c alsa-driver/pci/echoaudio/echoaudio_3g.c
--- alsa-driver_orig/pci/echoaudio/echoaudio_3g.c	Sat Jan 29 16:31:53 2005
+++ alsa-driver/pci/echoaudio/echoaudio_3g.c	Sat Jan 29 16:21:05 2005
@@ -31,7 +31,11 @@
 
 /* These functions are common for all "3G" cards */
 
-
+/* Check if the card is alive. Returns
+-Esomething	if it's not
+0		if it is working fine
+box_type+1	if it's ok, but we must replace the firmware
+*/
 static int check_asic_status(echoaudio_t *chip)
 {
 	u32 box_status;
@@ -58,10 +62,10 @@
 		return -ENODEV;
 	}
 
-	box_type = box_status & E3G_BOX_TYPE_MASK;
-	if (box_type != ECHOCARD_BOX) {
+	box_type = (box_status & E3G_BOX_TYPE_MASK) + 1;
+	if (box_type != chip->e3g_box_type) {
 		DE_INIT(("check_asic_status: wrong box type: %x\n", box_type));
-		return -ENODEV;
+		return box_type;
 	}
 
 	chip->asic_loaded = TRUE;
diff -du alsa-driver_orig/pci/echoaudio/echoaudio_dsp.c alsa-driver/pci/echoaudio/echoaudio_dsp.c
--- alsa-driver_orig/pci/echoaudio/echoaudio_dsp.c	Sat Jan 29 16:31:53 2005
+++ alsa-driver/pci/echoaudio/echoaudio_dsp.c	Sat Jan 29 15:37:38 2005
@@ -545,8 +545,9 @@
 	if (err < 0)
 		return err;
 
-	/* Load the ASIC if the DSP load succeeded */
-	if ((err = load_asic(chip)) < 0)
+	/* Load the ASIC if the DSP load succeeded. >0 means it did not fail
+	but we cannot continue (eg. we loaded the wrong firmware) */
+	if ((err = load_asic(chip)) != 0)
 		return err;
 
 	return restore_dsp_rettings(chip);
diff -du alsa-driver_orig/pci/echoaudio/echoaudio_dsp.h alsa-driver/pci/echoaudio/echoaudio_dsp.h
--- alsa-driver_orig/pci/echoaudio/echoaudio_dsp.h	Sat Jan 29 16:31:53 2005
+++ alsa-driver/pci/echoaudio/echoaudio_dsp.h	Sat Jan 29 15:37:38 2005
@@ -560,8 +560,8 @@
 #define E3G_FREQ_REG_MAX		0xffff
 
 // 3G external box types
-#define E3G_GINA3G			0x00
-#define E3G_LAYLA3G			0x10
+#define E3G_GINA3G_BOX_TYPE		0x00
+#define E3G_LAYLA3G_BOX_TYPE		0x10
 #define E3G_ASIC_NOT_LOADED		0xffff
 #define E3G_BOX_TYPE_MASK		0xf0
 
diff -du alsa-driver_orig/pci/echoaudio/gina3g.c alsa-driver/pci/echoaudio/gina3g.c
--- alsa-driver_orig/pci/echoaudio/gina3g.c	Sat Jan 29 16:31:53 2005
+++ alsa-driver/pci/echoaudio/gina3g.c	Sat Jan 29 16:14:34 2005
@@ -18,7 +18,7 @@
 
 #define ECHO3G_FAMILY
 #define ECHOCARD_GINA3G
-#define ECHOCARD_NAME "Gina3G"
+#define ECHOCARD_NAME "Echo3G"
 #define ECHOCARD_HAS_MONITOR
 #define ECHOCARD_HAS_ASIC
 #define ECHOCARD_HAS_INPUT_NOMINAL_LEVEL
@@ -34,19 +34,18 @@
 #define ECHOCARD_BOX	E3G_GINA3G
 
 /* Pipe indexes */
-#define PX_ANALOG_OUT	0	/* 6 */
-#define PX_DIGITAL_OUT	6	/* 8 */
-#define PX_ANALOG_IN	14	/* 2 */
-#define PX_DIGITAL_IN	16	/* 8 */
-#define PX_NUM		24
+#define PX_ANALOG_OUT	0
+#define PX_DIGITAL_OUT	(chip->px_digital_out)
+#define PX_ANALOG_IN	(chip->px_analog_in)
+#define PX_DIGITAL_IN	(chip->px_digital_in)
+#define PX_NUM		(chip->px_num)
 
 /* Bus indexes */
-#define BX_ANALOG_OUT	0	/* 6 */
-#define BX_DIGITAL_OUT	6	/* 8 */
-#define BX_ANALOG_IN	14	/* 2 */
-#define BX_DIGITAL_IN	16	/* 8 */
-#define BX_NUM		24
-
+#define BX_ANALOG_OUT	PX_ANALOG_OUT
+#define BX_DIGITAL_OUT	PX_DIGITAL_OUT
+#define BX_ANALOG_IN	PX_ANALOG_IN
+#define BX_DIGITAL_IN	PX_DIGITAL_IN
+#define BX_NUM		PX_NUM
 
 /* Number of channels */
 #define NUM_PIPES		PX_NUM
@@ -82,11 +81,13 @@
 
 #define FW_361_LOADER	0
 #define FW_GINA3G_DSP	1
-#define FW_3G_ASIC	2
+#define FW_ECHO3G_DSP	2
+#define FW_3G_ASIC	3
 
 static const struct firmware card_fw[] = {
 	{0, "loader_dsp.fw"},
 	{0, "gina3g_dsp.fw"},
+	{0, "echo3g_dsp.fw"},
 	{0, "3g_asic.fw"}
 };
 
diff -du alsa-driver_orig/pci/echoaudio/gina3g_dsp.c alsa-driver/pci/echoaudio/gina3g_dsp.c
--- alsa-driver_orig/pci/echoaudio/gina3g_dsp.c	Sat Jan 29 16:31:53 2005
+++ alsa-driver/pci/echoaudio/gina3g_dsp.c	Sat Jan 29 16:23:01 2005
@@ -57,20 +57,52 @@
 	chip->subdevice_id = subdevice_id;
 	chip->bad_board = TRUE;
 	chip->has_midi = TRUE;
-	chip->dsp_code_to_load = &card_fw[FW_GINA3G_DSP];
+	chip->dsp_code_to_load = &card_fw[FW_ECHO3G_DSP];
 	chip->input_clock_types =	ECHO_CLOCK_BIT_INTERNAL |
 					ECHO_CLOCK_BIT_SPDIF |
-					ECHO_CLOCK_BIT_ADAT;
+					ECHO_CLOCK_BIT_ADAT |
+					ECHO_CLOCK_BIT_WORD;
 	chip->digital_modes =	ECHOCAPS_HAS_DIGITAL_MODE_SPDIF_RCA |
 				ECHOCAPS_HAS_DIGITAL_MODE_SPDIF_OPTICAL |
 				ECHOCAPS_HAS_DIGITAL_MODE_ADAT;
+	chip->e3g_box_type = E3G_LAYLA3G_BOX_TYPE + 1;
+	chip->px_digital_out = 8;
+	chip->px_analog_in = 16;
+	chip->px_digital_in = 24;
+	chip->px_num = 32;
+	chip->has_phantom_power = 1;
 	chip->digital_mode = DIGITAL_MODE_SPDIF_RCA;
 	chip->professional_spdif = FALSE;
 	chip->non_audio_spdif = FALSE;
 
 	/* Load the DSP and the ASIC on the PCI card */
-	if ((err = load_firmware(chip)) < 0)
-		return err;
+	err = load_firmware(chip);
+
+	if (err < 0) {
+		return err;		/* Something went wrong */
+	} else if (err == E3G_GINA3G_BOX_TYPE + 1) {
+		/* The card was initialized successfully, but we loaded the
+		wrong firmware because this is not a Layla3G. Let's load
+		the right one. */
+
+		chip->dsp_code_to_load = &card_fw[FW_GINA3G_DSP];
+		chip->input_clock_types =	ECHO_CLOCK_BIT_INTERNAL |
+						ECHO_CLOCK_BIT_SPDIF |
+						ECHO_CLOCK_BIT_ADAT;
+		chip->e3g_box_type = E3G_GINA3G_BOX_TYPE + 1;
+		chip->px_digital_out = 6;
+		chip->px_analog_in = 14;
+		chip->px_digital_in = 16;
+		chip->px_num = 24;
+		chip->has_phantom_power = 0;
+
+		/* Re-load the DSP and the ASIC codes */
+		chip->dsp_code = 0;
+		if ((err = load_firmware(chip))
+			return err;		/* Something went wrong */
+	} else if (err > 0) {
+		return -ENODEV;			/* Unknown external box */
+	}
 
 	chip->bad_board = FALSE;
 



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
