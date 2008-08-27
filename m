From: "John L. Utz III" <john.utz@dmx.com>
Subject: PATCH - via82xx  vt1618 7.1 Audio Support
Date: Wed, 27 Aug 2008 14:57:39 -0700
Message-ID: <op.ugkfadrw647oa9@jutz-gnto64>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 86EFB24807
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Aug 2008 23:57:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

1. Implement 7.1 Output for vt1618 codec.
2. Fix typos in comments from my previous 1617a patch.

Signed-off-by: John L. Utz III <john.utz@dmx.com>

diff --git a/pci/ac97/ac97_codec.c b/pci/ac97/ac97_codec.c
index d0023e9..89f3050 100644
--- a/pci/ac97/ac97_codec.c
+++ b/pci/ac97/ac97_codec.c
@@ -168,7 +168,7 @@ static const struct ac97_codec_id snd_ac97_codec_ids[]  
= {
  { 0x54584e20, 0xffffffff, "TLC320AD9xC",	NULL,		NULL },
  { 0x56494161, 0xffffffff, "VIA1612A",		NULL,		NULL }, // modified ICE1232  
with S/PDIF
  { 0x56494170, 0xffffffff, "VIA1617A",		patch_vt1617a,	NULL }, // modified  
VT1616 with S/PDIF
-{ 0x56494182, 0xffffffff, "VIA1618",		NULL,		NULL },
+{ 0x56494182, 0xffffffff, "VIA1618",		patch_vt1618,   NULL },
  { 0x57454301, 0xffffffff, "W83971D",		NULL,		NULL },
  { 0x574d4c00, 0xffffffff, "WM9701,WM9701A",	NULL,		NULL },
  { 0x574d4C03, 0xffffffff, "WM9703,WM9707,WM9708,WM9717", patch_wolfson03,  
NULL},
@@ -609,7 +609,6 @@ AC97_SINGLE("PC Speaker Playback Volume",  
AC97_PC_BEEP, 1, 15, 1)
  static const struct snd_kcontrol_new snd_ac97_controls_mic_boost =
  	AC97_SINGLE("Mic Boost (+20dB)", AC97_MIC, 6, 1, 0);

-
  static const char* std_rec_sel[] = {"Mic", "CD", "Video", "Aux", "Line",  
"Mix", "Mix Mono", "Phone"};
  static const char* std_3d_path[] = {"pre 3D", "post 3D"};
  static const char* std_mix[] = {"Mix", "Mic"};
diff --git a/pci/ac97/ac97_patch.c b/pci/ac97/ac97_patch.c
index bb028f8..7d5abf5 100644
--- a/pci/ac97/ac97_patch.c
+++ b/pci/ac97/ac97_patch.c
@@ -3465,7 +3465,7 @@ static int patch_vt1616(struct snd_ac97 * ac97)

  /*
   * unfortunately, the vt1617a stashes the twiddlers required for
- * nooding the i/o jacks on 2 different regs. * thameans that we cant
+ * noodling the i/o jacks on 2 different regs. that means that we cant
   * use the easy way provided by AC97_ENUM_DOUBLE() we have to write
   * are own funcs.
   *
@@ -3498,7 +3498,7 @@ static int snd_ac97_vt1617a_smart51_get(struct  
snd_kcontrol *kcontrol,
  	
  	pac97 = snd_kcontrol_chip(kcontrol); /* grab codec handle */

-	/* grab our desirec bits, then mash them together in a manner
+	/* grab our desired bits, then mash them together in a manner
  	 * consistent with Table 6 on page 17 in the 1617a docs */

  	usSM51 = snd_ac97_read(pac97, 0x7a) >> 14;
@@ -3576,6 +3576,201 @@ int patch_vt1617a(struct snd_ac97 * ac97)
  	return err;
  }

+/* VIA VT1618 8 CHANNEL AC97 CODEC
+ *
+ * VIA implements 'Smart 5.1' completely differently on the 1618 than
+ * it does on the 1617a. awesome! They seem to have sourced this
+ * particular revision of the technology from somebody else, it's
+ * called Universal Audio Jack and it shows up on some other folk's chips
+ * as well.
+ *
+ * ordering in this list reflects vt1618 docs for Reg 60h and
+ * the block diagram, DACs are as follows:
+ *
+ *        OUT_O -> Front,
+ *	  OUT_1 -> Surround,
+ *	  OUT_2 -> C/LFE
+ *
+ * Unlike the 1617a, each OUT has a consistent set of mappings
+ * for all bitpatterns other than 00:
+ *
+ *        01       Unmixed Output
+ *        10       Line In
+ *        11       Mic  In
+ *
+ * Special Case of 00:
+ *
+ *        OUT_0    Mixed Output
+ *        OUT_1    Reserved
+ *        OUT_2    Reserved
+ *
+ * I have no idea what the hell Reserved does, but on an MSI
+ * CN700T, i have to set it to get 5.1 output - YMMV, bad
+ * shit may happen.
+ *
+ * If other chips use Universal Audio Jack, then this code might be  
applicable
+ * to them.
+ */
+
+struct vt1618_uaj_item {
+	unsigned short mask;
+	unsigned short shift;
+	const char *items[4];
+};
+
+/* This list reflects the vt1618 docs for Vendor Defined Register 0x60. */
+
+static struct vt1618_uaj_item vt1618_uaj[3] = {
+	{
+		/* speaker jack */
+		.mask  = 0x03,
+		.shift = 0,
+		.items = {
+			"Speaker Out", "DAC Unmixed Out", "Line In", "Mic In"
+		}
+	},
+	{
+		/* line jack */
+		.mask  = 0x0c,
+		.shift = 2,
+		.items = {
+			"Surround Out", "DAC Unmixed Out", "Line In", "Mic In"
+		}
+	},
+	{
+		/* mic jack */
+		.mask  = 0x30,
+		.shift = 4,
+		.items = {
+			"Center LFE Out", "DAC Unmixed Out", "Line In", "Mic In"
+		},
+	},
+};
+
+static int snd_ac97_vt1618_UAJ_info(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_info *uinfo)
+{
+	return ac97_enum_text_info(kcontrol, uinfo,
+				   vt1618_uaj[kcontrol->private_value].items,
+				   4);
+}
+
+/* All of the vt1618 Universal Audio Jack twiddlers are on
+   Vendor Defined Register 0x60, page 0. The bits, and thus
+   the mask, are the only thing that changes */
+
+static int snd_ac97_vt1618_UAJ_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	unsigned short datpag, uaj;
+
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	mutex_lock(&pac97->page_mutex);
+
+	datpag = snd_ac97_read(pac97, AC97_INT_PAGING) & AC97_PAGE_MASK;
+	snd_ac97_update_bits(pac97, AC97_INT_PAGING, AC97_PAGE_MASK, 0);
+
+	uaj = snd_ac97_read(pac97, 0x60) &
+		vt1618_uaj[kcontrol->private_value].mask;
+
+	snd_ac97_update_bits(pac97, AC97_INT_PAGING, AC97_PAGE_MASK, datpag);
+	mutex_unlock(&pac97->page_mutex);
+
+	ucontrol->value.enumerated.item[0] = uaj >>
+		vt1618_uaj[kcontrol->private_value].shift;
+
+	return 0;
+}
+
+static int snd_ac97_vt1618_UAJ_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	return ac97_update_bits_page(snd_kcontrol_chip(kcontrol), 0x60,
+				     vt1618_uaj[kcontrol->private_value].mask,
+				     ucontrol->value.enumerated.item[0]<<
+				     vt1618_uaj[kcontrol->private_value].shift,
+				     0);
+}
+
+/* config aux in jack - not found on 3 jack motherboards or soundcards */
+
+static int snd_ac97_vt1618_aux_info(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_info *uinfo)
+{
+	static const  char  *txt_aux[] = {"Aux In", "Back Surr Out"};
+
+	return ac97_enum_text_info(kcontrol, uinfo, txt_aux, 2);
+}
+
+static int snd_ac97_vt1618_aux_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.enumerated.item[0] =
+		(snd_ac97_read(snd_kcontrol_chip(kcontrol), 0x5c) & 0x0008)>>3;
+	return 0;
+}
+
+static int snd_ac97_vt1618_aux_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	/* toggle surround rear dac power */
+
+	snd_ac97_update_bits(snd_kcontrol_chip(kcontrol), 0x5c, 0x0008,
+			     ucontrol->value.enumerated.item[0] << 3);
+
+	/* toggle aux in surround rear out jack */
+
+	return snd_ac97_update_bits(snd_kcontrol_chip(kcontrol), 0x76, 0x0008,
+				    ucontrol->value.enumerated.item[0] << 3);
+}
+
+static const struct snd_kcontrol_new snd_ac97_controls_vt1618[] = {
+	AC97_SINGLE("Exchange Center/LFE", 0x5a,  8, 1,     0),
+	AC97_SINGLE("DC Offset",           0x5a, 10, 1,     0),
+	AC97_SINGLE("Soft Mute",           0x5c,  0, 1,     1),
+	AC97_SINGLE("Headphone Amp",       0x5c,  5, 1,     1),
+	AC97_DOUBLE("Back Surr Volume",    0x5e,  8, 0, 31, 1),
+	AC97_SINGLE("Back Surr Switch",    0x5e, 15, 1,     1),
+	{
+		.iface         = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name          = "Speaker Jack Mode",
+		.info          = snd_ac97_vt1618_UAJ_info,
+		.get           = snd_ac97_vt1618_UAJ_get,
+		.put           = snd_ac97_vt1618_UAJ_put,
+		.private_value = 0
+	},
+	{
+		.iface         = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name          = "Line Jack Mode",
+		.info          = snd_ac97_vt1618_UAJ_info,
+		.get           = snd_ac97_vt1618_UAJ_get,
+		.put           = snd_ac97_vt1618_UAJ_put,
+		.private_value = 1
+	},
+	{
+		.iface         = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name          = "Mic Jack Mode",
+		.info          = snd_ac97_vt1618_UAJ_info,
+		.get           = snd_ac97_vt1618_UAJ_get,
+		.put           = snd_ac97_vt1618_UAJ_put,
+		.private_value = 2
+	},
+	{
+		.iface         = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name          = "Aux Jack Mode",
+		.info          = snd_ac97_vt1618_aux_info,
+		.get           = snd_ac97_vt1618_aux_get,
+		.put           = snd_ac97_vt1618_aux_put,
+	}
+};
+
+int patch_vt1618(struct snd_ac97 *ac97)
+{
+	return patch_build_controls(ac97, snd_ac97_controls_vt1618,
+				    ARRAY_SIZE(snd_ac97_controls_vt1618));
+}
+
  /*
   */
  static void it2646_update_jacks(struct snd_ac97 *ac97)
