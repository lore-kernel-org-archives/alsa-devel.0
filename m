From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 1/2] Echoaudio: Add support for Indigo express
	cards
Date: Sun, 15 Mar 2009 21:36:42 +0100
Message-ID: <20090315213642.6a841b73.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out113.alice.it (smtp-out113.alice.it [85.37.17.113])
	by alsa0.perex.cz (Postfix) with ESMTP id 89A0E1037EE
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2009 21:36:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This patch adds support for IndigoIOx and IndigoDJx. I tested IndigoIOx
myself, and Carmen Rocco tested the IndigoDJx. It wasn't tested
extensively, but I think it stable enough. Maybe you want to mark it as
experimental anyway. The soundcard matrix should be updated as well, but
the page is locked. These two cards have the same features of their
respective CARDBUS versions. The links to the manufacturer's site are:
http://www.echoaudio.com/Products/ExpressCard/IndigoDJx/ and
http://www.echoaudio.com/Products/ExpressCard/IndigoIOx/ .

I want to thank Echoaudio again for their support.


This patch adds support for IndigoIOx and IndigoDJx.

Signed-off-by Giuliano Pochini <pochini@shiny.it>

diff -dupN alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/echoaudio_dsp.h alsa-driver-1.0.19/sound/pci/echoaudio/echoaudio_dsp.h
--- alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/echoaudio_dsp.h	2009-01-19 12:08:58.000000000 +0100
+++ alsa-driver-1.0.19/sound/pci/echoaudio/echoaudio_dsp.h	2009-03-15 17:38:47.000000000 +0100
@@ -576,8 +576,13 @@ SET_LAYLA24_FREQUENCY_REG command.
 #define E3G_ASIC_NOT_LOADED		0xffff
 #define E3G_BOX_TYPE_MASK		0xf0
 
-#define EXT_3GBOX_NC			0x01
-#define EXT_3GBOX_NOT_SET		0x02
+/* Indigo express control register values */
+#define INDIGO_EXPRESS_32000		0x02
+#define INDIGO_EXPRESS_44100		0x01
+#define INDIGO_EXPRESS_48000		0x00
+#define INDIGO_EXPRESS_DOUBLE_SPEED	0x10
+#define INDIGO_EXPRESS_QUAD_SPEED	0x04
+#define INDIGO_EXPRESS_CLOCK_MASK	0x17
 
 
 /*
diff -dupN alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/echoaudio.h alsa-driver-1.0.19/sound/pci/echoaudio/echoaudio.h
--- alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/echoaudio.h	2009-01-19 12:08:58.000000000 +0100
+++ alsa-driver-1.0.19/sound/pci/echoaudio/echoaudio.h	2009-03-15 17:14:39.000000000 +0100
@@ -189,6 +189,9 @@
 #define INDIGO			0x0090
 #define INDIGO_IO		0x00a0
 #define INDIGO_DJ		0x00b0
+#define DC8			0x00c0
+#define INDIGO_IOX		0x00d0
+#define INDIGO_DJX		0x00e0
 #define ECHO3G			0x0100
 
 
diff -dupN alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/indigodjx.c alsa-driver-1.0.19/sound/pci/echoaudio/indigodjx.c
--- alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/indigodjx.c	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver-1.0.19/sound/pci/echoaudio/indigodjx.c	2009-03-15 17:14:39.000000000 +0100
@@ -0,0 +1,107 @@
+/*
+ *  ALSA driver for Echoaudio soundcards.
+ *  Copyright (C) 2009 Giuliano Pochini <pochini@shiny.it>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#define INDIGO_FAMILY
+#define ECHOCARD_INDIGO_DJX
+#define ECHOCARD_NAME "Indigo DJx"
+#define ECHOCARD_HAS_SUPER_INTERLEAVE
+#define ECHOCARD_HAS_VMIXER
+#define ECHOCARD_HAS_STEREO_BIG_ENDIAN32
+
+/* Pipe indexes */
+#define PX_ANALOG_OUT	0	/* 8 */
+#define PX_DIGITAL_OUT	8	/* 0 */
+#define PX_ANALOG_IN	8	/* 0 */
+#define PX_DIGITAL_IN	8	/* 0 */
+#define PX_NUM		8
+
+/* Bus indexes */
+#define BX_ANALOG_OUT	0	/* 4 */
+#define BX_DIGITAL_OUT	4	/* 0 */
+#define BX_ANALOG_IN	4	/* 0 */
+#define BX_DIGITAL_IN	4	/* 0 */
+#define BX_NUM		4
+
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/moduleparam.h>
+#include <linux/firmware.h>
+#include <sound/core.h>
+#include <sound/info.h>
+#include <sound/control.h>
+#include <sound/tlv.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/asoundef.h>
+#include <sound/initval.h>
+#include <asm/io.h>
+#include <asm/atomic.h>
+#include "echoaudio.h"
+
+MODULE_FIRMWARE("ea/loader_dsp.fw");
+MODULE_FIRMWARE("ea/indigo_djx_dsp.fw");
+
+#define FW_361_LOADER		0
+#define FW_INDIGO_DJX_DSP	1
+
+static const struct firmware card_fw[] = {
+	{0, "loader_dsp.fw"},
+	{0, "indigo_djx_dsp.fw"}
+};
+
+static struct pci_device_id snd_echo_ids[] = {
+	{0x1057, 0x3410, 0xECC0, 0x00E0, 0, 0, 0},	/* Indigo DJx*/
+	{0,}
+};
+
+static struct snd_pcm_hardware pcm_hardware_skel = {
+	.info = SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_PAUSE |
+		SNDRV_PCM_INFO_SYNC_START,
+	.formats =	SNDRV_PCM_FMTBIT_U8 |
+			SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S24_3LE |
+			SNDRV_PCM_FMTBIT_S32_LE |
+			SNDRV_PCM_FMTBIT_S32_BE,
+	.rates = 	SNDRV_PCM_RATE_32000 |
+			SNDRV_PCM_RATE_44100 |
+			SNDRV_PCM_RATE_48000 |
+			SNDRV_PCM_RATE_88200 |
+			SNDRV_PCM_RATE_96000,
+	.rate_min = 32000,
+	.rate_max = 96000,
+	.channels_min = 1,
+	.channels_max = 4,
+	.buffer_bytes_max = 262144,
+	.period_bytes_min = 32,
+	.period_bytes_max = 131072,
+	.periods_min = 2,
+	.periods_max = 220,
+};
+
+#include "indigodjx_dsp.c"
+#include "indigo_express_dsp.c"
+#include "echoaudio_dsp.c"
+#include "echoaudio.c"
diff -dupN alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/indigodjx_dsp.c alsa-driver-1.0.19/sound/pci/echoaudio/indigodjx_dsp.c
--- alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/indigodjx_dsp.c	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver-1.0.19/sound/pci/echoaudio/indigodjx_dsp.c	2009-03-15 17:17:50.000000000 +0100
@@ -0,0 +1,65 @@
+/************************************************************************
+
+This file is part of Echo Digital Audio's generic driver library.
+Copyright Echo Digital Audio Corporation (c) 1998 - 2005
+All rights reserved
+www.echoaudio.com
+
+This library is free software; you can redistribute it and/or
+modify it under the terms of the GNU Lesser General Public
+License as published by the Free Software Foundation; either
+version 2.1 of the License, or (at your option) any later version.
+
+This library is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+Lesser General Public License for more details.
+
+You should have received a copy of the GNU Lesser General Public
+License along with this library; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+
+*************************************************************************
+
+ Translation from C++ and adaptation for use in ALSA-Driver
+ were made by Giuliano Pochini <pochini@shiny.it>
+
+*************************************************************************/
+
+static int update_vmixer_level(struct echoaudio *chip);
+static int set_vmixer_gain(struct echoaudio *chip, u16 output,
+			   u16 pipe, int gain);
+
+
+static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
+{
+	int err;
+
+	DE_INIT(("init_hw() - Indigo DJx\n"));
+	if (snd_BUG_ON((subdevice_id & 0xfff0) != INDIGO_DJX))
+		return -ENODEV;
+
+	if ((err = init_dsp_comm_page(chip))) {
+		DE_INIT(("init_hw - could not initialize DSP comm page\n"));
+		return err;
+	}
+
+	chip->device_id = device_id;
+	chip->subdevice_id = subdevice_id;
+	chip->bad_board = TRUE;
+	chip->dsp_code_to_load = &card_fw[FW_INDIGO_DJX_DSP];
+	/* Since this card has no ASIC, mark it as loaded so everything
+	   works OK */
+	chip->asic_loaded = TRUE;
+	chip->input_clock_types = ECHO_CLOCK_BIT_INTERNAL;
+
+	if ((err = load_firmware(chip)) < 0)
+		return err;
+	chip->bad_board = FALSE;
+
+	if ((err = init_line_levels(chip)) < 0)
+		return err;
+
+	DE_INIT(("init_hw done\n"));
+	return err;
+}
diff -dupN alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/indigo_express_dsp.c alsa-driver-1.0.19/sound/pci/echoaudio/indigo_express_dsp.c
--- alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/indigo_express_dsp.c	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver-1.0.19/sound/pci/echoaudio/indigo_express_dsp.c	2009-03-15 17:14:39.000000000 +0100
@@ -0,0 +1,119 @@
+/************************************************************************
+
+This file is part of Echo Digital Audio's generic driver library.
+Copyright Echo Digital Audio Corporation (c) 1998 - 2005
+All rights reserved
+www.echoaudio.com
+
+This library is free software; you can redistribute it and/or
+modify it under the terms of the GNU Lesser General Public
+License as published by the Free Software Foundation; either
+version 2.1 of the License, or (at your option) any later version.
+
+This library is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+Lesser General Public License for more details.
+
+You should have received a copy of the GNU Lesser General Public
+License along with this library; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+
+*************************************************************************
+
+ Translation from C++ and adaptation for use in ALSA-Driver
+ were made by Giuliano Pochini <pochini@shiny.it>
+
+*************************************************************************/
+
+static int set_sample_rate(struct echoaudio *chip, u32 rate)
+{
+	u32 clock, control_reg, old_control_reg;
+
+	if (wait_handshake(chip))
+		return -EIO;
+
+	old_control_reg = le32_to_cpu(chip->comm_page->control_register);
+	control_reg = old_control_reg & ~INDIGO_EXPRESS_CLOCK_MASK;
+
+	switch (rate) {
+	case 32000:
+		clock = INDIGO_EXPRESS_32000;
+		break;
+	case 44100:
+		clock = INDIGO_EXPRESS_44100;
+		break;
+	case 48000:
+		clock = INDIGO_EXPRESS_48000;
+		break;
+	case 64000:
+		clock = INDIGO_EXPRESS_32000|INDIGO_EXPRESS_DOUBLE_SPEED;
+		break;
+	case 88200:
+		clock = INDIGO_EXPRESS_44100|INDIGO_EXPRESS_DOUBLE_SPEED;
+		break;
+	case 96000:
+		clock = INDIGO_EXPRESS_48000|INDIGO_EXPRESS_DOUBLE_SPEED;
+		break;
+	default:
+		return -EINVAL;
+        }
+
+	control_reg |= clock;
+	if (control_reg != old_control_reg) {
+		chip->comm_page->control_register = cpu_to_le32(control_reg);
+		chip->sample_rate = rate;
+		clear_handshake(chip);
+		return send_vector(chip, DSP_VC_UPDATE_CLOCKS);
+	}
+	return 0;
+}
+
+
+
+/* This function routes the sound from a virtual channel to a real output */
+static int set_vmixer_gain(struct echoaudio *chip, u16 output, u16 pipe,
+			   int gain)
+{
+	int index;
+
+	if (snd_BUG_ON(pipe >= num_pipes_out(chip) ||
+		       output >= num_busses_out(chip)))
+		return -EINVAL;
+
+	if (wait_handshake(chip))
+		return -EIO;
+
+	chip->vmixer_gain[output][pipe] = gain;
+	index = output * num_pipes_out(chip) + pipe;
+	chip->comm_page->vmixer[index] = gain;
+
+	DE_ACT(("set_vmixer_gain: pipe %d, out %d = %d\n", pipe, output, gain));
+	return 0;
+}
+
+
+
+/* Tell the DSP to read and update virtual mixer levels in comm page. */
+static int update_vmixer_level(struct echoaudio *chip)
+{
+	if (wait_handshake(chip))
+		return -EIO;
+	clear_handshake(chip);
+	return send_vector(chip, DSP_VC_SET_VMIXER_GAIN);
+}
+
+
+
+static u32 detect_input_clocks(const struct echoaudio *chip)
+{
+	return ECHO_CLOCK_BIT_INTERNAL;
+}
+
+
+
+/* The IndigoIO has no ASIC. Just do nothing */
+static int load_asic(struct echoaudio *chip)
+{
+	return 0;
+}
diff -dupN alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/indigoiox.c alsa-driver-1.0.19/sound/pci/echoaudio/indigoiox.c
--- alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/indigoiox.c	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver-1.0.19/sound/pci/echoaudio/indigoiox.c	2009-03-15 17:14:39.000000000 +0100
@@ -0,0 +1,109 @@
+/*
+ *  ALSA driver for Echoaudio soundcards.
+ *  Copyright (C) 2009 Giuliano Pochini <pochini@shiny.it>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#define INDIGO_FAMILY
+#define ECHOCARD_INDIGO_IOX
+#define ECHOCARD_NAME "Indigo IOx"
+#define ECHOCARD_HAS_MONITOR
+#define ECHOCARD_HAS_SUPER_INTERLEAVE
+#define ECHOCARD_HAS_VMIXER
+#define ECHOCARD_HAS_STEREO_BIG_ENDIAN32
+
+/* Pipe indexes */
+#define PX_ANALOG_OUT	0	/* 8 */
+#define PX_DIGITAL_OUT	8	/* 0 */
+#define PX_ANALOG_IN	8	/* 2 */
+#define PX_DIGITAL_IN	10	/* 0 */
+#define PX_NUM		10
+
+/* Bus indexes */
+#define BX_ANALOG_OUT	0	/* 2 */
+#define BX_DIGITAL_OUT	2	/* 0 */
+#define BX_ANALOG_IN	2	/* 2 */
+#define BX_DIGITAL_IN	4	/* 0 */
+#define BX_NUM		4
+
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/moduleparam.h>
+#include <linux/firmware.h>
+#include <sound/core.h>
+#include <sound/info.h>
+#include <sound/control.h>
+#include <sound/tlv.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/asoundef.h>
+#include <sound/initval.h>
+#include <asm/io.h>
+#include <asm/atomic.h>
+#include "echoaudio.h"
+
+MODULE_FIRMWARE("ea/loader_dsp.fw");
+MODULE_FIRMWARE("ea/indigo_iox_dsp.fw");
+
+#define FW_361_LOADER		0
+#define FW_INDIGO_IOX_DSP	1
+
+static const struct firmware card_fw[] = {
+	{0, "loader_dsp.fw"},
+	{0, "indigo_iox_dsp.fw"}
+};
+
+static struct pci_device_id snd_echo_ids[] = {
+	{0x1057, 0x3410, 0xECC0, 0x00D0, 0, 0, 0},	/* Indigo IOx */
+	{0,}
+};
+
+static struct snd_pcm_hardware pcm_hardware_skel = {
+	.info = SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_INTERLEAVED |
+		SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_MMAP_VALID |
+		SNDRV_PCM_INFO_PAUSE |
+		SNDRV_PCM_INFO_SYNC_START,
+	.formats =	SNDRV_PCM_FMTBIT_U8 |
+			SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S24_3LE |
+			SNDRV_PCM_FMTBIT_S32_LE |
+			SNDRV_PCM_FMTBIT_S32_BE,
+	.rates = 	SNDRV_PCM_RATE_32000 |
+			SNDRV_PCM_RATE_44100 |
+			SNDRV_PCM_RATE_48000 |
+			SNDRV_PCM_RATE_88200 |
+			SNDRV_PCM_RATE_96000,
+	.rate_min = 32000,
+	.rate_max = 96000,
+	.channels_min = 1,
+	.channels_max = 8,
+	.buffer_bytes_max = 262144,
+	.period_bytes_min = 32,
+	.period_bytes_max = 131072,
+	.periods_min = 2,
+	.periods_max = 220,
+};
+
+#include "indigoiox_dsp.c"
+#include "indigo_express_dsp.c"
+#include "echoaudio_dsp.c"
+#include "echoaudio.c"
+
diff -dupN alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/indigoiox_dsp.c alsa-driver-1.0.19/sound/pci/echoaudio/indigoiox_dsp.c
--- alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/indigoiox_dsp.c	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver-1.0.19/sound/pci/echoaudio/indigoiox_dsp.c	2009-03-15 17:17:38.000000000 +0100
@@ -0,0 +1,65 @@
+/************************************************************************
+
+This file is part of Echo Digital Audio's generic driver library.
+Copyright Echo Digital Audio Corporation (c) 1998 - 2005
+All rights reserved
+www.echoaudio.com
+
+This library is free software; you can redistribute it and/or
+modify it under the terms of the GNU Lesser General Public
+License as published by the Free Software Foundation; either
+version 2.1 of the License, or (at your option) any later version.
+
+This library is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+Lesser General Public License for more details.
+
+You should have received a copy of the GNU Lesser General Public
+License along with this library; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+
+*************************************************************************
+
+ Translation from C++ and adaptation for use in ALSA-Driver
+ were made by Giuliano Pochini <pochini@shiny.it>
+
+*************************************************************************/
+
+static int update_vmixer_level(struct echoaudio *chip);
+static int set_vmixer_gain(struct echoaudio *chip, u16 output,
+			   u16 pipe, int gain);
+
+
+static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
+{
+	int err;
+
+	DE_INIT(("init_hw() - Indigo IOx\n"));
+	if (snd_BUG_ON((subdevice_id & 0xfff0) != INDIGO_IOX))
+		return -ENODEV;
+
+	if ((err = init_dsp_comm_page(chip))) {
+		DE_INIT(("init_hw - could not initialize DSP comm page\n"));
+		return err;
+	}
+
+	chip->device_id = device_id;
+	chip->subdevice_id = subdevice_id;
+	chip->bad_board = TRUE;
+	chip->dsp_code_to_load = &card_fw[FW_INDIGO_IOX_DSP];
+	/* Since this card has no ASIC, mark it as loaded so everything
+	   works OK */
+	chip->asic_loaded = TRUE;
+	chip->input_clock_types = ECHO_CLOCK_BIT_INTERNAL;
+
+	if ((err = load_firmware(chip)) < 0)
+		return err;
+	chip->bad_board = FALSE;
+
+	if ((err = init_line_levels(chip)) < 0)
+		return err;
+
+	DE_INIT(("init_hw done\n"));
+	return err;
+}
diff -dupN alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/Makefile alsa-driver-1.0.19/sound/pci/echoaudio/Makefile
--- alsa-driver-1.0.19__orig/alsa-kernel/pci/echoaudio/Makefile	2009-01-19 12:08:58.000000000 +0100
+++ alsa-driver-1.0.19/sound/pci/echoaudio/Makefile	2009-03-15 17:14:39.000000000 +0100
@@ -15,6 +15,8 @@ snd-echo3g-objs := echo3g.o
 snd-indigo-objs := indigo.o
 snd-indigoio-objs := indigoio.o
 snd-indigodj-objs := indigodj.o
+snd-indigoiox-objs := indigoiox.o
+snd-indigodjx-objs := indigodjx.o
 
 obj-$(CONFIG_SND_DARLA20) += snd-darla20.o
 obj-$(CONFIG_SND_GINA20) += snd-gina20.o
@@ -28,3 +30,5 @@ obj-$(CONFIG_SND_ECHO3G) += snd-echo3g.o
 obj-$(CONFIG_SND_INDIGO) += snd-indigo.o
 obj-$(CONFIG_SND_INDIGOIO) += snd-indigoio.o
 obj-$(CONFIG_SND_INDIGODJ) += snd-indigodj.o
+obj-$(CONFIG_SND_INDIGOIOX) += snd-indigoiox.o
+obj-$(CONFIG_SND_INDIGODJX) += snd-indigodjx.o
--- alsa-driver-1.0.19__orig/alsa-kernel/pci/Kconfig	2009-01-19 12:08:58.000000000 +0100
+++ alsa-driver-1.0.19/sound/pci/Kconfig	2009-03-15 17:14:39.000000000 +0100
@@ -400,6 +400,26 @@ config SND_INDIGODJ
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-indigodj
 
+config SND_INDIGOIOX
+	tristate "(Echoaudio) Indigo IOx"
+	select FW_LOADER
+	select SND_PCM
+	help
+	  Say 'Y' or 'M' to include support for Echoaudio Indigo IOx.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-indigoiox
+
+config SND_INDIGODJX
+	tristate "(Echoaudio) Indigo DJx"
+	select FW_LOADER
+	select SND_PCM
+	help
+	  Say 'Y' or 'M' to include support for Echoaudio Indigo DJx.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-indigodjx
+
 config SND_EMU10K1
 	tristate "Emu10k1 (SB Live!, Audigy, E-mu APS)"
 	select FW_LOADER
--- alsa-driver-1.0.19__orig/pci/echoaudio/Makefile	2009-01-19 12:17:17.000000000 +0100
+++ alsa-driver-1.0.19/pci/echoaudio/Makefile	2009-03-15 17:14:39.000000000 +0100
@@ -11,7 +11,8 @@ include $(SND_TOPDIR)/toplevel.config
 include $(SND_TOPDIR)/Makefile.conf
 
 clean-files := echoaudio.c darla20.c darla24.c echo3g.c gina20.c gina24.c \
-		indigo.c indigodj.c indigoio.c layla20.c layla24.c mia.c mona.c
+		indigo.c indigodj.c indigoio.c indigodjx.c indigoiox.c \
+		layla20.c layla24.c mia.c mona.c
 
 include $(SND_TOPDIR)/alsa-kernel/pci/echoaudio/Makefile
 
@@ -26,6 +27,8 @@ gina24.c: gina24.patch $(SND_TOPDIR)/als
 indigo.c: indigo.patch $(SND_TOPDIR)/alsa-kernel/pci/echoaudio/indigo.c echoaudio.c
 indigodj.c: indigodj.patch $(SND_TOPDIR)/alsa-kernel/pci/echoaudio/indigodj.c echoaudio.c
 indigoio.c: indigoio.patch $(SND_TOPDIR)/alsa-kernel/pci/echoaudio/indigoio.c echoaudio.c
+indigodjx.c: indigodjx.patch $(SND_TOPDIR)/alsa-kernel/pci/echoaudio/indigodjx.c echoaudio.c
+indigoiox.c: indigoiox.patch $(SND_TOPDIR)/alsa-kernel/pci/echoaudio/indigoiox.c echoaudio.c
 layla20.c: layla20.patch $(SND_TOPDIR)/alsa-kernel/pci/echoaudio/layla20.c echoaudio.c
 layla24.c: layla24.patch $(SND_TOPDIR)/alsa-kernel/pci/echoaudio/layla24.c echoaudio.c
 mia.c: mia.patch $(SND_TOPDIR)/alsa-kernel/pci/echoaudio/mia.c echoaudio.c
--- alsa-driver-1.0.19__orig/pci/echoaudio/indigoiox.patch	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver-1.0.19/pci/echoaudio/indigoiox.patch	2009-03-15 17:14:39.000000000 +0100
@@ -0,0 +1,18 @@
+--- ../../alsa-kernel/pci/echoaudio/indigoiox.c	2009-03-01 15:26:34.000000000 +0100
++++ indigoiox.c	2009-03-01 15:32:56.000000000 +0100
+@@ -1,3 +1,9 @@
++#include "adriver.h"
++
++#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
++#define pci_device(chip) pci_name(chip->pci)
++#endif
++
+ /*
+  *  ALSA driver for Echoaudio soundcards.
+  *  Copyright (C) 2009 Giuliano Pochini <pochini@shiny.it>
+@@ -107,3 +113,5 @@ static struct snd_pcm_hardware pcm_hardw
+ #include "echoaudio_dsp.c"
+ #include "echoaudio.c"
+ 
++
++EXPORT_NO_SYMBOLS;
--- alsa-driver-1.0.19__orig/pci/echoaudio/indigodjx.patch	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver-1.0.19/pci/echoaudio/indigodjx.patch	2009-03-15 17:14:39.000000000 +0100
@@ -0,0 +1,18 @@
+--- ../../alsa-kernel/pci/echoaudio/indigodjx.c	2009-03-01 15:26:27.000000000 +0100
++++ indigodjx.c	2009-03-01 19:02:55.000000000 +0100
+@@ -1,3 +1,9 @@
++#include "adriver.h"
++
++#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 0)
++#define pci_device(chip) pci_name(chip->pci)
++#endif
++
+ /*
+  *  ALSA driver for Echoaudio soundcards.
+  *  Copyright (C) 2009 Giuliano Pochini <pochini@shiny.it>
+@@ -105,3 +111,5 @@ static struct snd_pcm_hardware pcm_hardw
+ #include "indigo_express_dsp.c"
+ #include "echoaudio_dsp.c"
+ #include "echoaudio.c"
++
++EXPORT_NO_SYMBOLS;
--- alsa-driver-1.0.19__orig/pci/echoaudio/indigo_express_dsp.c	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver-1.0.19/pci/echoaudio/indigo_express_dsp.c	2009-03-15 17:21:56.000000000 +0100
@@ -0,0 +1 @@
+#include "../../alsa-kernel/pci/echoaudio/indigo_express_dsp.c"
--- alsa-driver-1.0.19__orig/pci/echoaudio/indigoiox_dsp.c	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver-1.0.19/pci/echoaudio/indigoiox_dsp.c	2009-03-15 17:19:36.000000000 +0100
@@ -0,0 +1 @@
+#include "../../alsa-kernel/pci/echoaudio/indigoiox_dsp.c"
--- alsa-driver-1.0.19__orig/pci/echoaudio/indigodjx_dsp.c	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver-1.0.19/pci/echoaudio/indigodjx_dsp.c	2009-03-15 17:19:18.000000000 +0100
@@ -0,0 +1 @@
+#include "../../alsa-kernel/pci/echoaudio/indigodjx_dsp.c"



--
Giuliano.
