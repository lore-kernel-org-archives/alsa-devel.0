From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 1/2] Echoaudio - new firmware
Date: Sun, 1 Jan 2006 11:51:53 +0100
Message-ID: <20060101115153.00379dfd.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


This patchset adds support for the new firmware for "3G" cards. It fixes
clicks/pops during simultaneous audio and midi i/o and it uses the same DSP
firmware for both the Gina3G and the Layla 3G.

I announced this patch two months ago asking for someone to test it on a
Layla3G, but nobody cared. I tested it a lot on the Gina3G. The patch is
against the latest anonymous CVS version.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

diff -dup alsa-driver__orig/pci/echoaudio/echo3g.c alsa-driver/pci/echoaudio/echo3g.c
--- alsa-driver__orig/pci/echoaudio/echo3g.c	2005-04-20 08:58:14.000000000 +0000
+++ alsa-driver/pci/echoaudio/echo3g.c	2005-11-05 17:12:39.000000000 +0000
@@ -68,13 +68,11 @@
 #include "echoaudio.h"
 
 #define FW_361_LOADER	0
-#define FW_GINA3G_DSP	1
-#define FW_ECHO3G_DSP	2
-#define FW_3G_ASIC	3
+#define FW_ECHO3G_DSP	1
+#define FW_3G_ASIC	2
 
 static const struct firmware card_fw[] = {
 	{0, "loader_dsp.fw"},
-	{0, "gina3g_dsp.fw"},
 	{0, "echo3g_dsp.fw"},
 	{0, "3g_asic.fw"}
 };
diff -dup alsa-driver__orig/pci/echoaudio/echo3g_dsp.c alsa-driver/pci/echoaudio/echo3g_dsp.c
--- alsa-driver__orig/pci/echoaudio/echo3g_dsp.c	2005-10-12 19:00:55.000000000 +0000
+++ alsa-driver/pci/echoaudio/echo3g_dsp.c	2005-12-31 10:21:23.000000000 +0000
@@ -58,54 +58,43 @@ static int init_hw(echoaudio_t *chip, u1
 	chip->bad_board = TRUE;
 	chip->has_midi = TRUE;
 	chip->dsp_code_to_load = &card_fw[FW_ECHO3G_DSP];
-	chip->input_clock_types =	ECHO_CLOCK_BIT_INTERNAL |
-					ECHO_CLOCK_BIT_SPDIF |
-					ECHO_CLOCK_BIT_ADAT |
-					ECHO_CLOCK_BIT_WORD;
-	chip->digital_modes =	ECHOCAPS_HAS_DIGITAL_MODE_SPDIF_RCA |
-				ECHOCAPS_HAS_DIGITAL_MODE_SPDIF_OPTICAL |
-				ECHOCAPS_HAS_DIGITAL_MODE_ADAT;
-	chip->e3g_box_type = E3G_LAYLA3G_BOX_TYPE;
-	chip->card_name = "Layla3G";
-	chip->px_digital_out = chip->bx_digital_out = 8;
-	chip->px_analog_in = chip->bx_analog_in = 16;
-	chip->px_digital_in = chip->bx_digital_in = 24;
-	chip->px_num = chip->bx_num = 32;
 
-	chip->digital_mode = DIGITAL_MODE_SPDIF_RCA;
-	chip->professional_spdif = FALSE;
-	chip->non_audio_spdif = FALSE;
-
-	/* Load the DSP and the ASIC on the PCI card and check what
-	type of external box is attached */
+	/* Load the DSP code and the ASIC on the PCI card and get
+	what type of external box is attached */
 	err = load_firmware(chip);
 
 	if (err < 0) {
 		return err;
-	} else if (err == E3G_GINA3G_BOX_TYPE + 1) {
-		/* The card was initialized successfully, but we loaded the wrong
-		firmware because this is a Gina3G. Let's load the right one. */
-
-		chip->dsp_code_to_load = &card_fw[FW_GINA3G_DSP];
+	} else if (err == E3G_GINA3G_BOX_TYPE) {
 		chip->input_clock_types =	ECHO_CLOCK_BIT_INTERNAL |
 						ECHO_CLOCK_BIT_SPDIF |
 						ECHO_CLOCK_BIT_ADAT;
-		chip->e3g_box_type = E3G_GINA3G_BOX_TYPE;
 		chip->card_name = "Gina3G";
 		chip->px_digital_out = chip->bx_digital_out = 6;
 		chip->px_analog_in = chip->bx_analog_in = 14;
 		chip->px_digital_in = chip->bx_digital_in = 16;
 		chip->px_num = chip->bx_num = 24;
 		chip->has_phantom_power = 1;
-
-		/* Re-load the DSP and the ASIC codes */
-		chip->dsp_code = NULL;
-		if ((err = load_firmware(chip)) < 0)
-			return err;             /* Something went wrong */
-	} else if (err > 0) {
-		return -ENODEV;                 /* Unknown external box */
+	} else if (err == E3G_LAYLA3G_BOX_TYPE) {
+		chip->input_clock_types =	ECHO_CLOCK_BIT_INTERNAL |
+						ECHO_CLOCK_BIT_SPDIF |
+						ECHO_CLOCK_BIT_ADAT |
+						ECHO_CLOCK_BIT_WORD;
+		chip->card_name = "Layla3G";
+		chip->px_digital_out = chip->bx_digital_out = 8;
+		chip->px_analog_in = chip->bx_analog_in = 16;
+		chip->px_digital_in = chip->bx_digital_in = 24;
+		chip->px_num = chip->bx_num = 32;
+	} else {
+		return -ENODEV;
 	}
 
+	chip->digital_modes =	ECHOCAPS_HAS_DIGITAL_MODE_SPDIF_RCA |
+				ECHOCAPS_HAS_DIGITAL_MODE_SPDIF_OPTICAL |
+				ECHOCAPS_HAS_DIGITAL_MODE_ADAT;
+	chip->digital_mode =	DIGITAL_MODE_SPDIF_RCA;
+	chip->professional_spdif = FALSE;
+	chip->non_audio_spdif = FALSE;
 	chip->bad_board = FALSE;
 
 	/* Must call this here after DSP is init to init gains and mutes */
diff -dup alsa-driver__orig/pci/echoaudio/echoaudio.h alsa-driver/pci/echoaudio/echoaudio.h
--- alsa-driver__orig/pci/echoaudio/echoaudio.h	2005-09-24 11:54:35.000000000 +0000
+++ alsa-driver/pci/echoaudio/echoaudio.h	2005-12-30 20:38:15.000000000 +0000
@@ -204,6 +204,7 @@
 #define ECHO_MAXAUDIOINPUTS	32	// Max audio input channels
 #define ECHO_MAXAUDIOOUTPUTS	32	// Max audio output channels
 #define ECHO_MAXAUDIOPIPES	32	// Max number of input and output pipes
+#define E3G_MAX_OUTPUTS		16
 #define ECHO_MAXMIDIJACKS	1	// Max MIDI ports
 #define ECHO_MIDI_QUEUE_SZ 	512	// Max MIDI input queue entries
 #define ECHO_MTC_QUEUE_SZ	32	// Max MIDI time code input queue entries
@@ -378,7 +379,6 @@ struct echoaudio_chip {
 	u8 clock_state;				/* Gina20, Darla20, Darla24 - only */
 	u8 input_clock;				/* Currently selected sample clock source */
 	u8 output_clock;			/* Layla20 only */
-	u8 e3g_box_type;			/* The loaded fw supports this box type */
 
 	char meters_enabled;			/* VU-meters status */
 	char asic_loaded;			/* Set TRUE when ASIC loaded */
diff -dup alsa-driver__orig/pci/echoaudio/echoaudio_3g.c alsa-driver/pci/echoaudio/echoaudio_3g.c
--- alsa-driver__orig/pci/echoaudio/echoaudio_3g.c	2005-04-23 10:28:27.000000000 +0000
+++ alsa-driver/pci/echoaudio/echoaudio_3g.c	2005-12-31 10:49:25.000000000 +0000
@@ -35,7 +35,6 @@
 static int check_asic_status(echoaudio_t *chip)
 {
 	u32 box_status;
-	u8 box_type;
 
 	if (wait_handshake(chip))
 		return -EIO;
@@ -51,21 +50,13 @@ static int check_asic_status(echoaudio_t
 		return -EIO;
 	}
 
-	/* What box type was set? */
 	box_status = le32_to_cpu(chip->comm_page->ext_box_status);
-	if (box_status == E3G_ASIC_NOT_LOADED) {
-		DE_INIT(("box not conected\n"));
+	DE_INIT(("box_status=%x\n", box_status));
+	if (box_status == E3G_ASIC_NOT_LOADED)
 		return -ENODEV;
-	}
-
-	box_type = box_status & E3G_BOX_TYPE_MASK;
-	if (box_type != chip->e3g_box_type) {
-		DE_INIT(("wrong box type: %x\n", box_type));
-		return box_type + 1;
-	}
 
 	chip->asic_loaded = TRUE;
-	return 0;
+	return box_status & E3G_BOX_TYPE_MASK;
 }
 
 
@@ -114,9 +105,6 @@ static int set_digital_mode(echoaudio_t 
 	u8 previous_mode;
 	int err, i, o;
 
-	if (chip->bad_board)
-		return -EIO;
-
 	/* All audio channels must be closed before changing the digital mode */
 	snd_assert(!chip->pipe_alloc_mask, return -EAGAIN);
 
@@ -240,8 +228,7 @@ static u32 detect_input_clocks(const ech
 
 static int load_asic(echoaudio_t *chip)
 {
-	u32 control_reg;
-	int err;
+	int box_type, err;
 
 	if (chip->asic_loaded)
 		return 0;
@@ -258,15 +245,16 @@ static int load_asic(echoaudio_t *chip)
 	/* Now give the new ASIC a little time to set up */
 	mdelay(2);
 	/* See if it worked */
-	err = check_asic_status(chip);
+	box_type = check_asic_status(chip);
 
 	/* Set up the control register if the load succeeded - 48 kHz, internal clock, S/PDIF RCA mode */
-	if (!err) {
-		control_reg = E3G_48KHZ;
-		err = write_control_reg(chip, control_reg, E3G_FREQ_REG_DEFAULT, TRUE);	// TRUE == force write
+	if (box_type >= 0) {
+		err = write_control_reg(chip, E3G_48KHZ, E3G_FREQ_REG_DEFAULT, TRUE);
+		if (err < 0)
+			return err;
 	}
-	DE_INIT(("load_asic() err=%d\n", err));
-	return err;
+
+	return box_type;
 }
 
 
diff -dup alsa-driver__orig/pci/echoaudio/echoaudio_dsp.c alsa-driver/pci/echoaudio/echoaudio_dsp.c
--- alsa-driver__orig/pci/echoaudio/echoaudio_dsp.c	2005-11-05 15:15:39.000000000 +0000
+++ alsa-driver/pci/echoaudio/echoaudio_dsp.c	2005-12-30 21:17:53.000000000 +0000
@@ -526,14 +526,14 @@ static int load_dsp(echoaudio_t *chip, u
 static int load_firmware(echoaudio_t *chip)
 {
 	const struct firmware *fw;
-	int err;
+	int box_type, err;
 
 	snd_assert(chip->dsp_code_to_load && chip->comm_page, return -EPERM);
 
 	/* See if the ASIC is present and working - only if the DSP is already loaded */
 	if (chip->dsp_code) {
-		if (check_asic_status(chip) == 0)
-			return 0;
+		if ((box_type = check_asic_status(chip)) >= 0)
+			return box_type;
 		/* ASIC check failed; force the DSP to reload */
 		chip->dsp_code = NULL;
 	}
@@ -545,12 +545,13 @@ static int load_firmware(echoaudio_t *ch
 	if (err < 0)
 		return err;
 
-	/* Load the ASIC if the DSP load succeeded. >0 means it did not fail
-	but we cannot continue (eg. we loaded the wrong firmware) */
-	if ((err = load_asic(chip)) != 0)
+	if ((box_type = load_asic(chip)) < 0)
+		return box_type;	/* error */
+
+	if ((err = restore_dsp_rettings(chip)) < 0)
 		return err;
 
-	return restore_dsp_rettings(chip);
+	return box_type;
 }
 
 
@@ -687,6 +688,10 @@ static void get_audio_meters(echoaudio_t
 	for (; n < 32; n++)
 		meters[n] = 0;
 
+#ifdef ECHOCARD_ECHO3G
+	m = E3G_MAX_OUTPUTS;	/* Skip unused meters */
+#endif
+
 	for (i = 0; i < num_busses_in(chip); i++, m++) {
 		meters[n++] = chip->comm_page->vu_meter[m];
 		meters[n++] = chip->comm_page->peak_meter[m];
diff -dup alsa-driver__orig/pci/echoaudio/echoaudio_dsp.h alsa-driver/pci/echoaudio/echoaudio_dsp.h
--- alsa-driver__orig/pci/echoaudio/echoaudio_dsp.h	2005-04-23 10:28:27.000000000 +0000
+++ alsa-driver/pci/echoaudio/echoaudio_dsp.h	2005-11-05 18:13:58.000000000 +0000
@@ -541,7 +541,7 @@ SET_LAYLA24_FREQUENCY_REG command.
 #define E3G_ADAT_MODE		0x1000
 #define E3G_SPDIF_OPTICAL_MODE	0x2000
 
-#define E3G_CLOCK_CLEAR_MASK		0xffffbff0
+#define E3G_CLOCK_CLEAR_MASK		0xbfffbff0
 #define E3G_DIGITAL_MODE_CLEAR_MASK	0xffffcfff
 #define E3G_SPDIF_FORMAT_CLEAR_MASK	0xfffff01f
 


--
Giuliano.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
