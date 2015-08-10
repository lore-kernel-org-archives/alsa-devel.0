From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ALSA: echoaudio: Use standard C definitions of
	true and false
Date: Mon, 10 Aug 2015 13:02:53 +0100
Message-ID: <1439208173-16501-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 37C29260836
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 14:03:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The echoaudio locally defines TRUE and FALSE.  Not only is this
redundant given that C now has a boolean type it results in lots of
warnings as other headers also define these macros, causing duplicate
definitions.  Fix this by removing the local defines and converting all
local users to use the standard C true and false instead, simply
removing the macros is less safe due to implicit inclusion of the other
definitons.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/pci/echoaudio/darla20_dsp.c   |  6 +++---
 sound/pci/echoaudio/darla24_dsp.c   |  6 +++---
 sound/pci/echoaudio/echo3g_dsp.c    | 16 ++++++++--------
 sound/pci/echoaudio/echoaudio.c     |  2 +-
 sound/pci/echoaudio/echoaudio.h     |  7 ++-----
 sound/pci/echoaudio/echoaudio_3g.c  | 12 ++++++------
 sound/pci/echoaudio/echoaudio_dsp.c | 26 +++++++++++++-------------
 sound/pci/echoaudio/gina20_dsp.c    |  8 ++++----
 sound/pci/echoaudio/gina24_dsp.c    | 22 +++++++++++-----------
 sound/pci/echoaudio/indigo_dsp.c    |  6 +++---
 sound/pci/echoaudio/indigodj_dsp.c  |  6 +++---
 sound/pci/echoaudio/indigodjx_dsp.c |  6 +++---
 sound/pci/echoaudio/indigoio_dsp.c  |  6 +++---
 sound/pci/echoaudio/indigoiox_dsp.c |  6 +++---
 sound/pci/echoaudio/layla20_dsp.c   | 12 ++++++------
 sound/pci/echoaudio/layla24_dsp.c   | 26 +++++++++++++-------------
 sound/pci/echoaudio/mia_dsp.c       |  8 ++++----
 sound/pci/echoaudio/mona_dsp.c      | 20 ++++++++++----------
 18 files changed, 99 insertions(+), 102 deletions(-)

diff --git a/sound/pci/echoaudio/darla20_dsp.c b/sound/pci/echoaudio/darla20_dsp.c
index febee5b..320837b 100644
--- a/sound/pci/echoaudio/darla20_dsp.c
+++ b/sound/pci/echoaudio/darla20_dsp.c
@@ -44,18 +44,18 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
-	chip->bad_board = TRUE;
+	chip->bad_board = true;
 	chip->dsp_code_to_load = FW_DARLA20_DSP;
 	chip->spdif_status = GD_SPDIF_STATUS_UNDEF;
 	chip->clock_state = GD_CLOCK_UNDEF;
 	/* Since this card has no ASIC, mark it as loaded so everything
 	   works OK */
-	chip->asic_loaded = TRUE;
+	chip->asic_loaded = true;
 	chip->input_clock_types = ECHO_CLOCK_BIT_INTERNAL;
 
 	if ((err = load_firmware(chip)) < 0)
 		return err;
-	chip->bad_board = FALSE;
+	chip->bad_board = false;
 
 	return err;
 }
diff --git a/sound/pci/echoaudio/darla24_dsp.c b/sound/pci/echoaudio/darla24_dsp.c
index 7b4f6fd..8736b5e 100644
--- a/sound/pci/echoaudio/darla24_dsp.c
+++ b/sound/pci/echoaudio/darla24_dsp.c
@@ -44,17 +44,17 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
-	chip->bad_board = TRUE;
+	chip->bad_board = true;
 	chip->dsp_code_to_load = FW_DARLA24_DSP;
 	/* Since this card has no ASIC, mark it as loaded so everything
 	   works OK */
-	chip->asic_loaded = TRUE;
+	chip->asic_loaded = true;
 	chip->input_clock_types = ECHO_CLOCK_BIT_INTERNAL |
 		ECHO_CLOCK_BIT_ESYNC;
 
 	if ((err = load_firmware(chip)) < 0)
 		return err;
-	chip->bad_board = FALSE;
+	chip->bad_board = false;
 
 	return err;
 }
diff --git a/sound/pci/echoaudio/echo3g_dsp.c b/sound/pci/echoaudio/echo3g_dsp.c
index ae11ce1..6deb80c 100644
--- a/sound/pci/echoaudio/echo3g_dsp.c
+++ b/sound/pci/echoaudio/echo3g_dsp.c
@@ -59,8 +59,8 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 		cpu_to_le32((E3G_MAGIC_NUMBER / 48000) - 2);
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
-	chip->bad_board = TRUE;
-	chip->has_midi = TRUE;
+	chip->bad_board = true;
+	chip->has_midi = true;
 	chip->dsp_code_to_load = FW_ECHO3G_DSP;
 
 	/* Load the DSP code and the ASIC on the PCI card and get
@@ -78,8 +78,8 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 		chip->px_analog_in = chip->bx_analog_in = 14;
 		chip->px_digital_in = chip->bx_digital_in = 16;
 		chip->px_num = chip->bx_num = 24;
-		chip->has_phantom_power = TRUE;
-		chip->hasnt_input_nominal_level = TRUE;
+		chip->has_phantom_power = true;
+		chip->hasnt_input_nominal_level = true;
 	} else if (err == E3G_LAYLA3G_BOX_TYPE) {
 		chip->input_clock_types =	ECHO_CLOCK_BIT_INTERNAL |
 						ECHO_CLOCK_BIT_SPDIF |
@@ -106,10 +106,10 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 static int set_mixer_defaults(struct echoaudio *chip)
 {
 	chip->digital_mode = DIGITAL_MODE_SPDIF_RCA;
-	chip->professional_spdif = FALSE;
-	chip->non_audio_spdif = FALSE;
-	chip->bad_board = FALSE;
-	chip->phantom_power = FALSE;
+	chip->professional_spdif = false;
+	chip->non_audio_spdif = false;
+	chip->bad_board = false;
+	chip->phantom_power = false;
 	return init_line_levels(chip);
 }
 
diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 862db9a..1cb85ae 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -2245,7 +2245,7 @@ static int snd_echo_resume(struct device *dev)
 
 #ifdef ECHOCARD_HAS_MIDI
 	if (chip->midi_input_enabled)
-		enable_midi_input(chip, TRUE);
+		enable_midi_input(chip, true);
 	if (chip->midi_out)
 		snd_echo_midi_output_trigger(chip->midi_out, 1);
 #endif
diff --git a/sound/pci/echoaudio/echoaudio.h b/sound/pci/echoaudio/echoaudio.h
index 3251522..152ce15 100644
--- a/sound/pci/echoaudio/echoaudio.h
+++ b/sound/pci/echoaudio/echoaudio.h
@@ -153,9 +153,6 @@
 #define _ECHOAUDIO_H_
 
 
-#define TRUE 1
-#define FALSE 0
-
 #include "echoaudio_dsp.h"
 
 
@@ -378,8 +375,8 @@ struct echoaudio {
 					 */
 	u8 output_clock;		/* Layla20 only */
 	char meters_enabled;		/* VU-meters status */
-	char asic_loaded;		/* Set TRUE when ASIC loaded */
-	char bad_board;			/* Set TRUE if DSP won't load */
+	char asic_loaded;		/* Set true when ASIC loaded */
+	char bad_board;			/* Set true if DSP won't load */
 	char professional_spdif;	/* 0 = consumer; 1 = professional */
 	char non_audio_spdif;		/* 3G - only */
 	char digital_in_automute;	/* Gina24, Layla24, Mona - only */
diff --git a/sound/pci/echoaudio/echoaudio_3g.c b/sound/pci/echoaudio/echoaudio_3g.c
index 2fa66dc..22c786b 100644
--- a/sound/pci/echoaudio/echoaudio_3g.c
+++ b/sound/pci/echoaudio/echoaudio_3g.c
@@ -41,7 +41,7 @@ static int check_asic_status(struct echoaudio *chip)
 		return -EIO;
 
 	chip->comm_page->ext_box_status = cpu_to_le32(E3G_ASIC_NOT_LOADED);
-	chip->asic_loaded = FALSE;
+	chip->asic_loaded = false;
 	clear_handshake(chip);
 	send_vector(chip, DSP_VC_TEST_ASIC);
 
@@ -55,7 +55,7 @@ static int check_asic_status(struct echoaudio *chip)
 	if (box_status == E3G_ASIC_NOT_LOADED)
 		return -ENODEV;
 
-	chip->asic_loaded = TRUE;
+	chip->asic_loaded = true;
 	return box_status & E3G_BOX_TYPE_MASK;
 }
 
@@ -243,7 +243,7 @@ static int load_asic(struct echoaudio *chip)
 	 * 48 kHz, internal clock, S/PDIF RCA mode */
 	if (box_type >= 0) {
 		err = write_control_reg(chip, E3G_48KHZ,
-					E3G_FREQ_REG_DEFAULT, TRUE);
+					E3G_FREQ_REG_DEFAULT, true);
 		if (err < 0)
 			return err;
 	}
@@ -378,16 +378,16 @@ static int dsp_set_digital_mode(struct echoaudio *chip, u8 mode)
 	int err, incompatible_clock;
 
 	/* Set clock to "internal" if it's not compatible with the new mode */
-	incompatible_clock = FALSE;
+	incompatible_clock = false;
 	switch (mode) {
 	case DIGITAL_MODE_SPDIF_OPTICAL:
 	case DIGITAL_MODE_SPDIF_RCA:
 		if (chip->input_clock == ECHO_CLOCK_ADAT)
-			incompatible_clock = TRUE;
+			incompatible_clock = true;
 		break;
 	case DIGITAL_MODE_ADAT:
 		if (chip->input_clock == ECHO_CLOCK_SPDIF)
-			incompatible_clock = TRUE;
+			incompatible_clock = true;
 		break;
 	default:
 		dev_err(chip->card->dev,
diff --git a/sound/pci/echoaudio/echoaudio_dsp.c b/sound/pci/echoaudio/echoaudio_dsp.c
index 1a9427a..15aae2f 100644
--- a/sound/pci/echoaudio/echoaudio_dsp.c
+++ b/sound/pci/echoaudio/echoaudio_dsp.c
@@ -103,8 +103,8 @@ static int write_dsp(struct echoaudio *chip, u32 data)
 		cond_resched();
 	}
 
-	chip->bad_board = TRUE;		/* Set TRUE until DSP re-loaded */
-	dev_dbg(chip->card->dev, "write_dsp: Set bad_board to TRUE\n");
+	chip->bad_board = true;		/* Set true until DSP re-loaded */
+	dev_dbg(chip->card->dev, "write_dsp: Set bad_board to true\n");
 	return -EIO;
 }
 
@@ -126,8 +126,8 @@ static int read_dsp(struct echoaudio *chip, u32 *data)
 		cond_resched();
 	}
 
-	chip->bad_board = TRUE;		/* Set TRUE until DSP re-loaded */
-	dev_err(chip->card->dev, "read_dsp: Set bad_board to TRUE\n");
+	chip->bad_board = true;		/* Set true until DSP re-loaded */
+	dev_err(chip->card->dev, "read_dsp: Set bad_board to true\n");
 	return -EIO;
 }
 
@@ -166,7 +166,7 @@ static int read_sn(struct echoaudio *chip)
 /* This card has no ASIC, just return ok */
 static inline int check_asic_status(struct echoaudio *chip)
 {
-	chip->asic_loaded = TRUE;
+	chip->asic_loaded = true;
 	return 0;
 }
 
@@ -341,11 +341,11 @@ static int load_dsp(struct echoaudio *chip, u16 *code)
 		dev_warn(chip->card->dev, "DSP is already loaded!\n");
 		return 0;
 	}
-	chip->bad_board = TRUE;		/* Set TRUE until DSP loaded */
+	chip->bad_board = true;		/* Set true until DSP loaded */
 	chip->dsp_code = NULL;		/* Current DSP code not loaded */
-	chip->asic_loaded = FALSE;	/* Loading the DSP code will reset the ASIC */
+	chip->asic_loaded = false;	/* Loading the DSP code will reset the ASIC */
 
-	dev_dbg(chip->card->dev, "load_dsp: Set bad_board to TRUE\n");
+	dev_dbg(chip->card->dev, "load_dsp: Set bad_board to true\n");
 
 	/* If this board requires a resident loader, install it. */
 #ifdef DSP_56361
@@ -471,7 +471,7 @@ static int load_dsp(struct echoaudio *chip, u16 *code)
 			}
 
 			chip->dsp_code = code;		/* Show which DSP code loaded */
-			chip->bad_board = FALSE;	/* DSP OK */
+			chip->bad_board = false;	/* DSP OK */
 			return 0;
 		}
 		udelay(100);
@@ -951,10 +951,10 @@ static int rest_in_peace(struct echoaudio *chip)
 	/* Stops all active pipes (just to be sure) */
 	stop_transport(chip, chip->active_mask);
 
-	set_meters_on(chip, FALSE);
+	set_meters_on(chip, false);
 
 #ifdef ECHOCARD_HAS_MIDI
-	enable_midi_input(chip, FALSE);
+	enable_midi_input(chip, false);
 #endif
 
 	/* Go to sleep */
@@ -981,9 +981,9 @@ static int init_dsp_comm_page(struct echoaudio *chip)
 
 	/* Init all the basic stuff */
 	chip->card_name = ECHOCARD_NAME;
-	chip->bad_board = TRUE;	/* Set TRUE until DSP loaded */
+	chip->bad_board = true;	/* Set true until DSP loaded */
 	chip->dsp_code = NULL;	/* Current DSP code not loaded */
-	chip->asic_loaded = FALSE;
+	chip->asic_loaded = false;
 	memset(chip->comm_page, 0, sizeof(struct comm_page));
 
 	/* Init the comm page */
diff --git a/sound/pci/echoaudio/gina20_dsp.c b/sound/pci/echoaudio/gina20_dsp.c
index 5dafe92..b237757 100644
--- a/sound/pci/echoaudio/gina20_dsp.c
+++ b/sound/pci/echoaudio/gina20_dsp.c
@@ -48,19 +48,19 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
-	chip->bad_board = TRUE;
+	chip->bad_board = true;
 	chip->dsp_code_to_load = FW_GINA20_DSP;
 	chip->spdif_status = GD_SPDIF_STATUS_UNDEF;
 	chip->clock_state = GD_CLOCK_UNDEF;
 	/* Since this card has no ASIC, mark it as loaded so everything
 	   works OK */
-	chip->asic_loaded = TRUE;
+	chip->asic_loaded = true;
 	chip->input_clock_types = ECHO_CLOCK_BIT_INTERNAL |
 		ECHO_CLOCK_BIT_SPDIF;
 
 	if ((err = load_firmware(chip)) < 0)
 		return err;
-	chip->bad_board = FALSE;
+	chip->bad_board = false;
 
 	return err;
 }
@@ -69,7 +69,7 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 
 static int set_mixer_defaults(struct echoaudio *chip)
 {
-	chip->professional_spdif = FALSE;
+	chip->professional_spdif = false;
 	return init_line_levels(chip);
 }
 
diff --git a/sound/pci/echoaudio/gina24_dsp.c b/sound/pci/echoaudio/gina24_dsp.c
index 6971766..8eff2b4 100644
--- a/sound/pci/echoaudio/gina24_dsp.c
+++ b/sound/pci/echoaudio/gina24_dsp.c
@@ -52,7 +52,7 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
-	chip->bad_board = TRUE;
+	chip->bad_board = true;
 	chip->input_clock_types =
 		ECHO_CLOCK_BIT_INTERNAL | ECHO_CLOCK_BIT_SPDIF |
 		ECHO_CLOCK_BIT_ESYNC | ECHO_CLOCK_BIT_ESYNC96 |
@@ -76,7 +76,7 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 
 	if ((err = load_firmware(chip)) < 0)
 		return err;
-	chip->bad_board = FALSE;
+	chip->bad_board = false;
 
 	return err;
 }
@@ -86,8 +86,8 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 static int set_mixer_defaults(struct echoaudio *chip)
 {
 	chip->digital_mode = DIGITAL_MODE_SPDIF_RCA;
-	chip->professional_spdif = FALSE;
-	chip->digital_in_automute = TRUE;
+	chip->professional_spdif = false;
+	chip->digital_in_automute = true;
 	return init_line_levels(chip);
 }
 
@@ -152,7 +152,7 @@ static int load_asic(struct echoaudio *chip)
 	   48 kHz, internal clock, S/PDIF RCA mode */
 	if (!err) {
 		control_reg = GML_CONVERTER_ENABLE | GML_48KHZ;
-		err = write_control_reg(chip, control_reg, TRUE);
+		err = write_control_reg(chip, control_reg, true);
 	}
 	return err;
 }
@@ -226,7 +226,7 @@ static int set_sample_rate(struct echoaudio *chip, u32 rate)
 	chip->sample_rate = rate;
 	dev_dbg(chip->card->dev, "set_sample_rate: %d clock %d\n", rate, clock);
 
-	return write_control_reg(chip, control_reg, FALSE);
+	return write_control_reg(chip, control_reg, false);
 }
 
 
@@ -274,7 +274,7 @@ static int set_input_clock(struct echoaudio *chip, u16 clock)
 	}
 
 	chip->input_clock = clock;
-	return write_control_reg(chip, control_reg, TRUE);
+	return write_control_reg(chip, control_reg, true);
 }
 
 
@@ -285,17 +285,17 @@ static int dsp_set_digital_mode(struct echoaudio *chip, u8 mode)
 	int err, incompatible_clock;
 
 	/* Set clock to "internal" if it's not compatible with the new mode */
-	incompatible_clock = FALSE;
+	incompatible_clock = false;
 	switch (mode) {
 	case DIGITAL_MODE_SPDIF_OPTICAL:
 	case DIGITAL_MODE_SPDIF_CDROM:
 	case DIGITAL_MODE_SPDIF_RCA:
 		if (chip->input_clock == ECHO_CLOCK_ADAT)
-			incompatible_clock = TRUE;
+			incompatible_clock = true;
 		break;
 	case DIGITAL_MODE_ADAT:
 		if (chip->input_clock == ECHO_CLOCK_SPDIF)
-			incompatible_clock = TRUE;
+			incompatible_clock = true;
 		break;
 	default:
 		dev_err(chip->card->dev,
@@ -333,7 +333,7 @@ static int dsp_set_digital_mode(struct echoaudio *chip, u8 mode)
 		break;
 	}
 
-	err = write_control_reg(chip, control_reg, TRUE);
+	err = write_control_reg(chip, control_reg, true);
 	spin_unlock_irq(&chip->lock);
 	if (err < 0)
 		return err;
diff --git a/sound/pci/echoaudio/indigo_dsp.c b/sound/pci/echoaudio/indigo_dsp.c
index 54edd67..c97dc83 100644
--- a/sound/pci/echoaudio/indigo_dsp.c
+++ b/sound/pci/echoaudio/indigo_dsp.c
@@ -49,16 +49,16 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
-	chip->bad_board = TRUE;
+	chip->bad_board = true;
 	chip->dsp_code_to_load = FW_INDIGO_DSP;
 	/* Since this card has no ASIC, mark it as loaded so everything
 	   works OK */
-	chip->asic_loaded = TRUE;
+	chip->asic_loaded = true;
 	chip->input_clock_types = ECHO_CLOCK_BIT_INTERNAL;
 
 	if ((err = load_firmware(chip)) < 0)
 		return err;
-	chip->bad_board = FALSE;
+	chip->bad_board = false;
 
 	return err;
 }
diff --git a/sound/pci/echoaudio/indigodj_dsp.c b/sound/pci/echoaudio/indigodj_dsp.c
index 2cf5cc0..2428b35 100644
--- a/sound/pci/echoaudio/indigodj_dsp.c
+++ b/sound/pci/echoaudio/indigodj_dsp.c
@@ -49,16 +49,16 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
-	chip->bad_board = TRUE;
+	chip->bad_board = true;
 	chip->dsp_code_to_load = FW_INDIGO_DJ_DSP;
 	/* Since this card has no ASIC, mark it as loaded so everything
 	   works OK */
-	chip->asic_loaded = TRUE;
+	chip->asic_loaded = true;
 	chip->input_clock_types = ECHO_CLOCK_BIT_INTERNAL;
 
 	if ((err = load_firmware(chip)) < 0)
 		return err;
-	chip->bad_board = FALSE;
+	chip->bad_board = false;
 
 	return err;
 }
diff --git a/sound/pci/echoaudio/indigodjx_dsp.c b/sound/pci/echoaudio/indigodjx_dsp.c
index 5252863..5fbd4a3 100644
--- a/sound/pci/echoaudio/indigodjx_dsp.c
+++ b/sound/pci/echoaudio/indigodjx_dsp.c
@@ -47,17 +47,17 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
-	chip->bad_board = TRUE;
+	chip->bad_board = true;
 	chip->dsp_code_to_load = FW_INDIGO_DJX_DSP;
 	/* Since this card has no ASIC, mark it as loaded so everything
 	   works OK */
-	chip->asic_loaded = TRUE;
+	chip->asic_loaded = true;
 	chip->input_clock_types = ECHO_CLOCK_BIT_INTERNAL;
 
 	err = load_firmware(chip);
 	if (err < 0)
 		return err;
-	chip->bad_board = FALSE;
+	chip->bad_board = false;
 
 	return err;
 }
diff --git a/sound/pci/echoaudio/indigoio_dsp.c b/sound/pci/echoaudio/indigoio_dsp.c
index 4e81787..79b68ba 100644
--- a/sound/pci/echoaudio/indigoio_dsp.c
+++ b/sound/pci/echoaudio/indigoio_dsp.c
@@ -49,16 +49,16 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
-	chip->bad_board = TRUE;
+	chip->bad_board = true;
 	chip->dsp_code_to_load = FW_INDIGO_IO_DSP;
 	/* Since this card has no ASIC, mark it as loaded so everything
 	   works OK */
-	chip->asic_loaded = TRUE;
+	chip->asic_loaded = true;
 	chip->input_clock_types = ECHO_CLOCK_BIT_INTERNAL;
 
 	if ((err = load_firmware(chip)) < 0)
 		return err;
-	chip->bad_board = FALSE;
+	chip->bad_board = false;
 
 	return err;
 }
diff --git a/sound/pci/echoaudio/indigoiox_dsp.c b/sound/pci/echoaudio/indigoiox_dsp.c
index 6de3f9b..1ae394e 100644
--- a/sound/pci/echoaudio/indigoiox_dsp.c
+++ b/sound/pci/echoaudio/indigoiox_dsp.c
@@ -47,17 +47,17 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
-	chip->bad_board = TRUE;
+	chip->bad_board = true;
 	chip->dsp_code_to_load = FW_INDIGO_IOX_DSP;
 	/* Since this card has no ASIC, mark it as loaded so everything
 	   works OK */
-	chip->asic_loaded = TRUE;
+	chip->asic_loaded = true;
 	chip->input_clock_types = ECHO_CLOCK_BIT_INTERNAL;
 
 	err = load_firmware(chip);
 	if (err < 0)
 		return err;
-	chip->bad_board = FALSE;
+	chip->bad_board = false;
 
 	return err;
 }
diff --git a/sound/pci/echoaudio/layla20_dsp.c b/sound/pci/echoaudio/layla20_dsp.c
index f2024a3..5e5b6e2 100644
--- a/sound/pci/echoaudio/layla20_dsp.c
+++ b/sound/pci/echoaudio/layla20_dsp.c
@@ -51,8 +51,8 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
-	chip->bad_board = TRUE;
-	chip->has_midi = TRUE;
+	chip->bad_board = true;
+	chip->has_midi = true;
 	chip->dsp_code_to_load = FW_LAYLA20_DSP;
 	chip->input_clock_types =
 		ECHO_CLOCK_BIT_INTERNAL | ECHO_CLOCK_BIT_SPDIF |
@@ -62,7 +62,7 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 
 	if ((err = load_firmware(chip)) < 0)
 		return err;
-	chip->bad_board = FALSE;
+	chip->bad_board = false;
 
 	return err;
 }
@@ -71,7 +71,7 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 
 static int set_mixer_defaults(struct echoaudio *chip)
 {
-	chip->professional_spdif = FALSE;
+	chip->professional_spdif = false;
 	return init_line_levels(chip);
 }
 
@@ -113,7 +113,7 @@ static int check_asic_status(struct echoaudio *chip)
 	u32 asic_status;
 	int goodcnt, i;
 
-	chip->asic_loaded = FALSE;
+	chip->asic_loaded = false;
 	for (i = goodcnt = 0; i < 5; i++) {
 		send_vector(chip, DSP_VC_TEST_ASIC);
 
@@ -127,7 +127,7 @@ static int check_asic_status(struct echoaudio *chip)
 
 		if (asic_status == ASIC_ALREADY_LOADED) {
 			if (++goodcnt == 3) {
-				chip->asic_loaded = TRUE;
+				chip->asic_loaded = true;
 				return 0;
 			}
 		}
diff --git a/sound/pci/echoaudio/layla24_dsp.c b/sound/pci/echoaudio/layla24_dsp.c
index 4f11e81..df28e51 100644
--- a/sound/pci/echoaudio/layla24_dsp.c
+++ b/sound/pci/echoaudio/layla24_dsp.c
@@ -51,8 +51,8 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
-	chip->bad_board = TRUE;
-	chip->has_midi = TRUE;
+	chip->bad_board = true;
+	chip->has_midi = true;
 	chip->dsp_code_to_load = FW_LAYLA24_DSP;
 	chip->input_clock_types =
 		ECHO_CLOCK_BIT_INTERNAL | ECHO_CLOCK_BIT_SPDIF |
@@ -64,7 +64,7 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 
 	if ((err = load_firmware(chip)) < 0)
 		return err;
-	chip->bad_board = FALSE;
+	chip->bad_board = false;
 
 	if ((err = init_line_levels(chip)) < 0)
 		return err;
@@ -77,8 +77,8 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 static int set_mixer_defaults(struct echoaudio *chip)
 {
 	chip->digital_mode = DIGITAL_MODE_SPDIF_RCA;
-	chip->professional_spdif = FALSE;
-	chip->digital_in_automute = TRUE;
+	chip->professional_spdif = false;
+	chip->digital_in_automute = true;
 	return init_line_levels(chip);
 }
 
@@ -135,7 +135,7 @@ static int load_asic(struct echoaudio *chip)
 	err = load_asic_generic(chip, DSP_FNC_LOAD_LAYLA24_EXTERNAL_ASIC,
 				FW_LAYLA24_2S_ASIC);
 	if (err < 0)
-		return FALSE;
+		return false;
 
 	/* Now give the external ASIC a little time to set up */
 	mdelay(10);
@@ -147,7 +147,7 @@ static int load_asic(struct echoaudio *chip)
 	   48 kHz, internal clock, S/PDIF RCA mode */
 	if (!err)
 		err = write_control_reg(chip, GML_CONVERTER_ENABLE | GML_48KHZ,
-					TRUE);
+					true);
 	
 	return err;
 }
@@ -241,7 +241,7 @@ static int set_sample_rate(struct echoaudio *chip, u32 rate)
 	dev_dbg(chip->card->dev,
 		"set_sample_rate: %d clock %d\n", rate, control_reg);
 
-	return write_control_reg(chip, control_reg, FALSE);
+	return write_control_reg(chip, control_reg, false);
 }
 
 
@@ -287,7 +287,7 @@ static int set_input_clock(struct echoaudio *chip, u16 clock)
 	}
 
 	chip->input_clock = clock;
-	return write_control_reg(chip, control_reg, TRUE);
+	return write_control_reg(chip, control_reg, true);
 }
 
 
@@ -334,17 +334,17 @@ static int dsp_set_digital_mode(struct echoaudio *chip, u8 mode)
 	short asic;
 
 	/* Set clock to "internal" if it's not compatible with the new mode */
-	incompatible_clock = FALSE;
+	incompatible_clock = false;
 	switch (mode) {
 	case DIGITAL_MODE_SPDIF_OPTICAL:
 	case DIGITAL_MODE_SPDIF_RCA:
 		if (chip->input_clock == ECHO_CLOCK_ADAT)
-			incompatible_clock = TRUE;
+			incompatible_clock = true;
 		asic = FW_LAYLA24_2S_ASIC;
 		break;
 	case DIGITAL_MODE_ADAT:
 		if (chip->input_clock == ECHO_CLOCK_SPDIF)
-			incompatible_clock = TRUE;
+			incompatible_clock = true;
 		asic = FW_LAYLA24_2A_ASIC;
 		break;
 	default:
@@ -383,7 +383,7 @@ static int dsp_set_digital_mode(struct echoaudio *chip, u8 mode)
 		break;
 	}
 
-	err = write_control_reg(chip, control_reg, TRUE);
+	err = write_control_reg(chip, control_reg, true);
 	spin_unlock_irq(&chip->lock);
 	if (err < 0)
 		return err;
diff --git a/sound/pci/echoaudio/mia_dsp.c b/sound/pci/echoaudio/mia_dsp.c
index fdad079..8f612a0 100644
--- a/sound/pci/echoaudio/mia_dsp.c
+++ b/sound/pci/echoaudio/mia_dsp.c
@@ -52,19 +52,19 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
-	chip->bad_board = TRUE;
+	chip->bad_board = true;
 	chip->dsp_code_to_load = FW_MIA_DSP;
 	/* Since this card has no ASIC, mark it as loaded so everything
 	   works OK */
-	chip->asic_loaded = TRUE;
+	chip->asic_loaded = true;
 	if ((subdevice_id & 0x0000f) == MIA_MIDI_REV)
-		chip->has_midi = TRUE;
+		chip->has_midi = true;
 	chip->input_clock_types = ECHO_CLOCK_BIT_INTERNAL |
 		ECHO_CLOCK_BIT_SPDIF;
 
 	if ((err = load_firmware(chip)) < 0)
 		return err;
-	chip->bad_board = FALSE;
+	chip->bad_board = false;
 
 	return err;
 }
diff --git a/sound/pci/echoaudio/mona_dsp.c b/sound/pci/echoaudio/mona_dsp.c
index 843c7a5..dce9e57 100644
--- a/sound/pci/echoaudio/mona_dsp.c
+++ b/sound/pci/echoaudio/mona_dsp.c
@@ -52,7 +52,7 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 
 	chip->device_id = device_id;
 	chip->subdevice_id = subdevice_id;
-	chip->bad_board = TRUE;
+	chip->bad_board = true;
 	chip->input_clock_types =
 		ECHO_CLOCK_BIT_INTERNAL | ECHO_CLOCK_BIT_SPDIF |
 		ECHO_CLOCK_BIT_WORD | ECHO_CLOCK_BIT_ADAT;
@@ -69,7 +69,7 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 
 	if ((err = load_firmware(chip)) < 0)
 		return err;
-	chip->bad_board = FALSE;
+	chip->bad_board = false;
 
 	return err;
 }
@@ -79,8 +79,8 @@ static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
 static int set_mixer_defaults(struct echoaudio *chip)
 {
 	chip->digital_mode = DIGITAL_MODE_SPDIF_RCA;
-	chip->professional_spdif = FALSE;
-	chip->digital_in_automute = TRUE;
+	chip->professional_spdif = false;
+	chip->digital_in_automute = true;
 	return init_line_levels(chip);
 }
 
@@ -148,7 +148,7 @@ static int load_asic(struct echoaudio *chip)
 	   48 kHz, internal clock, S/PDIF RCA mode */
 	if (!err) {
 		control_reg = GML_CONVERTER_ENABLE | GML_48KHZ;
-		err = write_control_reg(chip, control_reg, TRUE);
+		err = write_control_reg(chip, control_reg, true);
 	}
 
 	return err;
@@ -356,7 +356,7 @@ static int set_input_clock(struct echoaudio *chip, u16 clock)
 	}
 
 	chip->input_clock = clock;
-	return write_control_reg(chip, control_reg, TRUE);
+	return write_control_reg(chip, control_reg, true);
 }
 
 
@@ -367,16 +367,16 @@ static int dsp_set_digital_mode(struct echoaudio *chip, u8 mode)
 	int err, incompatible_clock;
 
 	/* Set clock to "internal" if it's not compatible with the new mode */
-	incompatible_clock = FALSE;
+	incompatible_clock = false;
 	switch (mode) {
 	case DIGITAL_MODE_SPDIF_OPTICAL:
 	case DIGITAL_MODE_SPDIF_RCA:
 		if (chip->input_clock == ECHO_CLOCK_ADAT)
-			incompatible_clock = TRUE;
+			incompatible_clock = true;
 		break;
 	case DIGITAL_MODE_ADAT:
 		if (chip->input_clock == ECHO_CLOCK_SPDIF)
-			incompatible_clock = TRUE;
+			incompatible_clock = true;
 		break;
 	default:
 		dev_err(chip->card->dev,
@@ -415,7 +415,7 @@ static int dsp_set_digital_mode(struct echoaudio *chip, u8 mode)
 		break;
 	}
 
-	err = write_control_reg(chip, control_reg, FALSE);
+	err = write_control_reg(chip, control_reg, false);
 	spin_unlock_irq(&chip->lock);
 	if (err < 0)
 		return err;
-- 
2.5.0
