From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 1/5] Echoaudio - add suspend/resume support
Date: Sat, 30 Jan 2010 16:31:42 +0100
Message-ID: <20100130163142.751b838a@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out26.alice.it (smtp-out26.alice.it [85.33.2.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FF92103809
	for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2010 16:32:28 +0100 (CET)
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


1/5 Add firmware cache #1:
	When CONFIG_PM is enabled the firmware cannot be released because
	the driver will need it again to resume the card.
	With this patch the firmware is passed as an index of the struct
	firmware card_fw[] in place of a pointer. That same index is then
	used to locate the firmware in the firmware cache.

Short description:

Changes the way the firmware is passed through functions.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>


diff -dup alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/darla20_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/darla20_dsp.c
--- alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/darla20_dsp.c	2009-12-28 15:21:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/darla20_dsp.c	2010-01-02 21:27:05.000000000 +0100
@@ -45,7 +45,7 @@ static int init_hw(struct echoaudio *chi
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
 	chip->bad_board = TRUE;
-	chip->dsp_code_to_load = &card_fw[FW_DARLA20_DSP];
+	chip->dsp_code_to_load = FW_DARLA20_DSP;
 	chip->spdif_status = GD_SPDIF_STATUS_UNDEF;
 	chip->clock_state = GD_CLOCK_UNDEF;
 	/* Since this card has no ASIC, mark it as loaded so everything
diff -dup alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/darla24_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/darla24_dsp.c
--- alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/darla24_dsp.c	2009-12-28 15:21:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/darla24_dsp.c	2010-01-02 21:27:05.000000000 +0100
@@ -45,7 +45,7 @@ static int init_hw(struct echoaudio *chi
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
 	chip->bad_board = TRUE;
-	chip->dsp_code_to_load = &card_fw[FW_DARLA24_DSP];
+	chip->dsp_code_to_load = FW_DARLA24_DSP;
 	/* Since this card has no ASIC, mark it as loaded so everything
 	   works OK */
 	chip->asic_loaded = TRUE;
diff -dup alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/echo3g_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echo3g_dsp.c
--- alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/echo3g_dsp.c	2009-12-28 15:21:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echo3g_dsp.c	2010-01-02 21:27:05.000000000 +0100
@@ -61,7 +61,7 @@ static int init_hw(struct echoaudio *chi
 	chip->subdevice_id = subdevice_id;
 	chip->bad_board = TRUE;
 	chip->has_midi = TRUE;
-	chip->dsp_code_to_load = &card_fw[FW_ECHO3G_DSP];
+	chip->dsp_code_to_load = FW_ECHO3G_DSP;
 
 	/* Load the DSP code and the ASIC on the PCI card and get
 	what type of external box is attached */
diff -dup alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/echoaudio_3g.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio_3g.c
--- alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/echoaudio_3g.c	2009-12-28 15:21:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio_3g.c	2010-01-02 21:27:05.000000000 +0100
@@ -227,12 +227,11 @@ static int load_asic(struct echoaudio *c
 	/* Give the DSP a few milliseconds to settle down */
 	mdelay(2);
 
-	err = load_asic_generic(chip, DSP_FNC_LOAD_3G_ASIC,
-				&card_fw[FW_3G_ASIC]);
+	err = load_asic_generic(chip, DSP_FNC_LOAD_3G_ASIC, FW_3G_ASIC);
 	if (err < 0)
 		return err;
 
-	chip->asic_code = &card_fw[FW_3G_ASIC];
+	chip->asic_code = FW_3G_ASIC;
 
 	/* Now give the new ASIC some time to set up */
 	msleep(1000);
diff -dup alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/echoaudio.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.c
--- alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/echoaudio.c	2009-12-28 15:21:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.c	2010-01-02 21:27:05.000000000 +0100
@@ -36,11 +36,15 @@ MODULE_PARM_DESC(enable, "Enable " ECHOC
 static unsigned int channels_list[10] = {1, 2, 4, 6, 8, 10, 12, 14, 16, 999999};
 static const DECLARE_TLV_DB_SCALE(db_scale_output_gain, -12800, 100, 1);
 
+
+
 static int get_firmware(const struct firmware **fw_entry,
-			const struct firmware *frm, struct echoaudio *chip)
+			struct echoaudio *chip, const short fw_index)
 {
 	int err;
 	char name[30];
+	const struct firmware *frm = &card_fw[fw_index];
+
 	DE_ACT(("firmware requested: %s\n", frm->data));
 	snprintf(name, sizeof(name), "ea/%s", frm->data);
 	if ((err = request_firmware(fw_entry, name, pci_device(chip))) < 0)
@@ -48,6 +52,8 @@ static int get_firmware(const struct fir
 	return err;
 }
 
+
+
 static void free_firmware(const struct firmware *fw_entry)
 {
 	release_firmware(fw_entry);
diff -dup alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/echoaudio_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio_dsp.c
--- alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/echoaudio_dsp.c	2009-12-28 15:21:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio_dsp.c	2010-01-02 21:27:05.000000000 +0100
@@ -175,15 +175,15 @@ static inline int check_asic_status(stru
 #ifdef ECHOCARD_HAS_ASIC
 
 /* Load ASIC code - done after the DSP is loaded */
-static int load_asic_generic(struct echoaudio *chip, u32 cmd,
-			     const struct firmware *asic)
+static int load_asic_generic(struct echoaudio *chip, u32 cmd, short asic)
 {
 	const struct firmware *fw;
 	int err;
 	u32 i, size;
 	u8 *code;
 
-	if ((err = get_firmware(&fw, asic, chip)) < 0) {
+	err = get_firmware(&fw, chip, asic);
+	if (err < 0) {
 		snd_printk(KERN_WARNING "Firmware not found !\n");
 		return err;
 	}
@@ -245,7 +245,8 @@ static int install_resident_loader(struc
 		return 0;
 	}
 
-	if ((i = get_firmware(&fw, &card_fw[FW_361_LOADER], chip)) < 0) {
+	i = get_firmware(&fw, chip, FW_361_LOADER);
+	if (i < 0) {
 		snd_printk(KERN_WARNING "Firmware not found !\n");
 		return i;
 	}
@@ -485,7 +486,8 @@ static int load_firmware(struct echoaudi
 		chip->dsp_code = NULL;
 	}
 
-	if ((err = get_firmware(&fw, chip->dsp_code_to_load, chip)) < 0)
+	err = get_firmware(&fw, chip, chip->dsp_code_to_load);
+	if (err < 0)
 		return err;
 	err = load_dsp(chip, (u16 *)fw->data);
 	free_firmware(fw);
diff -dup alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/echoaudio.h alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.h
--- alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/echoaudio.h	2009-12-28 15:21:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/echoaudio.h	2010-01-02 21:27:05.000000000 +0100
@@ -442,8 +442,8 @@ struct echoaudio {
 	u16 device_id, subdevice_id;
 	u16 *dsp_code;			/* Current DSP code loaded,
 					 * NULL if nothing loaded */
-	const struct firmware *dsp_code_to_load;/* DSP code to load */
-	const struct firmware *asic_code;	/* Current ASIC code */
+	short dsp_code_to_load;		/* DSP code to load */
+	short asic_code;		/* Current ASIC code */
 	u32 comm_page_phys;			/* Physical address of the
 						 * memory seen by DSP */
 	volatile u32 __iomem *dsp_registers;	/* DSP's register base */
@@ -464,7 +464,7 @@ static int load_firmware(struct echoaudi
 static int wait_handshake(struct echoaudio *chip);
 static int send_vector(struct echoaudio *chip, u32 command);
 static int get_firmware(const struct firmware **fw_entry,
-			const struct firmware *frm, struct echoaudio *chip);
+			struct echoaudio *chip, const short fw_index);
 static void free_firmware(const struct firmware *fw_entry);
 
 #ifdef ECHOCARD_HAS_MIDI
diff -dup alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/gina20_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/gina20_dsp.c
--- alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/gina20_dsp.c	2009-12-28 15:21:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/gina20_dsp.c	2010-01-02 21:27:05.000000000 +0100
@@ -49,7 +49,7 @@ static int init_hw(struct echoaudio *chi
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
 	chip->bad_board = TRUE;
-	chip->dsp_code_to_load = &card_fw[FW_GINA20_DSP];
+	chip->dsp_code_to_load = FW_GINA20_DSP;
 	chip->spdif_status = GD_SPDIF_STATUS_UNDEF;
 	chip->clock_state = GD_CLOCK_UNDEF;
 	/* Since this card has no ASIC, mark it as loaded so everything
diff -dup alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/gina24_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/gina24_dsp.c
--- alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/gina24_dsp.c	2009-12-28 15:21:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/gina24_dsp.c	2010-01-02 21:27:05.000000000 +0100
@@ -33,8 +33,7 @@ static int write_control_reg(struct echo
 static int set_input_clock(struct echoaudio *chip, u16 clock);
 static int set_professional_spdif(struct echoaudio *chip, char prof);
 static int set_digital_mode(struct echoaudio *chip, u8 mode);
-static int load_asic_generic(struct echoaudio *chip, u32 cmd,
-			     const struct firmware *asic);
+static int load_asic_generic(struct echoaudio *chip, u32 cmd, short asic);
 static int check_asic_status(struct echoaudio *chip);
 
 
@@ -64,13 +63,13 @@ static int init_hw(struct echoaudio *chi
 
 	/* Gina24 comes in both '301 and '361 flavors */
 	if (chip->device_id == DEVICE_ID_56361) {
-		chip->dsp_code_to_load = &card_fw[FW_GINA24_361_DSP];
+		chip->dsp_code_to_load = FW_GINA24_361_DSP;
 		chip->digital_modes =
 			ECHOCAPS_HAS_DIGITAL_MODE_SPDIF_RCA |
 			ECHOCAPS_HAS_DIGITAL_MODE_SPDIF_OPTICAL |
 			ECHOCAPS_HAS_DIGITAL_MODE_ADAT;
 	} else {
-		chip->dsp_code_to_load = &card_fw[FW_GINA24_301_DSP];
+		chip->dsp_code_to_load = FW_GINA24_301_DSP;
 		chip->digital_modes =
 			ECHOCAPS_HAS_DIGITAL_MODE_SPDIF_RCA |
 			ECHOCAPS_HAS_DIGITAL_MODE_SPDIF_OPTICAL |
@@ -125,7 +124,7 @@ static int load_asic(struct echoaudio *c
 {
 	u32 control_reg;
 	int err;
-	const struct firmware *fw;
+	short asic;
 
 	if (chip->asic_loaded)
 		return 1;
@@ -135,14 +134,15 @@ static int load_asic(struct echoaudio *c
 
 	/* Pick the correct ASIC for '301 or '361 Gina24 */
 	if (chip->device_id == DEVICE_ID_56361)
-		fw = &card_fw[FW_GINA24_361_ASIC];
+		asic = FW_GINA24_361_ASIC;
 	else
-		fw = &card_fw[FW_GINA24_301_ASIC];
+		asic = FW_GINA24_301_ASIC;
 
-	if ((err = load_asic_generic(chip, DSP_FNC_LOAD_GINA24_ASIC, fw)) < 0)
+	err = load_asic_generic(chip, DSP_FNC_LOAD_GINA24_ASIC, asic);
+	if (err < 0)
 		return err;
 
-	chip->asic_code = fw;
+	chip->asic_code = asic;
 
 	/* Now give the new ASIC a little time to set up */
 	mdelay(10);
diff -dup alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/indigodj_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigodj_dsp.c
--- alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/indigodj_dsp.c	2009-12-28 15:21:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigodj_dsp.c	2010-01-02 21:27:05.000000000 +0100
@@ -50,7 +50,7 @@ static int init_hw(struct echoaudio *chi
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
 	chip->bad_board = TRUE;
-	chip->dsp_code_to_load = &card_fw[FW_INDIGO_DJ_DSP];
+	chip->dsp_code_to_load = FW_INDIGO_DJ_DSP;
 	/* Since this card has no ASIC, mark it as loaded so everything
 	   works OK */
 	chip->asic_loaded = TRUE;
diff -dup alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/indigodjx_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigodjx_dsp.c
--- alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/indigodjx_dsp.c	2009-12-28 15:21:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigodjx_dsp.c	2010-01-02 21:27:05.000000000 +0100
@@ -48,7 +48,7 @@ static int init_hw(struct echoaudio *chi
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
 	chip->bad_board = TRUE;
-	chip->dsp_code_to_load = &card_fw[FW_INDIGO_DJX_DSP];
+	chip->dsp_code_to_load = FW_INDIGO_DJX_DSP;
 	/* Since this card has no ASIC, mark it as loaded so everything
 	   works OK */
 	chip->asic_loaded = TRUE;
diff -dup alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/indigo_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigo_dsp.c
--- alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/indigo_dsp.c	2009-12-28 15:21:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigo_dsp.c	2010-01-02 21:27:05.000000000 +0100
@@ -50,7 +50,7 @@ static int init_hw(struct echoaudio *chi
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
 	chip->bad_board = TRUE;
-	chip->dsp_code_to_load = &card_fw[FW_INDIGO_DSP];
+	chip->dsp_code_to_load = FW_INDIGO_DSP;
 	/* Since this card has no ASIC, mark it as loaded so everything
 	   works OK */
 	chip->asic_loaded = TRUE;
diff -dup alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/indigoio_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigoio_dsp.c
--- alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/indigoio_dsp.c	2009-12-28 15:21:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigoio_dsp.c	2010-01-02 21:27:05.000000000 +0100
@@ -50,7 +50,7 @@ static int init_hw(struct echoaudio *chi
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
 	chip->bad_board = TRUE;
-	chip->dsp_code_to_load = &card_fw[FW_INDIGO_IO_DSP];
+	chip->dsp_code_to_load = FW_INDIGO_IO_DSP;
 	/* Since this card has no ASIC, mark it as loaded so everything
 	   works OK */
 	chip->asic_loaded = TRUE;
diff -dup alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/indigoiox_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigoiox_dsp.c
--- alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/indigoiox_dsp.c	2009-12-28 15:21:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/indigoiox_dsp.c	2010-01-02 21:27:05.000000000 +0100
@@ -48,7 +48,7 @@ static int init_hw(struct echoaudio *chi
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
 	chip->bad_board = TRUE;
-	chip->dsp_code_to_load = &card_fw[FW_INDIGO_IOX_DSP];
+	chip->dsp_code_to_load = FW_INDIGO_IOX_DSP;
 	/* Since this card has no ASIC, mark it as loaded so everything
 	   works OK */
 	chip->asic_loaded = TRUE;
diff -dup alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/layla20_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/layla20_dsp.c
--- alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/layla20_dsp.c	2009-12-28 15:21:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/layla20_dsp.c	2010-01-02 21:27:05.000000000 +0100
@@ -31,8 +31,7 @@
 
 static int read_dsp(struct echoaudio *chip, u32 *data);
 static int set_professional_spdif(struct echoaudio *chip, char prof);
-static int load_asic_generic(struct echoaudio *chip, u32 cmd,
-			     const struct firmware *asic);
+static int load_asic_generic(struct echoaudio *chip, u32 cmd, short asic);
 static int check_asic_status(struct echoaudio *chip);
 static int update_flags(struct echoaudio *chip);
 
@@ -54,7 +53,7 @@ static int init_hw(struct echoaudio *chi
 	chip->subdevice_id = subdevice_id;
 	chip->bad_board = TRUE;
 	chip->has_midi = TRUE;
-	chip->dsp_code_to_load = &card_fw[FW_LAYLA20_DSP];
+	chip->dsp_code_to_load = FW_LAYLA20_DSP;
 	chip->input_clock_types =
 		ECHO_CLOCK_BIT_INTERNAL | ECHO_CLOCK_BIT_SPDIF |
 		ECHO_CLOCK_BIT_WORD | ECHO_CLOCK_BIT_SUPER;
@@ -144,7 +143,7 @@ static int load_asic(struct echoaudio *c
 		return 0;
 
 	err = load_asic_generic(chip, DSP_FNC_LOAD_LAYLA_ASIC,
-				&card_fw[FW_LAYLA20_ASIC]);
+				FW_LAYLA20_ASIC);
 	if (err < 0)
 		return err;
 
diff -dup alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/layla24_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/layla24_dsp.c
--- alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/layla24_dsp.c	2009-12-28 15:21:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/layla24_dsp.c	2010-01-02 21:27:05.000000000 +0100
@@ -32,8 +32,7 @@ static int write_control_reg(struct echo
 static int set_input_clock(struct echoaudio *chip, u16 clock);
 static int set_professional_spdif(struct echoaudio *chip, char prof);
 static int set_digital_mode(struct echoaudio *chip, u8 mode);
-static int load_asic_generic(struct echoaudio *chip, u32 cmd,
-			     const struct firmware *asic);
+static int load_asic_generic(struct echoaudio *chip, u32 cmd, short asic);
 static int check_asic_status(struct echoaudio *chip);
 
 
@@ -54,7 +53,7 @@ static int init_hw(struct echoaudio *chi
 	chip->subdevice_id = subdevice_id;
 	chip->bad_board = TRUE;
 	chip->has_midi = TRUE;
-	chip->dsp_code_to_load = &card_fw[FW_LAYLA24_DSP];
+	chip->dsp_code_to_load = FW_LAYLA24_DSP;
 	chip->input_clock_types =
 		ECHO_CLOCK_BIT_INTERNAL | ECHO_CLOCK_BIT_SPDIF |
 		ECHO_CLOCK_BIT_WORD | ECHO_CLOCK_BIT_ADAT;
@@ -123,18 +122,18 @@ static int load_asic(struct echoaudio *c
 
 	/* Load the ASIC for the PCI card */
 	err = load_asic_generic(chip, DSP_FNC_LOAD_LAYLA24_PCI_CARD_ASIC,
-				&card_fw[FW_LAYLA24_1_ASIC]);
+				FW_LAYLA24_1_ASIC);
 	if (err < 0)
 		return err;
 
-	chip->asic_code = &card_fw[FW_LAYLA24_2S_ASIC];
+	chip->asic_code = FW_LAYLA24_2S_ASIC;
 
 	/* Now give the new ASIC a little time to set up */
 	mdelay(10);
 
 	/* Do the external one */
 	err = load_asic_generic(chip, DSP_FNC_LOAD_LAYLA24_EXTERNAL_ASIC,
-				&card_fw[FW_LAYLA24_2S_ASIC]);
+				FW_LAYLA24_2S_ASIC);
 	if (err < 0)
 		return FALSE;
 
@@ -299,7 +298,7 @@ static int set_input_clock(struct echoau
 /* Depending on what digital mode you want, Layla24 needs different ASICs
 loaded.  This function checks the ASIC needed for the new mode and sees
 if it matches the one already loaded. */
-static int switch_asic(struct echoaudio *chip, const struct firmware *asic)
+static int switch_asic(struct echoaudio *chip, short asic)
 {
 	s8 *monitors;
 
@@ -335,7 +334,7 @@ static int dsp_set_digital_mode(struct e
 {
 	u32 control_reg;
 	int err, incompatible_clock;
-	const struct firmware *asic;
+	short asic;
 
 	/* Set clock to "internal" if it's not compatible with the new mode */
 	incompatible_clock = FALSE;
@@ -344,12 +343,12 @@ static int dsp_set_digital_mode(struct e
 	case DIGITAL_MODE_SPDIF_RCA:
 		if (chip->input_clock == ECHO_CLOCK_ADAT)
 			incompatible_clock = TRUE;
-		asic = &card_fw[FW_LAYLA24_2S_ASIC];
+		asic = FW_LAYLA24_2S_ASIC;
 		break;
 	case DIGITAL_MODE_ADAT:
 		if (chip->input_clock == ECHO_CLOCK_SPDIF)
 			incompatible_clock = TRUE;
-		asic = &card_fw[FW_LAYLA24_2A_ASIC];
+		asic = FW_LAYLA24_2A_ASIC;
 		break;
 	default:
 		DE_ACT(("Digital mode not supported: %d\n", mode));
diff -dup alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/mia_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/mia_dsp.c
--- alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/mia_dsp.c	2009-12-28 15:21:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/mia_dsp.c	2010-01-02 21:27:05.000000000 +0100
@@ -53,7 +53,7 @@ static int init_hw(struct echoaudio *chi
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
 	chip->bad_board = TRUE;
-	chip->dsp_code_to_load = &card_fw[FW_MIA_DSP];
+	chip->dsp_code_to_load = FW_MIA_DSP;
 	/* Since this card has no ASIC, mark it as loaded so everything
 	   works OK */
 	chip->asic_loaded = TRUE;
diff -dup alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/mona_dsp.c alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/mona_dsp.c
--- alsa-driver-1.0.22.1__orig/alsa-kernel/pci/echoaudio/mona_dsp.c	2009-12-28 15:21:33.000000000 +0100
+++ alsa-driver-1.0.22.1/alsa-kernel/pci/echoaudio/mona_dsp.c	2010-01-02 21:27:05.000000000 +0100
@@ -33,8 +33,7 @@ static int write_control_reg(struct echo
 static int set_input_clock(struct echoaudio *chip, u16 clock);
 static int set_professional_spdif(struct echoaudio *chip, char prof);
 static int set_digital_mode(struct echoaudio *chip, u8 mode);
-static int load_asic_generic(struct echoaudio *chip, u32 cmd,
-			     const struct firmware *asic);
+static int load_asic_generic(struct echoaudio *chip, u32 cmd, short asic);
 static int check_asic_status(struct echoaudio *chip);
 
 
@@ -64,9 +63,9 @@ static int init_hw(struct echoaudio *chi
 
 	/* Mona comes in both '301 and '361 flavors */
 	if (chip->device_id == DEVICE_ID_56361)
-		chip->dsp_code_to_load = &card_fw[FW_MONA_361_DSP];
+		chip->dsp_code_to_load = FW_MONA_361_DSP;
 	else
-		chip->dsp_code_to_load = &card_fw[FW_MONA_301_DSP];
+		chip->dsp_code_to_load = FW_MONA_301_DSP;
 
 	chip->digital_mode = DIGITAL_MODE_SPDIF_RCA;
 	chip->professional_spdif = FALSE;
@@ -120,7 +119,7 @@ static int load_asic(struct echoaudio *c
 {
 	u32 control_reg;
 	int err;
-	const struct firmware *asic;
+	short asic;
 
 	if (chip->asic_loaded)
 		return 0;
@@ -128,9 +127,9 @@ static int load_asic(struct echoaudio *c
 	mdelay(10);
 
 	if (chip->device_id == DEVICE_ID_56361)
-		asic = &card_fw[FW_MONA_361_1_ASIC48];
+		asic = FW_MONA_361_1_ASIC48;
 	else
-		asic = &card_fw[FW_MONA_301_1_ASIC48];
+		asic = FW_MONA_301_1_ASIC48;
 
 	err = load_asic_generic(chip, DSP_FNC_LOAD_MONA_PCI_CARD_ASIC, asic);
 	if (err < 0)
@@ -141,7 +140,7 @@ static int load_asic(struct echoaudio *c
 
 	/* Do the external one */
 	err = load_asic_generic(chip, DSP_FNC_LOAD_MONA_EXTERNAL_ASIC,
-				&card_fw[FW_MONA_2_ASIC]);
+				FW_MONA_2_ASIC);
 	if (err < 0)
 		return err;
 
@@ -165,22 +164,22 @@ loaded.  This function checks the ASIC n
 if it matches the one already loaded. */
 static int switch_asic(struct echoaudio *chip, char double_speed)
 {
-	const struct firmware *asic;
 	int err;
+	short asic;
 
 	/* Check the clock detect bits to see if this is
 	a single-speed clock or a double-speed clock; load
 	a new ASIC if necessary. */
 	if (chip->device_id == DEVICE_ID_56361) {
 		if (double_speed)
-			asic = &card_fw[FW_MONA_361_1_ASIC96];
+			asic = FW_MONA_361_1_ASIC96;
 		else
-			asic = &card_fw[FW_MONA_361_1_ASIC48];
+			asic = FW_MONA_361_1_ASIC48;
 	} else {
 		if (double_speed)
-			asic = &card_fw[FW_MONA_301_1_ASIC96];
+			asic = FW_MONA_301_1_ASIC96;
 		else
-			asic = &card_fw[FW_MONA_301_1_ASIC48];
+			asic = FW_MONA_301_1_ASIC48;
 	}
 
 	if (asic != chip->asic_code) {
@@ -200,7 +199,7 @@ static int switch_asic(struct echoaudio 
 static int set_sample_rate(struct echoaudio *chip, u32 rate)
 {
 	u32 control_reg, clock;
-	const struct firmware *asic;
+	short asic;
 	char force_write;
 
 	/* Only set the clock for internal mode. */
@@ -218,14 +217,14 @@ static int set_sample_rate(struct echoau
 		if (chip->digital_mode == DIGITAL_MODE_ADAT)
 			return -EINVAL;
 		if (chip->device_id == DEVICE_ID_56361)
-			asic = &card_fw[FW_MONA_361_1_ASIC96];
+			asic = FW_MONA_361_1_ASIC96;
 		else
-			asic = &card_fw[FW_MONA_301_1_ASIC96];
+			asic = FW_MONA_301_1_ASIC96;
 	} else {
 		if (chip->device_id == DEVICE_ID_56361)
-			asic = &card_fw[FW_MONA_361_1_ASIC48];
+			asic = FW_MONA_361_1_ASIC48;
 		else
-			asic = &card_fw[FW_MONA_301_1_ASIC48];
+			asic = FW_MONA_301_1_ASIC48;
 	}
 
 	force_write = 0;
@@ -410,8 +409,8 @@ static int dsp_set_digital_mode(struct e
 	case DIGITAL_MODE_ADAT:
 		/* If the current ASIC is the 96KHz ASIC, switch the ASIC
 		   and set to 48 KHz */
-		if (chip->asic_code == &card_fw[FW_MONA_361_1_ASIC96] ||
-		    chip->asic_code == &card_fw[FW_MONA_301_1_ASIC96]) {
+		if (chip->asic_code == FW_MONA_361_1_ASIC96 ||
+		    chip->asic_code == FW_MONA_301_1_ASIC96) {
 			set_sample_rate(chip, 48000);
 		}
 		control_reg |= GML_ADAT_MODE;


-- 
Giuliano.
