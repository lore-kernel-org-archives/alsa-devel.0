From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [HDA patch] support for Si3054/5 HDA modems
Date: Wed, 10 Aug 2005 22:47:45 +0300
Message-ID: <20050810194745.GE20213@sashak.softier.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de, perex@suse.cz
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

This patch adds support for Si3054/5 HDA modem codecs.

Sasha.


Support for Si3054/5 HDA modem codecs.

Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>

Index: alsa-kernel/pci/hda/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/Makefile,v
retrieving revision 1.3
diff -u -p -u -p -r1.3 Makefile
--- alsa-kernel/pci/hda/Makefile	13 Apr 2005 13:45:30 -0000	1.3
+++ alsa-kernel/pci/hda/Makefile	10 Aug 2005 18:19:20 -0000
@@ -1,5 +1,5 @@
 snd-hda-intel-objs := hda_intel.o
-snd-hda-codec-objs := hda_codec.o hda_generic.o patch_realtek.o patch_cmedia.o patch_analog.o patch_sigmatel.o
+snd-hda-codec-objs := hda_codec.o hda_generic.o patch_realtek.o patch_cmedia.o patch_analog.o patch_sigmatel.o patch_si3054.o
 ifdef CONFIG_PROC_FS
 snd-hda-codec-objs += hda_proc.o
 endif
Index: alsa-kernel/pci/hda/hda_patch.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/hda_patch.h,v
retrieving revision 1.3
diff -u -p -u -p -r1.3 hda_patch.h
--- alsa-kernel/pci/hda/hda_patch.h	13 Apr 2005 13:45:31 -0000	1.3
+++ alsa-kernel/pci/hda/hda_patch.h	10 Aug 2005 18:19:20 -0000
@@ -10,11 +10,14 @@ extern struct hda_codec_preset snd_hda_p
 extern struct hda_codec_preset snd_hda_preset_analog[];
 /* SigmaTel codecs */
 extern struct hda_codec_preset snd_hda_preset_sigmatel[];
+/* SiLabs 3054/3055 modem codecs */
+extern struct hda_codec_preset snd_hda_preset_si3054[];
 
 static const struct hda_codec_preset *hda_preset_tables[] = {
 	snd_hda_preset_realtek,
 	snd_hda_preset_cmedia,
 	snd_hda_preset_analog,
 	snd_hda_preset_sigmatel,
+	snd_hda_preset_si3054,
 	NULL
 };
Index: alsa-kernel/pci/hda/patch_si3054.c
===================================================================
RCS file: alsa-kernel/pci/hda/patch_si3054.c
diff -N alsa-kernel/pci/hda/patch_si3054.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ alsa-kernel/pci/hda/patch_si3054.c	10 Aug 2005 18:19:20 -0000
@@ -0,0 +1,300 @@
+/*
+ * Universal Interface for Intel High Definition Audio Codec
+ *
+ * HD audio interface patch for Silicon Labs 3054/5 modem codec
+ *
+ * Copyright (c) 2005 Sasha Khapyorsky <sashak@smlink.com>
+ *                    Takashi Iwai <tiwai@suse.de>
+ *
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
+#include <sound/driver.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <sound/core.h>
+#include "hda_codec.h"
+#include "hda_local.h"
+
+
+/* si3054 verbs */
+#define SI3054_VERB_READ_NODE  0x900
+#define SI3054_VERB_WRITE_NODE 0x100
+
+/* si3054 nodes (registers) */
+#define SI3054_EXTENDED_MID    2
+#define SI3054_LINE_RATE       3
+#define SI3054_LINE_LEVEL      4
+#define SI3054_GPIO_CFG        5
+#define SI3054_GPIO_POLARITY   6
+#define SI3054_GPIO_STICKY     7
+#define SI3054_GPIO_WAKEUP     8
+#define SI3054_GPIO_STATUS     9
+#define SI3054_GPIO_CONTROL   10
+#define SI3054_MISC_AFE       11
+#define SI3054_CHIPID         12
+#define SI3054_LINE_CFG1      13
+#define SI3054_LINE_STATUS    14
+#define SI3054_DC_TERMINATION 15
+#define SI3054_LINE_CONFIG    16
+#define SI3054_CALLPROG_ATT   17
+#define SI3054_SQ_CONTROL     18
+#define SI3054_MISC_CONTROL   19
+#define SI3054_RING_CTRL1     20
+#define SI3054_RING_CTRL2     21
+
+/* extended MID */
+#define SI3054_MEI_READY 0xf
+
+/* line level */
+#define SI3054_ATAG_MASK 0x00f0
+#define SI3054_DTAG_MASK 0xf000
+
+/* GPIO bits */
+#define SI3054_GPIO_OH    0x0001
+#define SI3054_GPIO_CID   0x0002
+
+/* chipid and revisions */
+#define SI3054_CHIPID_CODEC_REV_MASK 0x000f
+#define SI3054_CHIPID_DAA_REV_MASK   0x00f0
+#define SI3054_CHIPID_INTERNATIONAL  0x0100
+#define SI3054_CHIPID_DAA_ID         0x0f00
+#define SI3054_CHIPID_CODEC_ID      (1<<12)
+
+/* si3054 codec registers (nodes) access macros */
+#define GET_REG(codec,reg) (snd_hda_codec_read(codec,reg,0,SI3054_VERB_READ_NODE,0))
+#define SET_REG(codec,reg,val) (snd_hda_codec_write(codec,reg,0,SI3054_VERB_WRITE_NODE,val))
+
+
+struct si3054_spec {
+	unsigned international;
+	struct hda_pcm pcm;
+};
+
+
+/*
+ * Modem mixer
+ */
+
+#define PRIVATE_VALUE(reg,mask) ((reg<<16)|(mask&0xffff))
+#define PRIVATE_REG(val) ((val>>16)&0xffff)
+#define PRIVATE_MASK(val) (val&0xffff)
+
+static int si3054_switch_info(snd_kcontrol_t *kcontrol,
+		               snd_ctl_elem_info_t *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int si3054_switch_get(snd_kcontrol_t *kcontrol,
+		               snd_ctl_elem_value_t *uvalue)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	u16 reg  = PRIVATE_REG(kcontrol->private_value);
+	u16 mask = PRIVATE_MASK(kcontrol->private_value);
+	uvalue->value.integer.value[0] = (GET_REG(codec, reg)) & mask ? 1 : 0 ;
+	return 0;
+}
+
+static int si3054_switch_put(snd_kcontrol_t *kcontrol,
+		               snd_ctl_elem_value_t *uvalue)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	u16 reg  = PRIVATE_REG(kcontrol->private_value);
+	u16 mask = PRIVATE_MASK(kcontrol->private_value);
+	if (uvalue->value.integer.value[0])
+		SET_REG(codec, reg, (GET_REG(codec, reg)) | mask);
+	else
+		SET_REG(codec, reg, (GET_REG(codec, reg)) & ~mask);
+	return 0;
+}
+
+#define SI3054_KCONTROL(kname,reg,mask) { \
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
+	.name = kname, \
+	.info = si3054_switch_info, \
+	.get  = si3054_switch_get, \
+	.put  = si3054_switch_put, \
+	.private_value = PRIVATE_VALUE(reg,mask), \
+}
+		
+
+static snd_kcontrol_new_t si3054_modem_mixer[] = {
+	SI3054_KCONTROL("Off-hook Switch", SI3054_GPIO_CONTROL, SI3054_GPIO_OH),
+	SI3054_KCONTROL("Caller ID Switch", SI3054_GPIO_CONTROL, SI3054_GPIO_CID),
+	{}
+};
+
+static int si3054_build_controls(struct hda_codec *codec)
+{
+	return snd_hda_add_new_ctls(codec, si3054_modem_mixer);
+}
+
+
+/*
+ * PCM callbacks
+ */
+
+static int si3054_pcm_prepare(struct hda_pcm_stream *hinfo,
+			      struct hda_codec *codec,
+			      unsigned int stream_tag,
+			      unsigned int format,
+			      snd_pcm_substream_t *substream)
+{
+	u16 val;
+
+	SET_REG(codec, SI3054_LINE_RATE, substream->runtime->rate);
+	val = GET_REG(codec, SI3054_LINE_LEVEL);
+	val &= 0xff << (8 * (substream->stream != SNDRV_PCM_STREAM_PLAYBACK));
+	val |= ((stream_tag & 0xf) << 4) << (8 * (substream->stream == SNDRV_PCM_STREAM_PLAYBACK));
+	SET_REG(codec, SI3054_LINE_LEVEL, val);
+
+	snd_hda_codec_setup_stream(codec, hinfo->nid,
+				   stream_tag, 0, format);
+	return 0;
+}
+
+static int si3054_pcm_open(struct hda_pcm_stream *hinfo,
+			   struct hda_codec *codec,
+			    snd_pcm_substream_t *substream)
+{
+	static unsigned int rates[] = { 8000, 9600, 16000 };
+	static snd_pcm_hw_constraint_list_t hw_constraints_rates = {
+		.count = ARRAY_SIZE(rates),
+		.list = rates,
+		.mask = 0,
+	};
+	substream->runtime->hw.period_bytes_min = 80;
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE, &hw_constraints_rates);
+}
+
+
+static struct hda_pcm_stream si3054_pcm = {
+	.substreams = 1,
+	.channels_min = 1,
+	.channels_max = 1,
+	.nid = 0x1,
+	.rates = SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_16000|SNDRV_PCM_RATE_KNOT,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE,
+	.maxbps = 16,
+	.ops = {
+		.open = si3054_pcm_open,
+		.prepare = si3054_pcm_prepare,
+	},
+};
+
+
+static int si3054_build_pcms(struct hda_codec *codec)
+{
+	struct si3054_spec *spec = codec->spec;
+	struct hda_pcm *info = &spec->pcm;
+	si3054_pcm.nid = codec->mfg;
+	codec->num_pcms = 1;
+	codec->pcm_info = info;
+	info->name = "Si3054 Modem";
+	info->stream[SNDRV_PCM_STREAM_PLAYBACK] = si3054_pcm;
+	info->stream[SNDRV_PCM_STREAM_CAPTURE]  = si3054_pcm;
+	return 0;
+}
+
+
+/*
+ * Init part
+ */
+
+static int si3054_init(struct hda_codec *codec)
+{
+	struct si3054_spec *spec = codec->spec;
+	unsigned wait_count;
+	u16 val;
+
+	snd_hda_codec_write(codec, AC_NODE_ROOT, 0, AC_VERB_SET_CODEC_RESET, 0);
+	snd_hda_codec_write(codec, codec->mfg, 0, AC_VERB_SET_STREAM_FORMAT, 0);
+	SET_REG(codec, SI3054_LINE_RATE, 9600);
+	SET_REG(codec, SI3054_LINE_LEVEL, SI3054_DTAG_MASK|SI3054_ATAG_MASK);
+	SET_REG(codec, SI3054_EXTENDED_MID, 0);
+
+	wait_count = 10;
+	do {
+		msleep(2);
+		val = GET_REG(codec, SI3054_EXTENDED_MID);
+	} while ((val & SI3054_MEI_READY) != SI3054_MEI_READY && wait_count--);
+
+	if((val&SI3054_MEI_READY) != SI3054_MEI_READY) {
+		snd_printk(KERN_ERR "si3054: cannot initialize. EXT MID = %04x\n", val);
+		return -EACCES;
+	}
+
+	SET_REG(codec, SI3054_GPIO_POLARITY, 0xffff);
+	SET_REG(codec, SI3054_GPIO_CFG, 0x0);
+	SET_REG(codec, SI3054_MISC_AFE, 0);
+	SET_REG(codec, SI3054_LINE_CFG1,0x200);
+
+	if((GET_REG(codec,SI3054_LINE_STATUS) & (1<<6)) == 0) {
+		snd_printd("Link Frame Detect(FDT) is not ready (line status: %04x)\n",
+				GET_REG(codec,SI3054_LINE_STATUS));
+	}
+
+	spec->international = GET_REG(codec, SI3054_CHIPID) & SI3054_CHIPID_INTERNATIONAL;
+
+	return 0;
+}
+
+static void si3054_free(struct hda_codec *codec)
+{
+	kfree(codec->spec);
+}
+
+
+/*
+ */
+
+static struct hda_codec_ops si3054_patch_ops = {
+	.build_controls = si3054_build_controls,
+	.build_pcms = si3054_build_pcms,
+	.init = si3054_init,
+	.free = si3054_free,
+#ifdef CONFIG_PM
+	//.suspend = si3054_suspend,
+	.resume = si3054_init,
+#endif
+};
+
+static int patch_si3054(struct hda_codec *codec)
+{
+	struct si3054_spec *spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	if (spec == NULL)
+		return -ENOMEM;
+	codec->spec = spec;
+	codec->patch_ops = si3054_patch_ops;
+	return 0;
+}
+
+/*
+ * patch entries
+ */
+struct hda_codec_preset snd_hda_preset_si3054[] = {
+ 	{ .id = 0x163c3155, .name = "Si3054", .patch = patch_si3054 },
+	{}
+};
+
Index: alsa-driver/pci/hda/patch_si3054.c
===================================================================
RCS file: alsa-driver/pci/hda/patch_si3054.c
diff -N alsa-driver/pci/hda/patch_si3054.c
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ alsa-driver/pci/hda/patch_si3054.c	10 Aug 2005 18:19:20 -0000
@@ -0,0 +1,2 @@
+#define __NO_VERSION__
+#include "../../alsa-kernel/pci/hda/patch_si3054.c"


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
