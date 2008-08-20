From: "John L. Utz III" <john.utz@dmx.com>
Subject: PATCH - vt1618 7.1 Audio
Date: Tue, 19 Aug 2008 17:17:44 -0700
Message-ID: <op.uf5sfuct647oa9@jutz-gnto64>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id C15A924420
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Aug 2008 02:18:05 +0200 (CEST)
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

Signed-off-by: John L. Utz III john.utz@dmx.com

diff --git a/pci/ac97/ac97_codec.c b/pci/ac97/ac97_codec.c
index d0023e9..a34f1ea 100644
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
+{ 0x56494182, 0xffffffff, "VIA1618",		patch_vt1618,   NULL }, // clean  
sheet of crinkled paper
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
index bb028f8..2042415 100644
--- a/pci/ac97/ac97_patch.c
+++ b/pci/ac97/ac97_patch.c
@@ -3465,7 +3465,7 @@ static int patch_vt1616(struct snd_ac97 * ac97)

  /*
   * unfortunately, the vt1617a stashes the twiddlers required for
- * nooding the i/o jacks on 2 different regs. * thameans that we cant
+ * nooding the i/o jacks on 2 different regs. that means that we cant
   * use the easy way provided by AC97_ENUM_DOUBLE() we have to write
   * are own funcs.
   *
@@ -3576,6 +3576,413 @@ int patch_vt1617a(struct snd_ac97 * ac97)
  	return err;
  }

+
+/* use these alot in the 1618 code but i cant find a better place to put  
them */
+
+static const char* std_enable[]  = {"Enabled", "Disabled"};
+static const char* std_disable[] = {"Disabled","Enabled"};
+
+/* disable enable c/lfe exchange */
+
+static int snd_ac97_vt1618_clex_info(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	return ac97_enum_text_info(kcontrol, uinfo, std_disable, 2);
+}
+
+static int snd_ac97_vt1618_clex_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = (snd_ac97_read(pac97, 0x5a) &
+					      0x0100) >> 8;
+	return 0;
+}
+
+static int snd_ac97_vt1618_clex_put(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	/* notice relationship between mask and shift! */
+
+	return snd_ac97_update_bits(pac97, 0x5a, 0x0100,
+				    ucontrol->value.enumerated.item[0] << 8);
+}
+
+
+/* disable enable dc offset */
+
+static int snd_ac97_vt1618_dcof_info(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	return ac97_enum_text_info(kcontrol, uinfo, std_disable, 2);
+}
+
+static int snd_ac97_vt1618_dcof_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = (snd_ac97_read(pac97, 0x5a) &
+					      0x0400) >> 10;
+	return 0;
+}
+
+static int snd_ac97_vt1618_dcof_put(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	/* notice relationship between mask and shift! */
+
+	return snd_ac97_update_bits(pac97, 0x5a, 0x0400,
+				    ucontrol->value.enumerated.item[0] << 10);
+}
+
+
+/* enable disable headphone amp */
+
+static int snd_ac97_vt1618_hamp_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	return ac97_enum_text_info(kcontrol, uinfo, std_enable, 2);
+}
+
+static int snd_ac97_vt1618_hamp_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = (snd_ac97_read(pac97, 0x5c) &
+					      0x0020) >> 5;
+	return 0;
+}
+
+static int snd_ac97_vt1618_hamp_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	/* notice relationship between mask and shift! */
+
+	return snd_ac97_update_bits(pac97, 0x5c, 0x0020,
+				    ucontrol->value.enumerated.item[0] << 5);
+}
+
+
+/* enable disable surround back channel */
+
+static int snd_ac97_vt1618_srbk_info(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	return ac97_enum_text_info(kcontrol, uinfo, std_enable, 2);
+}
+
+static int snd_ac97_vt1618_srbk_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = (snd_ac97_read(pac97, 0x5c) &
+					      0x0008) >> 3;
+	return 0;
+}
+
+static int snd_ac97_vt1618_srbk_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	/* notice relationship between mask and shift! */
+
+	return snd_ac97_update_bits(pac97, 0x5c, 0x0008,
+				    ucontrol->value.enumerated.item[0] << 3);
+}
+
+
+/* enable disable soft mute */
+
+static int snd_ac97_vt1618_smute_info(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_info *uinfo)
+{
+	return ac97_enum_text_info(kcontrol, uinfo, std_enable, 2);
+}
+
+static int snd_ac97_vt1618_smute_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = (snd_ac97_read(pac97, 0x5c) &
+					      0x0001);
+	return 0;
+}
+
+static int snd_ac97_vt1618_smute_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	/* notice relationship between mask and shift! */
+
+	return snd_ac97_update_bits(pac97, 0x5c, 0x0001,
+				    ucontrol->value.enumerated.item[0]);
+}
+
+
+/* config aux in jack - not found on 3 jack motherboards or soundcards */
+
+static int snd_ac97_vt1618_auxin_info(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_info *uinfo)
+{
+	static const  char* texts[] = {"Aux In", "Surround Back Out"};
+	return ac97_enum_text_info(kcontrol, uinfo, texts, 2);
+}
+
+static int snd_ac97_vt1618_auxin_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = (snd_ac97_read(pac97, 0x76) &
+					      0x0008) >> 3;
+
+	return 0;
+}
+
+static int snd_ac97_vt1618_auxin_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	/* notice relationship between mask and shift! */
+
+	return snd_ac97_update_bits(pac97, 0x76, 0x0008,
+				    ucontrol->value.enumerated.item[0] << 3);
+}
+
+
+/*
+ * VIA implements 'Smart 5.1' completely differently on the 1618 than
+ * it does on the 1617a. awesome! They seem to have sourced this
+ * particular revision of the technology from somebody else, it's
+ * called Universal Audio Jack, it shows up on some other folk's chips
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
+ * CN700T, i have to set it to get surround output - YMMV, bad
+ * shit may happen.
+ *
+ * If other chips use Universal Audio Jack, then this code might be
+ * applicable to them.
+ */
+
+/* copied from ac97_surround_jack_mode_info() ordering in this list
+ * reflects vt1618 docs for Vendor Defined Register 0x60 */
+
+static int snd_ac97_vt1618_UAJ0_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	static const char* texts[] = { "Speaker Out", "DAC Unmixed Out", "Line  
In", "Mic In"};
+	return ac97_enum_text_info(kcontrol, uinfo, texts, 4);
+}
+
+/* UAJ1 and UAJ2 are not supposed to have 00 written to them?? i
+ * dunno, because thats something that i have to do to get 5.1 out to
+ * work. */
+
+static int snd_ac97_vt1618_UAJ1_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+        static const char* texts[] = { "Surround Out", "DAC Unmixed Out",  
"Line In", "Mic In"};
+	return ac97_enum_text_info(kcontrol, uinfo, texts, 4);
+}
+
+static int snd_ac97_vt1618_UAJ2_info(struct snd_kcontrol *kcontrol,  
struct snd_ctl_elem_info *uinfo)
+{
+        static const char* texts[] = { "Center/LowFre Out", "DAC Unmixed  
Out", "Line In", "Mic In"};
+        return ac97_enum_text_info(kcontrol, uinfo, texts, 4);
+}
+
+/* All of the vt1618 Universal Audio Jack twiddlers are on
+   Vendor Defined Register 0x60, page 0. The bits, and thus
+   the mask, are the only thing that changes */
+
+static int snd_ac97_vt1618_UAJ_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol, unsigned short mask)
+{
+	struct snd_ac97 *pac97;
+	ushort usDatPag, usUAJ, usShift = 0; // 0 is a possible value
+
+	if(0x000C == mask) usShift = 2;
+	if(0x0030 == mask) usShift = 4;
+
+	pac97 = snd_kcontrol_chip(kcontrol);
+
+        mutex_lock(&pac97->page_mutex);
+
+        usDatPag = snd_ac97_read(pac97, AC97_INT_PAGING) & AC97_PAGE_MASK;
+        snd_ac97_update_bits(pac97, AC97_INT_PAGING, AC97_PAGE_MASK, 0);
+
+	usUAJ = snd_ac97_read(pac97, 0x60) & mask;
+
+	snd_ac97_update_bits(pac97, AC97_INT_PAGING, AC97_PAGE_MASK, usDatPag);
+        mutex_unlock(&pac97->page_mutex); // unlock paging
+
+	ucontrol->value.enumerated.item[0] = usUAJ >> usShift;
+
+	return 0;
+}
+
+static int snd_ac97_vt1618_UAJ_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol,
+				   unsigned short mask)
+{
+	struct snd_ac97 *pac97;
+	ushort usUAJ, usShift = 0; /* 0 is a possible value */
+
+	if(0x000C == mask) usShift = 2;
+	if(0x0030 == mask) usShift = 4;
+
+	pac97 = snd_kcontrol_chip(kcontrol);
+
+	usUAJ = ucontrol->value.enumerated.item[0] << usShift;
+
+	return ac97_update_bits_page(pac97, 0x60, mask, usUAJ, 0);
+}
+
+static int snd_ac97_vt1618_UAJ0_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_ac97_vt1618_UAJ_get(kcontrol, ucontrol, 0x0003);
+}
+
+static int snd_ac97_vt1618_UAJ1_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_ac97_vt1618_UAJ_get(kcontrol, ucontrol, 0x000C);
+}
+
+static int snd_ac97_vt1618_UAJ2_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_ac97_vt1618_UAJ_get(kcontrol, ucontrol, 0x0030);
+}
+
+static int snd_ac97_vt1618_UAJ0_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_ac97_vt1618_UAJ_put(kcontrol, ucontrol, 0x0003);
+}
+
+static int snd_ac97_vt1618_UAJ1_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_ac97_vt1618_UAJ_put(kcontrol, ucontrol, 0x000C);
+}
+
+static int snd_ac97_vt1618_UAJ2_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_ac97_vt1618_UAJ_put(kcontrol, ucontrol, 0x0030);
+}
+
+static const struct snd_kcontrol_new snd_ac97_controls_vt1618[] = {
+
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Center LFE Exchange",
+		.info  = snd_ac97_vt1618_clex_info,
+		.get   = snd_ac97_vt1618_clex_get,
+		.put   = snd_ac97_vt1618_clex_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "DC Offset",
+		.info  = snd_ac97_vt1618_dcof_info,
+		.get   = snd_ac97_vt1618_dcof_get,
+		.put   = snd_ac97_vt1618_dcof_put
+	},diff --git a/pci/ac97/ac97_codec.c b/pci/ac97/ac97_codec.c
index d0023e9..a34f1ea 100644
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
+{ 0x56494182, 0xffffffff, "VIA1618",		patch_vt1618,   NULL }, // clean  
sheet of crinkled paper
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
index bb028f8..2042415 100644
--- a/pci/ac97/ac97_patch.c
+++ b/pci/ac97/ac97_patch.c
@@ -3465,7 +3465,7 @@ static int patch_vt1616(struct snd_ac97 * ac97)

  /*
   * unfortunately, the vt1617a stashes the twiddlers required for
- * nooding the i/o jacks on 2 different regs. * thameans that we cant
+ * nooding the i/o jacks on 2 different regs. that means that we cant
   * use the easy way provided by AC97_ENUM_DOUBLE() we have to write
   * are own funcs.
   *
@@ -3576,6 +3576,413 @@ int patch_vt1617a(struct snd_ac97 * ac97)
  	return err;
  }

+
+/* use these alot in the 1618 code but i cant find a better place to put  
them */
+
+static const char* std_enable[]  = {"Enabled", "Disabled"};
+static const char* std_disable[] = {"Disabled","Enabled"};
+
+/* disable enable c/lfe exchange */
+
+static int snd_ac97_vt1618_clex_info(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	return ac97_enum_text_info(kcontrol, uinfo, std_disable, 2);
+}
+
+static int snd_ac97_vt1618_clex_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = (snd_ac97_read(pac97, 0x5a) &
+					      0x0100) >> 8;
+	return 0;
+}
+
+static int snd_ac97_vt1618_clex_put(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	/* notice relationship between mask and shift! */
+
+	return snd_ac97_update_bits(pac97, 0x5a, 0x0100,
+				    ucontrol->value.enumerated.item[0] << 8);
+}
+
+
+/* disable enable dc offset */
+
+static int snd_ac97_vt1618_dcof_info(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	return ac97_enum_text_info(kcontrol, uinfo, std_disable, 2);
+}
+
+static int snd_ac97_vt1618_dcof_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = (snd_ac97_read(pac97, 0x5a) &
+					      0x0400) >> 10;
+	return 0;
+}
+
+static int snd_ac97_vt1618_dcof_put(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	/* notice relationship between mask and shift! */
+
+	return snd_ac97_update_bits(pac97, 0x5a, 0x0400,
+				    ucontrol->value.enumerated.item[0] << 10);
+}
+
+
+/* enable disable headphone amp */
+
+static int snd_ac97_vt1618_hamp_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	return ac97_enum_text_info(kcontrol, uinfo, std_enable, 2);
+}
+
+static int snd_ac97_vt1618_hamp_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = (snd_ac97_read(pac97, 0x5c) &
+					      0x0020) >> 5;
+	return 0;
+}
+
+static int snd_ac97_vt1618_hamp_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	/* notice relationship between mask and shift! */
+
+	return snd_ac97_update_bits(pac97, 0x5c, 0x0020,
+				    ucontrol->value.enumerated.item[0] << 5);
+}
+
+
+/* enable disable surround back channel */
+
+static int snd_ac97_vt1618_srbk_info(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	return ac97_enum_text_info(kcontrol, uinfo, std_enable, 2);
+}
+
+static int snd_ac97_vt1618_srbk_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = (snd_ac97_read(pac97, 0x5c) &
+					      0x0008) >> 3;
+	return 0;
+}
+
+static int snd_ac97_vt1618_srbk_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	/* notice relationship between mask and shift! */
+
+	return snd_ac97_update_bits(pac97, 0x5c, 0x0008,
+				    ucontrol->value.enumerated.item[0] << 3);
+}
+
+
+/* enable disable soft mute */
+
+static int snd_ac97_vt1618_smute_info(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_info *uinfo)
+{
+	return ac97_enum_text_info(kcontrol, uinfo, std_enable, 2);
+}
+
+static int snd_ac97_vt1618_smute_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = (snd_ac97_read(pac97, 0x5c) &
+					      0x0001);
+	return 0;
+}
+
+static int snd_ac97_vt1618_smute_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	/* notice relationship between mask and shift! */
+
+	return snd_ac97_update_bits(pac97, 0x5c, 0x0001,
+				    ucontrol->value.enumerated.item[0]);
+}
+
+
+/* config aux in jack - not found on 3 jack motherboards or soundcards */
+
+static int snd_ac97_vt1618_auxin_info(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_info *uinfo)
+{
+	static const  char* texts[] = {"Aux In", "Surround Back Out"};
+	return ac97_enum_text_info(kcontrol, uinfo, texts, 2);
+}
+
+static int snd_ac97_vt1618_auxin_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = (snd_ac97_read(pac97, 0x76) &
+					      0x0008) >> 3;
+
+	return 0;
+}
+
+static int snd_ac97_vt1618_auxin_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	/* notice relationship between mask and shift! */
+
+	return snd_ac97_update_bits(pac97, 0x76, 0x0008,
+				    ucontrol->value.enumerated.item[0] << 3);
+}
+
+
+/*
+ * VIA implements 'Smart 5.1' completely differently on the 1618 than
+ * it does on the 1617a. awesome! They seem to have sourced this
+ * particular revision of the technology from somebody else, it's
+ * called Universal Audio Jack, it shows up on some other folk's chips
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
+ * CN700T, i have to set it to get surround output - YMMV, bad
+ * shit may happen.
+ *
+ * If other chips use Universal Audio Jack, then this code might be
+ * applicable to them.
+ */
+
+/* copied from ac97_surround_jack_mode_info() ordering in this list
+ * reflects vt1618 docs for Vendor Defined Register 0x60 */
+
+static int snd_ac97_vt1618_UAJ0_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	static const char* texts[] = { "Speaker Out", "DAC Unmixed Out", "Line  
In", "Mic In"};
+	return ac97_enum_text_info(kcontrol, uinfo, texts, 4);
+}
+
+/* UAJ1 and UAJ2 are not supposed to have 00 written to them?? i
+ * dunno, because thats something that i have to do to get 5.1 out to
+ * work. */
+
+static int snd_ac97_vt1618_UAJ1_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+        static const char* texts[] = { "Surround Out", "DAC Unmixed Out",  
"Line In", "Mic In"};
+	return ac97_enum_text_info(kcontrol, uinfo, texts, 4);
+}
+
+static int snd_ac97_vt1618_UAJ2_info(struct snd_kcontrol *kcontrol,  
struct snd_ctl_elem_info *uinfo)
+{
+        static const char* texts[] = { "Center/LowFre Out", "DAC Unmixed  
Out", "Line In", "Mic In"};
+        return ac97_enum_text_info(kcontrol, uinfo, texts, 4);
+}
+
+/* All of the vt1618 Universal Audio Jack twiddlers are on
+   Vendor Defined Register 0x60, page 0. The bits, and thus
+   the mask, are the only thing that changes */
+
+static int snd_ac97_vt1618_UAJ_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol, unsigned short mask)
+{
+	struct snd_ac97 *pac97;
+	ushort usDatPag, usUAJ, usShift = 0; // 0 is a possible value
+
+	if(0x000C == mask) usShift = 2;
+	if(0x0030 == mask) usShift = 4;
+
+	pac97 = snd_kcontrol_chip(kcontrol);
+
+        mutex_lock(&pac97->page_mutex);
+
+        usDatPag = snd_ac97_read(pac97, AC97_INT_PAGING) & AC97_PAGE_MASK;
+        snd_ac97_update_bits(pac97, AC97_INT_PAGING, AC97_PAGE_MASK, 0);
+
+	usUAJ = snd_ac97_read(pac97, 0x60) & mask;
+
+	snd_ac97_update_bits(pac97, AC97_INT_PAGING, AC97_PAGE_MASK, usDatPag);
+        mutex_unlock(&pac97->page_mutex); // unlock paging
+
+	ucontrol->value.enumerated.item[0] = usUAJ >> usShift;
+
+	return 0;
+}
+
+static int snd_ac97_vt1618_UAJ_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol,
+				   unsigned short mask)
+{
+	struct snd_ac97 *pac97;
+	ushort usUAJ, usShift = 0; /* 0 is a possible value */
+
+	if(0x000C == mask) usShift = 2;
+	if(0x0030 == mask) usShift = 4;
+
+	pac97 = snd_kcontrol_chip(kcontrol);
+
+	usUAJ = ucontrol->value.enumerated.item[0] << usShift;
+
+	return ac97_update_bits_page(pac97, 0x60, mask, usUAJ, 0);
+}
+
+static int snd_ac97_vt1618_UAJ0_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_ac97_vt1618_UAJ_get(kcontrol, ucontrol, 0x0003);
+}
+
+static int snd_ac97_vt1618_UAJ1_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_ac97_vt1618_UAJ_get(kcontrol, ucontrol, 0x000C);
+}
+
+static int snd_ac97_vt1618_UAJ2_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_ac97_vt1618_UAJ_get(kcontrol, ucontrol, 0x0030);
+}
+
+static int snd_ac97_vt1618_UAJ0_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_ac97_vt1618_UAJ_put(kcontrol, ucontrol, 0x0003);
+}
+
+static int snd_ac97_vt1618_UAJ1_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_ac97_vt1618_UAJ_put(kcontrol, ucontrol, 0x000C);
+}
+
+static int snd_ac97_vt1618_UAJ2_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_ac97_vt1618_UAJ_put(kcontrol, ucontrol, 0x0030);
+}
+
+static const struct snd_kcontrol_new snd_ac97_controls_vt1618[] = {
+
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Center LFE Exchange",
+		.info  = snd_ac97_vt1618_clex_info,
+		.get   = snd_ac97_vt1618_clex_get,
+		.put   = snd_ac97_vt1618_clex_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "DC Offset",
+		.info  = snd_ac97_vt1618_dcof_info,
+		.get   = snd_ac97_vt1618_dcof_get,
+		.put   = snd_ac97_vt1618_dcof_diff --git a/pci/ac97/ac97_codec.c  
b/pci/ac97/ac97_codec.c
index d0023e9..a34f1ea 100644
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
+{ 0x56494182, 0xffffffff, "VIA1618",		patch_vt1618,   NULL }, // clean  
sheet of crinkled paper
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
index bb028f8..2042415 100644
--- a/pci/ac97/ac97_patch.c
+++ b/pci/ac97/ac97_patch.c
@@ -3465,7 +3465,7 @@ static int patch_vt1616(struct snd_ac97 * ac97)

  /*
   * unfortunately, the vt1617a stashes the twiddlers required for
- * nooding the i/o jacks on 2 different regs. * thameans that we cant
+ * nooding the i/o jacks on 2 different regs. that means that we cant
   * use the easy way provided by AC97_ENUM_DOUBLE() we have to write
   * are own funcs.
   *
@@ -3576,6 +3576,413 @@ int patch_vt1617a(struct snd_ac97 * ac97)
  	return err;
  }

+
+/* use these alot in the 1618 code but i cant find a better place to put  
them */
+
+static const char* std_enable[]  = {"Enabled", "Disabled"};
+static const char* std_disable[] = {"Disabled","Enabled"};
+
+/* disable enable c/lfe exchange */
+
+static int snd_ac97_vt1618_clex_info(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	return ac97_enum_text_info(kcontrol, uinfo, std_disable, 2);
+}
+
+static int snd_ac97_vt1618_clex_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = (snd_ac97_read(pac97, 0x5a) &
+					      0x0100) >> 8;
+	return 0;
+}
+
+static int snd_ac97_vt1618_clex_put(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	/* notice relationship between mask and shift! */
+
+	return snd_ac97_update_bits(pac97, 0x5a, 0x0100,
+				    ucontrol->value.enumerated.item[0] << 8);
+}
+
+
+/* disable enable dc offset */
+
+static int snd_ac97_vt1618_dcof_info(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	return ac97_enum_text_info(kcontrol, uinfo, std_disable, 2);
+}
+
+static int snd_ac97_vt1618_dcof_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = (snd_ac97_read(pac97, 0x5a) &
+					      0x0400) >> 10;
+	return 0;
+}
+
+static int snd_ac97_vt1618_dcof_put(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	/* notice relationship between mask and shift! */
+
+	return snd_ac97_update_bits(pac97, 0x5a, 0x0400,
+				    ucontrol->value.enumerated.item[0] << 10);
+}
+
+
+/* enable disable headphone amp */
+
+static int snd_ac97_vt1618_hamp_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	return ac97_enum_text_info(kcontrol, uinfo, std_enable, 2);
+}
+
+static int snd_ac97_vt1618_hamp_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = (snd_ac97_read(pac97, 0x5c) &
+					      0x0020) >> 5;
+	return 0;
+}
+
+static int snd_ac97_vt1618_hamp_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	/* notice relationship between mask and shift! */
+
+	return snd_ac97_update_bits(pac97, 0x5c, 0x0020,
+				    ucontrol->value.enumerated.item[0] << 5);
+}
+
+
+/* enable disable surround back channel */
+
+static int snd_ac97_vt1618_srbk_info(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	return ac97_enum_text_info(kcontrol, uinfo, std_enable, 2);
+}
+
+static int snd_ac97_vt1618_srbk_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = (snd_ac97_read(pac97, 0x5c) &
+					      0x0008) >> 3;
+	return 0;
+}
+
+static int snd_ac97_vt1618_srbk_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	/* notice relationship between mask and shift! */
+
+	return snd_ac97_update_bits(pac97, 0x5c, 0x0008,
+				    ucontrol->value.enumerated.item[0] << 3);
+}
+
+
+/* enable disable soft mute */
+
+static int snd_ac97_vt1618_smute_info(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_info *uinfo)
+{
+	return ac97_enum_text_info(kcontrol, uinfo, std_enable, 2);
+}
+
+static int snd_ac97_vt1618_smute_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = (snd_ac97_read(pac97, 0x5c) &
+					      0x0001);
+	return 0;
+}
+
+static int snd_ac97_vt1618_smute_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	/* notice relationship between mask and shift! */
+
+	return snd_ac97_update_bits(pac97, 0x5c, 0x0001,
+				    ucontrol->value.enumerated.item[0]);
+}
+
+
+/* config aux in jack - not found on 3 jack motherboards or soundcards */
+
+static int snd_ac97_vt1618_auxin_info(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_info *uinfo)
+{
+	static const  char* texts[] = {"Aux In", "Surround Back Out"};
+	return ac97_enum_text_info(kcontrol, uinfo, texts, 2);
+}
+
+static int snd_ac97_vt1618_auxin_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.enumerated.item[0] = (snd_ac97_read(pac97, 0x76) &
+					      0x0008) >> 3;
+
+	return 0;
+}
+
+static int snd_ac97_vt1618_auxin_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *pac97 = snd_kcontrol_chip(kcontrol);
+
+	/* notice relationship between mask and shift! */
+
+	return snd_ac97_update_bits(pac97, 0x76, 0x0008,
+				    ucontrol->value.enumerated.item[0] << 3);
+}
+
+
+/*
+ * VIA implements 'Smart 5.1' completely differently on the 1618 than
+ * it does on the 1617a. awesome! They seem to have sourced this
+ * particular revision of the technology from somebody else, it's
+ * called Universal Audio Jack, it shows up on some other folk's chips
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
+ * CN700T, i have to set it to get surround output - YMMV, bad
+ * shit may happen.
+ *
+ * If other chips use Universal Audio Jack, then this code might be
+ * applicable to them.
+ */
+
+/* copied from ac97_surround_jack_mode_info() ordering in this list
+ * reflects vt1618 docs for Vendor Defined Register 0x60 */
+
+static int snd_ac97_vt1618_UAJ0_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	static const char* texts[] = { "Speaker Out", "DAC Unmixed Out", "Line  
In", "Mic In"};
+	return ac97_enum_text_info(kcontrol, uinfo, texts, 4);
+}
+
+/* UAJ1 and UAJ2 are not supposed to have 00 written to them?? i
+ * dunno, because thats something that i have to do to get 5.1 out to
+ * work. */
+
+static int snd_ac97_vt1618_UAJ1_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+        static const char* texts[] = { "Surround Out", "DAC Unmixed Out",  
"Line In", "Mic In"};
+	return ac97_enum_text_info(kcontrol, uinfo, texts, 4);
+}
+
+static int snd_ac97_vt1618_UAJ2_info(struct snd_kcontrol *kcontrol,  
struct snd_ctl_elem_info *uinfo)
+{
+        static const char* texts[] = { "Center/LowFre Out", "DAC Unmixed  
Out", "Line In", "Mic In"};
+        return ac97_enum_text_info(kcontrol, uinfo, texts, 4);
+}
+
+/* All of the vt1618 Universal Audio Jack twiddlers are on
+   Vendor Defined Register 0x60, page 0. The bits, and thus
+   the mask, are the only thing that changes */
+
+static int snd_ac97_vt1618_UAJ_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol, unsigned short mask)
+{
+	struct snd_ac97 *pac97;
+	ushort usDatPag, usUAJ, usShift = 0; // 0 is a possible value
+
+	if(0x000C == mask) usShift = 2;
+	if(0x0030 == mask) usShift = 4;
+
+	pac97 = snd_kcontrol_chip(kcontrol);
+
+        mutex_lock(&pac97->page_mutex);
+
+        usDatPag = snd_ac97_read(pac97, AC97_INT_PAGING) & AC97_PAGE_MASK;
+        snd_ac97_update_bits(pac97, AC97_INT_PAGING, AC97_PAGE_MASK, 0);
+
+	usUAJ = snd_ac97_read(pac97, 0x60) & mask;
+
+	snd_ac97_update_bits(pac97, AC97_INT_PAGING, AC97_PAGE_MASK, usDatPag);
+        mutex_unlock(&pac97->page_mutex); // unlock paging
+
+	ucontrol->value.enumerated.item[0] = usUAJ >> usShift;
+
+	return 0;
+}
+
+static int snd_ac97_vt1618_UAJ_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol,
+				   unsigned short mask)
+{
+	struct snd_ac97 *pac97;
+	ushort usUAJ, usShift = 0; /* 0 is a possible value */
+
+	if(0x000C == mask) usShift = 2;
+	if(0x0030 == mask) usShift = 4;
+
+	pac97 = snd_kcontrol_chip(kcontrol);
+
+	usUAJ = ucontrol->value.enumerated.item[0] << usShift;
+
+	return ac97_update_bits_page(pac97, 0x60, mask, usUAJ, 0);
+}
+
+static int snd_ac97_vt1618_UAJ0_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_ac97_vt1618_UAJ_get(kcontrol, ucontrol, 0x0003);
+}
+
+static int snd_ac97_vt1618_UAJ1_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_ac97_vt1618_UAJ_get(kcontrol, ucontrol, 0x000C);
+}
+
+static int snd_ac97_vt1618_UAJ2_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_ac97_vt1618_UAJ_get(kcontrol, ucontrol, 0x0030);
+}
+
+static int snd_ac97_vt1618_UAJ0_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_ac97_vt1618_UAJ_put(kcontrol, ucontrol, 0x0003);
+}
+
+static int snd_ac97_vt1618_UAJ1_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_ac97_vt1618_UAJ_put(kcontrol, ucontrol, 0x000C);
+}
+
+static int snd_ac97_vt1618_UAJ2_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	return snd_ac97_vt1618_UAJ_put(kcontrol, ucontrol, 0x0030);
+}
+
+static const struct snd_kcontrol_new snd_ac97_controls_vt1618[] = {
+
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Center LFE Exchange",
+		.info  = snd_ac97_vt1618_clex_info,
+		.get   = snd_ac97_vt1618_clex_get,
+		.put   = snd_ac97_vt1618_clex_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "DC Offset",
+		.info  = snd_ac97_vt1618_dcof_info,
+		.get   = snd_ac97_vt1618_dcof_get,
+		.put   = snd_ac97_vt1618_dcof_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Headphone Amp",
+		.info  = snd_ac97_vt1618_hamp_info,
+		.get   = snd_ac97_vt1618_hamp_get,
+		.put   = snd_ac97_vt1618_hamp_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Surround Back",
+		.info  = snd_ac97_vt1618_srbk_info,
+		.get   = snd_ac97_vt1618_srbk_get,
+		.put   = snd_ac97_vt1618_srbk_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Soft Mute",
+		.info  = snd_ac97_vt1618_smute_info,
+		.get   = snd_ac97_vt1618_smute_get,
+		.put   = snd_ac97_vt1618_smute_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Aux In Jack",
+		.info  = snd_ac97_vt1618_auxin_info,
+		.get   = snd_ac97_vt1618_auxin_get,
+		.put   = snd_ac97_vt1618_auxin_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Speaker Jack",
+		.info  = snd_ac97_vt1618_UAJ0_info,
+		.get   = snd_ac97_vt1618_UAJ0_get,
+		.put   = snd_ac97_vt1618_UAJ0_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Line In Jack",
+		.info  = snd_ac97_vt1618_UAJ1_info,
+		.get   = snd_ac97_vt1618_UAJ1_get,
+		.put   = snd_ac97_vt1618_UAJ1_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Mic In Jack",
+		.info  = snd_ac97_vt1618_UAJ2_info,
+		.get   = snd_ac97_vt1618_UAJ2_get,
+		.put   = snd_ac97_vt1618_UAJ2_put
+	}
+};
+
+int patch_vt1618(struct snd_ac97 *ac97)
+{
+	return patch_build_controls(ac97, snd_ac97_controls_vt1618,
+				    ARRAY_SIZE(snd_ac97_controls_vt1618));
+}
+
+
  /*
   */
  static void it2646_update_jacks(struct snd_ac97 *ac97)
put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Headphone Amp",
+		.info  = snd_ac97_vt1618_hamp_info,
+		.get   = snd_ac97_vt1618_hamp_get,
+		.put   = snd_ac97_vt1618_hamp_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Surround Back",
+		.info  = snd_ac97_vt1618_srbk_info,
+		.get   = snd_ac97_vt1618_srbk_get,
+		.put   = snd_ac97_vt1618_srbk_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Soft Mute",
+		.info  = snd_ac97_vt1618_smute_info,
+		.get   = snd_ac97_vt1618_smute_get,
+		.put   = snd_ac97_vt1618_smute_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Aux In Jack",
+		.info  = snd_ac97_vt1618_auxin_info,
+		.get   = snd_ac97_vt1618_auxin_get,
+		.put   = snd_ac97_vt1618_auxin_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Speaker Jack",
+		.info  = snd_ac97_vt1618_UAJ0_info,
+		.get   = snd_ac97_vt1618_UAJ0_get,
+		.put   = snd_ac97_vt1618_UAJ0_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Line In Jack",
+		.info  = snd_ac97_vt1618_UAJ1_info,
+		.get   = snd_ac97_vt1618_UAJ1_get,
+		.put   = snd_ac97_vt1618_UAJ1_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Mic In Jack",
+		.info  = snd_ac97_vt1618_UAJ2_info,
+		.get   = snd_ac97_vt1618_UAJ2_get,
+		.put   = snd_ac97_vt1618_UAJ2_put
+	}
+};
+
+int patch_vt1618(struct snd_ac97 *ac97)
+{
+	return patch_build_controls(ac97, snd_ac97_controls_vt1618,
+				    ARRAY_SIZE(snd_ac97_controls_vt1618));
+}
+
+
  /*
   */
  static void it2646_update_jacks(struct snd_ac97 *ac97)

+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Headphone Amp",
+		.info  = snd_ac97_vt1618_hamp_info,
+		.get   = snd_ac97_vt1618_hamp_get,
+		.put   = snd_ac97_vt1618_hamp_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Surround Back",
+		.info  = snd_ac97_vt1618_srbk_info,
+		.get   = snd_ac97_vt1618_srbk_get,
+		.put   = snd_ac97_vt1618_srbk_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Soft Mute",
+		.info  = snd_ac97_vt1618_smute_info,
+		.get   = snd_ac97_vt1618_smute_get,
+		.put   = snd_ac97_vt1618_smute_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Aux In Jack",
+		.info  = snd_ac97_vt1618_auxin_info,
+		.get   = snd_ac97_vt1618_auxin_get,
+		.put   = snd_ac97_vt1618_auxin_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Speaker Jack",
+		.info  = snd_ac97_vt1618_UAJ0_info,
+		.get   = snd_ac97_vt1618_UAJ0_get,
+		.put   = snd_ac97_vt1618_UAJ0_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Line In Jack",
+		.info  = snd_ac97_vt1618_UAJ1_info,
+		.get   = snd_ac97_vt1618_UAJ1_get,
+		.put   = snd_ac97_vt1618_UAJ1_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name  = "Mic In Jack",
+		.info  = snd_ac97_vt1618_UAJ2_info,
+		.get   = snd_ac97_vt1618_UAJ2_get,
+		.put   = snd_ac97_vt1618_UAJ2_put
+	}
+};
+
+int patch_vt1618(struct snd_ac97 *ac97)
+{
+	return patch_build_controls(ac97, snd_ac97_controls_vt1618,
+				    ARRAY_SIZE(snd_ac97_controls_vt1618));
+}
+
+
  /*
   */
  static void it2646_update_jacks(struct snd_ac97 *ac97)
