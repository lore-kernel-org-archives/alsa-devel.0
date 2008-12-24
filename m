From: carmen <_@whats-your.name>
Subject: [patch] Indigo DJx
Date: Wed, 24 Dec 2008 04:11:29 -0500
Message-ID: <20081224091129.GA14883@x>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay3-v.mail.gandi.net (relay3-v.mail.gandi.net
	[217.70.178.77]) by alsa0.perex.cz (Postfix) with ESMTP id 5CF4F24359
	for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2008 10:12:32 +0100 (CET)
Received: from localhost (c-24-60-196-238.hsd1.ma.comcast.net [24.60.196.238])
	by relay3-v.mail.gandi.net (Postfix) with ESMTP id 3C1C2B9FF
	for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2008 10:12:31 +0100 (CET)
Content-Disposition: inline
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


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

the old Indigo DJ driver worked after a few tweaks...

tested w/ jack, cmus, mplayer

mapping/virtual-outs seem good..


this is a diff on alsa-kernel.git. copied the old firmware and amazed it works, although something seems wonky with the samplerate registers. going to email echo about an updated firmware .. no noise bursts or ear destruction tho!

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa.indigodjx-driver.patch"

diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 6e3a184..6d1f29f 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -400,6 +400,16 @@ config SND_INDIGODJ
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-indigodj
 
+config SND_INDIGODJX
+        tristate "(Echoaudio) Indigo DJx"
+        select FW_LOADER
+        select SND_PCM
+        help
+          Say 'Y' or 'M' to include support for Echoaudio Indigo DJx.
+
+          To compile this driver as a module, choose M here: the module
+          will be called snd-indigodjx
+
 config SND_EMU10K1
 	tristate "Emu10k1 (SB Live!, Audigy, E-mu APS)"
 	select FW_LOADER
diff --git a/sound/pci/echoaudio/Makefile b/sound/pci/echoaudio/Makefile
index 7b576ae..8433240 100644
--- a/sound/pci/echoaudio/Makefile
+++ b/sound/pci/echoaudio/Makefile
@@ -15,6 +15,7 @@ snd-echo3g-objs := echo3g.o
 snd-indigo-objs := indigo.o
 snd-indigoio-objs := indigoio.o
 snd-indigodj-objs := indigodj.o
+snd-indigodjx-objs := indigodjx.o
 
 obj-$(CONFIG_SND_DARLA20) += snd-darla20.o
 obj-$(CONFIG_SND_GINA20) += snd-gina20.o
@@ -28,3 +29,4 @@ obj-$(CONFIG_SND_ECHO3G) += snd-echo3g.o
 obj-$(CONFIG_SND_INDIGO) += snd-indigo.o
 obj-$(CONFIG_SND_INDIGOIO) += snd-indigoio.o
 obj-$(CONFIG_SND_INDIGODJ) += snd-indigodj.o
+obj-$(CONFIG_SND_INDIGODJX) += snd-indigodjx.o
diff --git a/sound/pci/echoaudio/indigodjx.c b/sound/pci/echoaudio/indigodjx.c
new file mode 100644
index 0000000..9eb43de
--- /dev/null
+++ b/sound/pci/echoaudio/indigodjx.c
@@ -0,0 +1,107 @@
+/*
+ *  ALSA driver for Echoaudio soundcards.
+ *  Copyright (C) 2003-2004 Giuliano Pochini <pochini@shiny.it>
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
+#define ECHOCARD_INDIGO_DJ
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
+#include "echoaudio_dsp.c"
+#include "echoaudio.c"
+
diff --git a/sound/pci/echoaudio/indigodjx_dsp.c b/sound/pci/echoaudio/indigodjx_dsp.c
new file mode 100644
index 0000000..babcd0a
--- /dev/null
+++ b/sound/pci/echoaudio/indigodjx_dsp.c
@@ -0,0 +1,170 @@
+/****************************************************************************
+
+   Copyright Echo Digital Audio Corporation (c) 1998 - 2004
+   All rights reserved
+   www.echoaudio.com
+
+   This file is part of Echo Digital Audio's generic driver library.
+
+   Echo Digital Audio's generic driver library is free software;
+   you can redistribute it and/or modify it under the terms of
+   the GNU General Public License as published by the Free Software
+   Foundation.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program; if not, write to the Free Software
+   Foundation, Inc., 59 Temple Place - Suite 330, Boston,
+   MA  02111-1307, USA.
+
+   *************************************************************************
+
+ Translation from C++ and adaptation for use in ALSA-Driver
+ were made by Giuliano Pochini <pochini@shiny.it>
+
+****************************************************************************/
+
+
+static int set_vmixer_gain(struct echoaudio *chip, u16 output, u16 pipe,
+			   int gain);
+static int update_vmixer_level(struct echoaudio *chip);
+
+
+static int init_hw(struct echoaudio *chip, u16 device_id, u16 subdevice_id)
+{
+	int err;
+
+	DE_INIT(("init_hw() - Indigo DJx\n"));
+	snd_assert((subdevice_id & 0xfff0) == INDIGO_DJ, return -ENODEV);
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
+	/* Default routing of the virtual channels: vchannels 0-3 and
+	vchannels 4-7 are routed to real channels 0-4 */
+	set_vmixer_gain(chip, 0, 0, 0);
+	set_vmixer_gain(chip, 1, 1, 0);
+	set_vmixer_gain(chip, 2, 2, 0);
+	set_vmixer_gain(chip, 3, 3, 0);
+	set_vmixer_gain(chip, 0, 4, 0);
+	set_vmixer_gain(chip, 1, 5, 0);
+	set_vmixer_gain(chip, 2, 6, 0);
+	set_vmixer_gain(chip, 3, 7, 0);
+	err = update_vmixer_level(chip);
+
+	DE_INIT(("init_hw done\n"));
+	return err;
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
+/* The IndigoDJ has no ASIC. Just do nothing */
+static int load_asic(struct echoaudio *chip)
+{
+	return 0;
+}
+
+
+
+static int set_sample_rate(struct echoaudio *chip, u32 rate)
+{
+	u32 control_reg;
+
+	switch (rate) {
+	case 96000:
+		control_reg = MIA_96000;
+		break;
+	case 88200:
+		control_reg = MIA_88200;
+		break;
+	case 48000:
+		control_reg = MIA_48000;
+		break;
+	case 44100:
+		control_reg = MIA_44100;
+		break;
+	case 32000:
+		control_reg = MIA_32000;
+		break;
+	default:
+		DE_ACT(("set_sample_rate: %d invalid!\n", rate));
+		return -EINVAL;
+	}
+
+	/* Set the control register if it has changed */
+	if (control_reg != le32_to_cpu(chip->comm_page->control_register)) {
+		if (wait_handshake(chip))
+			return -EIO;
+
+		chip->comm_page->sample_rate = cpu_to_le32(rate);	/* ignored by the DSP */
+		chip->comm_page->control_register = cpu_to_le32(control_reg);
+		chip->sample_rate = rate;
+
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
+	snd_assert(pipe < num_pipes_out(chip) &&
+		   output < num_busses_out(chip), return -EINVAL);
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

--9amGYk9869ThD9tj
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--9amGYk9869ThD9tj--
