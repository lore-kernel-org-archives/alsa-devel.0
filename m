From: Ben Hutchings <ben@decadent.org.uk>
Subject: Bug#631963: [PATCH] ALSA: hda - Disable automute feature by default
Date: Thu, 14 Jul 2011 03:07:51 +0100
Message-ID: <1310609271.8783.252.camel@localhost>
Reply-To: Ben Hutchings <ben@decadent.org.uk>, 631963@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.631963.B631963.13106092979898@bugs.debian.org>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Takashi Iwai <tiwai@suse.de>
Cc: Toni Mueller <support@oeko.net>, Elimar Riesebieter <riesebie@lxtec.de>, 631963@bugs.debian.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The default behaviour should be the same as before this feature
was introduced, to avoid user confusion.

Reported-by: Toni Mueller <support@oeko.net>
References: http://bugs.debian.org/631963
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
The code is rather inconsistent in whether 'mode' means the behaviour or
mechanism of automute.  I didn't touch that but you might want to
consider some renaming.

Ben.

 sound/pci/hda/patch_realtek.c |   74 ++-----------------------------------=
----
 1 files changed, 3 insertions(+), 71 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b48fb43..1247a04 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -306,7 +306,7 @@ struct alc_multi_io {
 };
=20
 enum {
-	ALC_AUTOMUTE_PIN,	/* change the pin control */
+	ALC_AUTOMUTE_PIN =3D 1,	/* change the pin control */
 	ALC_AUTOMUTE_AMP,	/* mute/unmute the pin AMP */
 	ALC_AUTOMUTE_MIXER,	/* mute/unmute mixer widget AMP */
 };
@@ -1599,10 +1599,9 @@ static void alc_init_auto_hp(struct hda_codec *codec=
)
 		snd_hda_codec_write_cache(codec, nid, 0,
 				  AC_VERB_SET_UNSOLICITED_ENABLE,
 				  AC_USRSP_EN | ALC880_HP_EVENT);
-		spec->automute =3D 1;
 		spec->automute_mode =3D ALC_AUTOMUTE_PIN;
 	}
-	if (spec->automute && cfg->line_out_pins[0] &&
+	if (spec->automute_mode && cfg->line_out_pins[0] &&
 	    cfg->line_out_pins[0] !=3D cfg->hp_pins[0] &&
 	    cfg->line_out_pins[0] !=3D cfg->speaker_pins[0]) {
 		for (i =3D 0; i < cfg->line_outs; i++) {
@@ -1619,7 +1618,7 @@ static void alc_init_auto_hp(struct hda_codec *codec)
 		spec->automute_lines =3D spec->detect_line;
 	}
=20
-	if (spec->automute) {
+	if (spec->automute_mode) {
 		/* create a control for automute mode */
 		alc_add_automute_mode_enum(codec);
 		spec->unsol_event =3D alc_sku_unsol_event;
@@ -2241,7 +2240,6 @@ static void alc889_automute_setup(struct hda_codec *c=
odec)
 	spec->autocfg.speaker_pins[2] =3D 0x17;
 	spec->autocfg.speaker_pins[3] =3D 0x19;
 	spec->autocfg.speaker_pins[4] =3D 0x1a;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -2259,7 +2257,6 @@ static void alc888_fujitsu_xa3530_setup(struct hda_co=
dec *codec)
 	spec->autocfg.hp_pins[1] =3D 0x1b; /* hp */
 	spec->autocfg.speaker_pins[0] =3D 0x14; /* speaker */
 	spec->autocfg.speaker_pins[1] =3D 0x15; /* bass */
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -2543,7 +2540,6 @@ static void alc888_acer_aspire_4930g_setup(struct hda=
_codec *codec)
 	spec->autocfg.speaker_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[1] =3D 0x16;
 	spec->autocfg.speaker_pins[2] =3D 0x17;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -2555,7 +2551,6 @@ static void alc888_acer_aspire_6530g_setup(struct hda=
_codec *codec)
 	spec->autocfg.speaker_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[1] =3D 0x16;
 	spec->autocfg.speaker_pins[2] =3D 0x17;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -2567,7 +2562,6 @@ static void alc888_acer_aspire_7730g_setup(struct hda=
_codec *codec)
 	spec->autocfg.speaker_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[1] =3D 0x16;
 	spec->autocfg.speaker_pins[2] =3D 0x17;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -2579,7 +2573,6 @@ static void alc889_acer_aspire_8930g_setup(struct hda=
_codec *codec)
 	spec->autocfg.speaker_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[1] =3D 0x16;
 	spec->autocfg.speaker_pins[2] =3D 0x1b;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -3667,7 +3660,6 @@ static void alc880_uniwill_setup(struct hda_codec *co=
dec)
 	spec->autocfg.hp_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[0] =3D 0x15;
 	spec->autocfg.speaker_pins[0] =3D 0x16;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -3699,7 +3691,6 @@ static void alc880_uniwill_p53_setup(struct hda_codec=
 *codec)
=20
 	spec->autocfg.hp_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[0] =3D 0x15;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -3969,7 +3960,6 @@ static void alc880_lg_setup(struct hda_codec *codec)
=20
 	spec->autocfg.hp_pins[0] =3D 0x1b;
 	spec->autocfg.speaker_pins[0] =3D 0x17;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -4055,7 +4045,6 @@ static void alc880_lg_lw_setup(struct hda_codec *code=
c)
=20
 	spec->autocfg.hp_pins[0] =3D 0x1b;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -4128,7 +4117,6 @@ static void alc880_medion_rim_setup(struct hda_codec =
*codec)
=20
 	spec->autocfg.hp_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[0] =3D 0x1b;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -6277,7 +6265,6 @@ static void alc260_hp_setup(struct hda_codec *codec)
 	spec->autocfg.hp_pins[0] =3D 0x0f;
 	spec->autocfg.speaker_pins[0] =3D 0x10;
 	spec->autocfg.speaker_pins[1] =3D 0x11;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_PIN;
 }
=20
@@ -6308,7 +6295,6 @@ static void alc260_hp_3013_setup(struct hda_codec *co=
dec)
 	spec->autocfg.hp_pins[0] =3D 0x15;
 	spec->autocfg.speaker_pins[0] =3D 0x10;
 	spec->autocfg.speaker_pins[1] =3D 0x11;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_PIN;
 }
=20
@@ -6352,7 +6338,6 @@ static void alc260_hp_3012_setup(struct hda_codec *co=
dec)
 	spec->autocfg.speaker_pins[0] =3D 0x0f;
 	spec->autocfg.speaker_pins[1] =3D 0x11;
 	spec->autocfg.speaker_pins[2] =3D 0x15;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_PIN;
 }
=20
@@ -8887,7 +8872,6 @@ static void alc885_imac24_setup(struct hda_codec *cod=
ec)
 	spec->autocfg.hp_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[0] =3D 0x18;
 	spec->autocfg.speaker_pins[1] =3D 0x1a;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -8901,7 +8885,6 @@ static void alc885_mba21_setup(struct hda_codec *code=
c)
=20
        spec->autocfg.hp_pins[0] =3D 0x14;
        spec->autocfg.speaker_pins[0] =3D 0x18;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -8913,7 +8896,6 @@ static void alc885_mbp3_setup(struct hda_codec *codec=
)
=20
 	spec->autocfg.hp_pins[0] =3D 0x15;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -8924,7 +8906,6 @@ static void alc885_imac91_setup(struct hda_codec *cod=
ec)
 	spec->autocfg.hp_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[0] =3D 0x18;
 	spec->autocfg.speaker_pins[1] =3D 0x1a;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -8958,7 +8939,6 @@ static void alc882_targa_setup(struct hda_codec *code=
c)
=20
 	spec->autocfg.hp_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[0] =3D 0x1b;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -9405,7 +9385,6 @@ static void alc883_medion_wim2160_setup(struct hda_co=
dec *codec)
=20
 	spec->autocfg.hp_pins[0] =3D 0x1a;
 	spec->autocfg.speaker_pins[0] =3D 0x15;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -9559,7 +9538,6 @@ static void alc883_mitac_setup(struct hda_codec *code=
c)
 	spec->autocfg.hp_pins[0] =3D 0x15;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[1] =3D 0x17;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -9725,7 +9703,6 @@ static void alc888_3st_hp_setup(struct hda_codec *cod=
ec)
 	spec->autocfg.speaker_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[1] =3D 0x16;
 	spec->autocfg.speaker_pins[2] =3D 0x18;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -9786,7 +9763,6 @@ static void alc888_lenovo_ms7195_setup(struct hda_cod=
ec *codec)
 	spec->autocfg.hp_pins[0] =3D 0x1b;
 	spec->autocfg.line_out_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[0] =3D 0x15;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -9797,7 +9773,6 @@ static void alc883_lenovo_nb0763_setup(struct hda_cod=
ec *codec)
=20
 	spec->autocfg.hp_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[0] =3D 0x15;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -9811,7 +9786,6 @@ static void alc883_clevo_m720_setup(struct hda_codec =
*codec)
=20
 	spec->autocfg.hp_pins[0] =3D 0x15;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -9841,7 +9815,6 @@ static void alc883_2ch_fujitsu_pi2515_setup(struct hd=
a_codec *codec)
=20
 	spec->autocfg.hp_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[0] =3D 0x15;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -9851,7 +9824,6 @@ static void alc883_haier_w66_setup(struct hda_codec *=
codec)
=20
 	spec->autocfg.hp_pins[0] =3D 0x1b;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -9862,7 +9834,6 @@ static void alc883_lenovo_101e_setup(struct hda_codec=
 *codec)
 	spec->autocfg.hp_pins[0] =3D 0x1b;
 	spec->autocfg.line_out_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[0] =3D 0x15;
-	spec->automute =3D 1;
 	spec->detect_line =3D 1;
 	spec->automute_lines =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
@@ -9876,7 +9847,6 @@ static void alc883_acer_aspire_setup(struct hda_codec=
 *codec)
 	spec->autocfg.hp_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[0] =3D 0x15;
 	spec->autocfg.speaker_pins[1] =3D 0x16;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -9907,7 +9877,6 @@ static void alc888_6st_dell_setup(struct hda_codec *c=
odec)
 	spec->autocfg.speaker_pins[1] =3D 0x15;
 	spec->autocfg.speaker_pins[2] =3D 0x16;
 	spec->autocfg.speaker_pins[3] =3D 0x17;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -9921,7 +9890,6 @@ static void alc888_lenovo_sky_setup(struct hda_codec =
*codec)
 	spec->autocfg.speaker_pins[2] =3D 0x16;
 	spec->autocfg.speaker_pins[3] =3D 0x17;
 	spec->autocfg.speaker_pins[4] =3D 0x1a;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -9932,7 +9900,6 @@ static void alc883_vaiott_setup(struct hda_codec *cod=
ec)
 	spec->autocfg.hp_pins[0] =3D 0x15;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[1] =3D 0x17;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -9959,7 +9926,6 @@ static void alc883_mode2_setup(struct hda_codec *code=
c)
 	spec->ext_mic.mux_idx =3D 0;
 	spec->int_mic.mux_idx =3D 1;
 	spec->auto_mic =3D 1;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -11470,7 +11436,6 @@ static void alc262_hp_bpc_setup(struct hda_codec *c=
odec)
=20
 	spec->autocfg.hp_pins[0] =3D 0x1b;
 	spec->autocfg.speaker_pins[0] =3D 0x16;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_PIN;
 }
=20
@@ -11480,7 +11445,6 @@ static void alc262_hp_wildwest_setup(struct hda_cod=
ec *codec)
=20
 	spec->autocfg.hp_pins[0] =3D 0x15;
 	spec->autocfg.speaker_pins[0] =3D 0x16;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_PIN;
 }
=20
@@ -11560,7 +11524,6 @@ static void alc262_hp_t5735_setup(struct hda_codec =
*codec)
=20
 	spec->autocfg.hp_pins[0] =3D 0x15;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_PIN;
 }
=20
@@ -11674,7 +11637,6 @@ static void alc262_hippo_setup(struct hda_codec *co=
dec)
=20
 	spec->autocfg.hp_pins[0] =3D 0x15;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -11684,7 +11646,6 @@ static void alc262_hippo1_setup(struct hda_codec *c=
odec)
=20
 	spec->autocfg.hp_pins[0] =3D 0x1b;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -11748,7 +11709,6 @@ static void alc262_tyan_setup(struct hda_codec *cod=
ec)
=20
 	spec->autocfg.hp_pins[0] =3D 0x1b;
 	spec->autocfg.speaker_pins[0] =3D 0x15;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -11893,7 +11853,6 @@ static void alc262_toshiba_s06_setup(struct hda_cod=
ec *codec)
 	spec->int_mic.pin =3D 0x12;
 	spec->int_mic.mux_idx =3D 9;
 	spec->auto_mic =3D 1;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_PIN;
 }
=20
@@ -11998,7 +11957,6 @@ static void alc262_fujitsu_setup(struct hda_codec *=
codec)
 	spec->autocfg.hp_pins[0] =3D 0x14;
 	spec->autocfg.hp_pins[1] =3D 0x1b;
 	spec->autocfg.speaker_pins[0] =3D 0x15;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -12045,7 +12003,6 @@ static void alc262_lenovo_3000_setup(struct hda_cod=
ec *codec)
 	spec->autocfg.hp_pins[0] =3D 0x1b;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[1] =3D 0x16;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -13255,7 +13212,6 @@ static void alc268_acer_setup(struct hda_codec *cod=
ec)
=20
 	spec->autocfg.hp_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[0] =3D 0x15;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -13339,7 +13295,6 @@ static void alc268_acer_lc_setup(struct hda_codec *=
codec)
 	struct alc_spec *spec =3D codec->spec;
 	spec->autocfg.hp_pins[0] =3D 0x15;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 	spec->ext_mic.pin =3D 0x18;
 	spec->ext_mic.mux_idx =3D 0;
@@ -13379,7 +13334,6 @@ static void alc268_dell_setup(struct hda_codec *cod=
ec)
 	spec->int_mic.pin =3D 0x19;
 	spec->int_mic.mux_idx =3D 1;
 	spec->auto_mic =3D 1;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_PIN;
 }
=20
@@ -13411,7 +13365,6 @@ static void alc267_quanta_il1_setup(struct hda_code=
c *codec)
 	spec->int_mic.pin =3D 0x19;
 	spec->int_mic.mux_idx =3D 1;
 	spec->auto_mic =3D 1;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_PIN;
 }
=20
@@ -14415,7 +14368,6 @@ static void alc269_quanta_fl1_setup(struct hda_code=
c *codec)
 	spec->autocfg.hp_pins[0] =3D 0x15;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
 	spec->automute_mixer_nid[0] =3D 0x0c;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_MIXER;
 	spec->ext_mic.pin =3D 0x18;
 	spec->ext_mic.mux_idx =3D 0;
@@ -14437,7 +14389,6 @@ static void alc269_lifebook_setup(struct hda_codec =
*codec)
 	spec->autocfg.hp_pins[1] =3D 0x1a;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
 	spec->automute_mixer_nid[0] =3D 0x0c;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_MIXER;
 }
=20
@@ -14510,7 +14461,6 @@ static void alc269_laptop_amic_setup(struct hda_cod=
ec *codec)
 	spec->autocfg.hp_pins[0] =3D 0x15;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
 	spec->automute_mixer_nid[0] =3D 0x0c;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_MIXER;
 	spec->ext_mic.pin =3D 0x18;
 	spec->ext_mic.mux_idx =3D 0;
@@ -14525,7 +14475,6 @@ static void alc269_laptop_dmic_setup(struct hda_cod=
ec *codec)
 	spec->autocfg.hp_pins[0] =3D 0x15;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
 	spec->automute_mixer_nid[0] =3D 0x0c;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_MIXER;
 	spec->ext_mic.pin =3D 0x18;
 	spec->ext_mic.mux_idx =3D 0;
@@ -14540,7 +14489,6 @@ static void alc269vb_laptop_amic_setup(struct hda_c=
odec *codec)
 	spec->autocfg.hp_pins[0] =3D 0x21;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
 	spec->automute_mixer_nid[0] =3D 0x0c;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_MIXER;
 	spec->ext_mic.pin =3D 0x18;
 	spec->ext_mic.mux_idx =3D 0;
@@ -14555,7 +14503,6 @@ static void alc269vb_laptop_dmic_setup(struct hda_c=
odec *codec)
 	spec->autocfg.hp_pins[0] =3D 0x21;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
 	spec->automute_mixer_nid[0] =3D 0x0c;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_MIXER;
 	spec->ext_mic.pin =3D 0x18;
 	spec->ext_mic.mux_idx =3D 0;
@@ -16878,7 +16825,6 @@ static void alc861vd_lenovo_setup(struct hda_codec =
*codec)
 	struct alc_spec *spec =3D codec->spec;
 	spec->autocfg.hp_pins[0] =3D 0x1b;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -16953,7 +16899,6 @@ static void alc861vd_dallas_setup(struct hda_codec =
*codec)
=20
 	spec->autocfg.hp_pins[0] =3D 0x15;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -18222,7 +18167,6 @@ static void alc662_lenovo_101e_setup(struct hda_cod=
ec *codec)
 	spec->autocfg.hp_pins[0] =3D 0x1b;
 	spec->autocfg.line_out_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[0] =3D 0x15;
-	spec->automute =3D 1;
 	spec->detect_line =3D 1;
 	spec->automute_lines =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
@@ -18246,7 +18190,6 @@ static void alc662_eeepc_ep20_setup(struct hda_code=
c *codec)
=20
 	spec->autocfg.hp_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[0] =3D 0x1b;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
@@ -18256,7 +18199,6 @@ static void alc663_m51va_setup(struct hda_codec *co=
dec)
 	spec->autocfg.hp_pins[0] =3D 0x21;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
 	spec->automute_mixer_nid[0] =3D 0x0c;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_MIXER;
 	spec->ext_mic.pin =3D 0x18;
 	spec->ext_mic.mux_idx =3D 0;
@@ -18272,7 +18214,6 @@ static void alc663_mode1_setup(struct hda_codec *co=
dec)
 	spec->autocfg.hp_pins[0] =3D 0x21;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
 	spec->automute_mixer_nid[0] =3D 0x0c;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_MIXER;
 	spec->ext_mic.pin =3D 0x18;
 	spec->ext_mic.mux_idx =3D 0;
@@ -18287,7 +18228,6 @@ static void alc662_mode2_setup(struct hda_codec *co=
dec)
 	struct alc_spec *spec =3D codec->spec;
 	spec->autocfg.hp_pins[0] =3D 0x1b;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_PIN;
 	spec->ext_mic.pin =3D 0x18;
 	spec->ext_mic.mux_idx =3D 0;
@@ -18303,7 +18243,6 @@ static void alc663_mode3_setup(struct hda_codec *co=
dec)
 	spec->autocfg.hp_pins[0] =3D 0x21;
 	spec->autocfg.hp_pins[0] =3D 0x15;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_PIN;
 	spec->ext_mic.pin =3D 0x18;
 	spec->ext_mic.mux_idx =3D 0;
@@ -18321,7 +18260,6 @@ static void alc663_mode4_setup(struct hda_codec *co=
dec)
 	spec->autocfg.speaker_pins[1] =3D 0x16;
 	spec->automute_mixer_nid[0] =3D 0x0c;
 	spec->automute_mixer_nid[1] =3D 0x0e;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_MIXER;
 	spec->ext_mic.pin =3D 0x18;
 	spec->ext_mic.mux_idx =3D 0;
@@ -18339,7 +18277,6 @@ static void alc663_mode5_setup(struct hda_codec *co=
dec)
 	spec->autocfg.speaker_pins[1] =3D 0x16;
 	spec->automute_mixer_nid[0] =3D 0x0c;
 	spec->automute_mixer_nid[1] =3D 0x0e;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_MIXER;
 	spec->ext_mic.pin =3D 0x18;
 	spec->ext_mic.mux_idx =3D 0;
@@ -18356,7 +18293,6 @@ static void alc663_mode6_setup(struct hda_codec *co=
dec)
 	spec->autocfg.hp_pins[0] =3D 0x15;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
 	spec->automute_mixer_nid[0] =3D 0x0c;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_MIXER;
 	spec->ext_mic.pin =3D 0x18;
 	spec->ext_mic.mux_idx =3D 0;
@@ -18373,7 +18309,6 @@ static void alc663_mode7_setup(struct hda_codec *co=
dec)
 	spec->autocfg.hp_pins[0] =3D 0x21;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[0] =3D 0x17;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_PIN;
 	spec->ext_mic.pin =3D 0x18;
 	spec->ext_mic.mux_idx =3D 0;
@@ -18390,7 +18325,6 @@ static void alc663_mode8_setup(struct hda_codec *co=
dec)
 	spec->autocfg.hp_pins[1] =3D 0x15;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
 	spec->autocfg.speaker_pins[0] =3D 0x17;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_PIN;
 	spec->ext_mic.pin =3D 0x18;
 	spec->ext_mic.mux_idx =3D 0;
@@ -18405,7 +18339,6 @@ static void alc663_g71v_setup(struct hda_codec *cod=
ec)
 	spec->autocfg.hp_pins[0] =3D 0x21;
 	spec->autocfg.line_out_pins[0] =3D 0x15;
 	spec->autocfg.speaker_pins[0] =3D 0x14;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 	spec->detect_line =3D 1;
 	spec->automute_lines =3D 1;
@@ -19818,7 +19751,6 @@ static void alc680_base_setup(struct hda_codec *cod=
ec)
 	spec->autocfg.inputs[0].type =3D AUTO_PIN_MIC;
 	spec->autocfg.inputs[1].pin =3D 0x19;
 	spec->autocfg.inputs[1].type =3D AUTO_PIN_LINE_IN;
-	spec->automute =3D 1;
 	spec->automute_mode =3D ALC_AUTOMUTE_AMP;
 }
=20
--=20
1.7.5.4
