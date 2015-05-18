From: Gabriele Martino <g.martino@gmx.com>
Subject: Re: Intel HDA / ca0132: support for Alienware 15
 Creative Sound Core3D-EX
Date: Mon, 18 May 2015 21:15:13 +0200
Message-ID: <555A3A41.2010505@gmx.com>
References: <553AE4CF.3070805@gmx.com> <s5hh9s2lyz0.wl-tiwai@suse.de>
 <553E7B34.2080501@gmx.com> <s5h4mo14d72.wl-tiwai@suse.de>
 <553EB55D.4060701@gmx.com> <s5hlhhc3hiy.wl-tiwai@suse.de>
 <55400DF4.2080309@gmx.com> <s5hpp6nf41g.wl-tiwai@suse.de>
 <5540FBFF.6020904@gmx.com> <s5h8uda93pf.wl-tiwai@suse.de>
 <55416BEE.5090003@gmx.com> <s5hvbge6u4x.wl-tiwai@suse.de>
 <5546B501.7050207@gmx.com> <s5hbni0ikyl.wl-tiwai@suse.de>
 <55510E3D.90508@gmx.com> <s5hsiau1axv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050505010903020701020409"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by alsa0.perex.cz (Postfix) with ESMTP id CF9E52615F3
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2015 21:15:03 +0200 (CEST)
Received: from [192.168.69.6] ([79.16.216.153]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0LbMmA-1ZZlan12Zm-00kyxv for
 <alsa-devel@alsa-project.org>; Mon, 18 May 2015 21:15:03 +0200
In-Reply-To: <s5hsiau1axv.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050505010903020701020409
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

This patch adds quirks detection to the Creative CA0132 codec, and the
quirk for Alienware 15 (2015).
Some quirks may need different pin configuration, so the relevant
compile-time configuration has been removed.
The pin configuration and related initialization verbs are generated at
runtime instead, in ca0132_config() and ca0132_prepare_verbs().

Signed-off-by: Gabriele Martino <g.martino@gmx.com>


--------------050505010903020701020409
Content-Type: text/x-patch;
 name="ca0132-quirks-dynverbs.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="ca0132-quirks-dynverbs.patch"

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 4a4e7b2..1c7a9ec 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -43,8 +43,6 @@
 #define FLOAT_TWO	0x40000000
 #define FLOAT_MINUS_5	0xc0a00000
=20
-#define UNSOL_TAG_HP	0x10
-#define UNSOL_TAG_AMIC1	0x12
 #define UNSOL_TAG_DSP	0x16
=20
 #define DSP_DMA_WRITE_BUFLEN_INIT (1UL<<18)
@@ -703,8 +701,8 @@
 	unsigned int num_mixers;
 	const struct hda_verb *base_init_verbs;
 	const struct hda_verb *base_exit_verbs;
-	const struct hda_verb *init_verbs[5];
-	unsigned int num_init_verbs;  /* exclude base init verbs */
+	const struct hda_verb *chip_init_verbs;
+	struct hda_verb *spec_init_verbs;
 	struct auto_pin_cfg autocfg;
=20
 	/* Nodes configurations */
@@ -719,6 +717,8 @@
 	unsigned int num_inputs;
 	hda_nid_t shared_mic_nid;
 	hda_nid_t shared_out_nid;
+	hda_nid_t unsol_tag_hp;
+	hda_nid_t unsol_tag_amic1;
=20
 	/* chip access */
 	struct mutex chipio_mutex; /* chip access mutex */
@@ -748,10 +748,24 @@
=20
 	struct hda_codec *codec;
 	struct delayed_work unsol_hp_work;
+	int quirk;
=20
 #ifdef ENABLE_TUNING_CONTROLS
 	long cur_ctl_vals[TUNING_CTLS_COUNT];
 #endif
+};
+
+/*
+ * CA0132 quirks table
+ */
+enum {
+	QUIRK_NONE,
+	QUIRK_ALIENWARE,
+};
+
+static const struct snd_pci_quirk ca0132_quirks[] =3D {
+	SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15", QUIRK_ALIENWARE),
+	{}
 };
=20
 /*
@@ -3227,7 +3241,7 @@
 	struct hda_jack_tbl *jack;
=20
 	ca0132_select_out(spec->codec);
-	jack =3D snd_hda_jack_tbl_get(spec->codec, UNSOL_TAG_HP);
+	jack =3D snd_hda_jack_tbl_get(spec->codec, spec->unsol_tag_hp);
 	if (jack) {
 		jack->block_report =3D 0;
 		snd_hda_jack_report_sync(spec->codec);
@@ -4417,8 +4431,9 @@
=20
 static void ca0132_init_unsol(struct hda_codec *codec)
 {
-	snd_hda_jack_detect_enable_callback(codec, UNSOL_TAG_HP, hp_callback);
-	snd_hda_jack_detect_enable_callback(codec, UNSOL_TAG_AMIC1,
+	struct ca0132_spec *spec =3D codec->spec;
+	snd_hda_jack_detect_enable_callback(codec, spec->unsol_tag_hp, hp_callb=
ack);
+	snd_hda_jack_detect_enable_callback(codec, spec->unsol_tag_amic1,
 					    amic_callback);
 	snd_hda_jack_detect_enable_callback(codec, UNSOL_TAG_DSP,
 					    ca0132_process_dsp_response);
@@ -4476,17 +4491,6 @@
 	{0x15, 0x5E8, 0xC9},
 	{0x15, 0x717, 0x0D},
 	{0x15, 0x718, 0x20},
-	{}
-};
-
-static struct hda_verb ca0132_init_verbs1[] =3D {
-	{0x10, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | UNSOL_TAG_HP},
-	{0x12, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | UNSOL_TAG_AMIC1},
-	/* config EAPD */
-	{0x0b, 0x78D, 0x00},
-	/*{0x0b, AC_VERB_SET_EAPD_BTLENABLE, 0x02},*/
-	/*{0x10, 0x78D, 0x02},*/
-	/*{0x10, AC_VERB_SET_EAPD_BTLENABLE, 0x02},*/
 	{}
 };
=20
@@ -4569,8 +4573,8 @@
=20
 	init_input(codec, cfg->dig_in_pin, spec->dig_in);
=20
-	for (i =3D 0; i < spec->num_init_verbs; i++)
-		snd_hda_sequence_write(codec, spec->init_verbs[i]);
+	snd_hda_sequence_write(codec, spec->chip_init_verbs);
+	snd_hda_sequence_write(codec, spec->spec_init_verbs);
=20
 	ca0132_select_out(codec);
 	ca0132_select_mic(codec);
@@ -4591,6 +4595,7 @@
 	snd_hda_sequence_write(codec, spec->base_exit_verbs);
 	ca0132_exit_chip(codec);
 	snd_hda_power_down(codec);
+	kfree(spec->spec_init_verbs);
 	kfree(codec->spec);
 }
=20
@@ -4617,18 +4622,26 @@
=20
 	spec->num_outputs =3D 2;
 	spec->out_pins[0] =3D 0x0b; /* speaker out */
-	spec->out_pins[1] =3D 0x10; /* headphone out */
+	if (spec->quirk =3D=3D QUIRK_ALIENWARE) {
+		codec_dbg(codec, "ca0132_config: QUIRK_ALIENWARE applied.\n");
+		spec->out_pins[1] =3D 0x0f;
+	}
+	else{
+		spec->out_pins[1] =3D 0x10; /* headphone out */
+	}
 	spec->shared_out_nid =3D 0x2;
+	spec->unsol_tag_hp =3D spec->out_pins[1];
=20
-	spec->num_inputs =3D 3;
 	spec->adcs[0] =3D 0x7; /* digital mic / analog mic1 */
 	spec->adcs[1] =3D 0x8; /* analog mic2 */
 	spec->adcs[2] =3D 0xa; /* what u hear */
-	spec->shared_mic_nid =3D 0x7;
=20
+	spec->num_inputs =3D 3;
 	spec->input_pins[0] =3D 0x12;
 	spec->input_pins[1] =3D 0x11;
 	spec->input_pins[2] =3D 0x13;
+	spec->shared_mic_nid =3D 0x7;
+	spec->unsol_tag_amic1 =3D spec->input_pins[0];
=20
 	/* SPDIF I/O */
 	spec->dig_out =3D 0x05;
@@ -4641,10 +4654,56 @@
 	cfg->dig_in_type =3D HDA_PCM_TYPE_SPDIF;
 }
=20
+static int ca0132_prepare_verbs(struct hda_codec *codec)
+{
+/* Verbs + terminator (an empty element) */
+#define NUM_SPEC_VERBS 4
+	struct ca0132_spec *spec =3D codec->spec;
+
+	spec->chip_init_verbs =3D ca0132_init_verbs0;
+	spec->spec_init_verbs =3D kzalloc(sizeof(struct hda_verb) * NUM_SPEC_VE=
RBS, GFP_KERNEL);
+	if (!spec->spec_init_verbs)
+		return -ENOMEM;
+
+	/* HP jack autodetection */
+	spec->spec_init_verbs[0].nid =3D spec->unsol_tag_hp;
+	spec->spec_init_verbs[0].param =3D AC_VERB_SET_UNSOLICITED_ENABLE;
+	spec->spec_init_verbs[0].verb =3D AC_USRSP_EN | spec->unsol_tag_hp;
+
+	/* MIC1 jack autodetection */
+	spec->spec_init_verbs[1].nid =3D spec->unsol_tag_amic1;
+	spec->spec_init_verbs[1].param =3D AC_VERB_SET_UNSOLICITED_ENABLE;
+	spec->spec_init_verbs[1].verb =3D AC_USRSP_EN | spec->unsol_tag_amic1;
+
+	/* config EAPD */
+	spec->spec_init_verbs[2].nid =3D 0x0b;
+	spec->spec_init_verbs[2].param =3D 0x78D;
+	spec->spec_init_verbs[2].verb =3D 0x00;
+
+	/* Previously commented configuration */
+	/*
+	spec->spec_init_verbs[3].nid =3D 0x0b;
+	spec->spec_init_verbs[3].param =3D AC_VERB_SET_EAPD_BTLENABLE;
+	spec->spec_init_verbs[3].verb =3D 0x02;
+
+	spec->spec_init_verbs[4].nid =3D 0x10;
+	spec->spec_init_verbs[4].param =3D 0x78D;
+	spec->spec_init_verbs[4].verb =3D 0x02;
+
+	spec->spec_init_verbs[5].nid =3D 0x10;
+	spec->spec_init_verbs[5].param =3D AC_VERB_SET_EAPD_BTLENABLE;
+	spec->spec_init_verbs[5].verb =3D 0x02;
+	*/
+
+	/* Terminator: spec->spec_init_verbs[NUM_SPEC_VERBS-1] */
+	return 0;
+}
+
 static int patch_ca0132(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec;
 	int err;
+	const struct snd_pci_quirk *quirk;
=20
 	codec_dbg(codec, "patch_ca0132\n");
=20
@@ -4654,15 +4713,19 @@
 	codec->spec =3D spec;
 	spec->codec =3D codec;
=20
+	/* Detect codec quirk */
+	quirk =3D snd_pci_quirk_lookup(codec->bus->pci, ca0132_quirks);
+	if (quirk)
+		spec->quirk =3D quirk->value;
+	else
+		spec->quirk =3D QUIRK_NONE;
+
 	spec->dsp_state =3D DSP_DOWNLOAD_INIT;
 	spec->num_mixers =3D 1;
 	spec->mixers[0] =3D ca0132_mixer;
=20
 	spec->base_init_verbs =3D ca0132_base_init_verbs;
 	spec->base_exit_verbs =3D ca0132_base_exit_verbs;
-	spec->init_verbs[0] =3D ca0132_init_verbs0;
-	spec->init_verbs[1] =3D ca0132_init_verbs1;
-	spec->num_init_verbs =3D 2;
=20
 	INIT_DELAYED_WORK(&spec->unsol_hp_work, ca0132_unsol_hp_delayed);
=20
@@ -4670,6 +4733,10 @@
=20
 	ca0132_config(codec);
=20
+	err =3D ca0132_prepare_verbs(codec);
+	if (err < 0)
+		return err;
+
 	err =3D snd_hda_parse_pin_def_config(codec, &spec->autocfg, NULL);
 	if (err < 0)
 		return err;
--------------050505010903020701020409
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050505010903020701020409--
