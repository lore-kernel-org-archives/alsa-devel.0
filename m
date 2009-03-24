From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH v2] alsa: lx6464es - driver for the digigram
 lx6464es interface
Date: Tue, 24 Mar 2009 12:24:35 +0100
Message-ID: <20090324122435.2630842f@thinkpad>
References: <s5hvdq05xjb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9074870689998400308=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 353DB103837
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2009 12:25:04 +0100 (CET)
In-Reply-To: <s5hvdq05xjb.wl%tiwai@suse.de>
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

--===============9074870689998400308==
Content-Type: multipart/signed; boundary="Sig_/kKrIrSnRrSCIMpQiGFNabM1";
 protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_/kKrIrSnRrSCIMpQiGFNabM1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

prototype of a driver for the digigram lx6464es 64 channel ethersound
interface.

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 include/linux/pci_ids.h       |    5 +
 sound/pci/Kconfig             |   10 +
 sound/pci/Makefile            |    1 +
 sound/pci/lx6464es/Makefile   |    2 +
 sound/pci/lx6464es/lx6464es.c | 1152 ++++++++++++++++++++++++++++++++
 sound/pci/lx6464es/lx6464es.h |  114 ++++
 sound/pci/lx6464es/lx_core.c  | 1442 +++++++++++++++++++++++++++++++++++++=
++++
 sound/pci/lx6464es/lx_core.h  |  242 +++++++
 sound/pci/lx6464es/lx_defs.h  |  376 +++++++++++
 9 files changed, 3344 insertions(+), 0 deletions(-)
 create mode 100644 sound/pci/lx6464es/Makefile
 create mode 100644 sound/pci/lx6464es/lx6464es.c
 create mode 100644 sound/pci/lx6464es/lx6464es.h
 create mode 100644 sound/pci/lx6464es/lx_core.c
 create mode 100644 sound/pci/lx6464es/lx_core.h
 create mode 100644 sound/pci/lx6464es/lx_defs.h

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 02c18b9..0a8c36d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -976,6 +976,7 @@
 #define PCI_DEVICE_ID_PLX_PCI200SYN	0x3196
 #define PCI_DEVICE_ID_PLX_9030          0x9030
 #define PCI_DEVICE_ID_PLX_9050		0x9050
+#define PCI_DEVICE_ID_PLX_9056		0x9056
 #define PCI_DEVICE_ID_PLX_9080		0x9080
 #define PCI_DEVICE_ID_PLX_GTEK_SERIAL2	0xa001
=20
@@ -1813,6 +1814,10 @@
 #define PCI_SUBDEVICE_ID_HYPERCOPE_METRO	0x0107
 #define PCI_SUBDEVICE_ID_HYPERCOPE_CHAMP2	0x0108
=20
+#define PCI_VENDOR_ID_DIGIGRAM		0x1369
+#define PCI_SUBDEVICE_ID_DIGIGRAM_LX6464ES_SERIAL_SUBSYSTEM	0xc001
+#define PCI_SUBDEVICE_ID_DIGIGRAM_LX6464ES_CAE_SERIAL_SUBSYSTEM	0xc002
+
 #define PCI_VENDOR_ID_KAWASAKI		0x136b
 #define PCI_DEVICE_ID_MCHIP_KL5A72002	0xff01
=20
diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index ca25e61..8002ae4 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -622,6 +622,16 @@ config SND_KORG1212
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-korg1212.
=20
+config SND_LX6464ES
+	tristate "Digigram LX6464ES"
+	select SND_PCM
+	help
+	  Say Y here to include support for Digigram LX6464ES boards.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-lx6464es.
+
+
 config SND_MAESTRO3
 	tristate "ESS Allegro/Maestro3"
 	select SND_AC97_CODEC
diff --git a/sound/pci/Makefile b/sound/pci/Makefile
index 65b25d2..7d83e08 100644
--- a/sound/pci/Makefile
+++ b/sound/pci/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_SND) +=3D \
 	ca0106/ \
 	cs46xx/ \
 	cs5535audio/ \
+	lx6464es/ \
 	echoaudio/ \
 	emu10k1/ \
 	hda/ \
diff --git a/sound/pci/lx6464es/Makefile b/sound/pci/lx6464es/Makefile
new file mode 100644
index 0000000..eb04a6c
--- /dev/null
+++ b/sound/pci/lx6464es/Makefile
@@ -0,0 +1,2 @@
+snd-lx6464es-objs :=3D lx6464es.o lx_core.o
+obj-$(CONFIG_SND_LX6464ES) +=3D snd-lx6464es.o
diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
new file mode 100644
index 0000000..7bc8b8c
--- /dev/null
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -0,0 +1,1152 @@
+/* -*- linux-c -*- *
+ *
+ * ALSA driver for the digigram lx6464es interface
+ *
+ * Copyright (c) 2008, 2009 Tim Blechmann <tim@klingt.org>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; see the file COPYING.  If not, write to
+ * the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 02111-1307, USA.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+
+#include <sound/initval.h>
+#include <sound/control.h>
+#include <sound/info.h>
+
+#include "lx6464es.h"
+
+MODULE_AUTHOR("Tim Blechmann");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("digigram lx6464es");
+MODULE_SUPPORTED_DEVICE("{digigram lx6464es{}}");
+
+
+static int index[SNDRV_CARDS] =3D SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS] =3D SNDRV_DEFAULT_STR;
+static int enable[SNDRV_CARDS] =3D SNDRV_DEFAULT_ENABLE_PNP;
+
+static const char card_name[] =3D "LX6464ES";
+
+
+#define PCI_DEVICE_ID_PLX_LX6464ES		PCI_DEVICE_ID_PLX_9056
+
+static struct pci_device_id snd_lx6464es_ids[] =3D {
+	{ PCI_DEVICE(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_LX6464ES),
+	  .subvendor =3D PCI_VENDOR_ID_DIGIGRAM,
+	  .subdevice =3D PCI_SUBDEVICE_ID_DIGIGRAM_LX6464ES_SERIAL_SUBSYSTEM
+	},			/* LX6464ES */
+	{ PCI_DEVICE(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_LX6464ES),
+	  .subvendor =3D PCI_VENDOR_ID_DIGIGRAM,
+	  .subdevice =3D PCI_SUBDEVICE_ID_DIGIGRAM_LX6464ES_CAE_SERIAL_SUBSYSTEM
+	},			/* LX6464ES-CAE */
+	{ 0, },
+};
+
+MODULE_DEVICE_TABLE(pci, snd_lx6464es_ids);
+
+
+
+/* PGO pour USERo dans le registre pci_0x06/loc_0xEC */
+#define CHIPSC_RESET_XILINX (1L<<16)
+
+
+/* alsa callbacks */
+static struct snd_pcm_hardware lx_caps =3D {
+	.info             =3D (SNDRV_PCM_INFO_MMAP |
+			     SNDRV_PCM_INFO_INTERLEAVED |
+			     SNDRV_PCM_INFO_MMAP_VALID |
+			     SNDRV_PCM_INFO_SYNC_START),
+	.formats	  =3D (SNDRV_PCM_FMTBIT_S16_LE |
+			     SNDRV_PCM_FMTBIT_S16_BE |
+			     SNDRV_PCM_FMTBIT_S24_3LE |
+			     SNDRV_PCM_FMTBIT_S24_3BE),
+	.rates            =3D (SNDRV_PCM_RATE_CONTINUOUS |
+			     SNDRV_PCM_RATE_8000_192000),
+	.rate_min         =3D 8000,
+	.rate_max         =3D 192000,
+	.channels_min     =3D 2,
+	.channels_max     =3D 64,
+	.buffer_bytes_max =3D 64*2*3*MICROBLAZE_IBL_MAX*MAX_STREAM_BUFFER,
+	.period_bytes_min =3D (2*2*MICROBLAZE_IBL_MIN*2),
+	.period_bytes_max =3D (4*64*MICROBLAZE_IBL_MAX*MAX_STREAM_BUFFER),
+	.periods_min      =3D 2,
+	.periods_max      =3D MAX_STREAM_BUFFER,
+};
+
+static int lx_set_granularity(struct lx6464es *chip, u32 gran);
+
+
+static int lx_hardware_open(struct lx6464es *chip,
+			    struct snd_pcm_substream *substream)
+{
+	int err =3D 0;
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	int channels =3D runtime->channels;
+	int is_capture =3D (substream->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE);
+
+	snd_pcm_uframes_t period_size =3D runtime->period_size;
+
+	snd_printd(LXP "allocating pipe for %d channels\n", channels);
+	err =3D lx_pipe_allocate(chip, 0, is_capture, channels);
+	if (err < 0) {
+		snd_printk(KERN_ERR LXP "allocating pipe failed\n");
+		return err;
+	}
+
+	err =3D lx_set_granularity(chip, period_size);
+	if (err < 0) {
+		snd_printk(KERN_ERR LXP "setting granularity to %ld failed\n",
+			   period_size);
+		return err;
+	}
+
+	return 0;
+}
+
+static int lx_hardware_start(struct lx6464es *chip,
+			     struct snd_pcm_substream *substream)
+{
+	int err =3D 0;
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	int is_capture =3D (substream->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE);
+
+	snd_printd(LXP "setting stream format\n");
+	err =3D lx_stream_set_format(chip, runtime, 0, is_capture);
+	if (err < 0) {
+		snd_printk(KERN_ERR LXP "setting stream format failed\n");
+		return err;
+	}
+
+	snd_printd(LXP "starting pipe\n");
+	err =3D lx_pipe_start(chip, 0, is_capture);
+	if (err < 0) {
+		snd_printk(KERN_ERR LXP "starting pipe failed\n");
+		return err;
+	}
+
+	snd_printd(LXP "waiting for pipe to start\n");
+	err =3D lx_pipe_wait_for_start(chip, 0, is_capture);
+	if (err < 0) {
+		snd_printk(KERN_ERR LXP "waiting for pipe failed\n");
+		return err;
+	}
+
+	return err;
+}
+
+
+static int lx_hardware_stop(struct lx6464es *chip,
+			    struct snd_pcm_substream *substream)
+{
+	int err =3D 0;
+	int is_capture =3D (substream->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE);
+
+	snd_printd(LXP "pausing pipe\n");
+	err =3D lx_pipe_pause(chip, 0, is_capture);
+	if (err < 0) {
+		snd_printk(KERN_ERR LXP "pausing pipe failed\n");
+		return err;
+	}
+
+	snd_printd(LXP "waiting for pipe to become idle\n");
+	err =3D lx_pipe_wait_for_idle(chip, 0, is_capture);
+	if (err < 0) {
+		snd_printk(KERN_ERR LXP "waiting for pipe failed\n");
+		return err;
+	}
+
+	snd_printd(LXP "stopping pipe\n");
+	err =3D lx_pipe_stop(chip, 0, is_capture);
+	if (err < 0) {
+		snd_printk(LXP "stopping pipe failed\n");
+		return err;
+	}
+
+	return err;
+}
+
+
+static int lx_hardware_close(struct lx6464es *chip,
+			     struct snd_pcm_substream *substream)
+{
+	int err =3D 0;
+	int is_capture =3D (substream->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE);
+
+	snd_printd(LXP "releasing pipe\n");
+	err =3D lx_pipe_release(chip, 0, is_capture);
+	if (err < 0) {
+		snd_printk(LXP "releasing pipe failed\n");
+		return err;
+	}
+
+	return err;
+}
+
+
+static int lx_pcm_open(struct snd_pcm_substream *substream)
+{
+	struct lx6464es *chip =3D snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	int err =3D 0;
+	int board_rate;
+
+	snd_printdd("->lx_pcm_open\n");
+	mutex_lock(&chip->setup_mutex);
+
+	/* copy the struct snd_pcm_hardware struct */
+	runtime->hw =3D lx_caps;
+
+#if 0
+	/* buffer-size should better be multiple of period-size */
+	err =3D snd_pcm_hw_constraint_integer(runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (err < 0) {
+		snd_printk(KERN_WARNING LXP "could not constrain periods\n");
+		goto exit;
+	}
+#endif
+
+	/* the clock rate cannot be changed */
+	board_rate =3D chip->board_sample_rate;
+	err =3D snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_RATE,
+					   board_rate, board_rate);
+
+	if (err < 0) {
+		snd_printk(KERN_WARNING LXP "could not constrain periods\n");
+		goto exit;
+	}
+
+	/* constrain period size */
+	err =3D snd_pcm_hw_constraint_minmax(runtime,
+					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					   MICROBLAZE_IBL_MIN,
+					   MICROBLAZE_IBL_MAX);
+	if (err < 0) {
+		snd_printk(KERN_WARNING LXP
+			   "could not constrain period size\n");
+		goto exit;
+	}
+
+	snd_pcm_hw_constraint_step(runtime, 0,
+				   SNDRV_PCM_HW_PARAM_BUFFER_SIZE, 32);
+
+	snd_pcm_set_sync(substream);
+	err =3D 0;
+
+exit:
+	runtime->private_data =3D chip;
+
+	mutex_unlock(&chip->setup_mutex);
+	snd_printdd("<-lx_pcm_open, %d\n", err);
+	return err;
+}
+
+static int lx_pcm_close(struct snd_pcm_substream *substream)
+{
+	int err =3D 0;
+	snd_printdd("->lx_pcm_close\n");
+	return err;
+}
+
+static snd_pcm_uframes_t lx_pcm_stream_pointer(struct snd_pcm_substream
+					       *substream)
+{
+	struct lx6464es *chip =3D snd_pcm_substream_chip(substream);
+	snd_pcm_uframes_t pos;
+	unsigned long flags;
+	int is_capture =3D (substream->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE);
+
+	struct lx_stream *lx_stream =3D is_capture ? &chip->capture_stream :
+		&chip->playback_stream;
+
+	snd_printdd("->lx_pcm_stream_pointer\n");
+
+	spin_lock_irqsave(&chip->lock, flags);
+	pos =3D lx_stream->frame_pos * substream->runtime->period_size;
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	snd_printdd(LXP "stream_pointer at %ld\n", pos);
+	return pos;
+}
+
+static int lx_pcm_prepare(struct snd_pcm_substream *substream)
+{
+	struct lx6464es *chip =3D snd_pcm_substream_chip(substream);
+	int err =3D 0;
+	const int is_capture =3D (substream->stream =3D=3D SNDRV_PCM_STREAM_CAPTU=
RE);
+
+	snd_printdd("->lx_pcm_prepare\n");
+
+	mutex_lock(&chip->setup_mutex);
+
+	if (chip->hardware_running[is_capture]) {
+		err =3D lx_hardware_stop(chip, substream);
+		if (err < 0) {
+			snd_printk(KERN_ERR LXP "failed to stop hardware. "
+				   "Error code %d\n", err);
+			goto exit;
+		}
+
+		err =3D lx_hardware_close(chip, substream);
+		if (err < 0) {
+			snd_printk(KERN_ERR LXP "failed to close hardware. "
+				   "Error code %d\n", err);
+			goto exit;
+		}
+	}
+
+	snd_printd(LXP "opening hardware\n");
+	err =3D lx_hardware_open(chip, substream);
+	if (err < 0) {
+		snd_printk(KERN_ERR LXP "failed to open hardware. "
+			   "Error code %d\n", err);
+		goto exit;
+	}
+
+	err =3D lx_hardware_start(chip, substream);
+	if (err < 0) {
+		snd_printk(KERN_ERR LXP "failed to start hardware. "
+			   "Error code %d\n", err);
+		goto exit;
+	}
+
+	chip->hardware_running[is_capture] =3D 1;
+
+	if (chip->board_sample_rate !=3D substream->runtime->rate) {
+		if (!err)
+			chip->board_sample_rate =3D substream->runtime->rate;
+	}
+
+exit:
+	mutex_unlock(&chip->setup_mutex);
+	return err;
+}
+
+static int lx_pcm_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *hw_params, int is_capture)
+{
+	struct lx6464es *chip =3D snd_pcm_substream_chip(substream);
+	int err =3D 0;
+
+	snd_printdd("->lx_pcm_hw_params\n");
+
+	mutex_lock(&chip->setup_mutex);
+
+	/* set dma buffer */
+	err =3D snd_pcm_lib_malloc_pages(substream,
+				       params_buffer_bytes(hw_params));
+
+	if (is_capture)
+		chip->capture_stream.stream =3D substream;
+	else
+		chip->playback_stream.stream =3D substream;
+
+	mutex_unlock(&chip->setup_mutex);
+	return err;
+}
+
+static int lx_pcm_hw_params_playback(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *hw_params)
+{
+	return lx_pcm_hw_params(substream, hw_params, 0);
+}
+
+static int lx_pcm_hw_params_capture(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *hw_params)
+{
+	return lx_pcm_hw_params(substream, hw_params, 1);
+}
+
+static int lx_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+	struct lx6464es *chip =3D snd_pcm_substream_chip(substream);
+	int err =3D 0;
+	int is_capture =3D (substream->stream =3D=3D SNDRV_PCM_STREAM_CAPTURE);
+
+	snd_printdd("->lx_pcm_hw_free\n");
+	mutex_lock(&chip->setup_mutex);
+
+	if (chip->hardware_running[is_capture]) {
+		err =3D lx_hardware_stop(chip, substream);
+		if (err < 0) {
+			snd_printk(KERN_ERR LXP "failed to stop hardware. "
+				   "Error code %d\n", err);
+			goto exit;
+		}
+
+		err =3D lx_hardware_close(chip, substream);
+		if (err < 0) {
+			snd_printk(KERN_ERR LXP "failed to close hardware. "
+				   "Error code %d\n", err);
+			goto exit;
+		}
+
+		chip->hardware_running[is_capture] =3D 0;
+	}
+
+	err =3D snd_pcm_lib_free_pages(substream);
+
+	if (is_capture)
+		chip->capture_stream.stream =3D 0;
+	else
+		chip->playback_stream.stream =3D 0;
+
+exit:
+	mutex_unlock(&chip->setup_mutex);
+	return err;
+}
+
+static void lx_trigger_start(struct lx6464es *chip, struct lx_stream *lx_s=
tream)
+{
+	struct snd_pcm_substream *substream =3D lx_stream->stream;
+	const int is_capture =3D lx_stream->is_capture;
+
+	int err;
+
+	const u32 channels =3D substream->runtime->channels;
+	const u32 bytes_per_frame =3D channels * 3;
+	const u32 period_size =3D substream->runtime->period_size;
+	const u32 periods =3D substream->runtime->periods;
+	const u32 period_bytes =3D period_size * bytes_per_frame;
+
+	dma_addr_t buf =3D substream->dma_buffer.addr;
+	int i;
+
+	u32 needed, freed;
+	u32 size_array[5];
+
+	for (i =3D 0; i !=3D periods; ++i) {
+		u32 buffer_index =3D 0;
+
+		err =3D lx_buffer_ask(chip, 0, is_capture, &needed, &freed,
+				    size_array);
+		snd_printdd(LXP "starting: needed %d, freed %d\n",
+			    needed, freed);
+
+		err =3D lx_buffer_give(chip, 0, is_capture, period_bytes,
+				     lower_32_bits(buf), upper_32_bits(buf),
+				     &buffer_index);
+
+		snd_printdd(LXP "starting: buffer index %x on %p (%d bytes)\n",
+			    buffer_index, (void *)buf, period_bytes);
+		buf +=3D period_bytes;
+	}
+
+	err =3D lx_buffer_ask(chip, 0, is_capture, &needed, &freed, size_array);
+	snd_printdd(LXP "starting: needed %d, freed %d\n", needed, freed);
+
+	snd_printd(LXP "starting: starting stream\n");
+	err =3D lx_stream_start(chip, 0, is_capture);
+	if (err < 0)
+		snd_printk(KERN_ERR LXP "couldn't start stream\n");
+	else
+		lx_stream->status =3D LX_STREAM_STATUS_RUNNING;
+
+	lx_stream->frame_pos =3D 0;
+}
+
+static void lx_trigger_stop(struct lx6464es *chip, struct lx_stream *lx_st=
ream)
+{
+	const int is_capture =3D lx_stream->is_capture;
+	int err;
+
+	snd_printd(LXP "stopping: stopping stream\n");
+	err =3D lx_stream_stop(chip, 0, is_capture);
+	if (err < 0)
+		snd_printk(KERN_ERR LXP "couldn't stop stream\n");
+	else
+		lx_stream->status =3D LX_STREAM_STATUS_FREE;
+
+}
+
+static void lx_trigger_tasklet_dispatch_stream(struct lx6464es *chip,
+					       struct lx_stream *lx_stream)
+{
+	switch (lx_stream->status) {
+	case LX_STREAM_STATUS_SCHEDULE_RUN:
+		lx_trigger_start(chip, lx_stream);
+		break;
+
+	case LX_STREAM_STATUS_SCHEDULE_STOP:
+		lx_trigger_stop(chip, lx_stream);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static void lx_trigger_tasklet(unsigned long data)
+{
+	struct lx6464es *chip =3D (struct lx6464es *)data;
+	unsigned long flags;
+
+	snd_printdd("->lx_trigger_tasklet\n");
+
+	spin_lock_irqsave(&chip->lock, flags);
+	lx_trigger_tasklet_dispatch_stream(chip, &chip->capture_stream);
+	lx_trigger_tasklet_dispatch_stream(chip, &chip->playback_stream);
+	spin_unlock_irqrestore(&chip->lock, flags);
+}
+
+static int lx_pcm_trigger_dispatch(struct lx6464es *chip,
+				   struct lx_stream *lx_stream, int cmd)
+{
+	int err =3D 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		lx_stream->status =3D LX_STREAM_STATUS_SCHEDULE_RUN;
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+		lx_stream->status =3D LX_STREAM_STATUS_SCHEDULE_STOP;
+		break;
+
+	default:
+		err =3D -EINVAL;
+		goto exit;
+	}
+	tasklet_schedule(&chip->trigger_tasklet);
+
+exit:
+	return err;
+}
+
+
+static int lx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct lx6464es *chip =3D snd_pcm_substream_chip(substream);
+	const int is_capture =3D (substream->stream =3D=3D SNDRV_PCM_STREAM_CAPTU=
RE);
+	struct lx_stream *stream =3D is_capture ? &chip->capture_stream :
+		&chip->playback_stream;
+
+	snd_printdd("->lx_pcm_trigger\n");
+
+	return lx_pcm_trigger_dispatch(chip, stream, cmd);
+}
+
+static int snd_lx6464es_free(struct lx6464es *chip)
+{
+	snd_printdd("->snd_lx6464es_free\n");
+
+	lx_irq_disable(chip);
+
+	if (chip->irq >=3D 0)
+		free_irq(chip->irq, chip);
+
+	iounmap(chip->port_dsp_bar);
+	ioport_unmap(chip->port_plx_remapped);
+
+	pci_release_regions(chip->pci);
+	pci_disable_device(chip->pci);
+
+	kfree(chip);
+
+	return 0;
+}
+
+static int snd_lx6464es_dev_free(struct snd_device *device)
+{
+	return snd_lx6464es_free(device->device_data);
+}
+
+/* reset the dsp during initialization */
+static int __devinit lx_init_xilinx_reset(struct lx6464es *chip)
+{
+	int i;
+	u32 plx_reg =3D lx_plx_reg_read(chip, ePLX_CHIPSC);
+
+	snd_printdd("->lx_init_xilinx_reset\n");
+
+	/* activate reset of xilinx */
+	plx_reg &=3D ~CHIPSC_RESET_XILINX;
+
+	lx_plx_reg_write(chip, ePLX_CHIPSC, plx_reg);
+	msleep(1);
+
+	lx_plx_reg_write(chip, ePLX_MBOX3, 0);
+	msleep(1);
+
+	plx_reg |=3D CHIPSC_RESET_XILINX;
+	lx_plx_reg_write(chip, ePLX_CHIPSC, plx_reg);
+
+	/* deactivate reset of xilinx */
+	for (i =3D 0; i !=3D 100; ++i) {
+		u32 reg_mbox3;
+		msleep(10);
+		reg_mbox3 =3D lx_plx_reg_read(chip, ePLX_MBOX3);
+		if (reg_mbox3) {
+			snd_printd(LXP "xilinx reset done\n");
+			snd_printdd(LXP "xilinx took %d loops\n", i);
+			break;
+		}
+	}
+
+	/* todo: add some error handling? */
+
+	/* clear mr */
+	lx_dsp_reg_write(chip, eReg_CSM, 0);
+
+	/* le xilinx ES peut ne pas etre encore pret, on attend. */
+	msleep(600);
+
+	return 0;
+}
+
+static int __devinit lx_init_xilinx_test(struct lx6464es *chip)
+{
+	u32 reg;
+
+	snd_printdd("->lx_init_xilinx_test\n");
+
+	/* TEST if we have access to Xilinx/MicroBlaze */
+	lx_dsp_reg_write(chip, eReg_CSM, 0);
+
+	reg =3D lx_dsp_reg_read(chip, eReg_CSM);
+
+	if (reg) {
+		snd_printk(KERN_ERR LXP "Problem: Reg_CSM %x.\n", reg);
+
+		/* PCI9056_SPACE0_REMAP */
+		lx_plx_reg_write(chip, ePLX_PCICR, 1);
+
+		reg =3D lx_dsp_reg_read(chip, eReg_CSM);
+		if (reg) {
+			snd_printk(KERN_ERR LXP "Error: Reg_CSM %x.\n", reg);
+			return -EAGAIN; /* seems to be appropriate */
+		}
+	}
+
+	snd_printd(LXP "Xilinx/MicroBlaze access test successful\n");
+
+	return 0;
+}
+
+/* initialize ethersound */
+static int __devinit lx_init_ethersound_config(struct lx6464es *chip)
+{
+	int i;
+	u32 orig_conf_es =3D lx_dsp_reg_read(chip, eReg_CONFES);
+
+	u32 default_conf_es =3D (64 << IOCR_OUTPUTS_OFFSET) |
+		(64 << IOCR_INPUTS_OFFSET) |
+		(FREQ_RATIO_SINGLE_MODE << FREQ_RATIO_OFFSET);
+
+	u32 conf_es =3D (orig_conf_es & CONFES_READ_PART_MASK)
+		| (default_conf_es & CONFES_WRITE_PART_MASK);
+
+	snd_printdd("->lx_init_ethersound\n");
+
+	chip->freq_ratio =3D FREQ_RATIO_SINGLE_MODE;
+
+	/*
+	 * write it to the card !
+	 * this actually kicks the ES xilinx, the first time since poweron.
+	 * the MAC address in the Reg_ADMACESMSB Reg_ADMACESLSB registers
+	 * is not ready before this is done, and the bit 2 in Reg_CSES is set.
+	 * */
+	lx_dsp_reg_write(chip, eReg_CONFES, conf_es);
+
+	for (i =3D 0; i !=3D 1000; ++i) {
+		if (lx_dsp_reg_read(chip, eReg_CSES) & 4) {
+			snd_printd(LXP "ethersound initialized after %dms\n",
+				   i);
+			goto ethersound_initialized;
+		}
+		msleep(1);
+	}
+	snd_printk(KERN_WARNING LXP
+		   "ethersound could not be initialized after %dms\n", i);
+	return -ETIMEDOUT;
+
+ ethersound_initialized:
+	snd_printd(LXP "ethersound initialized\n");
+	return 0;
+}
+
+static int __devinit lx_init_get_version_features(struct lx6464es *chip)
+{
+	u32 dsp_version;
+
+	int err;
+
+	snd_printdd("->lx_init_get_version_features\n");
+
+	err =3D lx_dsp_get_version(chip, &dsp_version);
+
+	if (err =3D=3D 0) {
+		u32 freq;
+
+		snd_printk(LXP "DSP version: V%02d.%02d #%d\n",
+			   (dsp_version>>16) & 0xff, (dsp_version>>8) & 0xff,
+			   dsp_version & 0xff);
+
+		/* later: what firmware version do we expect? */
+
+		/* retrieve Play/Rec features */
+		/* done here because we may have to handle alternate
+		 * DSP files. */
+		/* later */
+
+		/* init the EtherSound sample rate */
+		err =3D lx_dsp_get_clock_frequency(chip, &freq);
+		if (err =3D=3D 0)
+			chip->board_sample_rate =3D freq;
+		snd_printd(LXP "actual clock frequency %d\n", freq);
+	} else {
+		snd_printk(KERN_ERR LXP "DSP corrupted \n");
+		err =3D -EAGAIN;
+	}
+
+	return err;
+}
+
+static int lx_set_granularity(struct lx6464es *chip, u32 gran)
+{
+	int err =3D 0;
+	u32 snapped_gran =3D MICROBLAZE_IBL_MIN;
+
+	snd_printdd("->lx_set_granularity\n");
+
+	/* blocksize is a power of 2 */
+	while ((snapped_gran < gran) &&
+	       (snapped_gran < MICROBLAZE_IBL_MAX)) {
+		snapped_gran *=3D 2;
+	}
+
+	if (snapped_gran =3D=3D chip->pcm_granularity)
+		return 0;
+
+	err =3D lx_dsp_set_granularity(chip, snapped_gran);
+	if (err < 0) {
+		snd_printk(KERN_WARNING LXP "could not set granularity\n");
+		err =3D -EAGAIN;
+	}
+
+	if (snapped_gran !=3D gran)
+		snd_printk(LXP "snapped blocksize to %d\n", snapped_gran);
+
+	snd_printd(LXP "set blocksize on board %d\n", snapped_gran);
+	chip->pcm_granularity =3D snapped_gran;
+
+	return err;
+}
+
+/* initialize and test the xilinx dsp chip */
+static int __devinit lx_init_dsp(struct lx6464es *chip)
+{
+	int err;
+	u8 mac_address[6];
+	int i;
+
+	snd_printdd("->lx_init_dsp\n");
+
+	snd_printd(LXP "initialize board\n");
+	err =3D lx_init_xilinx_reset(chip);
+	if (err)
+		return err;
+
+	snd_printd(LXP "testing board\n");
+	err =3D lx_init_xilinx_test(chip);
+	if (err)
+		return err;
+
+	snd_printd(LXP "initialize ethersound configuration\n");
+	err =3D lx_init_ethersound_config(chip);
+	if (err)
+		return err;
+
+	lx_irq_enable(chip);
+
+	/** \todo the mac address should be ready by not, but it isn't,
+	 *  so we wait for it */
+	for (i =3D 0; i !=3D 1000; ++i) {
+		err =3D lx_dsp_get_mac(chip, mac_address);
+		if (err)
+			return err;
+		if (mac_address[0] || mac_address[1] || mac_address[2] ||
+		    mac_address[3] || mac_address[4] || mac_address[5])
+			goto mac_ready;
+		msleep(1);
+	}
+	return -ETIMEDOUT;
+
+mac_ready:
+	snd_printd(LXP "mac address ready read after: %dms\n", i);
+	snd_printk(LXP "mac address: %02X.%02X.%02X.%02X.%02X.%02X\n",
+		   mac_address[0], mac_address[1], mac_address[2],
+		   mac_address[3], mac_address[4], mac_address[5]);
+
+	err =3D lx_init_get_version_features(chip);
+	if (err)
+		return err;
+
+	lx_set_granularity(chip, MICROBLAZE_IBL_DEFAULT);
+
+	chip->playback_mute =3D 0;
+
+	return err;
+}
+
+static struct snd_pcm_ops lx_ops_playback =3D {
+	.open      =3D lx_pcm_open,
+	.close     =3D lx_pcm_close,
+	.ioctl     =3D snd_pcm_lib_ioctl,
+	.prepare   =3D lx_pcm_prepare,
+	.hw_params =3D lx_pcm_hw_params_playback,
+	.hw_free   =3D lx_pcm_hw_free,
+	.trigger   =3D lx_pcm_trigger,
+	.pointer   =3D lx_pcm_stream_pointer,
+};
+
+static struct snd_pcm_ops lx_ops_capture =3D {
+	.open      =3D lx_pcm_open,
+	.close     =3D lx_pcm_close,
+	.ioctl     =3D snd_pcm_lib_ioctl,
+	.prepare   =3D lx_pcm_prepare,
+	.hw_params =3D lx_pcm_hw_params_capture,
+	.hw_free   =3D lx_pcm_hw_free,
+	.trigger   =3D lx_pcm_trigger,
+	.pointer   =3D lx_pcm_stream_pointer,
+};
+
+static int __devinit lx_pcm_create(struct lx6464es *chip)
+{
+	int err;
+	struct snd_pcm *pcm;
+
+	u32 size =3D 64 *		     /* channels */
+		3 *		     /* 24 bit samples */
+		MAX_STREAM_BUFFER *  /* periods */
+		MICROBLAZE_IBL_MAX * /* frames per period */
+		2;		     /* duplex */
+
+	size =3D PAGE_ALIGN(size);
+
+	/* hardcoded device name & channel count */
+	err =3D snd_pcm_new(chip->card, (char *)card_name, 0,
+			  1, 1, &pcm);
+
+	pcm->private_data =3D chip;
+
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &lx_ops_playback);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &lx_ops_capture);
+
+	pcm->info_flags =3D 0;
+	strcpy(pcm->name, card_name);
+
+	err =3D snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+						    snd_dma_pci_data(chip->pci),
+						    size, size);
+	if (err < 0)
+		return err;
+
+	chip->pcm =3D pcm;
+	chip->capture_stream.is_capture =3D 1;
+
+	return 0;
+}
+
+static int lx_control_playback_info(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count =3D 1;
+	uinfo->value.integer.min =3D 0;
+	uinfo->value.integer.max =3D 1;
+	return 0;
+}
+
+static int lx_control_playback_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct lx6464es *chip =3D snd_kcontrol_chip(kcontrol);
+	ucontrol->value.integer.value[0] =3D chip->playback_mute;
+	return 0;
+}
+
+static int lx_control_playback_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct lx6464es *chip =3D snd_kcontrol_chip(kcontrol);
+	int changed =3D 0;
+	int current_value =3D chip->playback_mute;
+
+	if (current_value !=3D ucontrol->value.integer.value[0]) {
+		lx_level_unmute(chip, 0, !current_value);
+		chip->playback_mute =3D !current_value;
+		changed =3D 1;
+	}
+	return changed;
+}
+
+static struct snd_kcontrol_new lx_control_playback_switch __devinitdata =
=3D {
+	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =3D "PCM Playback Switch",
+	.index =3D 0,
+	.access =3D SNDRV_CTL_ELEM_ACCESS_READWRITE,
+	.private_value =3D 0,
+	.info =3D lx_control_playback_info,
+	.get =3D lx_control_playback_get,
+	.put =3D lx_control_playback_put
+};
+
+
+
+static void lx_proc_levels_read(struct snd_info_entry *entry,
+				struct snd_info_buffer *buffer)
+{
+	u32 levels[64];
+	int err;
+	int i, j;
+	struct lx6464es *chip =3D entry->private_data;
+
+	snd_iprintf(buffer, "capture levels:\n");
+	err =3D lx_level_peaks(chip, 1, 64, levels);
+	if (err < 0)
+		return;
+
+	for (i =3D 0; i !=3D 8; ++i) {
+		for (j =3D 0; j !=3D 8; ++j)
+			snd_iprintf(buffer, "%08x ", levels[i*8+j]);
+		snd_iprintf(buffer, "\n");
+	}
+
+	snd_iprintf(buffer, "\nplayback levels:\n");
+
+	err =3D lx_level_peaks(chip, 0, 64, levels);
+	if (err < 0)
+		return;
+
+	for (i =3D 0; i !=3D 8; ++i) {
+		for (j =3D 0; j !=3D 8; ++j)
+			snd_iprintf(buffer, "%08x ", levels[i*8+j]);
+		snd_iprintf(buffer, "\n");
+	}
+
+	snd_iprintf(buffer, "\n");
+}
+
+static int __devinit lx_proc_create(struct snd_card *card, struct lx6464es=
 *chip)
+{
+	struct snd_info_entry *entry;
+	int err =3D snd_card_proc_new(card, "levels", &entry);
+	if (err < 0)
+		return err;
+
+	snd_info_set_text_ops(entry, chip, lx_proc_levels_read);
+	return 0;
+}
+
+
+static int __devinit snd_lx6464es_create(struct snd_card *card,
+					 struct pci_dev *pci,
+					 struct lx6464es **rchip)
+{
+	struct lx6464es *chip;
+	int err;
+
+	static struct snd_device_ops ops =3D {
+		.dev_free =3D snd_lx6464es_dev_free,
+	};
+
+	snd_printdd("->snd_lx6464es_create\n");
+
+	*rchip =3D NULL;
+
+	/* enable PCI device */
+	err =3D pci_enable_device(pci);
+	if (err < 0)
+		return err;
+
+	pci_set_master(pci);
+
+	/* check if we can restrict PCI DMA transfers to 32 bits */
+	err =3D pci_set_dma_mask(pci, DMA_32BIT_MASK);
+	if (err < 0) {
+		snd_printk(KERN_ERR "architecture does not support "
+			   "32bit PCI busmaster DMA\n");
+		pci_disable_device(pci);
+		return -ENXIO;
+	}
+
+	chip =3D kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (chip =3D=3D NULL) {
+		err =3D -ENOMEM;
+		goto alloc_failed;
+	}
+
+	chip->card =3D card;
+	chip->pci =3D pci;
+	chip->irq =3D -1;
+
+	/* initialize synchronization structs */
+	spin_lock_init(&chip->lock);
+	spin_lock_init(&chip->msg_lock);
+	mutex_init(&chip->setup_mutex);
+	tasklet_init(&chip->trigger_tasklet, lx_trigger_tasklet,
+		     (unsigned long)chip);
+	tasklet_init(&chip->tasklet_capture, lx_tasklet_capture,
+		     (unsigned long)chip);
+	tasklet_init(&chip->tasklet_playback, lx_tasklet_playback,
+		     (unsigned long)chip);
+
+	/* request resources */
+	err =3D pci_request_regions(pci, card_name);
+	if (err < 0)
+		goto request_regions_failed;
+
+	/* plx port */
+	chip->port_plx =3D pci_resource_start(pci, 1);
+	chip->port_plx_remapped =3D ioport_map(chip->port_plx,
+					     pci_resource_len(pci, 1));
+
+	/* dsp port */
+	chip->port_dsp_bar =3D pci_ioremap_bar(pci, 2);
+
+	err =3D request_irq(pci->irq, lx_interrupt, IRQF_SHARED,
+			  card_name, chip);
+	if (err) {
+		snd_printk(KERN_ERR LXP "unable to grab IRQ %d\n", pci->irq);
+		goto request_irq_failed;
+	}
+	chip->irq =3D pci->irq;
+
+	err =3D snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0)
+		goto device_new_failed;
+
+	err =3D lx_init_dsp(chip);
+	if (err < 0) {
+		snd_printk(KERN_ERR LXP "error during DSP initialization\n");
+		return err;
+	}
+
+	err =3D lx_pcm_create(chip);
+	if (err < 0)
+		return err;
+
+	err =3D lx_proc_create(card, chip);
+	if (err < 0)
+		return err;
+
+	err =3D snd_ctl_add(card, snd_ctl_new1(&lx_control_playback_switch,
+					     chip));
+	if (err < 0)
+		return err;
+
+	snd_card_set_dev(card, &pci->dev);
+
+	*rchip =3D chip;
+	return 0;
+
+device_new_failed:
+	free_irq(pci->irq, chip);
+
+request_irq_failed:
+	pci_release_regions(pci);
+
+request_regions_failed:
+	kfree(chip);
+
+alloc_failed:
+	pci_disable_device(pci);
+
+	return err;
+}
+
+static int __devinit snd_lx6464es_probe(struct pci_dev *pci,
+					const struct pci_device_id *pci_id)
+{
+	static int dev;
+	struct snd_card *card;
+	struct lx6464es *chip;
+	int err;
+
+	snd_printdd("->snd_lx6464es_probe\n");
+
+	if (dev >=3D SNDRV_CARDS)
+		return -ENODEV;
+	if (!enable[dev]) {
+		dev++;
+		return -ENOENT;
+	}
+
+	card =3D snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
+	if (card =3D=3D NULL)
+		return -ENOMEM;
+
+	err =3D snd_lx6464es_create(card, pci, &chip);
+	if (err < 0) {
+		snd_printk(KERN_ERR LXP "error during snd_lx6464es_create\n");
+		goto out_free;
+	}
+
+	strcpy(card->driver, "lx6464es");
+	strcpy(card->shortname, "Digigram LX6464ES");
+	sprintf(card->longname, "%s at 0x%lx, 0x%p, irq %i",
+		card->shortname, chip->port_plx,
+		chip->port_dsp_bar, chip->irq);
+
+	err =3D snd_card_register(card);
+	if (err < 0)
+		goto out_free;
+
+	snd_printdd(LXP "initialization successful\n");
+	pci_set_drvdata(pci, card);
+	dev++;
+	return 0;
+
+out_free:
+	snd_card_free(card);
+	return err;
+
+}
+
+static void __devexit snd_lx6464es_remove(struct pci_dev *pci)
+{
+	snd_card_free(pci_get_drvdata(pci));
+	pci_set_drvdata(pci, NULL);
+}
+
+
+static struct pci_driver driver =3D {
+	.name =3D     "Digigram LX6464ES",
+	.id_table =3D snd_lx6464es_ids,
+	.probe =3D    snd_lx6464es_probe,
+	.remove =3D __devexit_p(snd_lx6464es_remove),
+};
+
+
+/* module initialization */
+static int __init mod_init(void)
+{
+	return pci_register_driver(&driver);
+}
+
+static void __exit mod_exit(void)
+{
+	pci_unregister_driver(&driver);
+}
+
+module_init(mod_init);
+module_exit(mod_exit);
diff --git a/sound/pci/lx6464es/lx6464es.h b/sound/pci/lx6464es/lx6464es.h
new file mode 100644
index 0000000..012c010
--- /dev/null
+++ b/sound/pci/lx6464es/lx6464es.h
@@ -0,0 +1,114 @@
+/* -*- linux-c -*- *
+ *
+ * ALSA driver for the digigram lx6464es interface
+ *
+ * Copyright (c) 2009 Tim Blechmann <tim@klingt.org>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; see the file COPYING.  If not, write to
+ * the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 02111-1307, USA.
+ *
+ */
+
+#ifndef LX6464ES_H
+#define LX6464ES_H
+
+#include <linux/spinlock.h>
+#include <asm/atomic.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+
+#include "lx_core.h"
+
+#define LXP "LX6464ES: "
+
+enum {
+    ES_cmd_free         =3D 0,    /* no command executing */
+    ES_cmd_processing   =3D 1,	/* execution of a read/write command */
+    ES_read_pending     =3D 2,    /* a asynchron read command is pending */
+    ES_read_finishing   =3D 3,    /* a read command has finished waiting (=
set by
+				 * Interrupt or CancelIrp) */
+};
+
+enum lx_stream_status {
+	LX_STREAM_STATUS_FREE,
+/* 	LX_STREAM_STATUS_OPEN, */
+	LX_STREAM_STATUS_SCHEDULE_RUN,
+/* 	LX_STREAM_STATUS_STARTED, */
+	LX_STREAM_STATUS_RUNNING,
+	LX_STREAM_STATUS_SCHEDULE_STOP,
+/* 	LX_STREAM_STATUS_STOPPED, */
+/* 	LX_STREAM_STATUS_PAUSED */
+};
+
+
+struct lx_stream {
+	struct snd_pcm_substream  *stream;
+	snd_pcm_uframes_t          frame_pos;
+	enum lx_stream_status      status; /* free, open, running, draining
+					    * pause */
+	int                        is_capture:1;
+};
+
+
+struct lx6464es {
+	struct snd_card        *card;
+	struct pci_dev         *pci;
+	int			irq;
+
+	spinlock_t		lock;        /* interrupt spinlock */
+	struct mutex            setup_mutex; /* mutex used in hw_params, open
+					      * and close */
+
+	struct tasklet_struct   trigger_tasklet; /* trigger tasklet */
+	struct tasklet_struct   tasklet_capture;
+	struct tasklet_struct   tasklet_playback;
+
+	/* ports */
+	unsigned long		port_plx;	   /* io port (size=3D256) */
+	void __iomem           *port_plx_remapped; /* remapped plx port */
+	void __iomem           *port_dsp_bar;      /* memory port (32-bit,
+						    * non-prefetchable,
+						    * size=3D8K) */
+
+	/* messaging */
+	spinlock_t		msg_lock;          /* message spinlock */
+	atomic_t	        send_message_locked;
+	struct lx_rmh           rmh;
+
+	/* configuration */
+	uint			freq_ratio : 2;
+	uint                    playback_mute : 1;
+	uint                    hardware_running[2];
+	u32                     board_sample_rate; /* sample rate read from
+						    * board */
+	u32                     sample_rate;	   /* our sample rate */
+	u16                     pcm_granularity;   /* board blocksize */
+
+	/* dma */
+	struct snd_dma_buffer   capture_dma_buf;
+	struct snd_dma_buffer   playback_dma_buf;
+
+	/* pcm */
+	struct snd_pcm         *pcm;
+
+	/* streams */
+	struct lx_stream        capture_stream;
+	struct lx_stream        playback_stream;
+};
+
+
+#endif /* LX6464ES_H */
diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
new file mode 100644
index 0000000..58f9542
--- /dev/null
+++ b/sound/pci/lx6464es/lx_core.c
@@ -0,0 +1,1442 @@
+/* -*- linux-c -*- *
+ *
+ * ALSA driver for the digigram lx6464es interface
+ * low-level interface
+ *
+ * Copyright (c) 2009 Tim Blechmann <tim@klingt.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; see the file COPYING.  If not, write to
+ * the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 02111-1307, USA.
+ *
+ */
+
+/* #define RMH_DEBUG 1 */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+
+#include "lx6464es.h"
+#include "lx_core.h"
+
+/* low-level register access */
+
+static const unsigned long dsp_port_offsets[] =3D {
+	0,
+	0x400,
+	0x401,
+	0x402,
+	0x403,
+	0x404,
+	0x405,
+	0x406,
+	0x407,
+	0x408,
+	0x409,
+	0x40a,
+	0x40b,
+	0x40c,
+
+	0x410,
+	0x411,
+	0x412,
+	0x413,
+	0x414,
+	0x415,
+	0x416,
+
+	0x420,
+	0x430,
+	0x431,
+	0x432,
+	0x433,
+	0x434,
+	0x440
+};
+
+static void __iomem *lx_dsp_register(struct lx6464es *chip, int port)
+{
+	void __iomem *base_address =3D chip->port_dsp_bar;
+	return base_address + dsp_port_offsets[port]*4;
+}
+
+unsigned long lx_dsp_reg_read(struct lx6464es *chip, int port)
+{
+	void __iomem *address =3D lx_dsp_register(chip, port);
+	return ioread32(address);
+}
+
+void lx_dsp_reg_readbuf(struct lx6464es *chip, int port, u32 *data, u32 le=
n)
+{
+	void __iomem *address =3D lx_dsp_register(chip, port);
+	memcpy_fromio(data, address, len*sizeof(u32));
+}
+
+
+void lx_dsp_reg_write(struct lx6464es *chip, int port, unsigned data)
+{
+	void __iomem *address =3D lx_dsp_register(chip, port);
+	iowrite32(data, address);
+}
+
+void lx_dsp_reg_writebuf(struct lx6464es *chip, int port, const u32 *data,
+			 u32 len)
+{
+	void __iomem *address =3D lx_dsp_register(chip, port);
+	memcpy_toio(address, data, len*sizeof(u32));
+}
+
+
+static const unsigned long plx_port_offsets[] =3D {
+	0x04,
+	0x40,
+	0x44,
+	0x48,
+	0x4c,
+	0x50,
+	0x54,
+	0x58,
+	0x5c,
+	0x64,
+	0x68,
+	0x6C
+};
+
+static void __iomem *lx_plx_register(struct lx6464es *chip, int port)
+{
+	void __iomem *base_address =3D chip->port_plx_remapped;
+	return base_address + plx_port_offsets[port];
+}
+
+unsigned long lx_plx_reg_read(struct lx6464es *chip, int port)
+{
+	void __iomem *address =3D lx_plx_register(chip, port);
+	return ioread32(address);
+}
+
+void lx_plx_reg_write(struct lx6464es *chip, int port, u32 data)
+{
+	void __iomem *address =3D lx_plx_register(chip, port);
+	iowrite32(data, address);
+}
+
+u32 lx_plx_mbox_read(struct lx6464es *chip, int mbox_nr)
+{
+	int index;
+
+	switch (mbox_nr) {
+	case 1:
+		index =3D ePLX_MBOX1;    break;
+	case 2:
+		index =3D ePLX_MBOX2;    break;
+	case 3:
+		index =3D ePLX_MBOX3;    break;
+	case 4:
+		index =3D ePLX_MBOX4;    break;
+	case 5:
+		index =3D ePLX_MBOX5;    break;
+	case 6:
+		index =3D ePLX_MBOX6;    break;
+	case 7:
+		index =3D ePLX_MBOX7;    break;
+	case 0:			/* reserved for HF flags */
+		snd_BUG();
+	default:
+		return 0xdeadbeef;
+	}
+
+	return lx_plx_reg_read(chip, index);
+}
+
+int lx_plx_mbox_write(struct lx6464es *chip, int mbox_nr, u32 value)
+{
+	int index =3D -1;
+
+	switch (mbox_nr) {
+	case 1:
+		index =3D ePLX_MBOX1;    break;
+	case 3:
+		index =3D ePLX_MBOX3;    break;
+	case 4:
+		index =3D ePLX_MBOX4;    break;
+	case 5:
+		index =3D ePLX_MBOX5;    break;
+	case 6:
+		index =3D ePLX_MBOX6;    break;
+	case 7:
+		index =3D ePLX_MBOX7;    break;
+	case 0:			/* reserved for HF flags */
+	case 2:			/* reserved for Pipe States
+				 * the DSP keeps an image of it */
+		snd_BUG();
+		return -EBADRQC;
+	}
+
+	lx_plx_reg_write(chip, index, value);
+	return 0;
+}
+
+
+/* rmh */
+
+#ifdef CONFIG_SND_DEBUG
+#define CMD_NAME(a) a
+#else
+#define CMD_NAME(a) NULL
+#endif
+
+#define Reg_CSM_MR			0x00000002
+#define Reg_CSM_MC			0x00000001
+
+struct dsp_cmd_info {
+	u32    dcCodeOp;	/* Op Code of the command (usually 1st 24-bits
+				 * word).*/
+	u16    dcCmdLength;	/* Command length in words of 24 bits.*/
+	u16    dcStatusType;	/* Status type: 0 for fixed length, 1 for
+				 * random. */
+	u16    dcStatusLength;	/* Status length (if fixed).*/
+	char  *dcOpName;
+};
+
+/*
+  Initialization and control data for the Microblaze interface
+  - OpCode:
+    the opcode field of the command set at the proper offset
+  - CmdLength
+    the number of command words
+  - StatusType
+    offset in the status registers: 0 means that the return value may be
+    different from 0, and must be read
+  - StatusLength
+    the number of status words (in addition to the return value)
+*/
+
+static struct dsp_cmd_info dsp_commands[] =3D
+{
+	{ (CMD_00_INFO_DEBUG << OPCODE_OFFSET)			, 1 /*custom*/
+	  , 1	, 0 /**/		    , CMD_NAME("INFO_DEBUG") },
+	{ (CMD_01_GET_SYS_CFG << OPCODE_OFFSET) 		, 1 /**/
+	  , 1      , 2 /**/		    , CMD_NAME("GET_SYS_CFG") },
+	{ (CMD_02_SET_GRANULARITY << OPCODE_OFFSET)	        , 1 /**/
+	  , 1      , 0 /**/		    , CMD_NAME("SET_GRANULARITY") },
+	{ (CMD_03_SET_TIMER_IRQ << OPCODE_OFFSET)		, 1 /**/
+	  , 1      , 0 /**/		    , CMD_NAME("SET_TIMER_IRQ") },
+	{ (CMD_04_GET_EVENT << OPCODE_OFFSET)			, 1 /**/
+	  , 1      , 0 /*up to 10*/     , CMD_NAME("GET_EVENT") },
+	{ (CMD_05_GET_PIPES << OPCODE_OFFSET)			, 1 /**/
+	  , 1      , 2 /*up to 4*/      , CMD_NAME("GET_PIPES") },
+	{ (CMD_06_ALLOCATE_PIPE << OPCODE_OFFSET)		, 1 /**/
+	  , 0      , 0 /**/		    , CMD_NAME("ALLOCATE_PIPE") },
+	{ (CMD_07_RELEASE_PIPE << OPCODE_OFFSET)		, 1 /**/
+	  , 0      , 0 /**/		    , CMD_NAME("RELEASE_PIPE") },
+	{ (CMD_08_ASK_BUFFERS << OPCODE_OFFSET) 		, 1 /**/
+	  , 1      , MAX_STREAM_BUFFER  , CMD_NAME("ASK_BUFFERS") },
+	{ (CMD_09_STOP_PIPE << OPCODE_OFFSET)			, 1 /**/
+	  , 0      , 0 /*up to 2*/      , CMD_NAME("STOP_PIPE") },
+	{ (CMD_0A_GET_PIPE_SPL_COUNT << OPCODE_OFFSET)	        , 1 /**/
+	  , 1      , 1 /*up to 2*/      , CMD_NAME("GET_PIPE_SPL_COUNT") },
+	{ (CMD_0B_TOGGLE_PIPE_STATE << OPCODE_OFFSET)           , 1 /*up to 5*/
+	  , 1      , 0 /**/		    , CMD_NAME("TOGGLE_PIPE_STATE") },
+	{ (CMD_0C_DEF_STREAM << OPCODE_OFFSET)			, 1 /*up to 4*/
+	  , 1      , 0 /**/		    , CMD_NAME("DEF_STREAM") },
+	{ (CMD_0D_SET_MUTE  << OPCODE_OFFSET)			, 3 /**/
+	  , 1      , 0 /**/		    , CMD_NAME("SET_MUTE") },
+	{ (CMD_0E_GET_STREAM_SPL_COUNT << OPCODE_OFFSET)        , 1/**/
+	  , 1      , 2 /**/		    , CMD_NAME("GET_STREAM_SPL_COUNT") },
+	{ (CMD_0F_UPDATE_BUFFER << OPCODE_OFFSET)		, 3 /*up to 4*/
+	  , 0      , 1 /**/		    , CMD_NAME("UPDATE_BUFFER") },
+	{ (CMD_10_GET_BUFFER << OPCODE_OFFSET)			, 1 /**/
+	  , 1      , 4 /**/		    , CMD_NAME("GET_BUFFER") },
+	{ (CMD_11_CANCEL_BUFFER << OPCODE_OFFSET)		, 1 /**/
+	  , 1      , 1 /*up to 4*/      , CMD_NAME("CANCEL_BUFFER") },
+	{ (CMD_12_GET_PEAK << OPCODE_OFFSET)			, 1 /**/
+	  , 1      , 1 /**/		    , CMD_NAME("GET_PEAK") },
+	{ (CMD_13_SET_STREAM_STATE << OPCODE_OFFSET)	        , 1 /**/
+	  , 1      , 0 /**/		    , CMD_NAME("SET_STREAM_STATE") },
+};
+
+static void lx_message_init(struct lx_rmh *rmh, enum cmd_mb_opcodes cmd)
+{
+	snd_BUG_ON(cmd >=3D CMD_14_INVALID);
+
+	rmh->cmd[0] =3D dsp_commands[cmd].dcCodeOp;
+	rmh->cmd_len =3D dsp_commands[cmd].dcCmdLength;
+	rmh->stat_len =3D dsp_commands[cmd].dcStatusLength;
+	rmh->dsp_stat =3D dsp_commands[cmd].dcStatusType;
+	rmh->cmd_idx =3D cmd;
+	memset(&rmh->cmd[1], 0, (REG_CRM_NUMBER - 1) * sizeof(u32));
+
+#ifdef CONFIG_SND_DEBUG
+	memset(rmh->stat, 0, REG_CRM_NUMBER * sizeof(u32));
+#endif
+#ifdef RMH_DEBUG
+	rmh->cmd_idx =3D cmd;
+#endif
+}
+
+#ifdef RMH_DEBUG
+#define LXRMH "lx6464es rmh: "
+static void lx_message_dump(struct lx_rmh *rmh)
+{
+	u8 idx =3D rmh->cmd_idx;
+	int i;
+
+	snd_printk(LXRMH "command %s\n", dsp_commands[idx].dcOpName);
+
+	for (i =3D 0; i !=3D rmh->cmd_len; ++i)
+		snd_printk(LXRMH "\tcmd[%d] %08x\n", i, rmh->cmd[i]);
+
+	for (i =3D 0; i !=3D rmh->stat_len; ++i)
+		snd_printk(LXRMH "\tstat[%d]: %08x\n", i, rmh->stat[i]);
+	snd_printk("\n");
+}
+#else
+static inline void lx_message_dump(struct lx_rmh *rmh)
+{}
+#endif
+
+
+
+/* sleep 500 - 100 =3D 400 times 100us -> the timeout is >=3D 40 ms */
+#define XILINX_TIMEOUT_MS       40
+#define XILINX_POLL_NO_SLEEP    100
+#define XILINX_POLL_ITERATIONS  150
+
+static int lx_message_send(struct lx6464es *chip, struct lx_rmh *rmh)
+{
+	u32 reg =3D ED_DSP_TIMED_OUT;
+	int dwloop;
+	int answer_received;
+
+	if (lx_dsp_reg_read(chip, eReg_CSM) & (Reg_CSM_MC | Reg_CSM_MR)) {
+		snd_printk(KERN_ERR LXP "PIOSendMessage eReg_CSM %x\n", reg);
+		return -EBUSY;
+	}
+
+	/* write command */
+	lx_dsp_reg_writebuf(chip, eReg_CRM1, rmh->cmd, rmh->cmd_len);
+
+	snd_BUG_ON(atomic_read(&chip->send_message_locked) !=3D 0);
+	atomic_set(&chip->send_message_locked, 1);
+
+	/* MicoBlaze gogogo */
+	lx_dsp_reg_write(chip, eReg_CSM, Reg_CSM_MC);
+
+	/* wait for interrupt to answer */
+	for (dwloop =3D 0; dwloop !=3D XILINX_TIMEOUT_MS; ++dwloop) {
+		answer_received =3D atomic_read(&chip->send_message_locked);
+		if (answer_received =3D=3D 0)
+			break;
+		msleep(1);
+	}
+
+	if (answer_received =3D=3D 0) {
+		/* in Debug mode verify Reg_CSM_MR */
+		snd_BUG_ON(!(lx_dsp_reg_read(chip, eReg_CSM) & Reg_CSM_MR));
+
+		/* command finished, read status */
+		if (rmh->dsp_stat =3D=3D 0)
+			reg =3D lx_dsp_reg_read(chip, eReg_CRM1);
+		else
+			reg =3D 0;
+	} else {
+		int i;
+		snd_printk(KERN_WARNING LXP "TIMEOUT lx_message_send! "
+			   "Interrupts disabled?\n");
+
+		/* attente bit Reg_CSM_MR */
+		for (i =3D 0; i !=3D XILINX_POLL_ITERATIONS; i++) {
+			if ((lx_dsp_reg_read(chip, eReg_CSM) & Reg_CSM_MR)) {
+				if (rmh->dsp_stat =3D=3D 0)
+					reg =3D lx_dsp_reg_read(chip, eReg_CRM1);
+				else
+					reg =3D 0;
+				goto polling_successful;
+			}
+
+			if (i > XILINX_POLL_NO_SLEEP)
+				msleep(1);
+		}
+		snd_printk(KERN_WARNING LXP "TIMEOUT lx_message_send! "
+			   "polling failed\n");
+
+polling_successful:
+		atomic_set(&chip->send_message_locked, 0);
+	}
+
+	if ((reg & ERROR_VALUE) =3D=3D 0) {
+		/* read response */
+		if (rmh->stat_len) {
+			snd_BUG_ON(rmh->stat_len >=3D (REG_CRM_NUMBER-1));
+
+			lx_dsp_reg_readbuf(chip, eReg_CRM2, rmh->stat,
+					   rmh->stat_len);
+		}
+	} else
+		snd_printk(KERN_WARNING LXP "lx_message_send: error_value %x\n",
+			   reg);
+
+	/* clear Reg_CSM_MR */
+	lx_dsp_reg_write(chip, eReg_CSM, 0);
+
+	switch (reg) {
+	case ED_DSP_TIMED_OUT:
+		snd_printk(KERN_WARNING LXP "lx_message_send: dsp timeout\n");
+		return -ETIMEDOUT;
+
+	case ED_DSP_CRASHED:
+		snd_printk(KERN_WARNING LXP "lx_message_send: dsp crashed\n");
+		return -EAGAIN;
+	}
+
+	lx_message_dump(rmh);
+	return 0;
+}
+
+static int lx_message_send_atomic(struct lx6464es *chip, struct lx_rmh *rm=
h)
+{
+	u32 reg =3D ED_DSP_TIMED_OUT;
+	int dwloop;
+
+	if (lx_dsp_reg_read(chip, eReg_CSM) & (Reg_CSM_MC | Reg_CSM_MR)) {
+		snd_printk(KERN_ERR LXP "PIOSendMessage eReg_CSM %x\n", reg);
+		return -EBUSY;
+	}
+
+	/* write command */
+	lx_dsp_reg_writebuf(chip, eReg_CRM1, rmh->cmd, rmh->cmd_len);
+
+	/* MicoBlaze gogogo */
+	lx_dsp_reg_write(chip, eReg_CSM, Reg_CSM_MC);
+
+	/* wait for interrupt to answer */
+	for (dwloop =3D 0; dwloop !=3D XILINX_TIMEOUT_MS * 1000; ++dwloop) {
+		if (lx_dsp_reg_read(chip, eReg_CSM) & Reg_CSM_MR) {
+			if (rmh->dsp_stat =3D=3D 0)
+				reg =3D lx_dsp_reg_read(chip, eReg_CRM1);
+			else
+				reg =3D 0;
+			goto polling_successful;
+		} else
+			udelay(1);
+	}
+	snd_printk(KERN_WARNING LXP "TIMEOUT lx_message_send_atomic! "
+		   "polling failed\n");
+
+polling_successful:
+	if ((reg & ERROR_VALUE) =3D=3D 0) {
+		/* read response */
+		if (rmh->stat_len) {
+			snd_BUG_ON(rmh->stat_len >=3D (REG_CRM_NUMBER-1));
+			lx_dsp_reg_readbuf(chip, eReg_CRM2, rmh->stat,
+					   rmh->stat_len);
+		}
+	} else
+		snd_printk(LXP "rmh error: %08x\n", reg);
+
+	/* clear Reg_CSM_MR */
+	lx_dsp_reg_write(chip, eReg_CSM, 0);
+
+	switch (reg) {
+	case ED_DSP_TIMED_OUT:
+		snd_printk(KERN_WARNING LXP "lx_message_send: dsp timeout\n");
+		return -ETIMEDOUT;
+
+	case ED_DSP_CRASHED:
+		snd_printk(KERN_WARNING LXP "lx_message_send: dsp crashed\n");
+		return -EAGAIN;
+	}
+
+	lx_message_dump(rmh);
+
+	return reg;
+}
+
+
+/* low-level dsp access */
+int __devinit lx_dsp_get_version(struct lx6464es *chip, u32 *rdsp_version)
+{
+	u16 ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->msg_lock, flags);
+
+	lx_message_init(&chip->rmh, CMD_01_GET_SYS_CFG);
+	ret =3D lx_message_send_atomic(chip, &chip->rmh);
+
+	*rdsp_version =3D chip->rmh.stat[1];
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	return ret;
+}
+
+int lx_dsp_get_clock_frequency(struct lx6464es *chip, u32 *rfreq)
+{
+	u16 ret =3D 0;
+	unsigned long flags;
+	u32 freq_raw =3D 0;
+	u32 freq =3D 0;
+	u32 frequency =3D 0;
+
+	spin_lock_irqsave(&chip->msg_lock, flags);
+
+	lx_message_init(&chip->rmh, CMD_01_GET_SYS_CFG);
+	ret =3D lx_message_send_atomic(chip, &chip->rmh);
+
+	if (ret =3D=3D 0) {
+		freq_raw =3D chip->rmh.stat[0] >> FREQ_FIELD_OFFSET;
+		freq =3D freq_raw & XES_FREQ_COUNT8_MASK;
+
+		if ((freq < XES_FREQ_COUNT8_48_MAX) ||
+		    (freq > XES_FREQ_COUNT8_44_MIN))
+			frequency =3D 0; /* unknown */
+		else if (freq >=3D XES_FREQ_COUNT8_44_MAX)
+			frequency =3D 44100;
+		else
+			frequency =3D 48000;
+	}
+
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+
+	*rfreq =3D frequency * chip->freq_ratio;
+
+	return ret;
+}
+
+int lx_dsp_get_mac(struct lx6464es *chip, u8 *mac_address)
+{
+	u32 macmsb, maclsb;
+
+	macmsb =3D lx_dsp_reg_read(chip, eReg_ADMACESMSB) & 0x00FFFFFF;
+	maclsb =3D lx_dsp_reg_read(chip, eReg_ADMACESLSB) & 0x00FFFFFF;
+
+	/* todo: endianess handling */
+	mac_address[5] =3D ((u8 *)(&maclsb))[0];
+	mac_address[4] =3D ((u8 *)(&maclsb))[1];
+	mac_address[3] =3D ((u8 *)(&maclsb))[2];
+	mac_address[2] =3D ((u8 *)(&macmsb))[0];
+	mac_address[1] =3D ((u8 *)(&macmsb))[1];
+	mac_address[0] =3D ((u8 *)(&macmsb))[2];
+
+	return 0;
+}
+
+
+int lx_dsp_set_granularity(struct lx6464es *chip, u32 gran)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&chip->msg_lock, flags);
+
+	lx_message_init(&chip->rmh, CMD_02_SET_GRANULARITY);
+	chip->rmh.cmd[0] |=3D gran;
+
+	ret =3D lx_message_send_atomic(chip, &chip->rmh);
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	return ret;
+}
+
+int lx_dsp_read_async_events(struct lx6464es *chip, u32 *data)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&chip->msg_lock, flags);
+
+	lx_message_init(&chip->rmh, CMD_04_GET_EVENT);
+	chip->rmh.stat_len =3D 9;	/* we don't necessarily need the full length */
+
+	ret =3D lx_message_send_atomic(chip, &chip->rmh);
+
+	if (!ret)
+		memcpy(data, chip->rmh.stat, chip->rmh.stat_len * sizeof(u32));
+
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	return ret;
+}
+
+#define CSES_TIMEOUT        100     /* microseconds */
+#define CSES_CE             0x0001
+#define CSES_BROADCAST      0x0002
+#define CSES_UPDATE_LDSV    0x0004
+
+int lx_dsp_es_check_pipeline(struct lx6464es *chip)
+{
+	int i;
+
+	for (i =3D 0; i !=3D CSES_TIMEOUT; ++i) {
+		/*
+		 * le bit CSES_UPDATE_LDSV est =C3=83=C2=A0 1 d=C3=83=C2=A9s que le macp=
rog
+		 * est pret. il re-passe =C3=83=C2=A0 0 lorsque le premier read a
+		 * =C3=83=C2=A9t=C3=83=C2=A9 fait. pour l'instant on retire le test car =
ce bit
+		 * passe a 1 environ 200 =C3=83=C2=A0 400 ms apr=C3=83=C2=A9s que le reg=
istre
+		 * confES =C3=83=C2=A0 =C3=83=C2=A9t=C3=83=C2=A9 =C3=83=C2=A9crit (kick =
du xilinx ES).
+		 *
+		 * On ne teste que le bit CE.
+		 * */
+
+		u32 cses =3D lx_dsp_reg_read(chip, eReg_CSES);
+
+		if ((cses & CSES_CE) =3D=3D 0)
+			return 0;
+
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
+
+#define PIPE_INFO_TO_CMD(capture, pipe)					\
+	((u32)((u32)(pipe) | ((capture) ? ID_IS_CAPTURE : 0L)) << ID_OFFSET)
+
+
+
+/* low-level pipe handling */
+int lx_pipe_allocate(struct lx6464es *chip, u32 pipe, int is_capture,
+		     int channels)
+{
+	int err;
+	unsigned long flags;
+
+	u32 pipe_cmd =3D PIPE_INFO_TO_CMD(is_capture, pipe);
+
+	spin_lock_irqsave(&chip->msg_lock, flags);
+	lx_message_init(&chip->rmh, CMD_06_ALLOCATE_PIPE);
+
+	chip->rmh.cmd[0] |=3D pipe_cmd;
+	chip->rmh.cmd[0] |=3D channels;
+
+	err =3D lx_message_send_atomic(chip, &chip->rmh);
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+
+	if (err !=3D 0)
+		snd_printk(KERN_ERR "lx6464es: could not allocate pipe\n");
+
+	return err;
+}
+
+int lx_pipe_release(struct lx6464es *chip, u32 pipe, int is_capture)
+{
+	int err;
+	unsigned long flags;
+
+	u32 pipe_cmd =3D PIPE_INFO_TO_CMD(is_capture, pipe);
+
+	spin_lock_irqsave(&chip->msg_lock, flags);
+	lx_message_init(&chip->rmh, CMD_07_RELEASE_PIPE);
+
+	chip->rmh.cmd[0] |=3D pipe_cmd;
+
+	err =3D lx_message_send_atomic(chip, &chip->rmh);
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+
+	return err;
+}
+
+int lx_buffer_ask(struct lx6464es *chip, u32 pipe, int is_capture,
+		  u32 *r_needed, u32 *r_freed, u32 *size_array)
+{
+	int err;
+	unsigned long flags;
+
+	u32 pipe_cmd =3D PIPE_INFO_TO_CMD(is_capture, pipe);
+
+#ifdef CONFIG_SND_DEBUG
+	if (size_array)
+		memset(size_array, 0, sizeof(u32)*MAX_STREAM_BUFFER);
+#endif
+
+	*r_needed =3D 0;
+	*r_freed =3D 0;
+
+	spin_lock_irqsave(&chip->msg_lock, flags);
+	lx_message_init(&chip->rmh, CMD_08_ASK_BUFFERS);
+
+	chip->rmh.cmd[0] |=3D pipe_cmd;
+
+	err =3D lx_message_send_atomic(chip, &chip->rmh);
+
+	if (!err) {
+		int i;
+		for (i =3D 0; i < MAX_STREAM_BUFFER; ++i) {
+			u32 stat =3D chip->rmh.stat[i];
+			if (stat & (BF_EOB << BUFF_FLAGS_OFFSET)) {
+				/* finished */
+				*r_freed +=3D 1;
+				if (size_array)
+					size_array[i] =3D stat & MASK_DATA_SIZE;
+			} else if ((stat & (BF_VALID << BUFF_FLAGS_OFFSET))
+				   =3D=3D 0)
+				/* free */
+				*r_needed +=3D 1;
+		}
+
+#if 0
+		snd_printdd(LXP "CMD_08_ASK_BUFFERS: needed %d, freed %d\n",
+			    *r_needed, *r_freed);
+		for (i =3D 0; i < MAX_STREAM_BUFFER; ++i) {
+			for (i =3D 0; i !=3D chip->rmh.stat_len; ++i)
+				snd_printdd("  stat[%d]: %x, %x\n", i,
+					    chip->rmh.stat[i],
+					    chip->rmh.stat[i] & MASK_DATA_SIZE);
+		}
+#endif
+	}
+
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	return err;
+}
+
+
+int lx_pipe_stop(struct lx6464es *chip, u32 pipe, int is_capture)
+{
+	int err;
+	unsigned long flags;
+
+	u32 pipe_cmd =3D PIPE_INFO_TO_CMD(is_capture, pipe);
+
+	spin_lock_irqsave(&chip->msg_lock, flags);
+	lx_message_init(&chip->rmh, CMD_09_STOP_PIPE);
+
+	chip->rmh.cmd[0] |=3D pipe_cmd;
+
+	err =3D lx_message_send_atomic(chip, &chip->rmh);
+
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	return err;
+}
+
+static int lx_pipe_toggle_state(struct lx6464es *chip, u32 pipe, int is_ca=
pture)
+{
+	int err;
+	unsigned long flags;
+
+	u32 pipe_cmd =3D PIPE_INFO_TO_CMD(is_capture, pipe);
+
+	spin_lock_irqsave(&chip->msg_lock, flags);
+	lx_message_init(&chip->rmh, CMD_0B_TOGGLE_PIPE_STATE);
+
+	chip->rmh.cmd[0] |=3D pipe_cmd;
+
+	err =3D lx_message_send_atomic(chip, &chip->rmh);
+
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	return err;
+}
+
+
+int lx_pipe_start(struct lx6464es *chip, u32 pipe, int is_capture)
+{
+	int err;
+
+	err =3D lx_pipe_wait_for_idle(chip, pipe, is_capture);
+	if (err < 0)
+		return err;
+
+	err =3D lx_pipe_toggle_state(chip, pipe, is_capture);
+
+	return err;
+}
+
+int lx_pipe_pause(struct lx6464es *chip, u32 pipe, int is_capture)
+{
+	int err =3D 0;
+
+	err =3D lx_pipe_wait_for_start(chip, pipe, is_capture);
+	if (err < 0)
+		return err;
+
+	err =3D lx_pipe_toggle_state(chip, pipe, is_capture);
+
+	return err;
+}
+
+
+int lx_pipe_sample_count(struct lx6464es *chip, u32 pipe, int is_capture,
+			 u64 *rsample_count)
+{
+	int err;
+	unsigned long flags;
+
+	u32 pipe_cmd =3D PIPE_INFO_TO_CMD(is_capture, pipe);
+
+	spin_lock_irqsave(&chip->msg_lock, flags);
+	lx_message_init(&chip->rmh, CMD_0A_GET_PIPE_SPL_COUNT);
+
+	chip->rmh.cmd[0] |=3D pipe_cmd;
+	chip->rmh.stat_len =3D 2;	/* need all words here! */
+
+	err =3D lx_message_send_atomic(chip, &chip->rmh); /* don't sleep! */
+
+	if (err !=3D 0)
+		snd_printk(KERN_ERR
+			   "lx6464es: could not query pipe's sample count\n");
+	else {
+		*rsample_count =3D ((u64)(chip->rmh.stat[0] & MASK_SPL_COUNT_HI)
+				  << 24)     /* hi part */
+			+ chip->rmh.stat[1]; /* lo part */
+	}
+
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	return err;
+}
+
+int lx_pipe_state(struct lx6464es *chip, u32 pipe, int is_capture, u16 *rs=
tate)
+{
+	int err;
+	unsigned long flags;
+
+	u32 pipe_cmd =3D PIPE_INFO_TO_CMD(is_capture, pipe);
+
+	spin_lock_irqsave(&chip->msg_lock, flags);
+	lx_message_init(&chip->rmh, CMD_0A_GET_PIPE_SPL_COUNT);
+
+	chip->rmh.cmd[0] |=3D pipe_cmd;
+
+	err =3D lx_message_send_atomic(chip, &chip->rmh);
+
+	if (err !=3D 0)
+		snd_printk(KERN_ERR "lx6464es: could not query pipe's state\n");
+	else
+		*rstate =3D (chip->rmh.stat[0] >> PSTATE_OFFSET) & 0x0F;
+
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	return err;
+}
+
+static int lx_pipe_wait_for_state(struct lx6464es *chip, u32 pipe,
+				  int is_capture, u16 state)
+{
+	int i;
+
+	/* max 2*PCMOnlyGranularity =3D 2*1024 at 44100 =3D < 50 ms:
+	 * timeout 50 ms */
+	for (i =3D 0; i !=3D 50; ++i) {
+		u16 current_state;
+		int err =3D lx_pipe_state(chip, pipe, is_capture, &current_state);
+
+		if (err < 0)
+			return err;
+
+		if (current_state =3D=3D state)
+			return 0;
+
+		mdelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
+int lx_pipe_wait_for_start(struct lx6464es *chip, u32 pipe, int is_capture)
+{
+	return lx_pipe_wait_for_state(chip, pipe, is_capture, PSTATE_RUN);
+}
+
+int lx_pipe_wait_for_idle(struct lx6464es *chip, u32 pipe, int is_capture)
+{
+	return lx_pipe_wait_for_state(chip, pipe, is_capture, PSTATE_IDLE);
+}
+
+/* low-level stream handling */
+int lx_stream_set_state(struct lx6464es *chip, u32 pipe,
+			       int is_capture, enum stream_state_t state)
+{
+	int err;
+	unsigned long flags;
+
+	u32 pipe_cmd =3D PIPE_INFO_TO_CMD(is_capture, pipe);
+
+	spin_lock_irqsave(&chip->msg_lock, flags);
+	lx_message_init(&chip->rmh, CMD_13_SET_STREAM_STATE);
+
+	chip->rmh.cmd[0] |=3D pipe_cmd;
+	chip->rmh.cmd[0] |=3D state;
+
+	err =3D lx_message_send_atomic(chip, &chip->rmh);
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+
+	return err;
+}
+
+int lx_stream_set_format(struct lx6464es *chip, struct snd_pcm_runtime *ru=
ntime,
+			 u32 pipe, int is_capture)
+{
+	int err;
+	unsigned long flags;
+
+	u32 pipe_cmd =3D PIPE_INFO_TO_CMD(is_capture, pipe);
+
+	u32 channels =3D runtime->channels;
+
+	if (runtime->channels !=3D channels)
+		snd_printk(KERN_ERR LXP "channel count mismatch: %d vs %d",
+			   runtime->channels, channels);
+
+	spin_lock_irqsave(&chip->msg_lock, flags);
+	lx_message_init(&chip->rmh, CMD_0C_DEF_STREAM);
+
+	chip->rmh.cmd[0] |=3D pipe_cmd;
+
+	if (runtime->sample_bits =3D=3D 16)
+		/* 16 bit format */
+		chip->rmh.cmd[0] |=3D (STREAM_FMT_16b << STREAM_FMT_OFFSET);
+
+	if (snd_pcm_format_little_endian(runtime->format))
+		/* little endian/intel format */
+		chip->rmh.cmd[0] |=3D (STREAM_FMT_intel << STREAM_FMT_OFFSET);
+
+	chip->rmh.cmd[0] |=3D channels-1;
+
+	err =3D lx_message_send_atomic(chip, &chip->rmh);
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+
+	return err;
+}
+
+int lx_stream_state(struct lx6464es *chip, u32 pipe, int is_capture,
+		    int *rstate)
+{
+	int err;
+	unsigned long flags;
+
+	u32 pipe_cmd =3D PIPE_INFO_TO_CMD(is_capture, pipe);
+
+	spin_lock_irqsave(&chip->msg_lock, flags);
+	lx_message_init(&chip->rmh, CMD_0E_GET_STREAM_SPL_COUNT);
+
+	chip->rmh.cmd[0] |=3D pipe_cmd;
+
+	err =3D lx_message_send_atomic(chip, &chip->rmh);
+
+	*rstate =3D (chip->rmh.stat[0] & SF_START) ? START_STATE : PAUSE_STATE;
+
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	return err;
+}
+
+int lx_stream_sample_position(struct lx6464es *chip, u32 pipe, int is_capt=
ure,
+			      u64 *r_bytepos)
+{
+	int err;
+	unsigned long flags;
+
+	u32 pipe_cmd =3D PIPE_INFO_TO_CMD(is_capture, pipe);
+
+	spin_lock_irqsave(&chip->msg_lock, flags);
+	lx_message_init(&chip->rmh, CMD_0E_GET_STREAM_SPL_COUNT);
+
+	chip->rmh.cmd[0] |=3D pipe_cmd;
+
+	err =3D lx_message_send_atomic(chip, &chip->rmh);
+
+	*r_bytepos =3D ((u64) (chip->rmh.stat[0] & MASK_SPL_COUNT_HI)
+		      << 32)	     /* hi part */
+		+ chip->rmh.stat[1]; /* lo part */
+
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	return err;
+}
+
+/* low-level buffer handling */
+int lx_buffer_give(struct lx6464es *chip, u32 pipe, int is_capture,
+		   u32 buffer_size, u32 buf_address_lo, u32 buf_address_hi,
+		   u32 *r_buffer_index)
+{
+	int err;
+	unsigned long flags;
+
+	u32 pipe_cmd =3D PIPE_INFO_TO_CMD(is_capture, pipe);
+
+	spin_lock_irqsave(&chip->msg_lock, flags);
+	lx_message_init(&chip->rmh, CMD_0F_UPDATE_BUFFER);
+
+	chip->rmh.cmd[0] |=3D pipe_cmd;
+	chip->rmh.cmd[0] |=3D BF_NOTIFY_EOB; /* request interrupt notification */
+
+	/* todo: pause request, circular buffer */
+
+	chip->rmh.cmd[1] =3D buffer_size & MASK_DATA_SIZE;
+	chip->rmh.cmd[2] =3D buf_address_lo;
+
+	if (buf_address_hi) {
+		chip->rmh.cmd_len =3D 4;
+		chip->rmh.cmd[3] =3D buf_address_hi;
+		chip->rmh.cmd[0] |=3D BF_64BITS_ADR;
+	}
+
+	err =3D lx_message_send_atomic(chip, &chip->rmh);
+
+	if (err =3D=3D 0) {
+		*r_buffer_index =3D chip->rmh.stat[0];
+		goto done;
+	}
+
+	if (err =3D=3D EB_RBUFFERS_TABLE_OVERFLOW)
+		snd_printk(LXP "lx_buffer_give EB_RBUFFERS_TABLE_OVERFLOW\n");
+
+	if (err =3D=3D EB_INVALID_STREAM)
+		snd_printk(LXP "lx_buffer_give EB_INVALID_STREAM\n");
+
+	if (err =3D=3D EB_CMD_REFUSED)
+		snd_printk(LXP "lx_buffer_give EB_CMD_REFUSED\n");
+
+ done:
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	return err;
+}
+
+int lx_buffer_free(struct lx6464es *chip, u32 pipe, int is_capture,
+		   u32 *r_buffer_size)
+{
+	int err;
+	unsigned long flags;
+
+	u32 pipe_cmd =3D PIPE_INFO_TO_CMD(is_capture, pipe);
+
+	spin_lock_irqsave(&chip->msg_lock, flags);
+	lx_message_init(&chip->rmh, CMD_11_CANCEL_BUFFER);
+
+	chip->rmh.cmd[0] |=3D pipe_cmd;
+	chip->rmh.cmd[0] |=3D MASK_BUFFER_ID; /* ask for the current buffer: the
+					     * microblaze will seek for it */
+
+	err =3D lx_message_send_atomic(chip, &chip->rmh);
+
+	if (err =3D=3D 0)
+		*r_buffer_size =3D chip->rmh.stat[0]  & MASK_DATA_SIZE;
+
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	return err;
+}
+
+int lx_buffer_cancel(struct lx6464es *chip, u32 pipe, int is_capture,
+		     u32 buffer_index)
+{
+	int err;
+	unsigned long flags;
+
+	u32 pipe_cmd =3D PIPE_INFO_TO_CMD(is_capture, pipe);
+
+	spin_lock_irqsave(&chip->msg_lock, flags);
+	lx_message_init(&chip->rmh, CMD_11_CANCEL_BUFFER);
+
+	chip->rmh.cmd[0] |=3D pipe_cmd;
+	chip->rmh.cmd[0] |=3D buffer_index;
+
+	err =3D lx_message_send_atomic(chip, &chip->rmh);
+
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	return err;
+}
+
+
+/* low-level gain/peak handling
+ *
+ * \todo: can we unmute capture/playback channels independently?
+ *
+ * */
+int lx_level_unmute(struct lx6464es *chip, int is_capture, int unmute)
+{
+	int err;
+	unsigned long flags;
+
+	/* bit set to 1: channel muted */
+	u64 mute_mask =3D unmute ? 0 : 0xFFFFFFFFFFFFFFFFLLU;
+
+	spin_lock_irqsave(&chip->msg_lock, flags);
+	lx_message_init(&chip->rmh, CMD_0D_SET_MUTE);
+
+	chip->rmh.cmd[0] |=3D PIPE_INFO_TO_CMD(is_capture, 0);
+
+	chip->rmh.cmd[1] =3D (u32)(mute_mask >> (u64)32);	       /* hi part */
+	chip->rmh.cmd[2] =3D (u32)(mute_mask & (u64)0xFFFFFFFF); /* lo part */
+
+	snd_printk("mute %x %x %x\n", chip->rmh.cmd[0], chip->rmh.cmd[1],
+		   chip->rmh.cmd[2]);
+
+	err =3D lx_message_send_atomic(chip, &chip->rmh);
+
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	return err;
+}
+
+static u32 peak_map[] =3D {
+	0x00000109, /* -90.308dB */
+	0x0000083B, /* -72.247dB */
+	0x000020C4, /* -60.205dB */
+	0x00008273, /* -48.030dB */
+	0x00020756, /* -36.005dB */
+	0x00040C37, /* -30.001dB */
+	0x00081385, /* -24.002dB */
+	0x00101D3F, /* -18.000dB */
+	0x0016C310, /* -15.000dB */
+	0x002026F2, /* -12.001dB */
+	0x002D6A86, /* -9.000dB */
+	0x004026E6, /* -6.004dB */
+	0x005A9DF6, /* -3.000dB */
+	0x0065AC8B, /* -2.000dB */
+	0x00721481, /* -1.000dB */
+	0x007FFFFF, /* FS */
+};
+
+int lx_level_peaks(struct lx6464es *chip, int is_capture, int channels,
+		   u32 *r_levels)
+{
+	int err =3D 0;
+	unsigned long flags;
+	int i;
+	spin_lock_irqsave(&chip->msg_lock, flags);
+
+	for (i =3D 0; i < channels; i +=3D 4) {
+		u32 s0, s1, s2, s3;
+
+		lx_message_init(&chip->rmh, CMD_12_GET_PEAK);
+		chip->rmh.cmd[0] |=3D PIPE_INFO_TO_CMD(is_capture, i);
+
+		err =3D lx_message_send_atomic(chip, &chip->rmh);
+
+		if (err =3D=3D 0) {
+			s0 =3D peak_map[chip->rmh.stat[0] & 0x0F];
+			s1 =3D peak_map[(chip->rmh.stat[0] >>  4) & 0xf];
+			s2 =3D peak_map[(chip->rmh.stat[0] >>  8) & 0xf];
+			s3 =3D peak_map[(chip->rmh.stat[0] >>  12) & 0xf];
+		} else
+			s0 =3D s1 =3D s2 =3D s3 =3D 0;
+
+		r_levels[0] =3D s0;
+		r_levels[1] =3D s1;
+		r_levels[2] =3D s2;
+		r_levels[3] =3D s3;
+
+		r_levels +=3D 4;
+	}
+
+	spin_unlock_irqrestore(&chip->msg_lock, flags);
+	return err;
+}
+
+/* interrupt handling */
+#define PCX_IRQ_NONE 0
+#define IRQCS_ACTIVE_PCIDB  0x00002000L         /* Bit n=C3=83=C2=83=C3=82=
=C2=B8 13 */
+#define IRQCS_ENABLE_PCIIRQ 0x00000100L         /* Bit n=C3=83=C2=83=C3=82=
=C2=B8 08 */
+#define IRQCS_ENABLE_PCIDB  0x00000200L         /* Bit n=C3=83=C2=83=C3=82=
=C2=B8 09 */
+
+static u32 lx_interrupt_test_ack(struct lx6464es *chip)
+{
+	u32 irqcs =3D lx_plx_reg_read(chip, ePLX_IRQCS);
+
+	/* Test if PCI Doorbell interrupt is active */
+	if (irqcs & IRQCS_ACTIVE_PCIDB)	{
+		u32 temp;
+		irqcs =3D PCX_IRQ_NONE;
+
+		while ((temp =3D lx_plx_reg_read(chip, ePLX_L2PCIDB))) {
+			/* RAZ interrupt */
+			irqcs |=3D temp;
+			lx_plx_reg_write(chip, ePLX_L2PCIDB, temp);
+		}
+
+		return irqcs;
+	}
+	return PCX_IRQ_NONE;
+}
+
+static int lx_interrupt_ack(struct lx6464es *chip, u32 *r_irqsrc,
+			    int *r_async_pending, int *r_async_escmd)
+{
+	u32 irq_async;
+	u32 irqsrc =3D lx_interrupt_test_ack(chip);
+
+	if (irqsrc =3D=3D PCX_IRQ_NONE)
+		return 0;
+
+	*r_irqsrc =3D irqsrc;
+
+	irq_async =3D irqsrc & MASK_SYS_ASYNC_EVENTS; /* + EtherSound response
+						     * (set by xilinx) + EOB */
+
+	if (irq_async & MASK_SYS_STATUS_ESA) {
+		irq_async &=3D ~MASK_SYS_STATUS_ESA;
+		*r_async_escmd =3D 1;
+	}
+
+	if (irqsrc & MASK_SYS_STATUS_CMD_DONE)
+		/* xilinx command notification */
+		atomic_set(&chip->send_message_locked, 0);
+
+	if (irq_async) {
+		/* snd_printd("interrupt: async event pending\n"); */
+		*r_async_pending =3D 1;
+	}
+
+	return 1;
+}
+
+static int lx_interrupt_handle_async_events(struct lx6464es *chip, u32 irq=
src,
+					    int *r_freq_changed,
+					    u64 *r_notified_in_pipe_mask,
+					    u64 *r_notified_out_pipe_mask)
+{
+	int err;
+	u32 stat[9];		/* answer from CMD_04_GET_EVENT */
+
+	/* On peut optimiser pour ne pas lire les evenements vides
+	 * les mots de r=C3=83=C2=83=C3=82=C2=A9ponse sont dans l'ordre suivant :
+	 * Stat[0]	mot de status g=C3=83=C2=83=C3=82=C2=A9n=C3=83=C2=83=C3=82=C2=
=A9ral
+	 * Stat[1]	fin de buffer OUT pF
+	 * Stat[2]	fin de buffer OUT pf
+	 * Stat[3]	fin de buffer IN pF
+	 * Stat[4]	fin de buffer IN pf
+	 * Stat[5]	underrun poid fort
+	 * Stat[6]	underrun poid faible
+	 * Stat[7]	overrun poid fort
+	 * Stat[8]	overrun poid faible
+	 * */
+
+	u64 orun_mask;
+	u64 urun_mask;
+#if 0
+	int has_underrun   =3D (irqsrc & MASK_SYS_STATUS_URUN) ? 1 : 0;
+	int has_overrun    =3D (irqsrc & MASK_SYS_STATUS_ORUN) ? 1 : 0;
+#endif
+	int eb_pending_out =3D (irqsrc & MASK_SYS_STATUS_EOBO) ? 1 : 0;
+	int eb_pending_in  =3D (irqsrc & MASK_SYS_STATUS_EOBI) ? 1 : 0;
+
+	*r_freq_changed =3D (irqsrc & MASK_SYS_STATUS_FREQ) ? 1 : 0;
+
+	err =3D lx_dsp_read_async_events(chip, stat);
+	if (err < 0)
+		return err;
+
+	if (eb_pending_in) {
+		*r_notified_in_pipe_mask =3D ((u64)stat[3] << 32)
+			+ stat[4];
+		snd_printdd(LXP "interrupt: EOBI pending %llx\n",
+			    *r_notified_in_pipe_mask);
+	}
+	if (eb_pending_out) {
+		*r_notified_out_pipe_mask =3D ((u64)stat[1] << 32)
+			+ stat[2];
+		snd_printdd(LXP "interrupt: EOBO pending %llx\n",
+			    *r_notified_out_pipe_mask);
+	}
+
+	orun_mask =3D ((u64)stat[7] << 32) + stat[8];
+	urun_mask =3D ((u64)stat[5] << 32) + stat[6];
+
+	/* todo: handle xrun notification */
+
+	return err;
+}
+
+static int lx_interrupt_request_new_buffer(struct lx6464es *chip,
+					   struct lx_stream *lx_stream)
+{
+	struct snd_pcm_substream *substream =3D lx_stream->stream;
+	int is_capture =3D lx_stream->is_capture;
+	int err;
+	unsigned long flags;
+
+	const u32 channels =3D substream->runtime->channels;
+	const u32 bytes_per_frame =3D channels * 3;
+	const u32 period_size =3D substream->runtime->period_size;
+	const u32 period_bytes =3D period_size * bytes_per_frame;
+	const u32 pos =3D lx_stream->frame_pos;
+	const u32 next_pos =3D ((pos+1) =3D=3D substream->runtime->periods) ?
+		0 : pos + 1;
+
+	dma_addr_t buf =3D substream->dma_buffer.addr + pos * period_bytes;
+	u32 buf_hi =3D 0;
+	u32 buf_lo =3D 0;
+	u32 buffer_index =3D 0;
+
+	u32 needed, freed;
+	u32 size_array[MAX_STREAM_BUFFER];
+
+	snd_printdd("->lx_interrupt_request_new_buffer\n");
+
+	spin_lock_irqsave(&chip->lock, flags);
+
+	err =3D lx_buffer_ask(chip, 0, is_capture, &needed, &freed, size_array);
+	snd_printdd(LXP "interrupt: needed %d, freed %d\n", needed, freed);
+
+	unpack_pointer(buf, &buf_lo, &buf_hi);
+	err =3D lx_buffer_give(chip, 0, is_capture, period_bytes, buf_lo, buf_hi,
+			     &buffer_index);
+	snd_printdd(LXP "interrupt: gave buffer index %x on %p (%d bytes)\n",
+		    buffer_index, (void *)buf, period_bytes);
+
+	lx_stream->frame_pos =3D next_pos;
+	spin_unlock_irqrestore(&chip->lock, flags);
+
+	return err;
+}
+
+void lx_tasklet_playback(unsigned long data)
+{
+	struct lx6464es *chip =3D (struct lx6464es *)data;
+	struct lx_stream *lx_stream =3D &chip->playback_stream;
+	int err;
+
+	snd_printdd("->lx_tasklet_playback\n");
+
+	err =3D lx_interrupt_request_new_buffer(chip, lx_stream);
+	if (err < 0)
+		snd_printk(KERN_ERR LXP
+			   "cannot request new buffer for playback\n");
+
+	snd_pcm_period_elapsed(lx_stream->stream);
+}
+
+void lx_tasklet_capture(unsigned long data)
+{
+	struct lx6464es *chip =3D (struct lx6464es *)data;
+	struct lx_stream *lx_stream =3D &chip->capture_stream;
+	int err;
+
+	snd_printdd("->lx_tasklet_capture\n");
+	err =3D lx_interrupt_request_new_buffer(chip, lx_stream);
+	if (err < 0)
+		snd_printk(KERN_ERR LXP
+			   "cannot request new buffer for capture\n");
+
+	snd_pcm_period_elapsed(lx_stream->stream);
+}
+
+
+
+static int lx_interrupt_handle_audio_transfer(struct lx6464es *chip,
+					      u64 notified_in_pipe_mask,
+					      u64 notified_out_pipe_mask)
+{
+	int err =3D 0;
+
+	if (notified_in_pipe_mask) {
+		snd_printdd(LXP "requesting audio transfer for capture\n");
+		tasklet_hi_schedule(&chip->tasklet_capture);
+	}
+
+	if (notified_out_pipe_mask) {
+		snd_printdd(LXP "requesting audio transfer for playback\n");
+		tasklet_hi_schedule(&chip->tasklet_playback);
+	}
+
+	return err;
+}
+
+
+irqreturn_t lx_interrupt(int irq, void *dev_id)
+{
+	struct lx6464es *chip =3D dev_id;
+	int async_pending, async_escmd;
+	u32 irqsrc;
+
+	spin_lock(&chip->lock);
+
+	snd_printdd("**************************************************\n");
+
+	if (!lx_interrupt_ack(chip, &irqsrc, &async_pending, &async_escmd)) {
+		spin_unlock(&chip->lock);
+		snd_printdd("IRQ_NONE\n");
+		return IRQ_NONE; /* this device did not cause the interrupt */
+	}
+
+	if (irqsrc & MASK_SYS_STATUS_CMD_DONE)
+		goto exit;
+
+#if 0
+	if (irqsrc & MASK_SYS_STATUS_EOBI)
+		snd_printdd(LXP "interrupt: EOBI\n");
+
+	if (irqsrc & MASK_SYS_STATUS_EOBO)
+		snd_printdd(LXP "interrupt: EOBO\n");
+
+	if (irqsrc & MASK_SYS_STATUS_URUN)
+		snd_printdd(LXP "interrupt: URUN\n");
+
+	if (irqsrc & MASK_SYS_STATUS_ORUN)
+		snd_printdd(LXP "interrupt: ORUN\n");
+#endif
+
+	if (async_pending) {
+		u64 notified_in_pipe_mask =3D 0;
+		u64 notified_out_pipe_mask =3D 0;
+		int freq_changed;
+		int err;
+
+		/* handle async events */
+		err =3D lx_interrupt_handle_async_events(chip, irqsrc,
+						       &freq_changed,
+						       &notified_in_pipe_mask,
+						       &notified_out_pipe_mask);
+		if (err)
+			snd_printk(KERN_ERR LXP
+				   "error handling async events\n");
+
+		err =3D lx_interrupt_handle_audio_transfer(chip,
+							 notified_in_pipe_mask,
+							 notified_out_pipe_mask
+			);
+		if (err)
+			snd_printk(KERN_ERR LXP
+				   "error during audio transfer\n");
+	}
+
+	if (async_escmd) {
+#if 0
+		/* backdoor for ethersound commands
+		 *
+		 * for now, we do not need this
+		 *
+		 * */
+
+		snd_printdd("lx6464es: interrupt requests escmd handling\n");
+#endif
+	}
+
+exit:
+	spin_unlock(&chip->lock);
+	return IRQ_HANDLED;	/* this device caused the interrupt */
+}
+
+
+static void lx_irq_set(struct lx6464es *chip, int enable)
+{
+	u32 reg =3D lx_plx_reg_read(chip, ePLX_IRQCS);
+
+	/* enable/disable interrupts
+	 *
+	 * Set the Doorbell and PCI interrupt enable bits
+	 *
+	 * */
+	if (enable)
+		reg |=3D  (IRQCS_ENABLE_PCIIRQ | IRQCS_ENABLE_PCIDB);
+	else
+		reg &=3D ~(IRQCS_ENABLE_PCIIRQ | IRQCS_ENABLE_PCIDB);
+	lx_plx_reg_write(chip, ePLX_IRQCS, reg);
+}
+
+void lx_irq_enable(struct lx6464es *chip)
+{
+	snd_printdd("->lx_irq_enable\n");
+	lx_irq_set(chip, 1);
+}
+
+void lx_irq_disable(struct lx6464es *chip)
+{
+	snd_printdd("->lx_irq_disable\n");
+	lx_irq_set(chip, 0);
+}
diff --git a/sound/pci/lx6464es/lx_core.h b/sound/pci/lx6464es/lx_core.h
new file mode 100644
index 0000000..6bd9cbb
--- /dev/null
+++ b/sound/pci/lx6464es/lx_core.h
@@ -0,0 +1,242 @@
+/* -*- linux-c -*- *
+ *
+ * ALSA driver for the digigram lx6464es interface
+ * low-level interface
+ *
+ * Copyright (c) 2009 Tim Blechmann <tim@klingt.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; see the file COPYING.  If not, write to
+ * the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 02111-1307, USA.
+ *
+ */
+
+#ifndef LX_CORE_H
+#define LX_CORE_H
+
+#include <linux/interrupt.h>
+
+#include "lx_defs.h"
+
+#define REG_CRM_NUMBER		12
+
+struct lx6464es;
+
+/* low-level register access */
+
+/* dsp register access */
+enum {
+	eReg_BASE,
+	eReg_CSM,
+	eReg_CRM1,
+	eReg_CRM2,
+	eReg_CRM3,
+	eReg_CRM4,
+	eReg_CRM5,
+	eReg_CRM6,
+	eReg_CRM7,
+	eReg_CRM8,
+	eReg_CRM9,
+	eReg_CRM10,
+	eReg_CRM11,
+	eReg_CRM12,
+
+	eReg_ICR,
+	eReg_CVR,
+	eReg_ISR,
+	eReg_RXHTXH,
+	eReg_RXMTXM,
+	eReg_RHLTXL,
+	eReg_RESETDSP,
+
+	eReg_CSUF,
+	eReg_CSES,
+	eReg_CRESMSB,
+	eReg_CRESLSB,
+	eReg_ADMACESMSB,
+	eReg_ADMACESLSB,
+	eReg_CONFES,
+
+	eMaxPortLx
+};
+
+unsigned long lx_dsp_reg_read(struct lx6464es *chip, int port);
+void lx_dsp_reg_readbuf(struct lx6464es *chip, int port, u32 *data, u32 le=
n);
+void lx_dsp_reg_write(struct lx6464es *chip, int port, unsigned data);
+void lx_dsp_reg_writebuf(struct lx6464es *chip, int port, const u32 *data,
+			 u32 len);
+
+/* plx register access */
+enum {
+    ePLX_PCICR,
+
+    ePLX_MBOX0,
+    ePLX_MBOX1,
+    ePLX_MBOX2,
+    ePLX_MBOX3,
+    ePLX_MBOX4,
+    ePLX_MBOX5,
+    ePLX_MBOX6,
+    ePLX_MBOX7,
+
+    ePLX_L2PCIDB,
+    ePLX_IRQCS,
+    ePLX_CHIPSC,
+
+    eMaxPort
+};
+
+unsigned long lx_plx_reg_read(struct lx6464es *chip, int port);
+void lx_plx_reg_write(struct lx6464es *chip, int port, u32 data);
+
+/* rhm */
+struct lx_rmh {
+	u16	cmd_len;	/* length of the command to send (WORDs) */
+	u16	stat_len;	/* length of the status received (WORDs) */
+	u16	dsp_stat;	/* status type, RMP_SSIZE_XXX */
+	u16	cmd_idx;	/* index of the command */
+	u32	cmd[REG_CRM_NUMBER];
+	u32	stat[REG_CRM_NUMBER];
+};
+
+
+/* low-level dsp access */
+int __devinit lx_dsp_get_version(struct lx6464es *chip, u32 *rdsp_version);
+int lx_dsp_get_clock_frequency(struct lx6464es *chip, u32 *rfreq);
+int lx_dsp_set_granularity(struct lx6464es *chip, u32 gran);
+int lx_dsp_read_async_events(struct lx6464es *chip, u32 *data);
+int lx_dsp_get_mac(struct lx6464es *chip, u8 *mac_address);
+
+
+/* low-level pipe handling */
+int lx_pipe_allocate(struct lx6464es *chip, u32 pipe, int is_capture,
+		     int channels);
+int lx_pipe_release(struct lx6464es *chip, u32 pipe, int is_capture);
+int lx_pipe_sample_count(struct lx6464es *chip, u32 pipe, int is_capture,
+			 u64 *rsample_count);
+int lx_pipe_state(struct lx6464es *chip, u32 pipe, int is_capture, u16 *rs=
tate);
+int lx_pipe_stop(struct lx6464es *chip, u32 pipe, int is_capture);
+int lx_pipe_start(struct lx6464es *chip, u32 pipe, int is_capture);
+int lx_pipe_pause(struct lx6464es *chip, u32 pipe, int is_capture);
+
+int lx_pipe_wait_for_start(struct lx6464es *chip, u32 pipe, int is_capture=
);
+int lx_pipe_wait_for_idle(struct lx6464es *chip, u32 pipe, int is_capture);
+
+/* low-level stream handling */
+int lx_stream_set_format(struct lx6464es *chip, struct snd_pcm_runtime *ru=
ntime,
+			 u32 pipe, int is_capture);
+int lx_stream_state(struct lx6464es *chip, u32 pipe, int is_capture,
+		    int *rstate);
+int lx_stream_sample_position(struct lx6464es *chip, u32 pipe, int is_capt=
ure,
+			      u64 *r_bytepos);
+
+int lx_stream_set_state(struct lx6464es *chip, u32 pipe,
+			int is_capture, enum stream_state_t state);
+
+static inline int lx_stream_start(struct lx6464es *chip, u32 pipe,
+				  int is_capture)
+{
+	snd_printdd("->lx_stream_start\n");
+	return lx_stream_set_state(chip, pipe, is_capture, SSTATE_RUN);
+}
+
+static inline int lx_stream_pause(struct lx6464es *chip, u32 pipe,
+				  int is_capture)
+{
+	snd_printdd("->lx_stream_pause\n");
+	return lx_stream_set_state(chip, pipe, is_capture, SSTATE_PAUSE);
+}
+
+static inline int lx_stream_stop(struct lx6464es *chip, u32 pipe,
+				 int is_capture)
+{
+	snd_printdd("->lx_stream_stop\n");
+	return lx_stream_set_state(chip, pipe, is_capture, SSTATE_STOP);
+}
+
+/* low-level buffer handling */
+int lx_buffer_ask(struct lx6464es *chip, u32 pipe, int is_capture,
+		  u32 *r_needed, u32 *r_freed, u32 *size_array);
+int lx_buffer_give(struct lx6464es *chip, u32 pipe, int is_capture,
+		   u32 buffer_size, u32 buf_address_lo, u32 buf_address_hi,
+		   u32 *r_buffer_index);
+int lx_buffer_free(struct lx6464es *chip, u32 pipe, int is_capture,
+		   u32 *r_buffer_size);
+int lx_buffer_cancel(struct lx6464es *chip, u32 pipe, int is_capture,
+		     u32 buffer_index);
+
+/* low-level gain/peak handling */
+int lx_level_unmute(struct lx6464es *chip, int is_capture, int unmute);
+int lx_level_peaks(struct lx6464es *chip, int is_capture, int channels,
+		   u32 *r_levels);
+
+
+/* interrupt handling */
+irqreturn_t lx_interrupt(int irq, void *dev_id);
+void lx_irq_enable(struct lx6464es *chip);
+void lx_irq_disable(struct lx6464es *chip);
+
+void lx_tasklet_capture(unsigned long data);
+void lx_tasklet_playback(unsigned long data);
+
+
+/* Stream Format Header Defines (for LIN and IEEE754) */
+#define HEADER_FMT_BASE		HEADER_FMT_BASE_LIN
+#define HEADER_FMT_BASE_LIN	0xFED00000
+#define HEADER_FMT_BASE_FLOAT	0xFAD00000
+#define HEADER_FMT_MONO		0x00000080 /* bit 23 in header_lo. WARNING: old
+					    * bit 22 is ignored in float
+					    * format */
+#define HEADER_FMT_INTEL	0x00008000
+#define HEADER_FMT_16BITS	0x00002000
+#define HEADER_FMT_24BITS	0x00004000
+#define HEADER_FMT_UPTO11	0x00000200 /* frequency is less or equ. to 11k.
+					    * */
+#define HEADER_FMT_UPTO32	0x00000100 /* frequency is over 11k and less
+					    * then 32k.*/
+
+
+#define BIT_FMP_HEADER          23
+#define BIT_FMP_SD              22
+#define BIT_FMP_MULTICHANNEL    19
+
+#define START_STATE             1
+#define PAUSE_STATE             0
+
+
+
+
+
+/* from PcxAll_e.h */
+/* Start/Pause condition for pipes (PCXStartPipe, PCXPausePipe) */
+#define START_PAUSE_IMMEDIATE           0
+#define START_PAUSE_ON_SYNCHRO          1
+#define START_PAUSE_ON_TIME_CODE        2
+
+
+/* Pipe / Stream state */
+#define START_STATE             1
+#define PAUSE_STATE             0
+
+static inline void unpack_pointer(dma_addr_t ptr, u32 *r_low, u32 *r_high)
+{
+	*r_low =3D (u32)(ptr & 0xffffffff);
+#if BITS_PER_LONG =3D=3D 32
+	*r_high =3D 0;
+#else
+	*r_high =3D (u32)((u64)ptr>>32);
+#endif
+}
+
+#endif /* LX_CORE_H */
diff --git a/sound/pci/lx6464es/lx_defs.h b/sound/pci/lx6464es/lx_defs.h
new file mode 100644
index 0000000..49d36bd
--- /dev/null
+++ b/sound/pci/lx6464es/lx_defs.h
@@ -0,0 +1,376 @@
+/* -*- linux-c -*- *
+ *
+ * ALSA driver for the digigram lx6464es interface
+ * adapted upstream headers
+ *
+ * Copyright (c) 2009 Tim Blechmann <tim@klingt.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; see the file COPYING.  If not, write to
+ * the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 02111-1307, USA.
+ *
+ */
+
+#ifndef LX_DEFS_H
+#define LX_DEFS_H
+
+/* code adapted from ethersound.h */
+#define	XES_FREQ_COUNT8_MASK    0x00001FFF /* compteur 25MHz entre 8 ech. =
*/
+#define	XES_FREQ_COUNT8_44_MIN  0x00001288 /* 25M /
+					    * [ 44k - ( 44.1k + 48k ) / 2 ]
+					    * * 8 */
+#define	XES_FREQ_COUNT8_44_MAX	0x000010F0 /* 25M / [ ( 44.1k + 48k ) / 2 ]
+					    * * 8 */
+#define	XES_FREQ_COUNT8_48_MAX	0x00000F08 /* 25M /
+					    * [ 48k + ( 44.1k + 48k ) / 2 ]
+					    * * 8 */
+
+/* code adapted from LXES_registers.h */
+
+#define IOCR_OUTPUTS_OFFSET 0	/* (rw) offset for the number of OUTs in the
+				 * ConfES register. */
+#define IOCR_INPUTS_OFFSET  8	/* (rw) offset for the number of INs in the
+				 * ConfES register. */
+#define FREQ_RATIO_OFFSET  19	/* (rw) offset for frequency ratio in the
+				 * ConfES register. */
+#define	FREQ_RATIO_SINGLE_MODE 0x01 /* value for single mode frequency rat=
io:
+				     * sample rate =3D frequency rate. */
+
+#define CONFES_READ_PART_MASK	0x00070000
+#define CONFES_WRITE_PART_MASK	0x00F80000
+
+/* code adapted from if_drv_mb.h */
+
+#define MASK_SYS_STATUS_ERROR	(1L << 31) /* events that lead to a PCI irq =
if
+					    * not yet pending */
+#define MASK_SYS_STATUS_URUN	(1L << 30)
+#define MASK_SYS_STATUS_ORUN	(1L << 29)
+#define MASK_SYS_STATUS_EOBO	(1L << 28)
+#define MASK_SYS_STATUS_EOBI	(1L << 27)
+#define MASK_SYS_STATUS_FREQ	(1L << 26)
+#define MASK_SYS_STATUS_ESA	(1L << 25) /* reserved, this is set by the
+					    * XES */
+#define MASK_SYS_STATUS_TIMER	(1L << 24)
+
+#define MASK_SYS_ASYNC_EVENTS	(MASK_SYS_STATUS_ERROR |		\
+				 MASK_SYS_STATUS_URUN  |		\
+				 MASK_SYS_STATUS_ORUN  |		\
+				 MASK_SYS_STATUS_EOBO  |		\
+				 MASK_SYS_STATUS_EOBI  |		\
+				 MASK_SYS_STATUS_FREQ  |		\
+				 MASK_SYS_STATUS_ESA)
+
+#define MASK_SYS_PCI_EVENTS		(MASK_SYS_ASYNC_EVENTS |	\
+					 MASK_SYS_STATUS_TIMER)
+
+#define MASK_SYS_TIMER_COUNT	0x0000FFFF
+
+#define MASK_SYS_STATUS_EOT_PLX		(1L << 22) /* event that remains
+						    * internal: reserved fo end
+						    * of plx dma */
+#define MASK_SYS_STATUS_XES		(1L << 21) /* event that remains
+						    * internal: pending XES
+						    * IRQ */
+#define MASK_SYS_STATUS_CMD_DONE	(1L << 20) /* alternate command
+						    * management: notify driver
+						    * instead of polling */
+
+
+#define MAX_STREAM_BUFFER 5	/* max amount of stream buffers. */
+
+#define MICROBLAZE_IBL_MIN		 32
+#define MICROBLAZE_IBL_DEFAULT	        128
+#define MICROBLAZE_IBL_MAX		512
+/* #define MASK_GRANULARITY		(2*MICROBLAZE_IBL_MAX-1) */
+
+
+
+/* command opcodes, see reference for details */
+
+/*
+ the capture bit position in the object_id field in driver commands
+ depends upon the number of managed channels. For now, 64 IN + 64 OUT are
+ supported. HOwever, the communication protocol forsees 1024 channels, hen=
ce
+ bit 10 indicates a capture (input) object).
+*/
+#define ID_IS_CAPTURE (1L << 10)
+#define ID_OFFSET	13	/* object ID is at the 13th bit in the
+				 * 1st command word.*/
+#define ID_CH_MASK    0x3F
+#define OPCODE_OFFSET	24	/* offset of the command opcode in the first
+				 * command word.*/
+
+enum cmd_mb_opcodes {
+	CMD_00_INFO_DEBUG	        =3D 0x00,
+	CMD_01_GET_SYS_CFG		=3D 0x01,
+	CMD_02_SET_GRANULARITY		=3D 0x02,
+	CMD_03_SET_TIMER_IRQ		=3D 0x03,
+	CMD_04_GET_EVENT		=3D 0x04,
+	CMD_05_GET_PIPES		=3D 0x05,
+
+	CMD_06_ALLOCATE_PIPE            =3D 0x06,
+	CMD_07_RELEASE_PIPE		=3D 0x07,
+	CMD_08_ASK_BUFFERS		=3D 0x08,
+	CMD_09_STOP_PIPE		=3D 0x09,
+	CMD_0A_GET_PIPE_SPL_COUNT	=3D 0x0a,
+	CMD_0B_TOGGLE_PIPE_STATE	=3D 0x0b,
+
+	CMD_0C_DEF_STREAM		=3D 0x0c,
+	CMD_0D_SET_MUTE			=3D 0x0d,
+	CMD_0E_GET_STREAM_SPL_COUNT     =3D 0x0e,
+	CMD_0F_UPDATE_BUFFER		=3D 0x0f,
+	CMD_10_GET_BUFFER		=3D 0x10,
+	CMD_11_CANCEL_BUFFER		=3D 0x11,
+	CMD_12_GET_PEAK			=3D 0x12,
+	CMD_13_SET_STREAM_STATE		=3D 0x13,
+	CMD_14_INVALID			=3D 0x14,
+};
+
+/* pipe states */
+enum pipe_state_t {
+	PSTATE_IDLE	=3D 0,	/* the pipe is not processed in the XES_IRQ
+				 * (free or stopped, or paused). */
+	PSTATE_RUN	=3D 1,	/* sustained play/record state. */
+	PSTATE_PURGE	=3D 2,	/* the ES channels are now off, render pipes do
+				 * not DMA, record pipe do a last DMA. */
+	PSTATE_ACQUIRE	=3D 3,	/* the ES channels are now on, render pipes do
+				 * not yet increase their sample count, record
+				 * pipes do not DMA. */
+	PSTATE_CLOSING	=3D 4,	/* the pipe is releasing, and may not yet
+				 * receive an "alloc" command. */
+};
+
+/* stream states */
+enum stream_state_t {
+	SSTATE_STOP	=3D  0x00,       /* setting to stop resets the stream spl
+					* count.*/
+	SSTATE_RUN	=3D (0x01 << 0), /* start DMA and spl count handling. */
+	SSTATE_PAUSE	=3D (0x01 << 1), /* pause DMA and spl count handling. */
+};
+
+/* buffer flags */
+enum buffer_flags {
+	BF_VALID	=3D 0x80,	/* set if the buffer is valid, clear if free.*/
+	BF_CURRENT	=3D 0x40,	/* set if this is the current buffer (there is
+				 * always a current buffer).*/
+	BF_NOTIFY_EOB	=3D 0x20,	/* set if this buffer must cause a PCI event
+				 * when finished.*/
+	BF_CIRCULAR	=3D 0x10,	/* set if buffer[1] must be copied to buffer[0]
+				 * by the end of this buffer.*/
+	BF_64BITS_ADR	=3D 0x08,	/* set if the hi part of the address is valid.*/
+	BF_xx		=3D 0x04,	/* future extension.*/
+	BF_EOB		=3D 0x02,	/* set if finished, but not yet free.*/
+	BF_PAUSE	=3D 0x01,	/* pause stream at buffer end.*/
+	BF_ZERO		=3D 0x00,	/* no flags (init).*/
+};
+
+/**
+*	Stream Flags definitions
+*/
+enum stream_flags {
+	SF_ZERO		=3D 0x00000000, /* no flags (stream invalid). */
+	SF_VALID	=3D 0x10000000, /* the stream has a valid DMA_conf
+				       * info (setstreamformat). */
+	SF_XRUN		=3D 0x20000000, /* the stream is un x-run state. */
+	SF_START	=3D 0x40000000, /* the DMA is running.*/
+	SF_ASIO		=3D 0x80000000, /* ASIO.*/
+};
+
+
+#define MASK_SPL_COUNT_HI 0x00FFFFFF /* 4 MSBits are status bits */
+#define PSTATE_OFFSET             28 /* 4 MSBits are status bits */
+
+
+#define MASK_STREAM_HAS_MAPPING	(1L << 12)
+#define MASK_STREAM_IS_ASIO	(1L <<  9)
+#define STREAM_FMT_OFFSET	10   /* the stream fmt bits start at the 10th
+				      * bit in the command word. */
+
+#define STREAM_FMT_16b          0x02
+#define STREAM_FMT_intel        0x01
+
+#define FREQ_FIELD_OFFSET	15  /* offset of the freq field in the response
+				     * word */
+
+#define BUFF_FLAGS_OFFSET	  24 /*  offset of the buffer flags in the
+				      *  response word. */
+#define MASK_DATA_SIZE	  0x00FFFFFF /* this must match the field size of
+				      * datasize in the buffer_t structure. */
+
+#define MASK_BUFFER_ID	        0xFF /* the cancel command awaits a buffer =
ID,
+				      * may be 0xFF for "current". */
+
+
+/* code adapted from PcxErr_e.h */
+
+/* Bits masks */
+
+#define ERROR_MASK              0x8000
+
+#define SOURCE_MASK             0x7800
+
+#define E_SOURCE_BOARD          0x4000 /* 8 >> 1 */
+#define E_SOURCE_DRV            0x2000 /* 4 >> 1 */
+#define E_SOURCE_API            0x1000 /* 2 >> 1 */
+/* Error tools */
+#define E_SOURCE_TOOLS          0x0800 /* 1 >> 1 */
+/* Error pcxaudio */
+#define E_SOURCE_AUDIO          0x1800 /* 3 >> 1 */
+/* Error virtual pcx */
+#define E_SOURCE_VPCX           0x2800 /* 5 >> 1 */
+/* Error dispatcher */
+#define E_SOURCE_DISPATCHER     0x3000 /* 6 >> 1 */
+/* Error from CobraNet firmware */
+#define E_SOURCE_COBRANET       0x3800 /* 7 >> 1 */
+
+#define E_SOURCE_USER           0x7800
+
+#define CLASS_MASK              0x0700
+
+#define CODE_MASK               0x00FF
+
+/* Bits values */
+
+/* Values for the error/warning bit */
+#define ERROR_VALUE             0x8000
+#define WARNING_VALUE           0x0000
+
+/* Class values */
+#define E_CLASS_GENERAL                  0x0000
+#define E_CLASS_INVALID_CMD              0x0100
+#define E_CLASS_INVALID_STD_OBJECT       0x0200
+#define E_CLASS_RSRC_IMPOSSIBLE          0x0300
+#define E_CLASS_WRONG_CONTEXT            0x0400
+#define E_CLASS_BAD_SPECIFIC_PARAMETER   0x0500
+#define E_CLASS_REAL_TIME_ERROR          0x0600
+#define E_CLASS_DIRECTSHOW               0x0700
+#define E_CLASS_FREE                     0x0700
+
+
+/* Complete DRV error code for the general class */
+#define ED_GN           (ERROR_VALUE | E_SOURCE_DRV | E_CLASS_GENERAL)
+#define ED_CONCURRENCY                  (ED_GN | 0x01)
+#define ED_DSP_CRASHED                  (ED_GN | 0x02)
+#define ED_UNKNOWN_BOARD                (ED_GN | 0x03)
+#define ED_NOT_INSTALLED                (ED_GN | 0x04)
+#define ED_CANNOT_OPEN_SVC_MANAGER      (ED_GN | 0x05)
+#define ED_CANNOT_READ_REGISTRY         (ED_GN | 0x06)
+#define ED_DSP_VERSION_MISMATCH         (ED_GN | 0x07)
+#define ED_UNAVAILABLE_FEATURE          (ED_GN | 0x08)
+#define ED_CANCELLED                    (ED_GN | 0x09)
+#define ED_NO_RESPONSE_AT_IRQA          (ED_GN | 0x10)
+#define ED_INVALID_ADDRESS              (ED_GN | 0x11)
+#define ED_DSP_CORRUPTED                (ED_GN | 0x12)
+#define ED_PENDING_OPERATION            (ED_GN | 0x13)
+#define ED_NET_ALLOCATE_MEMORY_IMPOSSIBLE   (ED_GN | 0x14)
+#define ED_NET_REGISTER_ERROR               (ED_GN | 0x15)
+#define ED_NET_THREAD_ERROR                 (ED_GN | 0x16)
+#define ED_NET_OPEN_ERROR                   (ED_GN | 0x17)
+#define ED_NET_CLOSE_ERROR                  (ED_GN | 0x18)
+#define ED_NET_NO_MORE_PACKET               (ED_GN | 0x19)
+#define ED_NET_NO_MORE_BUFFER               (ED_GN | 0x1A)
+#define ED_NET_SEND_ERROR                   (ED_GN | 0x1B)
+#define ED_NET_RECEIVE_ERROR                (ED_GN | 0x1C)
+#define ED_NET_WRONG_MSG_SIZE               (ED_GN | 0x1D)
+#define ED_NET_WAIT_ERROR                   (ED_GN | 0x1E)
+#define ED_NET_EEPROM_ERROR                 (ED_GN | 0x1F)
+#define ED_INVALID_RS232_COM_NUMBER         (ED_GN | 0x20)
+#define ED_INVALID_RS232_INIT               (ED_GN | 0x21)
+#define ED_FILE_ERROR                       (ED_GN | 0x22)
+#define ED_INVALID_GPIO_CMD                 (ED_GN | 0x23)
+#define ED_RS232_ALREADY_OPENED             (ED_GN | 0x24)
+#define ED_RS232_NOT_OPENED                 (ED_GN | 0x25)
+#define ED_GPIO_ALREADY_OPENED              (ED_GN | 0x26)
+#define ED_GPIO_NOT_OPENED                  (ED_GN | 0x27)
+#define ED_REGISTRY_ERROR                   (ED_GN | 0x28) /* <- NCX */
+#define ED_INVALID_SERVICE                  (ED_GN | 0x29) /* <- NCX */
+
+#define ED_READ_FILE_ALREADY_OPENED	    (ED_GN | 0x2a) /* <- Decalage
+							    * pour RCX
+							    * (old 0x28)
+							    * */
+#define ED_READ_FILE_INVALID_COMMAND	    (ED_GN | 0x2b) /* ~ */
+#define ED_READ_FILE_INVALID_PARAMETER	    (ED_GN | 0x2c) /* ~ */
+#define ED_READ_FILE_ALREADY_CLOSED	    (ED_GN | 0x2d) /* ~ */
+#define ED_READ_FILE_NO_INFORMATION	    (ED_GN | 0x2e) /* ~ */
+#define ED_READ_FILE_INVALID_HANDLE	    (ED_GN | 0x2f) /* ~ */
+#define ED_READ_FILE_END_OF_FILE	    (ED_GN | 0x30) /* ~ */
+#define ED_READ_FILE_ERROR	            (ED_GN | 0x31) /* ~ */
+
+#define ED_DSP_CRASHED_EXC_DSPSTACK_OVERFLOW (ED_GN | 0x32) /* <- Decalage=
 pour
+							     * PCX (old 0x14) */
+#define ED_DSP_CRASHED_EXC_SYSSTACK_OVERFLOW (ED_GN | 0x33) /* ~ */
+#define ED_DSP_CRASHED_EXC_ILLEGAL           (ED_GN | 0x34) /* ~ */
+#define ED_DSP_CRASHED_EXC_TIMER_REENTRY     (ED_GN | 0x35) /* ~ */
+#define ED_DSP_CRASHED_EXC_FATAL_ERROR       (ED_GN | 0x36) /* ~ */
+
+#define ED_FLASH_PCCARD_NOT_PRESENT          (ED_GN | 0x37)
+
+#define ED_NO_CURRENT_CLOCK                  (ED_GN | 0x38)
+
+/* Complete DRV error code for real time class */
+#define ED_RT           (ERROR_VALUE | E_SOURCE_DRV | E_CLASS_REAL_TIME_ER=
ROR)
+#define ED_DSP_TIMED_OUT                (ED_RT | 0x01)
+#define ED_DSP_CHK_TIMED_OUT            (ED_RT | 0x02)
+#define ED_STREAM_OVERRUN               (ED_RT | 0x03)
+#define ED_DSP_BUSY                     (ED_RT | 0x04)
+#define ED_DSP_SEMAPHORE_TIME_OUT       (ED_RT | 0x05)
+#define ED_BOARD_TIME_OUT               (ED_RT | 0x06)
+#define ED_XILINX_ERROR                 (ED_RT | 0x07)
+#define ED_COBRANET_ITF_NOT_RESPONDING  (ED_RT | 0x08)
+
+/* Complete BOARD error code for the invaid standard object class */
+#define EB_ISO          (ERROR_VALUE | E_SOURCE_BOARD | \
+			 E_CLASS_INVALID_STD_OBJECT)
+#define EB_INVALID_EFFECT               (EB_ISO | 0x00)
+#define EB_INVALID_PIPE                 (EB_ISO | 0x40)
+#define EB_INVALID_STREAM               (EB_ISO | 0x80)
+#define EB_INVALID_AUDIO                (EB_ISO | 0xC0)
+
+/* Complete BOARD error code for impossible resource allocation class */
+#define EB_RI           (ERROR_VALUE | E_SOURCE_BOARD | E_CLASS_RSRC_IMPOS=
SIBLE)
+#define EB_ALLOCATE_ALL_STREAM_TRANSFERT_BUFFERS_IMPOSSIBLE (EB_RI | 0x01)
+#define EB_ALLOCATE_PIPE_SAMPLE_BUFFER_IMPOSSIBLE           (EB_RI | 0x02)
+
+#define EB_ALLOCATE_MEM_STREAM_IMPOSSIBLE		\
+	EB_ALLOCATE_ALL_STREAM_TRANSFERT_BUFFERS_IMPOSSIBLE
+#define EB_ALLOCATE_MEM_PIPE_IMPOSSIBLE			\
+	EB_ALLOCATE_PIPE_SAMPLE_BUFFER_IMPOSSIBLE
+
+#define EB_ALLOCATE_DIFFERED_CMD_IMPOSSIBLE     (EB_RI | 0x03)
+#define EB_TOO_MANY_DIFFERED_CMD                (EB_RI | 0x04)
+#define EB_RBUFFERS_TABLE_OVERFLOW              (EB_RI | 0x05)
+#define EB_ALLOCATE_EFFECTS_IMPOSSIBLE          (EB_RI | 0x08)
+#define EB_ALLOCATE_EFFECT_POS_IMPOSSIBLE       (EB_RI | 0x09)
+#define EB_RBUFFER_NOT_AVAILABLE                (EB_RI | 0x0A)
+#define EB_ALLOCATE_CONTEXT_LIII_IMPOSSIBLE     (EB_RI | 0x0B)
+#define EB_STATUS_DIALOG_IMPOSSIBLE             (EB_RI | 0x1D)
+#define EB_CONTROL_CMD_IMPOSSIBLE               (EB_RI | 0x1E)
+#define EB_STATUS_SEND_IMPOSSIBLE               (EB_RI | 0x1F)
+#define EB_ALLOCATE_PIPE_IMPOSSIBLE             (EB_RI | 0x40)
+#define EB_ALLOCATE_STREAM_IMPOSSIBLE           (EB_RI | 0x80)
+#define EB_ALLOCATE_AUDIO_IMPOSSIBLE            (EB_RI | 0xC0)
+
+/* Complete BOARD error code for wrong call context class */
+#define EB_WCC          (ERROR_VALUE | E_SOURCE_BOARD | E_CLASS_WRONG_CONT=
EXT)
+#define EB_CMD_REFUSED                  (EB_WCC | 0x00)
+#define EB_START_STREAM_REFUSED         (EB_WCC | 0xFC)
+#define EB_SPC_REFUSED                  (EB_WCC | 0xFD)
+#define EB_CSN_REFUSED                  (EB_WCC | 0xFE)
+#define EB_CSE_REFUSED                  (EB_WCC | 0xFF)
+
+
+
+
+#endif /* LX_DEFS_H */
--=20
1.6.2.1

--Sig_/kKrIrSnRrSCIMpQiGFNabM1
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknIwvMACgkQdL+4qsZfVsuAmQCeMAtqCYEScUhJx4xXm3MNzYT8
50kAn1jQjCj+gepGDlXmNYZtworSXt4L
=uBzi
-----END PGP SIGNATURE-----

--Sig_/kKrIrSnRrSCIMpQiGFNabM1--

--===============9074870689998400308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============9074870689998400308==--
