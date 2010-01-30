From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 3/5] Echoaudio - add suspend/resume support
Date: Sat, 30 Jan 2010 16:32:08 +0100
Message-ID: <20100130163208.1898f322@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out27.alice.it (smtp-out27.alice.it [85.33.2.27])
	by alsa0.perex.cz (Postfix) with ESMTP id 75F9C103852
	for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2010 16:32:51 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org


3/5 Add suspend support #1:
	This patch moves the code that initializes the card's controls with
	default valued from the init_hw() function into a separated
	set_mixer_defaults() function (one for each of the 16 supported
	cards). This change is necessary because during resume we must
	resurrect the hardware without losing the previous settings.
	set_mixer_defaults() must be called only once when the module is
	loaded.

Short description:

Move the controls init code outside the init_hw() function because is must
not be called during resume.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>


diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/darla20_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/darla20_dsp.c
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/darla20_dsp.c	2010-01-29 23:08:13.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/darla20_dsp.c	2010-01-29 23:11:43.000000000 +0100
@@ -57,15 +57,19 @@ static int init_hw(struct echoaudio *chi
 		return err;
 	chip->bad_board = FALSE;
 
-	if ((err = init_line_levels(chip)) < 0)
-		return err;
-
 	DE_INIT(("init_hw done\n"));
 	return err;
 }
 
 
 
+static int set_mixer_defaults(struct echoaudio *chip)
+{
+	return init_line_levels(chip);
+}
+
+
+
 /* The Darla20 has no external clock sources */
 static u32 detect_input_clocks(const struct echoaudio *chip)
 {
diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/darla24_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/darla24_dsp.c
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/darla24_dsp.c	2010-01-29 23:08:13.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/darla24_dsp.c	2010-01-29 23:11:43.000000000 +0100
@@ -56,15 +56,19 @@ static int init_hw(struct echoaudio *chi
 		return err;
 	chip->bad_board = FALSE;
 
-	if ((err = init_line_levels(chip)) < 0)
-		return err;
-
 	DE_INIT(("init_hw done\n"));
 	return err;
 }
 
 
 
+static int set_mixer_defaults(struct echoaudio *chip)
+{
+	return init_line_levels(chip);
+}
+
+
+
 static u32 detect_input_clocks(const struct echoaudio *chip)
 {
 	u32 clocks_from_dsp, clock_bits;
diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/echo3g_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echo3g_dsp.c
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/echo3g_dsp.c	2010-01-29 23:08:13.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echo3g_dsp.c	2010-01-29 23:11:43.000000000 +0100
@@ -97,20 +97,6 @@ static int init_hw(struct echoaudio *chi
 	chip->digital_modes =	ECHOCAPS_HAS_DIGITAL_MODE_SPDIF_RCA |
 				ECHOCAPS_HAS_DIGITAL_MODE_SPDIF_OPTICAL |
 				ECHOCAPS_HAS_DIGITAL_MODE_ADAT;
-	chip->digital_mode =	DIGITAL_MODE_SPDIF_RCA;
-	chip->professional_spdif = FALSE;
-	chip->non_audio_spdif = FALSE;
-	chip->bad_board = FALSE;
-
-	if ((err = init_line_levels(chip)) < 0)
-		return err;
-	err = set_digital_mode(chip, DIGITAL_MODE_SPDIF_RCA);
-	if (err < 0)
-		return err;
-	err = set_phantom_power(chip, 0);
-	if (err < 0)
-		return err;
-	err = set_professional_spdif(chip, TRUE);
 
 	DE_INIT(("init_hw done\n"));
 	return err;
@@ -118,6 +104,18 @@ static int init_hw(struct echoaudio *chi
 
 
 
+static int set_mixer_defaults(struct echoaudio *chip)
+{
+	chip->digital_mode = DIGITAL_MODE_SPDIF_RCA;
+	chip->professional_spdif = FALSE;
+	chip->non_audio_spdif = FALSE;
+	chip->bad_board = FALSE;
+	chip->phantom_power = FALSE;
+	return init_line_levels(chip);
+}
+
+
+
 static int set_phantom_power(struct echoaudio *chip, char on)
 {
 	u32 control_reg = le32_to_cpu(chip->comm_page->control_register);
diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/gina20_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/gina20_dsp.c
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/gina20_dsp.c	2010-01-29 23:08:13.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/gina20_dsp.c	2010-01-29 23:11:43.000000000 +0100
@@ -62,17 +62,20 @@ static int init_hw(struct echoaudio *chi
 		return err;
 	chip->bad_board = FALSE;
 
-	if ((err = init_line_levels(chip)) < 0)
-		return err;
-
-	err = set_professional_spdif(chip, TRUE);
-
 	DE_INIT(("init_hw done\n"));
 	return err;
 }
 
 
 
+static int set_mixer_defaults(struct echoaudio *chip)
+{
+	chip->professional_spdif = FALSE;
+	return init_line_levels(chip);
+}
+
+
+
 static u32 detect_input_clocks(const struct echoaudio *chip)
 {
 	u32 clocks_from_dsp, clock_bits;
diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/gina24_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/gina24_dsp.c
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/gina24_dsp.c	2010-01-29 23:08:13.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/gina24_dsp.c	2010-01-29 23:11:43.000000000 +0100
@@ -57,9 +57,6 @@ static int init_hw(struct echoaudio *chi
 		ECHO_CLOCK_BIT_INTERNAL | ECHO_CLOCK_BIT_SPDIF |
 		ECHO_CLOCK_BIT_ESYNC | ECHO_CLOCK_BIT_ESYNC96 |
 		ECHO_CLOCK_BIT_ADAT;
-	chip->professional_spdif = FALSE;
-	chip->digital_in_automute = TRUE;
-	chip->digital_mode = DIGITAL_MODE_SPDIF_RCA;
 
 	/* Gina24 comes in both '301 and '361 flavors */
 	if (chip->device_id == DEVICE_ID_56361) {
@@ -81,19 +78,22 @@ static int init_hw(struct echoaudio *chi
 		return err;
 	chip->bad_board = FALSE;
 
-	if ((err = init_line_levels(chip)) < 0)
-		return err;
-	err = set_digital_mode(chip, DIGITAL_MODE_SPDIF_RCA);
-	if (err < 0)
-		return err;
-	err = set_professional_spdif(chip, TRUE);
-
 	DE_INIT(("init_hw done\n"));
 	return err;
 }
 
 
 
+static int set_mixer_defaults(struct echoaudio *chip)
+{
+	chip->digital_mode = DIGITAL_MODE_SPDIF_RCA;
+	chip->professional_spdif = FALSE;
+	chip->digital_in_automute = TRUE;
+	return init_line_levels(chip);
+}
+
+
+
 static u32 detect_input_clocks(const struct echoaudio *chip)
 {
 	u32 clocks_from_dsp, clock_bits;
diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/indigodj_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigodj_dsp.c
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/indigodj_dsp.c	2010-01-29 23:08:13.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigodj_dsp.c	2010-01-29 23:11:43.000000000 +0100
@@ -60,15 +60,19 @@ static int init_hw(struct echoaudio *chi
 		return err;
 	chip->bad_board = FALSE;
 
-	if ((err = init_line_levels(chip)) < 0)
-		return err;
-
 	DE_INIT(("init_hw done\n"));
 	return err;
 }
 
 
 
+static int set_mixer_defaults(struct echoaudio *chip)
+{
+	return init_line_levels(chip);
+}
+
+
+
 static u32 detect_input_clocks(const struct echoaudio *chip)
 {
 	return ECHO_CLOCK_BIT_INTERNAL;
diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/indigodjx_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigodjx_dsp.c
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/indigodjx_dsp.c	2010-01-29 23:08:13.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigodjx_dsp.c	2010-01-29 23:11:43.000000000 +0100
@@ -59,10 +59,13 @@ static int init_hw(struct echoaudio *chi
 		return err;
 	chip->bad_board = FALSE;
 
-	err = init_line_levels(chip);
-	if (err < 0)
-		return err;
-
 	DE_INIT(("init_hw done\n"));
 	return err;
 }
+
+
+
+static int set_mixer_defaults(struct echoaudio *chip)
+{
+	return init_line_levels(chip);
+}
diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/indigo_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigo_dsp.c
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/indigo_dsp.c	2010-01-29 23:08:13.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigo_dsp.c	2010-01-29 23:11:43.000000000 +0100
@@ -60,15 +60,19 @@ static int init_hw(struct echoaudio *chi
 		return err;
 	chip->bad_board = FALSE;
 
-	if ((err = init_line_levels(chip)) < 0)
-		return err;
-
 	DE_INIT(("init_hw done\n"));
 	return err;
 }
 
 
 
+static int set_mixer_defaults(struct echoaudio *chip)
+{
+	return init_line_levels(chip);
+}
+
+
+
 static u32 detect_input_clocks(const struct echoaudio *chip)
 {
 	return ECHO_CLOCK_BIT_INTERNAL;
diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/indigo_express_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigo_express_dsp.c
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/indigo_express_dsp.c	2009-12-28 15:21:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigo_express_dsp.c	2010-01-29 23:11:43.000000000 +0100
@@ -61,6 +61,7 @@ static int set_sample_rate(struct echoau
 
 	control_reg |= clock;
 	if (control_reg != old_control_reg) {
+		DE_ACT(("set_sample_rate: %d clock %d\n", rate, clock));
 		chip->comm_page->control_register = cpu_to_le32(control_reg);
 		chip->sample_rate = rate;
 		clear_handshake(chip);
diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/indigoio_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigoio_dsp.c
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/indigoio_dsp.c	2010-01-29 23:08:13.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigoio_dsp.c	2010-01-29 23:11:43.000000000 +0100
@@ -60,15 +60,19 @@ static int init_hw(struct echoaudio *chi
 		return err;
 	chip->bad_board = FALSE;
 
-	if ((err = init_line_levels(chip)) < 0)
-		return err;
-
 	DE_INIT(("init_hw done\n"));
 	return err;
 }
 
 
 
+static int set_mixer_defaults(struct echoaudio *chip)
+{
+	return init_line_levels(chip);
+}
+
+
+
 static u32 detect_input_clocks(const struct echoaudio *chip)
 {
 	return ECHO_CLOCK_BIT_INTERNAL;
diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/indigoiox_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigoiox_dsp.c
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/indigoiox_dsp.c	2010-01-29 23:08:13.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigoiox_dsp.c	2010-01-29 23:11:43.000000000 +0100
@@ -59,10 +59,13 @@ static int init_hw(struct echoaudio *chi
 		return err;
 	chip->bad_board = FALSE;
 
-	err = init_line_levels(chip);
-	if (err < 0)
-		return err;
-
 	DE_INIT(("init_hw done\n"));
 	return err;
 }
+
+
+
+static int set_mixer_defaults(struct echoaudio *chip)
+{
+	return init_line_levels(chip);
+}
diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/layla20_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/layla20_dsp.c
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/layla20_dsp.c	2010-01-29 23:08:13.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/layla20_dsp.c	2010-01-29 23:11:43.000000000 +0100
@@ -64,17 +64,20 @@ static int init_hw(struct echoaudio *chi
 		return err;
 	chip->bad_board = FALSE;
 
-	if ((err = init_line_levels(chip)) < 0)
-		return err;
-
-	err = set_professional_spdif(chip, TRUE);
-
 	DE_INIT(("init_hw done\n"));
 	return err;
 }
 
 
 
+static int set_mixer_defaults(struct echoaudio *chip)
+{
+	chip->professional_spdif = FALSE;
+	return init_line_levels(chip);
+}
+
+
+
 static u32 detect_input_clocks(const struct echoaudio *chip)
 {
 	u32 clocks_from_dsp, clock_bits;
diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/layla24_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/layla24_dsp.c
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/layla24_dsp.c	2010-01-29 23:08:13.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/layla24_dsp.c	2010-01-29 23:11:43.000000000 +0100
@@ -61,9 +61,6 @@ static int init_hw(struct echoaudio *chi
 		ECHOCAPS_HAS_DIGITAL_MODE_SPDIF_RCA |
 		ECHOCAPS_HAS_DIGITAL_MODE_SPDIF_OPTICAL |
 		ECHOCAPS_HAS_DIGITAL_MODE_ADAT;
-	chip->digital_mode =		DIGITAL_MODE_SPDIF_RCA;
-	chip->professional_spdif = FALSE;
-	chip->digital_in_automute = TRUE;
 
 	if ((err = load_firmware(chip)) < 0)
 		return err;
@@ -72,17 +69,22 @@ static int init_hw(struct echoaudio *chi
 	if ((err = init_line_levels(chip)) < 0)
 		return err;
 
-	err = set_digital_mode(chip, DIGITAL_MODE_SPDIF_RCA);
-	if (err < 0)
-		return err;
-	err = set_professional_spdif(chip, TRUE);
-
 	DE_INIT(("init_hw done\n"));
 	return err;
 }
 
 
 
+static int set_mixer_defaults(struct echoaudio *chip)
+{
+	chip->digital_mode = DIGITAL_MODE_SPDIF_RCA;
+	chip->professional_spdif = FALSE;
+	chip->digital_in_automute = TRUE;
+	return init_line_levels(chip);
+}
+
+
+
 static u32 detect_input_clocks(const struct echoaudio *chip)
 {
 	u32 clocks_from_dsp, clock_bits;
diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/mia_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/mia_dsp.c
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/mia_dsp.c	2010-01-29 23:08:13.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/mia_dsp.c	2010-01-29 23:11:43.000000000 +0100
@@ -66,15 +66,19 @@ static int init_hw(struct echoaudio *chi
 		return err;
 	chip->bad_board = FALSE;
 
-	if ((err = init_line_levels(chip)))
-		return err;
-
 	DE_INIT(("init_hw done\n"));
 	return err;
 }
 
 
 
+static int set_mixer_defaults(struct echoaudio *chip)
+{
+	return init_line_levels(chip);
+}
+
+
+
 static u32 detect_input_clocks(const struct echoaudio *chip)
 {
 	u32 clocks_from_dsp, clock_bits;
diff -dup alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/mona_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/mona_dsp.c
--- alsa-driver-1.0.22.1__orig//alsa-kernel/pci/echoaudio/mona_dsp.c	2010-01-29 23:08:13.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/mona_dsp.c	2010-01-29 23:11:43.000000000 +0100
@@ -67,28 +67,26 @@ static int init_hw(struct echoaudio *chi
 	else
 		chip->dsp_code_to_load = FW_MONA_301_DSP;
 
-	chip->digital_mode = DIGITAL_MODE_SPDIF_RCA;
-	chip->professional_spdif = FALSE;
-	chip->digital_in_automute = TRUE;
-
 	if ((err = load_firmware(chip)) < 0)
 		return err;
 	chip->bad_board = FALSE;
 
-	if ((err = init_line_levels(chip)) < 0)
-		return err;
-
-	err = set_digital_mode(chip, DIGITAL_MODE_SPDIF_RCA);
-	if (err < 0)
-		return err;
-	err = set_professional_spdif(chip, TRUE);
-
 	DE_INIT(("init_hw done\n"));
 	return err;
 }
 
 
 
+static int set_mixer_defaults(struct echoaudio *chip)
+{
+	chip->digital_mode = DIGITAL_MODE_SPDIF_RCA;
+	chip->professional_spdif = FALSE;
+	chip->digital_in_automute = TRUE;
+	return init_line_levels(chip);
+}
+
+
+
 static u32 detect_input_clocks(const struct echoaudio *chip)
 {
 	u32 clocks_from_dsp, clock_bits;


-- 
Giuliano.
