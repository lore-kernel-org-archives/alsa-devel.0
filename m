From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH1/2] hda: digital pc-beep support hd-audio
	codecs.
Date: Fri, 18 Jul 2008 09:20:44 -0400
Message-ID: <488098AC.2090405@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id CBDEC244E2
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 15:21:00 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Added digital pc-beep support using linear tone generation for hd-codecs along
with initial support for several IDT codecs.

---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

diff --git a/pci/Kconfig b/pci/Kconfig
index 8fe5dac..c14cc6b 100644
--- a/pci/Kconfig
+++ b/pci/Kconfig
@@ -517,6 +517,14 @@ config SND_HDA_HWDEP
 	  This interface can be used for out-of-band communication
 	  with codecs for debugging purposes.

+config SND_HDA_INPUT_BEEP
+	bool "Support digital beep via input layer"
+	depends on SND_HDA_INTEL
+	depends on INPUT=y || INPUT=SND_HDA_INTEL
+	help
+	  Say Y here to build a digital beep interface for HD-audio
+	  driver. This interface is used to generate digital beeps.
+
 config SND_HDA_CODEC_REALTEK
 	bool "Build Realtek HD-audio codec support"
 	depends on SND_HDA_INTEL
diff --git a/pci/hda/Makefile b/pci/hda/Makefile
index ab0c726..6db92fd 100644
--- a/pci/hda/Makefile
+++ b/pci/hda/Makefile
@@ -5,6 +5,7 @@ snd-hda-intel-y := hda_intel.o
 snd-hda-intel-y += hda_codec.o
 snd-hda-intel-$(CONFIG_PROC_FS) += hda_proc.o
 snd-hda-intel-$(CONFIG_SND_HDA_HWDEP) += hda_hwdep.o
+snd-hda-intel-$(CONFIG_SND_HDA_INPUT_BEEP) += hda_beep.o
 snd-hda-intel-$(CONFIG_SND_HDA_GENERIC) += hda_generic.o
 snd-hda-intel-$(CONFIG_SND_HDA_CODEC_REALTEK) += patch_realtek.o
 snd-hda-intel-$(CONFIG_SND_HDA_CODEC_CMEDIA) += patch_cmedia.o
diff --git a/pci/hda/hda_beep.c b/pci/hda/hda_beep.c
new file mode 100644
index 0000000..5a764c4
--- /dev/null
+++ b/pci/hda/hda_beep.c
@@ -0,0 +1,134 @@
+/*
+ * Digital Beep Input Interface for HD-audio codec
+ *
+ * Author: Matthew Ranostay <mranostay@embeddedalley.com>
+ * Copyright (c) 2008 Embedded Alley Solutions Inc
+ *
+ *  This driver is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This driver is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/input.h>
+#include <linux/pci.h>
+#include <linux/workqueue.h>
+#include <sound/core.h>
+#include "hda_beep.h"
+
+enum {
+	DIGBEEP_HZ_STEP = 46875,	/* 46.875 Hz */
+	DIGBEEP_HZ_MIN = 93750,		/* 93.750 Hz */
+	DIGBEEP_HZ_MAX = 12000000,	/* 12 KHz */
+};
+
+static void snd_hda_generate_beep(struct work_struct *work)
+{
+	struct hda_beep *beep =
+		container_of(work, struct hda_beep, beep_work);
+	struct hda_codec *codec = beep->codec;
+
+	/* generate tone */
+	snd_hda_codec_write_cache(codec, beep->nid, 0,
+			AC_VERB_SET_BEEP_CONTROL, beep->tone);
+}
+
+static int snd_hda_beep_event(struct input_dev *dev, unsigned int type,
+				unsigned int code, int hz)
+{
+	struct hda_beep *beep = input_get_drvdata(dev);
+
+	switch (code) {
+	case SND_BELL:
+		if (hz)
+			hz = 1000;
+	case SND_TONE:
+		hz *= 1000; /* fixed point */
+		hz = hz - DIGBEEP_HZ_MIN;
+		if (hz < 0)
+			hz = 0; /* turn off PC beep*/
+		else if (hz >= (DIGBEEP_HZ_MAX - DIGBEEP_HZ_MIN))
+			hz = 0xff;
+		else {
+			hz /= DIGBEEP_HZ_STEP;
+			hz++;
+		}
+		break;
+	default:
+		return -1;
+	}
+	beep->tone = hz;
+
+	/* schedule beep event */
+	schedule_work(&beep->beep_work);
+	return 0;
+}
+
+int snd_hda_attach_beep_device(struct hda_codec *codec, int nid)
+{
+	struct input_dev *input_dev;
+	struct hda_beep *beep;
+	int err;
+
+	beep = kzalloc(sizeof(*beep), GFP_KERNEL);
+	if (beep == NULL)
+		return -ENOMEM;
+	snprintf(beep->phys, sizeof(beep->phys),
+		"card%d/codec#%d/beep0", codec->bus->card->number, codec->addr);
+	input_dev = input_allocate_device();
+
+	/* setup digital beep device */
+	input_dev->name = "HDA Digital PCBeep";
+	input_dev->phys = beep->phys;
+	input_dev->id.bustype = BUS_PCI;
+
+	input_dev->id.vendor = codec->vendor_id >> 16;
+	input_dev->id.product = codec->vendor_id & 0xffff;
+	input_dev->id.version = 0x01;
+
+	input_dev->evbit[0] = BIT_MASK(EV_SND);
+	input_dev->sndbit[0] = BIT_MASK(SND_BELL) | BIT_MASK(SND_TONE);
+	input_dev->event = snd_hda_beep_event;
+	input_dev->dev.parent = &codec->bus->pci->dev;
+	input_set_drvdata(input_dev, beep);
+
+	err = input_register_device(input_dev);
+	if (err < 0) {
+		kfree(input_dev);
+		kfree(beep);
+		return err;
+	}
+
+	/* enable linear scale */
+	snd_hda_codec_write(codec, nid, 0,
+		AC_VERB_SET_DIGI_CONVERT_2, 0x01);
+
+	beep->nid = nid;
+	beep->dev = input_dev;
+	beep->codec = codec;
+	codec->beep = beep;
+
+	INIT_WORK(&beep->beep_work, &snd_hda_generate_beep);
+	return 0;
+}
+
+void snd_hda_detach_beep_device(struct hda_codec *codec)
+{
+	struct hda_beep *beep = codec->beep;
+	if (beep) {
+		cancel_work_sync(&beep->beep_work);
+		flush_scheduled_work();
+
+		input_unregister_device(beep->dev);
+		kfree(beep);
+	}
+}
diff --git a/pci/hda/hda_beep.h b/pci/hda/hda_beep.h
new file mode 100644
index 0000000..de4036e
--- /dev/null
+++ b/pci/hda/hda_beep.h
@@ -0,0 +1,44 @@
+/*
+ * Digital Beep Input Interface for HD-audio codec
+ *
+ * Author: Matthew Ranostay <mranostay@embeddedalley.com>
+ * Copyright (c) 2008 Embedded Alley Solutions Inc
+ *
+ *  This driver is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This driver is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#ifndef __SOUND_HDA_BEEP_H
+#define __SOUND_HDA_BEEP_H
+
+#include "hda_codec.h"
+
+/* beep information */
+struct hda_beep {
+	struct input_dev *dev;
+	struct hda_codec *codec;
+	char phys[32];
+	int tone;
+	int nid;
+	struct work_struct beep_work; /* scheduled task for beep event */
+};
+
+#ifdef CONFIG_SND_HDA_INPUT_BEEP
+int snd_hda_attach_beep_device(struct hda_codec *codec, int nid);
+void snd_hda_detach_beep_device(struct hda_codec *codec);
+#else
+#define snd_hda_attach_beep_device(...)
+#define snd_hda_detach_beep_device(...)
+#endif
+#endif
diff --git a/pci/hda/hda_codec.h b/pci/hda/hda_codec.h
index efc6828..3a63c44 100644
--- a/pci/hda/hda_codec.h
+++ b/pci/hda/hda_codec.h
@@ -449,6 +449,7 @@ enum {
  */

 struct hda_bus;
+struct hda_beep;
 struct hda_codec;
 struct hda_pcm;
 struct hda_pcm_stream;
@@ -634,6 +635,9 @@ struct hda_codec {
 	/* codec specific info */
 	void *spec;

+	/* beep device */
+	struct hda_beep *beep;
+
 	/* widget capabilities cache */
 	unsigned int num_nodes;
 	hda_nid_t start_nid;
diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index 08cb77f..d11fd1a 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -33,6 +33,7 @@
 #include "hda_codec.h"
 #include "hda_local.h"
 #include "hda_patch.h"
+#include "hda_beep.h"

 #define NUM_CONTROL_ALLOC	32
 #define STAC_PWR_EVENT		0x20
@@ -161,6 +162,8 @@ struct sigmatel_spec {
 	unsigned int num_dmuxes;
 	hda_nid_t dig_in_nid;
 	hda_nid_t mono_nid;
+	hda_nid_t anabeep_nid;
+	hda_nid_t digbeep_nid;

 	/* pin widgets */
 	hda_nid_t *pin_nids;
@@ -686,6 +689,8 @@ static struct hda_verb d965_core_init[] = {
 static struct hda_verb stac927x_core_init[] = {
 	/* set master volume and direct control */	
 	{ 0x24, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
+	/* enable analog pc beep path */
+	{ 0x01, AC_VERB_SET_DIGI_CONVERT_2, 1 << 5},
 	{}
 };

@@ -825,8 +830,11 @@ static struct snd_kcontrol_new stac92hd71bxx_analog_mixer[] = {
 	HDA_CODEC_MUTE_IDX("Capture Switch", 0x1, 0x1d, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_IDX("Capture Mux Volume", 0x1, 0x1b, 0x0, HDA_OUTPUT),

+	/* analog pc-beep replaced with digital beep support */
+	/*
 	HDA_CODEC_VOLUME("PC Beep Volume", 0x17, 0x2, HDA_INPUT),
 	HDA_CODEC_MUTE("PC Beep Switch", 0x17, 0x2, HDA_INPUT),
+	*/

 	HDA_CODEC_MUTE("Analog Loopback 1", 0x17, 0x3, HDA_INPUT),
 	HDA_CODEC_MUTE("Analog Loopback 2", 0x17, 0x4, HDA_INPUT),
@@ -2603,6 +2611,34 @@ static int stac92xx_auto_create_mono_output_ctls(struct
hda_codec *codec)
 				"Mono Mux", spec->mono_nid);
 }

+/* create PC beep volume controls */
+static int stac92xx_auto_create_beep_ctls(struct hda_codec *codec,
+						hda_nid_t nid)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	u32 caps = query_amp_caps(codec, nid, HDA_OUTPUT);
+	int err;
+
+	/* check for mute support for the the amp */
+	if ((caps & AC_AMPCAP_MUTE) >> AC_AMPCAP_MUTE_SHIFT) {
+		err = stac92xx_add_control(spec, STAC_CTL_WIDGET_MUTE,
+			"PC Beep Playback Switch",
+			HDA_COMPOSE_AMP_VAL(nid, 1, 0, HDA_OUTPUT));
+			if (err < 0)
+				return err;
+	}
+
+	/* check to see if there is volume support for the amp */
+	if ((caps & AC_AMPCAP_NUM_STEPS) >> AC_AMPCAP_NUM_STEPS_SHIFT) {
+		err = stac92xx_add_control(spec, STAC_CTL_WIDGET_VOL,
+			"PC Beep Playback Volume",
+			HDA_COMPOSE_AMP_VAL(nid, 1, 0, HDA_OUTPUT));
+			if (err < 0)
+				return err;
+	}
+	return 0;
+}
+
 /* labels for dmic mux inputs */
 static const char *stac92xx_dmic_labels[5] = {
 	"Analog Inputs", "Digital Mic 1", "Digital Mic 2",
@@ -2838,6 +2874,28 @@ static int stac92xx_parse_auto_config(struct hda_codec
*codec, hda_nid_t dig_out
 	if (err < 0)
 		return err;

+	/* setup analog beep controls */
+	if (spec->anabeep_nid > 0) {
+		err = stac92xx_auto_create_beep_ctls(codec,
+			spec->anabeep_nid);
+		if (err < 0)
+			return err;
+	}
+
+	/* setup digital beep controls and input device */
+#ifdef CONFIG_SND_HDA_INPUT_BEEP
+	if (spec->digbeep_nid > 0) {
+		hda_nid_t nid = spec->digbeep_nid;
+
+		err = stac92xx_auto_create_beep_ctls(codec, nid);
+		if (err < 0)
+			return err;
+		err = snd_hda_attach_beep_device(codec, nid);
+		if (err < 0)
+			return err;
+	}
+#endif
+
 	if (hp_speaker_swap == 1) {
 		/* Restore the hp_outs and line_outs */
 		memcpy(spec->autocfg.hp_pins, spec->autocfg.line_out_pins,
@@ -3152,6 +3210,7 @@ static void stac92xx_free(struct hda_codec *codec)
 		kfree(spec->bios_pin_configs);

 	kfree(spec);
+	snd_hda_detach_beep_device(codec);
 }

 static void stac92xx_set_pinctl(struct hda_codec *codec, hda_nid_t nid,
@@ -3540,6 +3599,7 @@ again:
 	spec->aloopback_mask = 0x01;
 	spec->aloopback_shift = 8;

+	spec->digbeep_nid = 0x1c;
 	spec->mux_nids = stac92hd73xx_mux_nids;
 	spec->adc_nids = stac92hd73xx_adc_nids;
 	spec->dmic_nids = stac92hd73xx_dmic_nids;
@@ -3674,6 +3734,7 @@ again:
 	spec->gpio_dir = 0x01;
 	spec->gpio_data = 0x01;

+	spec->digbeep_nid = 0x26;
 	spec->mux_nids = stac92hd71bxx_mux_nids;
 	spec->adc_nids = stac92hd71bxx_adc_nids;
 	spec->dmic_nids = stac92hd71bxx_dmic_nids;
@@ -3845,6 +3906,7 @@ static int patch_stac927x(struct hda_codec *codec)
 		stac92xx_set_config_regs(codec);
 	}

+	spec->digbeep_nid = 0x23;
 	spec->adc_nids = stac927x_adc_nids;
 	spec->num_adcs = ARRAY_SIZE(stac927x_adc_nids);
 	spec->mux_nids = stac927x_mux_nids;
@@ -3965,6 +4027,7 @@ static int patch_stac9205(struct hda_codec *codec)
 		stac92xx_set_config_regs(codec);
 	}

+	spec->digbeep_nid = 0x23;
 	spec->adc_nids = stac9205_adc_nids;
 	spec->num_adcs = ARRAY_SIZE(stac9205_adc_nids);
 	spec->mux_nids = stac9205_mux_nids;
