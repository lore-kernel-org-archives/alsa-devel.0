From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 10/24] sound/pci: coding style fixes: hda
Date: Tue, 9 Sep 2008 05:53:02 +0400
Message-ID: <20080909015302.GM6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id E2B17103800
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 03:53:08 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1535746fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 18:53:08 -0700 (PDT)
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
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



- <asm/io.h> -> <linux/io.h>
- remove trailing whitespaces
- convert comments

Only compile tested.

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/pci/hda/hda_codec.c      |   12 ++--
 sound/pci/hda/hda_codec.h      |   10 ++--
 sound/pci/hda/hda_generic.c    |   58 +++++++++---------
 sound/pci/hda/hda_hwdep.c      |    2 +-
 sound/pci/hda/hda_intel.c      |   18 +++---
 sound/pci/hda/hda_proc.c       |    8 +-
 sound/pci/hda/patch_analog.c   |   22 ++++----
 sound/pci/hda/patch_cmedia.c   |    2 +-
 sound/pci/hda/patch_conexant.c |   22 ++++----
 sound/pci/hda/patch_realtek.c  |    6 +-
 sound/pci/hda/patch_si3054.c   |    8 +-
 sound/pci/hda/patch_sigmatel.c |  130 ++++++++++++++++++++--------------------
 sound/pci/hda/patch_via.c      |   34 +++++-----
 13 files changed, 166 insertions(+), 166 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 696d77e..f58c351 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1123,7 +1123,7 @@ int snd_hda_add_vmaster(struct hda_codec *codec, char *name,
 	err = snd_ctl_add(codec->bus->card, kctl);
 	if (err < 0)
 		return err;
-	
+
 	for (s = slaves; *s; s++) {
 		struct snd_kcontrol *sctl;
 
@@ -2832,7 +2832,7 @@ static void sort_pins_by_sequence(hda_nid_t * pins, short * sequences,
 	int i, j;
 	short seq;
 	hda_nid_t nid;
-	
+
 	for (i = 0; i < num_pins; i++) {
 		for (j = i + 1; j < num_pins; j++) {
 			if (sequences[i] > sequences[j]) {
@@ -2860,7 +2860,7 @@ static void sort_pins_by_sequence(hda_nid_t * pins, short * sequences,
  * is detected, one of speaker of HP pins is assigned as the primary
  * output, i.e. to line_out_pins[0].  So, line_outs is always positive
  * if any analog output exists.
- * 
+ *
  * The analog input pins are assigned to input_pins array.
  * The digital input/output pins are assigned to dig_in_pin and dig_out_pin,
  * respectively.
@@ -2925,9 +2925,9 @@ int snd_hda_parse_pin_def_config(struct hda_codec *codec,
 		case AC_JACK_SPEAKER:
 			seq = get_defcfg_sequence(def_conf);
 			assoc = get_defcfg_association(def_conf);
-			if (! assoc)
+			if (!assoc)
 				continue;
-			if (! assoc_speaker)
+			if (!assoc_speaker)
 				assoc_speaker = assoc;
 			else if (assoc_speaker != assoc)
 				continue;
@@ -3013,7 +3013,7 @@ int snd_hda_parse_pin_def_config(struct hda_codec *codec,
 			      cfg->speaker_outs);
 	sort_pins_by_sequence(cfg->hp_pins, sequences_hp,
 			      cfg->hp_outs);
-	
+
 	/* if we have only one mic, make it AUTO_PIN_MIC */
 	if (!cfg->input_pins[AUTO_PIN_MIC] &&
 	    cfg->input_pins[AUTO_PIN_FRONT_MIC]) {
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 60468f5..5dda6af 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -42,7 +42,7 @@ enum {
 	AC_GRP_AUDIO_FUNCTION = 0x01,
 	AC_GRP_MODEM_FUNCTION = 0x02,
 };
-	
+
 /*
  * widget types
  */
@@ -306,15 +306,15 @@ enum {
 #define AC_KNBCAP_DELTA			(1<<7)
 
 /* HDMI LPCM capabilities */
-#define AC_LPCMCAP_48K_CP_CHNS		(0x0f<<0) /* max channels w/ CP-on */	
+#define AC_LPCMCAP_48K_CP_CHNS		(0x0f<<0) /* max channels w/ CP-on */
 #define AC_LPCMCAP_48K_NO_CHNS		(0x0f<<4) /* max channels w/o CP-on */
 #define AC_LPCMCAP_48K_20BIT		(1<<8)	/* 20b bitrate supported */
 #define AC_LPCMCAP_48K_24BIT		(1<<9)	/* 24b bitrate supported */
-#define AC_LPCMCAP_96K_CP_CHNS		(0x0f<<10) /* max channels w/ CP-on */	
+#define AC_LPCMCAP_96K_CP_CHNS		(0x0f<<10) /* max channels w/ CP-on */
 #define AC_LPCMCAP_96K_NO_CHNS		(0x0f<<14) /* max channels w/o CP-on */
 #define AC_LPCMCAP_96K_20BIT		(1<<18)	/* 20b bitrate supported */
 #define AC_LPCMCAP_96K_24BIT		(1<<19)	/* 24b bitrate supported */
-#define AC_LPCMCAP_192K_CP_CHNS		(0x0f<<20) /* max channels w/ CP-on */	
+#define AC_LPCMCAP_192K_CP_CHNS		(0x0f<<20) /* max channels w/ CP-on */
 #define AC_LPCMCAP_192K_NO_CHNS		(0x0f<<24) /* max channels w/o CP-on */
 #define AC_LPCMCAP_192K_20BIT		(1<<28)	/* 20b bitrate supported */
 #define AC_LPCMCAP_192K_24BIT		(1<<29)	/* 24b bitrate supported */
@@ -603,7 +603,7 @@ struct hda_codec_preset {
 	const char *name;
 	int (*patch)(struct hda_codec *codec);
 };
-	
+
 /* ops set by the preset patch */
 struct hda_codec_ops {
 	int (*build_controls)(struct hda_codec *codec);
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 0ca3089..1a57399 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -96,7 +96,7 @@ static void snd_hda_generic_free(struct hda_codec *codec)
 	struct hda_gspec *spec = codec->spec;
 	struct hda_gnode *node, *n;
 
-	if (! spec)
+	if (!spec)
 		return;
 	/* free all widgets */
 	list_for_each_entry_safe(node, n, &spec->nid_list, list) {
@@ -132,7 +132,7 @@ static int add_new_node(struct hda_codec *codec, struct hda_gspec *spec, hda_nid
 	else {
 		node->conn_list = kmalloc(sizeof(hda_nid_t) * nconns,
 					  GFP_KERNEL);
-		if (! node->conn_list) {
+		if (!node->conn_list) {
 			snd_printk(KERN_ERR "hda-generic: cannot malloc\n");
 			kfree(node);
 			return -ENOMEM;
@@ -152,13 +152,13 @@ static int add_new_node(struct hda_codec *codec, struct hda_gspec *spec, hda_nid
 	if (node->wid_caps & AC_WCAP_OUT_AMP) {
 		if (node->wid_caps & AC_WCAP_AMP_OVRD)
 			node->amp_out_caps = snd_hda_param_read(codec, node->nid, AC_PAR_AMP_OUT_CAP);
-		if (! node->amp_out_caps)
+		if (!node->amp_out_caps)
 			node->amp_out_caps = spec->def_amp_out_caps;
 	}
 	if (node->wid_caps & AC_WCAP_IN_AMP) {
 		if (node->wid_caps & AC_WCAP_AMP_OVRD)
 			node->amp_in_caps = snd_hda_param_read(codec, node->nid, AC_PAR_AMP_IN_CAP);
-		if (! node->amp_in_caps)
+		if (!node->amp_in_caps)
 			node->amp_in_caps = spec->def_amp_in_caps;
 	}
 	list_add_tail(&node->list, &spec->nid_list);
@@ -181,7 +181,7 @@ static int build_afg_tree(struct hda_codec *codec)
 	spec->def_amp_in_caps = snd_hda_param_read(codec, codec->afg, AC_PAR_AMP_IN_CAP);
 
 	nodes = snd_hda_get_sub_nodes(codec, codec->afg, &nid);
-	if (! nid || nodes < 0) {
+	if (!nid || nodes < 0) {
 		printk(KERN_ERR "Invalid AFG subtree\n");
 		return -EINVAL;
 	}
@@ -301,7 +301,7 @@ static int parse_output_path(struct hda_codec *codec, struct hda_gspec *spec,
 
 	for (i = 0; i < node->nconns; i++) {
 		child = hda_get_node(spec, node->conn_list[i]);
-		if (! child)
+		if (!child)
 			continue;
 		err = parse_output_path(codec, spec, child, dac_idx);
 		if (err < 0)
@@ -349,7 +349,7 @@ static struct hda_gnode *parse_output_jack(struct hda_codec *codec,
 		if (node->type != AC_WID_PIN)
 			continue;
 		/* output capable? */
-		if (! (node->pin_caps & AC_PINCAP_OUT))
+		if (!(node->pin_caps & AC_PINCAP_OUT))
 			continue;
 		if (defcfg_port_conn(node) == AC_JACK_PORT_NONE)
 			continue; /* unconnected */
@@ -360,14 +360,14 @@ static struct hda_gnode *parse_output_jack(struct hda_codec *codec,
 				continue; /* skip SPDIF */
 		} else {
 			/* output as default? */
-			if (! (node->pin_ctl & AC_PINCTL_OUT_EN))
+			if (!(node->pin_ctl & AC_PINCTL_OUT_EN))
 				continue;
 		}
 		clear_check_flags(spec);
 		err = parse_output_path(codec, spec, node, 0);
 		if (err < 0)
 			return NULL;
-		if (! err && spec->out_pin_node[0]) {
+		if (!err && spec->out_pin_node[0]) {
 			err = parse_output_path(codec, spec, node, 1);
 			if (err < 0)
 				return NULL;
@@ -412,18 +412,18 @@ static int parse_output(struct hda_codec *codec)
 	/* look for the HP-out pin */
 	node = parse_output_jack(codec, spec, AC_JACK_HP_OUT);
 	if (node) {
-		if (! spec->out_pin_node[0])
+		if (!spec->out_pin_node[0])
 			spec->out_pin_node[0] = node;
 		else
 			spec->out_pin_node[1] = node;
 	}
 
-	if (! spec->out_pin_node[0]) {
+	if (!spec->out_pin_node[0]) {
 		/* no line-out or HP pins found,
 		 * then choose for the first output pin
 		 */
 		spec->out_pin_node[0] = parse_output_jack(codec, spec, -1);
-		if (! spec->out_pin_node[0])
+		if (!spec->out_pin_node[0])
 			snd_printd("hda_generic: no proper output path found\n");
 	}
 
@@ -517,7 +517,7 @@ static int parse_adc_sub_nodes(struct hda_codec *codec, struct hda_gspec *spec,
 		for (i = 0; i < node->nconns; i++) {
 			struct hda_gnode *child;
 			child = hda_get_node(spec, node->conn_list[i]);
-			if (! child)
+			if (!child)
 				continue;
 			err = parse_adc_sub_nodes(codec, spec, child);
 			if (err < 0)
@@ -537,7 +537,7 @@ static int parse_adc_sub_nodes(struct hda_codec *codec, struct hda_gspec *spec,
 	}
 
 	/* input capable? */
-	if (! (node->pin_caps & AC_PINCAP_IN))
+	if (!(node->pin_caps & AC_PINCAP_IN))
 		return 0;
 
 	if (defcfg_port_conn(node) == AC_JACK_PORT_NONE)
@@ -554,9 +554,9 @@ static int parse_adc_sub_nodes(struct hda_codec *codec, struct hda_gspec *spec,
 	pinctl = AC_PINCTL_IN_EN;
 	/* create a proper capture source label */
 	type = get_input_type(node, &pinctl);
-	if (! type) {
+	if (!type) {
 		/* input as default? */
-		if (! (node->pin_ctl & AC_PINCTL_IN_EN))
+		if (!(node->pin_ctl & AC_PINCTL_IN_EN))
 			return 0;
 		type = "Input";
 	}
@@ -584,7 +584,7 @@ static void add_cap_src(struct hda_gspec *spec, int idx)
 	csrc = &spec->input_mux.items[num];
 	buf = spec->cap_labels[num];
 	for (ocap = 0; ocap < num; ocap++) {
-		if (! strcmp(buf, spec->cap_labels[ocap])) {
+		if (!strcmp(buf, spec->cap_labels[ocap])) {
 			/* same label already exists,
 			 * put the index number to be unique
 			 */
@@ -608,9 +608,9 @@ static int parse_input_path(struct hda_codec *codec, struct hda_gnode *adc_node)
 	snd_printdd("AUD_IN = %x\n", adc_node->nid);
 	clear_check_flags(spec);
 
-	// awk added - fixed no recording due to muted widget
+	/* awk added - fixed no recording due to muted widget */
 	unmute_input(codec, adc_node, 0);
-	
+
 	/*
 	 * check each connection of the ADC
 	 * if it reaches to a proper input PIN, add the path as the
@@ -639,7 +639,7 @@ static int parse_input_path(struct hda_codec *codec, struct hda_gnode *adc_node)
 		}
 	}
 
-	if (! spec->input_mux.num_items)
+	if (!spec->input_mux.num_items)
 		return 0; /* no input path found... */
 
 	snd_printdd("[Capture Source] NID=0x%x, #SRC=%d\n", adc_node->nid, spec->input_mux.num_items);
@@ -830,7 +830,7 @@ static int build_input_controls(struct hda_codec *codec)
 		.put = capture_source_put,
 	};
 
-	if (! adc_node || ! spec->input_mux.num_items)
+	if (!adc_node || !spec->input_mux.num_items)
 		return 0; /* not found */
 
 	spec->cur_cap_src = 0;
@@ -854,8 +854,8 @@ static int build_input_controls(struct hda_codec *codec)
 		return err;
 
 	/* no volume control? */
-	if (! (adc_node->wid_caps & AC_WCAP_IN_AMP) ||
-	    ! (adc_node->amp_in_caps & AC_AMPCAP_NUM_STEPS))
+	if (!(adc_node->wid_caps & AC_WCAP_IN_AMP) ||
+	    !(adc_node->amp_in_caps & AC_AMPCAP_NUM_STEPS))
 		return 0;
 
 	for (i = 0; i < spec->input_mux.num_items; i++) {
@@ -901,7 +901,7 @@ static int parse_loopback_path(struct hda_codec *codec, struct hda_gspec *spec,
 
 	for (i = 0; i < node->nconns; i++) {
 		struct hda_gnode *child = hda_get_node(spec, node->conn_list[i]);
-		if (! child)
+		if (!child)
 			continue;
 		err = parse_loopback_path(codec, spec, child, dest_node, type);
 		if (err < 0)
@@ -938,14 +938,14 @@ static int build_loopback_controls(struct hda_codec *codec)
 	int err;
 	const char *type;
 
-	if (! spec->out_pin_node[0])
+	if (!spec->out_pin_node[0])
 		return 0;
 
 	list_for_each_entry(node, &spec->nid_list, list) {
 		if (node->type != AC_WID_PIN)
 			continue;
 		/* input capable? */
-		if (! (node->pin_caps & AC_PINCAP_IN))
+		if (!(node->pin_caps & AC_PINCAP_IN))
 			return 0;
 		type = get_input_type(node, NULL);
 		if (type) {
@@ -957,7 +957,7 @@ static int build_loopback_controls(struct hda_codec *codec)
 						  node, type);
 			if (err < 0)
 				return err;
-			if (! err)
+			if (!err)
 				continue;
 		}
 	}
@@ -1018,7 +1018,7 @@ static int build_generic_pcms(struct hda_codec *codec)
 	struct hda_gspec *spec = codec->spec;
 	struct hda_pcm *info = &spec->pcm_rec;
 
-	if (! spec->dac_node[0] && ! spec->adc_node) {
+	if (!spec->dac_node[0] && !spec->adc_node) {
 		snd_printd("hda_generic: no PCM found\n");
 		return 0;
 	}
@@ -1071,7 +1071,7 @@ int snd_hda_parse_generic_codec(struct hda_codec *codec)
 	struct hda_gspec *spec;
 	int err;
 
-	if(!codec->afg)
+	if (!codec->afg)
 		return 0;
 
 	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
index 6e18a42..22c44fc 100644
--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -49,7 +49,7 @@ static int get_wcap_ioctl(struct hda_codec *codec,
 			  struct hda_verb_ioctl __user *arg)
 {
 	u32 verb, res;
-	
+
 	if (get_user(verb, &arg->verb))
 		return -EFAULT;
 	res = get_wcaps(codec, verb >> 24);
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 60cc44a..3448c42 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -31,10 +31,10 @@
  *  CHANGES:
  *
  *  2004.12.01	Major rewrite by tiwai, merged the work of pshou
- * 
+ *
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -139,7 +139,7 @@ MODULE_DESCRIPTION("Intel HDA driver");
 #define ICH6_REG_INTCTL			0x20
 #define ICH6_REG_INTSTS			0x24
 #define ICH6_REG_WALCLK			0x30
-#define ICH6_REG_SYNC			0x34	
+#define ICH6_REG_SYNC			0x34
 #define ICH6_REG_CORBLBASE		0x40
 #define ICH6_REG_CORBUBASE		0x44
 #define ICH6_REG_CORBWP			0x48
@@ -422,7 +422,7 @@ static char *driver_short_names[] __devinitdata = {
 	[AZX_DRIVER_SIS] = "HDA SIS966",
 	[AZX_DRIVER_ULI] = "HDA ULI M5461",
 	[AZX_DRIVER_NVIDIA] = "HDA NVidia",
-	[AZX_DRIVER_TERA] = "HDA Teradici", 
+	[AZX_DRIVER_TERA] = "HDA Teradici",
 };
 
 /*
@@ -554,7 +554,7 @@ static void azx_update_rirb(struct azx *chip)
 	if (wp == chip->rirb.wp)
 		return;
 	chip->rirb.wp = wp;
-		
+
 	while (chip->rirb.rp != wp) {
 		chip->rirb.rp++;
 		chip->rirb.rp %= ICH6_MAX_RIRB_ENTRIES;
@@ -777,7 +777,7 @@ static int azx_reset(struct azx *chip)
 
 /*
  * Lowlevel interface
- */  
+ */
 
 /* enable interrupts */
 static void azx_int_enable(struct azx *chip)
@@ -913,7 +913,7 @@ static void azx_init_pci(struct azx *chip)
 	case AZX_DRIVER_ATI:
 		/* For ATI SB450 azalia HD audio, we need to enable snoop */
 		update_pci_byte(chip->pci,
-				ATI_SB450_HDAUDIO_MISC_CNTR2_ADDR, 
+				ATI_SB450_HDAUDIO_MISC_CNTR2_ADDR,
 				0x07, ATI_SB450_HDAUDIO_ENABLE_SNOOP);
 		break;
 	case AZX_DRIVER_NVIDIA:
@@ -964,7 +964,7 @@ static irqreturn_t azx_interrupt(int irq, void *dev_id)
 		spin_unlock(&chip->reg_lock);
 		return IRQ_NONE;
 	}
-	
+
 	for (i = 0; i < chip->num_streams; i++) {
 		azx_dev = &chip->azx_dev[i];
 		if (status & azx_dev->sd_int_sta_mask) {
@@ -1004,7 +1004,7 @@ static irqreturn_t azx_interrupt(int irq, void *dev_id)
 		azx_writeb(chip, STATESTS, 0x04);
 #endif
 	spin_unlock(&chip->reg_lock);
-	
+
 	return IRQ_HANDLED;
 }
 
diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index 4927c4b..5833f7e 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -1,6 +1,6 @@
 /*
  * Universal Interface for Intel High Definition Audio Codec
- * 
+ *
  * Generic proc interface
  *
  * Copyright (c) 2004 Takashi Iwai <tiwai@suse.de>
@@ -99,7 +99,7 @@ static void print_pcm_rates(struct snd_info_buffer *buffer, unsigned int pcm)
 
 	pcm &= AC_SUPPCM_RATES;
 	snd_iprintf(buffer, "    rates [0x%x]:", pcm);
-	for (i = 0; i < ARRAY_SIZE(rates); i++) 
+	for (i = 0; i < ARRAY_SIZE(rates); i++)
 		if (pcm & (1 << i))
 			snd_iprintf(buffer, " %d", rates[i]);
 	snd_iprintf(buffer, "\n");
@@ -527,7 +527,7 @@ static void print_codec_info(struct snd_info_entry *entry,
 	else
 		snd_iprintf(buffer, "No Modem Function Group found\n");
 
-	if (! codec->afg)
+	if (!codec->afg)
 		return;
 	snd_hda_power_up(codec);
 	snd_iprintf(buffer, "Default PCM:\n");
@@ -538,7 +538,7 @@ static void print_codec_info(struct snd_info_entry *entry,
 	print_amp_caps(buffer, codec, codec->afg, HDA_OUTPUT);
 
 	nodes = snd_hda_get_sub_nodes(codec, codec->afg, &nid);
-	if (! nid || nodes < 0) {
+	if (!nid || nodes < 0) {
 		snd_iprintf(buffer, "Invalid AFG subtree\n");
 		snd_hda_power_down(codec);
 		return;
diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 0899b6b..f5b125a 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -174,7 +174,7 @@ static int ad198x_build_controls(struct hda_codec *codec)
 		if (err < 0)
 			return err;
 		spec->multiout.share_spdif = 1;
-	} 
+	}
 	if (spec->dig_in_nid) {
 		err = snd_hda_create_spdif_in_ctls(codec, spec->dig_in_nid);
 		if (err < 0)
@@ -412,7 +412,7 @@ static int ad198x_eapd_get(struct snd_kcontrol *kcontrol,
 	struct ad198x_spec *spec = codec->spec;
 	int invert = (kcontrol->private_value >> 8) & 1;
 	if (invert)
-		ucontrol->value.integer.value[0] = ! spec->cur_eapd;
+		ucontrol->value.integer.value[0] = !spec->cur_eapd;
 	else
 		ucontrol->value.integer.value[0] = spec->cur_eapd;
 	return 0;
@@ -1413,7 +1413,7 @@ static int ad1981_hp_master_sw_put(struct snd_kcontrol *kcontrol,
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct ad198x_spec *spec = codec->spec;
 
-	if (! ad198x_eapd_put(kcontrol, ucontrol))
+	if (!ad198x_eapd_put(kcontrol, ucontrol))
 		return 0;
 	/* change speaker pin appropriately */
 	snd_hda_codec_write(codec, 0x05, 0,
@@ -2426,7 +2426,7 @@ static void ad1988_laptop_unsol_event(struct hda_codec *codec, unsigned int res)
 		snd_hda_sequence_write(codec, ad1988_laptop_hp_on);
 	else
 		snd_hda_sequence_write(codec, ad1988_laptop_hp_off);
-} 
+}
 
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 static struct hda_amp_list ad1988_loopbacks[] = {
@@ -2466,7 +2466,7 @@ static int add_control(struct ad198x_spec *spec, int type, const char *name,
 		int num = spec->num_kctl_alloc + NUM_CONTROL_ALLOC;
 
 		knew = kcalloc(num + 1, sizeof(*knew), GFP_KERNEL); /* array + terminator */
-		if (! knew)
+		if (!knew)
 			return -ENOMEM;
 		if (spec->kctl_alloc) {
 			memcpy(knew, spec->kctl_alloc, sizeof(*knew) * spec->num_kctl_alloc);
@@ -2479,7 +2479,7 @@ static int add_control(struct ad198x_spec *spec, int type, const char *name,
 	knew = &spec->kctl_alloc[spec->num_kctl_used];
 	*knew = ad1988_control_templates[type];
 	knew->name = kstrdup(name, GFP_KERNEL);
-	if (! knew->name)
+	if (!knew->name)
 		return -ENOMEM;
 	knew->private_value = val;
 	spec->num_kctl_used++;
@@ -2581,7 +2581,7 @@ static int ad1988_auto_create_multi_out_ctls(struct ad198x_spec *spec,
 
 	for (i = 0; i < cfg->line_outs; i++) {
 		hda_nid_t dac = spec->multiout.dac_nids[i];
-		if (! dac)
+		if (!dac)
 			continue;
 		nid = ad1988_mixer_nids[ad1988_pin_idx(cfg->line_out_pins[i])];
 		if (i == 2) {
@@ -2631,7 +2631,7 @@ static int ad1988_auto_create_extra_out(struct hda_codec *codec, hda_nid_t pin,
 	int i, idx, err;
 	char name[32];
 
-	if (! pin)
+	if (!pin)
 		return 0;
 
 	idx = ad1988_pin_idx(pin);
@@ -2784,7 +2784,7 @@ static void ad1988_auto_init_analog_input(struct hda_codec *codec)
 
 	for (i = 0; i < AUTO_PIN_LAST; i++) {
 		hda_nid_t nid = spec->autocfg.input_pins[i];
-		if (! nid)
+		if (!nid)
 			continue;
 		switch (nid) {
 		case 0x15: /* port-C */
@@ -2818,7 +2818,7 @@ static int ad1988_parse_auto_config(struct hda_codec *codec)
 		return err;
 	if ((err = ad1988_auto_fill_dac_nids(codec, &spec->autocfg)) < 0)
 		return err;
-	if (! spec->autocfg.line_outs)
+	if (!spec->autocfg.line_outs)
 		return 0; /* can't find valid BIOS pin config */
 	if ((err = ad1988_auto_create_multi_out_ctls(spec, &spec->autocfg)) < 0 ||
 	    (err = ad1988_auto_create_extra_out(codec,
@@ -2904,7 +2904,7 @@ static int patch_ad1988(struct hda_codec *codec)
 		if (err < 0) {
 			ad198x_free(codec);
 			return err;
-		} else if (! err) {
+		} else if (!err) {
 			printk(KERN_INFO "hda_codec: Cannot set up configuration from BIOS.  Using 6-stack mode...\n");
 			board_config = AD1988_6STACK;
 		}
diff --git a/sound/pci/hda/patch_cmedia.c b/sound/pci/hda/patch_cmedia.c
index 6ef57fb..473157b 100644
--- a/sound/pci/hda/patch_cmedia.c
+++ b/sound/pci/hda/patch_cmedia.c
@@ -372,7 +372,7 @@ static int cmi9880_fill_multi_dac_nids(struct hda_codec *codec, const struct aut
 			continue;
 		/* search for an empty channel */
 		for (j = 0; j < cfg->line_outs; j++) {
-			if (! assigned[j]) {
+			if (!assigned[j]) {
 				spec->dac_nids[i] = j + 0x03;
 				assigned[j] = 1;
 				break;
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 7c1eb23..f2b16f8 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -377,7 +377,7 @@ static int conexant_build_controls(struct hda_codec *codec)
 		if (err < 0)
 			return err;
 		spec->multiout.share_spdif = 1;
-	} 
+	}
 	if (spec->dig_in_nid) {
 		err = snd_hda_create_spdif_in_ctls(codec,spec->dig_in_nid);
 		if (err < 0)
@@ -428,7 +428,7 @@ static int cxt_eapd_put(struct snd_kcontrol *kcontrol,
 		eapd = !eapd;
 	if (eapd == spec->cur_eapd)
 		return 0;
-	
+
 	spec->cur_eapd = eapd;
 	snd_hda_codec_write_cache(codec, nid,
 				  0, AC_VERB_SET_EAPD_BTLENABLE,
@@ -592,7 +592,7 @@ static void cxt5045_hp_automute(struct hda_codec *codec)
 	spec->hp_present = snd_hda_codec_read(codec, 0x11, 0,
 				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
 
-	bits = (spec->hp_present || !spec->cur_eapd) ? HDA_AMP_MUTE : 0; 
+	bits = (spec->hp_present || !spec->cur_eapd) ? HDA_AMP_MUTE : 0;
 	snd_hda_codec_amp_stereo(codec, 0x10, HDA_OUTPUT, 0,
 				 HDA_AMP_MUTE, bits);
 }
@@ -706,7 +706,7 @@ static struct hda_verb cxt5045_init_verbs[] = {
 	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	{ 0x13, AC_VERB_SET_CONNECT_SEL, 0x0 },
 	/* EAPD */
-	{0x10, AC_VERB_SET_EAPD_BTLENABLE, 0x2 }, /* default on */ 
+	{0x10, AC_VERB_SET_EAPD_BTLENABLE, 0x2 }, /* default on */
 	{ } /* end */
 };
 
@@ -772,7 +772,7 @@ static struct snd_kcontrol_new cxt5045_test_mixer[] = {
 	HDA_CODEC_MUTE("Node 11 Playback Switch", 0x11, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Node 12 Playback Volume", 0x12, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Node 12 Playback Switch", 0x12, 0x0, HDA_OUTPUT),
-	
+
 	/* Modes for retasking pin widgets */
 	CXT_PIN_MODE("HP-OUT pin mode", 0x11, CXT_PIN_DIR_INOUT),
 	CXT_PIN_MODE("LINE1 pin mode", 0x12, CXT_PIN_DIR_INOUT),
@@ -1004,8 +1004,8 @@ static int patch_cxt5045(struct hda_codec *codec)
 		spec->mixers[0] = cxt5045_test_mixer;
 		spec->init_verbs[0] = cxt5045_test_init_verbs;
 		break;
-		
-#endif	
+
+#endif
 	}
 
 	switch (codec->subsystem_id >> 16) {
@@ -1395,7 +1395,7 @@ static struct hda_verb cxt5047_test_init_verbs[] = {
 	 */
 	{0x18, AC_VERB_SET_DIGI_CONVERT_1, 0},
 
-	/* Ensure mic1, mic2, line1 pin widgets take input from the 
+	/* Ensure mic1, mic2, line1 pin widgets take input from the
 	 * OUT1 sum bus when acting as an output.
 	 */
 	{0x1a, AC_VERB_SET_CONNECT_SEL, 0},
@@ -1530,7 +1530,7 @@ static int patch_cxt5047(struct hda_codec *codec)
 		spec->mixers[0] = cxt5047_test_mixer;
 		spec->init_verbs[0] = cxt5047_test_init_verbs;
 		codec->patch_ops.unsol_event = cxt5047_hp_unsol_event;
-#endif	
+#endif
 	}
 	return 0;
 }
@@ -1685,7 +1685,7 @@ static struct hda_verb cxt5051_init_verbs[] = {
 	/* HP, Amp  */
 	{0x16, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
 	{0x16, AC_VERB_SET_CONNECT_SEL, 0x00},
-	/* DAC1 */	
+	/* DAC1 */
 	{0x10, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
 	/* Record selector: Int mic */
 	{0x14, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0) | 0x44},
@@ -1694,7 +1694,7 @@ static struct hda_verb cxt5051_init_verbs[] = {
 	/* SPDIF route: PCM */
 	{0x1c, AC_VERB_SET_CONNECT_SEL, 0x0},
 	/* EAPD */
-	{0x1a, AC_VERB_SET_EAPD_BTLENABLE, 0x2}, /* default on */ 
+	{0x1a, AC_VERB_SET_EAPD_BTLENABLE, 0x2}, /* default on */
 	{0x16, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN|CONEXANT_HP_EVENT},
 	{0x17, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN|CXT5051_PORTB_EVENT},
 	{0x18, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN|CXT5051_PORTC_EVENT},
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 5c80a27..80e66d2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9291,7 +9291,7 @@ static struct hda_verb alc262_hippo1_unsol_verbs[] = {
 static struct hda_verb alc262_sony_unsol_verbs[] = {
 	{0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0},
 	{0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
-	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24},	// Front Mic
+	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x24},	/* Front Mic */
 
 	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | ALC880_HP_EVENT},
 	{0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
@@ -15209,7 +15209,7 @@ static void alc662_eeepc_unsol_event(struct hda_codec *codec,
 				     unsigned int res)
 {
 	if ((res >> 26) == ALC880_HP_EVENT)
-		alc262_hippo1_automute( codec );
+		alc262_hippo1_automute(codec);
 
 	if ((res >> 26) == ALC880_MIC_EVENT)
 		alc662_eeepc_mic_automute(codec);
@@ -15217,7 +15217,7 @@ static void alc662_eeepc_unsol_event(struct hda_codec *codec,
 
 static void alc662_eeepc_inithook(struct hda_codec *codec)
 {
-	alc262_hippo1_automute( codec );
+	alc262_hippo1_automute(codec);
 	alc662_eeepc_mic_automute(codec);
 }
 
diff --git a/sound/pci/hda/patch_si3054.c b/sound/pci/hda/patch_si3054.c
index 9332b63..1148d8d 100644
--- a/sound/pci/hda/patch_si3054.c
+++ b/sound/pci/hda/patch_si3054.c
@@ -103,7 +103,7 @@ static int si3054_switch_get(struct snd_kcontrol *kcontrol,
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	u16 reg  = PRIVATE_REG(kcontrol->private_value);
 	u16 mask = PRIVATE_MASK(kcontrol->private_value);
-	uvalue->value.integer.value[0] = (GET_REG(codec, reg)) & mask ? 1 : 0 ;
+	uvalue->value.integer.value[0] = (GET_REG(codec, reg)) & mask ? 1 : 0;
 	return 0;
 }
 
@@ -128,7 +128,7 @@ static int si3054_switch_put(struct snd_kcontrol *kcontrol,
 	.put  = si3054_switch_put, \
 	.private_value = PRIVATE_VALUE(reg,mask), \
 }
-		
+
 
 static struct snd_kcontrol_new si3054_modem_mixer[] = {
 	SI3054_KCONTROL("Off-hook Switch", SI3054_GPIO_CONTROL, SI3054_GPIO_OH),
@@ -233,7 +233,7 @@ static int si3054_init(struct hda_codec *codec)
 		val = GET_REG(codec, SI3054_EXTENDED_MID);
 	} while ((val & SI3054_MEI_READY) != SI3054_MEI_READY && wait_count--);
 
-	if((val&SI3054_MEI_READY) != SI3054_MEI_READY) {
+	if ((val&SI3054_MEI_READY) != SI3054_MEI_READY) {
 		snd_printk(KERN_ERR "si3054: cannot initialize. EXT MID = %04x\n", val);
 		/* let's pray that this is no fatal error */
 		/* return -EACCES; */
@@ -244,7 +244,7 @@ static int si3054_init(struct hda_codec *codec)
 	SET_REG(codec, SI3054_MISC_AFE, 0);
 	SET_REG(codec, SI3054_LINE_CFG1,0x200);
 
-	if((GET_REG(codec,SI3054_LINE_STATUS) & (1<<6)) == 0) {
+	if ((GET_REG(codec,SI3054_LINE_STATUS) & (1<<6)) == 0) {
 		snd_printd("Link Frame Detect(FDT) is not ready (line status: %04x)\n",
 				GET_REG(codec,SI3054_LINE_STATUS));
 	}
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 238aebf..6c4cfe8 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -405,12 +405,12 @@ static hda_nid_t stac9205_dmic_nids[STAC9205_NUM_DMICS + 1] = {
 };
 
 static hda_nid_t stac9200_pin_nids[8] = {
-	0x08, 0x09, 0x0d, 0x0e, 
+	0x08, 0x09, 0x0d, 0x0e,
 	0x0f, 0x10, 0x11, 0x12,
 };
 
 static hda_nid_t stac925x_pin_nids[8] = {
-	0x07, 0x08, 0x0a, 0x0b, 
+	0x07, 0x08, 0x0a, 0x0b,
 	0x0c, 0x0d, 0x10, 0x11,
 };
 
@@ -796,23 +796,23 @@ static struct hda_verb stac925x_core_init[] = {
 };
 
 static struct hda_verb stac922x_core_init[] = {
-	/* set master volume and direct control */	
+	/* set master volume and direct control */
 	{ 0x16, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
 	{}
 };
 
 static struct hda_verb d965_core_init[] = {
-	/* set master volume and direct control */	
+	/* set master volume and direct control */
 	{ 0x24, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
 	/* unmute node 0x1b */
 	{ 0x1b, AC_VERB_SET_AMP_GAIN_MUTE, 0xb000},
-	/* select node 0x03 as DAC */	
+	/* select node 0x03 as DAC */
 	{ 0x0b, AC_VERB_SET_CONNECT_SEL, 0x01},
 	{}
 };
 
 static struct hda_verb stac927x_core_init[] = {
-	/* set master volume and direct control */	
+	/* set master volume and direct control */
 	{ 0x24, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
 	/* enable analog pc beep path */
 	{ 0x01, AC_VERB_SET_DIGI_CONVERT_2, 1 << 5},
@@ -820,7 +820,7 @@ static struct hda_verb stac927x_core_init[] = {
 };
 
 static struct hda_verb stac9205_core_init[] = {
-	/* set master volume and direct control */	
+	/* set master volume and direct control */
 	{ 0x24, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
 	/* enable analog pc beep path */
 	{ 0x01, AC_VERB_SET_DIGI_CONVERT_2, 1 << 5},
@@ -1159,7 +1159,7 @@ static int stac92xx_build_controls(struct hda_codec *codec)
 			return err;
 	}
 
-	return 0;	
+	return 0;
 }
 
 static unsigned int ref9200_pin_configs[8] = {
@@ -1167,28 +1167,28 @@ static unsigned int ref9200_pin_configs[8] = {
 	0x02a19020, 0x01a19021, 0x90100140, 0x01813122,
 };
 
-/* 
+/*
     STAC 9200 pin configs for
     102801A8
     102801DE
     102801E8
 */
 static unsigned int dell9200_d21_pin_configs[8] = {
-	0x400001f0, 0x400001f1, 0x02214030, 0x01014010, 
+	0x400001f0, 0x400001f1, 0x02214030, 0x01014010,
 	0x02a19020, 0x01a19021, 0x90100140, 0x01813122,
 };
 
-/* 
+/*
     STAC 9200 pin configs for
     102801C0
     102801C1
 */
 static unsigned int dell9200_d22_pin_configs[8] = {
-	0x400001f0, 0x400001f1, 0x0221401f, 0x01014010, 
+	0x400001f0, 0x400001f1, 0x0221401f, 0x01014010,
 	0x01813020, 0x02a19021, 0x90100140, 0x400001f2,
 };
 
-/* 
+/*
     STAC 9200 pin configs for
     102801C4 (Dell Dimension E310)
     102801C5
@@ -1198,12 +1198,12 @@ static unsigned int dell9200_d22_pin_configs[8] = {
     102801E3
 */
 static unsigned int dell9200_d23_pin_configs[8] = {
-	0x400001f0, 0x400001f1, 0x0221401f, 0x01014010, 
-	0x01813020, 0x01a19021, 0x90100140, 0x400001f2, 
+	0x400001f0, 0x400001f1, 0x0221401f, 0x01014010,
+	0x01813020, 0x01a19021, 0x90100140, 0x400001f2,
 };
 
 
-/* 
+/*
     STAC 9200-32 pin configs for
     102801B5 (Dell Inspiron 630m)
     102801D8 (Dell Inspiron 640m)
@@ -1213,20 +1213,20 @@ static unsigned int dell9200_m21_pin_configs[8] = {
 	0x408003fb, 0x03a11020, 0x401003fc, 0x403003fd,
 };
 
-/* 
+/*
     STAC 9200-32 pin configs for
     102801C2 (Dell Latitude D620)
-    102801C8 
+    102801C8
     102801CC (Dell Latitude D820)
-    102801D4 
-    102801D6 
+    102801D4
+    102801D6
 */
 static unsigned int dell9200_m22_pin_configs[8] = {
-	0x40c003fa, 0x0144131f, 0x0321121f, 0x90170310, 
+	0x40c003fa, 0x0144131f, 0x0321121f, 0x90170310,
 	0x90a70321, 0x03a11020, 0x401003fb, 0x40f000fc,
 };
 
-/* 
+/*
     STAC 9200-32 pin configs for
     102801CE (Dell XPS M1710)
     102801CF (Dell Precision M90)
@@ -1237,15 +1237,15 @@ static unsigned int dell9200_m23_pin_configs[8] = {
 };
 
 /*
-    STAC 9200-32 pin configs for 
+    STAC 9200-32 pin configs for
     102801C9
     102801CA
     102801CB (Dell Latitude 120L)
     102801D3
 */
 static unsigned int dell9200_m24_pin_configs[8] = {
-	0x40c003fa, 0x404003fb, 0x0321121f, 0x90170310, 
-	0x408003fc, 0x03a11020, 0x401003fd, 0x403003fe, 
+	0x40c003fa, 0x404003fb, 0x0321121f, 0x90170310,
+	0x408003fc, 0x03a11020, 0x401003fd, 0x403003fe,
 };
 
 /*
@@ -1255,7 +1255,7 @@ static unsigned int dell9200_m24_pin_configs[8] = {
     102801EF
 */
 static unsigned int dell9200_m25_pin_configs[8] = {
-	0x40c003fa, 0x01441340, 0x0421121f, 0x90170310, 
+	0x40c003fa, 0x01441340, 0x0421121f, 0x90170310,
 	0x408003fb, 0x04a11020, 0x401003fc, 0x403003fd,
 };
 
@@ -1265,7 +1265,7 @@ static unsigned int dell9200_m25_pin_configs[8] = {
     102801F6
 */
 static unsigned int dell9200_m26_pin_configs[8] = {
-	0x40c003fa, 0x404003fb, 0x0421121f, 0x90170310, 
+	0x40c003fa, 0x404003fb, 0x0421121f, 0x90170310,
 	0x408003fc, 0x04a11020, 0x401003fd, 0x403003fe,
 };
 
@@ -1601,7 +1601,7 @@ static unsigned int dell_922x_d82_pin_configs[10] = {
 */
 static unsigned int dell_922x_m81_pin_configs[10] = {
 	0x0321101f, 0x01112024, 0x01111222, 0x91174220,
-	0x03a11050, 0x01116221, 0x90a70330, 0x01452340, 
+	0x03a11050, 0x01116221, 0x90a70330, 0x01452340,
 	0x40C003f1, 0x405003f0,
 };
 
@@ -1610,9 +1610,9 @@ static unsigned int dell_922x_m81_pin_configs[10] = {
     102801D7 (Dell XPS M1210)
 */
 static unsigned int dell_922x_m82_pin_configs[10] = {
-	0x02211211, 0x408103ff, 0x02a1123e, 0x90100310, 
-	0x408003f1, 0x0221121f, 0x03451340, 0x40c003f2, 
-	0x508003f3, 0x405003f4, 
+	0x02211211, 0x408103ff, 0x02a1123e, 0x90100310,
+	0x408003f1, 0x0221121f, 0x03451340, 0x40c003f2,
+	0x508003f3, 0x405003f4,
 };
 
 static unsigned int d945gtp3_pin_configs[10] = {
@@ -1682,9 +1682,9 @@ static unsigned int *stac922x_brd_tbl[STAC_922X_MODELS] = {
 	[STAC_IMAC_INTEL_20] = intel_mac_v3_pin_configs,
 	[STAC_ECS_202] = ecs202_pin_configs,
 	[STAC_922X_DELL_D81] = dell_922x_d81_pin_configs,
-	[STAC_922X_DELL_D82] = dell_922x_d82_pin_configs,	
+	[STAC_922X_DELL_D82] = dell_922x_d82_pin_configs,
 	[STAC_922X_DELL_M81] = dell_922x_m81_pin_configs,
-	[STAC_922X_DELL_M82] = dell_922x_m82_pin_configs,	
+	[STAC_922X_DELL_M82] = dell_922x_m82_pin_configs,
 };
 
 static const char *stac922x_models[STAC_922X_MODELS] = {
@@ -1823,7 +1823,7 @@ static struct snd_pci_quirk stac922x_cfg_tbl[] = {
 
 static unsigned int ref927x_pin_configs[14] = {
 	0x02214020, 0x02a19080, 0x0181304e, 0x01014010,
-	0x01a19040, 0x01011012, 0x01016011, 0x0101201f, 
+	0x01a19040, 0x01011012, 0x01016011, 0x0101201f,
 	0x183301f0, 0x18a001f0, 0x18a001f0, 0x01442070,
 	0x01c42190, 0x40000100,
 };
@@ -2015,25 +2015,25 @@ static int stac92xx_save_bios_config_regs(struct hda_codec *codec)
 {
 	int i;
 	struct sigmatel_spec *spec = codec->spec;
-	
-	if (! spec->bios_pin_configs) {
+
+	if (!spec->bios_pin_configs) {
 		spec->bios_pin_configs = kcalloc(spec->num_pins,
 		                                 sizeof(*spec->bios_pin_configs), GFP_KERNEL);
-		if (! spec->bios_pin_configs)
+		if (!spec->bios_pin_configs)
 			return -ENOMEM;
 	}
-	
+
 	for (i = 0; i < spec->num_pins; i++) {
 		hda_nid_t nid = spec->pin_nids[i];
 		unsigned int pin_cfg;
-		
-		pin_cfg = snd_hda_codec_read(codec, nid, 0, 
-			AC_VERB_GET_CONFIG_DEFAULT, 0x00);	
+
+		pin_cfg = snd_hda_codec_read(codec, nid, 0,
+			AC_VERB_GET_CONFIG_DEFAULT, 0x00);
 		snd_printdd(KERN_INFO "hda_codec: pin nid %2.2x bios pin config %8.8x\n",
 					nid, pin_cfg);
 		spec->bios_pin_configs[i] = pin_cfg;
 	}
-	
+
 	return 0;
 }
 
@@ -2055,7 +2055,7 @@ static void stac92xx_set_config_reg(struct hda_codec *codec,
 			    pin_config >> 24);
 	i = snd_hda_codec_read(codec, pin_nid, 0,
 			       AC_VERB_GET_CONFIG_DEFAULT,
-			       0x00);	
+			       0x00);
 	snd_printdd(KERN_INFO "hda_codec: pin nid %2.2x pin config %8.8x\n",
 		    pin_nid, i);
 }
@@ -2442,7 +2442,7 @@ static int stac92xx_add_control_idx(struct sigmatel_spec *spec, int type,
 		int num = spec->num_kctl_alloc + NUM_CONTROL_ALLOC;
 
 		knew = kcalloc(num + 1, sizeof(*knew), GFP_KERNEL); /* array + terminator */
-		if (! knew)
+		if (!knew)
 			return -ENOMEM;
 		if (spec->kctl_alloc) {
 			memcpy(knew, spec->kctl_alloc, sizeof(*knew) * spec->num_kctl_alloc);
@@ -2456,7 +2456,7 @@ static int stac92xx_add_control_idx(struct sigmatel_spec *spec, int type,
 	*knew = stac92xx_control_templates[type];
 	knew->index = idx;
 	knew->name = kstrdup(name, GFP_KERNEL);
-	if (! knew->name)
+	if (!knew->name)
 		return -ENOMEM;
 	knew->private_value = val;
 	spec->num_kctl_used++;
@@ -2477,7 +2477,7 @@ static int stac92xx_add_dyn_out_pins(struct hda_codec *codec, struct auto_pin_cf
 	struct sigmatel_spec *spec = codec->spec;
 	unsigned int wcaps, wtype;
 	int i, num_dacs = 0;
-	
+
 	/* use the wcaps cache to count all DACs available for line-outs */
 	for (i = 0; i < codec->num_nodes; i++) {
 		wcaps = codec->wcaps[i];
@@ -2488,7 +2488,7 @@ static int stac92xx_add_dyn_out_pins(struct hda_codec *codec, struct auto_pin_cf
 	}
 
 	snd_printdd("%s: total dac count=%d\n", __func__, num_dacs);
-	
+
 	switch (cfg->line_outs) {
 	case 3:
 		/* add line-in as side */
@@ -2538,7 +2538,7 @@ static int stac92xx_add_dyn_out_pins(struct hda_codec *codec, struct auto_pin_cf
 static int is_in_dac_nids(struct sigmatel_spec *spec, hda_nid_t nid)
 {
 	int i;
-	
+
 	for (i = 0; i < spec->multiout.num_dacs; i++) {
 		if (spec->multiout.dac_nids[i] == nid)
 			return 1;
@@ -2558,10 +2558,10 @@ static int stac92xx_auto_fill_dac_nids(struct hda_codec *codec,
 				       struct auto_pin_cfg *cfg)
 {
 	struct sigmatel_spec *spec = codec->spec;
-	int i, j, conn_len = 0; 
+	int i, j, conn_len = 0;
 	hda_nid_t nid, conn[HDA_MAX_CONNECTIONS];
 	unsigned int wcaps, wtype;
-	
+
 	for (i = 0; i < cfg->line_outs; i++) {
 		nid = cfg->line_out_pins[i];
 		conn_len = snd_hda_get_connections(codec, nid, conn,
@@ -2772,7 +2772,7 @@ static int stac92xx_auto_create_hp_ctls(struct hda_codec *codec,
 					 AC_VERB_GET_CONNECT_LIST, 0) & 0xff;
 		if (check_in_dac_nids(spec, nid))
 			nid = 0;
-		if (! nid)
+		if (!nid)
 			continue;
 		add_spec_dacs(spec, nid);
 	}
@@ -2781,7 +2781,7 @@ static int stac92xx_auto_create_hp_ctls(struct hda_codec *codec,
 					 AC_VERB_GET_CONNECT_LIST, 0) & 0xff;
 		if (check_in_dac_nids(spec, nid))
 			nid = 0;
-		if (! nid)
+		if (!nid)
 			continue;
 		add_spec_dacs(spec, nid);
 	}
@@ -2790,7 +2790,7 @@ static int stac92xx_auto_create_hp_ctls(struct hda_codec *codec,
 					AC_VERB_GET_CONNECT_LIST, 0) & 0xff;
 		if (check_in_dac_nids(spec, nid))
 			nid = 0;
-		if (! nid)
+		if (!nid)
 			continue;
 		add_spec_dacs(spec, nid);
 	}
@@ -3082,7 +3082,7 @@ static int stac92xx_parse_auto_config(struct hda_codec *codec, hda_nid_t dig_out
 						&spec->autocfg,
 						spec->dmic_nids)) < 0)
 		return err;
-	if (! spec->autocfg.line_outs)
+	if (!spec->autocfg.line_outs)
 		return 0; /* can't find valid pin config */
 
 	/* If we have no real line-out pin and multiple hp-outs, HPs should
@@ -3258,7 +3258,7 @@ static int stac9200_auto_create_hp_ctls(struct hda_codec *codec,
 	hda_nid_t pin = cfg->hp_pins[0];
 	unsigned int wid_caps;
 
-	if (! pin)
+	if (!pin)
 		return 0;
 
 	wid_caps = get_wcaps(codec, pin);
@@ -3503,7 +3503,7 @@ static void stac92xx_free(struct hda_codec *codec)
 	struct sigmatel_spec *spec = codec->spec;
 	int i;
 
-	if (! spec)
+	if (!spec)
 		return;
 
 	if (spec->kctl_alloc) {
@@ -3544,7 +3544,7 @@ static void stac92xx_set_pinctl(struct hda_codec *codec, hda_nid_t nid,
 	   direction bits first */
 	if (flag & (AC_PINCTL_IN_EN | AC_PINCTL_OUT_EN))
 		pin_ctl &= ~(AC_PINCTL_IN_EN | AC_PINCTL_OUT_EN);
-	
+
 	snd_hda_codec_write_cache(codec, nid, 0,
 			AC_VERB_SET_PIN_WIDGET_CONTROL,
 			pin_ctl | flag);
@@ -3628,7 +3628,7 @@ static void stac92xx_hp_detect(struct hda_codec *codec, unsigned int res)
 	}
 	if (!spec->hp_switch && cfg->hp_outs > 1 && presence)
 		stac92xx_set_pinctl(codec, nid, AC_PINCTL_OUT_EN);
-} 
+}
 
 static void stac92xx_pin_sense(struct hda_codec *codec, int idx)
 {
@@ -3779,7 +3779,7 @@ static int patch_stac925x(struct hda_codec *codec)
 							stac925x_cfg_tbl);
  again:
 	if (spec->board_config < 0) {
-		snd_printdd(KERN_INFO "hda_codec: Unknown model for STAC925x," 
+		snd_printdd(KERN_INFO "hda_codec: Unknown model for STAC925x,"
 				      "using BIOS defaults\n");
 		err = stac92xx_save_bios_config_regs(codec);
 		if (err < 0) {
@@ -4309,7 +4309,7 @@ static int patch_stac922x(struct hda_codec *codec)
 	spec->mixer = stac922x_mixer;
 
 	spec->multiout.dac_nids = spec->dac_nids;
-	
+
 	err = stac92xx_parse_auto_config(codec, 0x08, 0x09);
 	if (!err) {
 		if (spec->board_config < 0) {
@@ -4510,7 +4510,7 @@ static int patch_stac9205(struct hda_codec *codec)
 	spec->aloopback_mask = 0x40;
 	spec->aloopback_shift = 0;
 	spec->multiout.dac_nids = spec->dac_nids;
-	
+
 	switch (spec->board_config){
 	case STAC_9205_DELL_M43:
 		/* Enable SPDIF in/out */
@@ -4700,7 +4700,7 @@ static void stac9872_vaio_hp_detect(struct hda_codec *codec, unsigned int res)
 		stac92xx_reset_pinctl(codec, 0x0a, AC_PINCTL_OUT_EN);
 		stac92xx_set_pinctl(codec, 0x0f, AC_PINCTL_OUT_EN);
 	}
-} 
+}
 
 static void stac9872_vaio_unsol_event(struct hda_codec *codec, unsigned int res)
 {
@@ -4725,7 +4725,7 @@ static struct hda_codec_ops stac9872_vaio_patch_ops = {
 enum { /* FE and SZ series. id=0x83847661 and subsys=0x104D0700 or 104D1000. */
        CXD9872RD_VAIO,
        /* Unknown. id=0x83847662 and subsys=0x104D1200 or 104D1000. */
-       STAC9872AK_VAIO, 
+       STAC9872AK_VAIO,
        /* Unknown. id=0x83847661 and subsys=0x104D1200. */
        STAC9872K_VAIO,
        /* AR Series. id=0x83847664 and subsys=104D1300 */
@@ -4757,7 +4757,7 @@ static int patch_stac9872(struct hda_codec *codec)
 	if (board_config < 0)
 		/* unknown config, let generic-parser do its job... */
 		return snd_hda_parse_generic_codec(codec);
-	
+
 	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;
@@ -4780,7 +4780,7 @@ static int patch_stac9872(struct hda_codec *codec)
 		spec->mux_nids = vaio_mux_nids;
 		codec->patch_ops = stac9872_vaio_patch_ops;
 		break;
-	
+
 	case CXD9872AKD_VAIO:
 		spec->mixer = vaio_ar_mixer;
 		spec->init = vaio_ar_init;
diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index e7e4352..4597ec9 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -344,7 +344,7 @@ static struct hda_verb vt1708_volume_init_verbs[] = {
 	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
-	
+
 	/* Setup default input to PW4 */
 	{0x20, AC_VERB_SET_CONNECT_SEL, 0x1},
 	/* PW9 Output enable */
@@ -644,8 +644,8 @@ static int vt1708_auto_fill_dac_nids(struct via_spec *spec,
 	spec->multiout.num_dacs = cfg->line_outs;
 
 	spec->multiout.dac_nids = spec->private_dac_nids;
- 	
-	for(i = 0; i < 4; i++) {
+
+	for (i = 0; i < 4; i++) {
 		nid = cfg->line_out_pins[i];
 		if (nid) {
 			/* config dac list */
@@ -683,7 +683,7 @@ static int vt1708_auto_create_multi_out_ctls(struct via_spec *spec,
 
 		if (!nid)
 			continue;
-		
+
 		if (i != AUTO_SEQ_FRONT)
 			nid_vol = 0x1b - i + 1;
 
@@ -727,7 +727,7 @@ static int vt1708_auto_create_multi_out_ctls(struct via_spec *spec,
 								  HDA_INPUT));
 			if (err < 0)
 				return err;
-			
+
 			/* add control to PW3 */
 			sprintf(name, "%s Playback Volume", chname[i]);
 			err = via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
@@ -806,7 +806,7 @@ static int vt1708_auto_create_analog_input_ctls(struct via_spec *spec,
 		case 0x1d: /* Mic */
 			idx = 2;
 			break;
-				
+
 		case 0x1e: /* Line In */
 			idx = 3;
 			break;
@@ -874,7 +874,7 @@ static int vt1708_parse_auto_config(struct hda_codec *codec)
 	if (spec->kctl_alloc)
 		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;
 
-	spec->init_verbs = vt1708_volume_init_verbs;	
+	spec->init_verbs = vt1708_volume_init_verbs;
 
 	spec->input_mux = &spec->private_imux;
 
@@ -913,7 +913,7 @@ static int patch_vt1708(struct hda_codec *codec)
 		       "from BIOS.  Using genenic mode...\n");
 	}
 
-	
+
 	spec->stream_name_analog = "VT1708 Analog";
 	spec->stream_analog_playback = &vt1708_pcm_analog_playback;
 	/* disable 32bit format on VT1708 */
@@ -925,7 +925,7 @@ static int patch_vt1708(struct hda_codec *codec)
 	spec->stream_digital_playback = &vt1708_pcm_digital_playback;
 	spec->stream_digital_capture = &vt1708_pcm_digital_capture;
 
-	
+
 	if (!spec->adc_nids && spec->input_mux) {
 		spec->adc_nids = vt1708_adc_nids;
 		spec->num_adc_nids = ARRAY_SIZE(vt1708_adc_nids);
@@ -1104,7 +1104,7 @@ static int vt1709_auto_fill_dac_nids(struct via_spec *spec,
 		spec->multiout.dac_nids[cfg->line_outs] = 0x28; /* AOW4 */
 
 	} else if (cfg->line_outs == 3) { /* 6 channels */
-		for(i = 0; i < cfg->line_outs; i++) {
+		for (i = 0; i < cfg->line_outs; i++) {
 			nid = cfg->line_out_pins[i];
 			if (nid) {
 				/* config dac list */
@@ -1143,7 +1143,7 @@ static int vt1709_auto_create_multi_out_ctls(struct via_spec *spec,
 	for (i = 0; i <= AUTO_SEQ_SIDE; i++) {
 		nid = cfg->line_out_pins[i];
 
-		if (!nid)	
+		if (!nid)
 			continue;
 
 		if (i == AUTO_SEQ_CENLFE) {
@@ -1186,7 +1186,7 @@ static int vt1709_auto_create_multi_out_ctls(struct via_spec *spec,
 								  HDA_INPUT));
 			if (err < 0)
 				return err;
-			
+
 			/* add control to PW3 */
 			sprintf(name, "%s Playback Volume", chname[i]);
 			err = via_add_control(spec, VIA_CTL_WIDGET_VOL, name,
@@ -1281,7 +1281,7 @@ static int vt1709_auto_create_analog_input_ctls(struct via_spec *spec,
 		case 0x1d: /* Mic */
 			idx = 2;
 			break;
-				
+
 		case 0x1e: /* Line In */
 			idx = 3;
 			break;
@@ -1375,7 +1375,7 @@ static int patch_vt1709_10ch(struct hda_codec *codec)
 		       "Using genenic mode...\n");
 	}
 
-	spec->init_verbs = vt1709_10ch_volume_init_verbs;	
+	spec->init_verbs = vt1709_10ch_volume_init_verbs;
 
 	spec->stream_name_analog = "VT1709 Analog";
 	spec->stream_analog_playback = &vt1709_10ch_pcm_analog_playback;
@@ -1385,7 +1385,7 @@ static int patch_vt1709_10ch(struct hda_codec *codec)
 	spec->stream_digital_playback = &vt1709_pcm_digital_playback;
 	spec->stream_digital_capture = &vt1709_pcm_digital_capture;
 
-	
+
 	if (!spec->adc_nids && spec->input_mux) {
 		spec->adc_nids = vt1709_adc_nids;
 		spec->num_adc_nids = ARRAY_SIZE(vt1709_adc_nids);
@@ -1466,7 +1466,7 @@ static int patch_vt1709_6ch(struct hda_codec *codec)
 		       "Using genenic mode...\n");
 	}
 
-	spec->init_verbs = vt1709_6ch_volume_init_verbs;	
+	spec->init_verbs = vt1709_6ch_volume_init_verbs;
 
 	spec->stream_name_analog = "VT1709 Analog";
 	spec->stream_analog_playback = &vt1709_6ch_pcm_analog_playback;
@@ -1476,7 +1476,7 @@ static int patch_vt1709_6ch(struct hda_codec *codec)
 	spec->stream_digital_playback = &vt1709_pcm_digital_playback;
 	spec->stream_digital_capture = &vt1709_pcm_digital_capture;
 
-	
+
 	if (!spec->adc_nids && spec->input_mux) {
 		spec->adc_nids = vt1709_adc_nids;
 		spec->num_adc_nids = ARRAY_SIZE(vt1709_adc_nids);
