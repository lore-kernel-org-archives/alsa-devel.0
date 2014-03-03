From: Kailang <kailang@realtek.com>
Subject: Enable headset Mic for Dell DT
Date: Mon, 3 Mar 2014 15:42:42 +0800
Message-ID: <0B17B26B155A499C9D1F0B0FA4567E7D@realtek.com.tw>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C99D2655D3
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 08:42:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kailang <kailang@realtek.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 Hi Takashi,

I created patch below for Dell DT for support headset MIC.
Many Thanks.

Kailang.


>From 2f448d6f9ad7023befa91b80f86cb267311d3f8a Mon Sep 17 00:00:00 2001
From: Kailang Yang <kailang@realtek.com>
Date: Mon, 3 Mar 2014 15:27:22 +0800
Subject: [PATCH] ALSA: hda/realtek - Add headset quirk for Dell DT

This quirk is needed for the headset microphone to work.

Signed-off-by: Kailang Yang <kailang@realtek.com>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 534796e..74456bd 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3594,21 +3594,38 @@ static void alc_fixup_headset_mode_no_hp_mic(struct 
hda_codec *codec,
   alc_fixup_headset_mode(codec, fix, action);
 }

+static void alc255_set_default_jack_type(struct hda_codec *codec)
+{
+ /* Set to iphone type */
+ alc_write_coef_idx(codec, 0x1b, 0x880b);
+ alc_write_coef_idx(codec, 0x45, 0xd089);
+ alc_write_coef_idx(codec, 0x1b, 0x080b);
+ alc_write_coef_idx(codec, 0x46, 0x0004);
+ alc_write_coef_idx(codec, 0x1b, 0x0c0b);
+ msleep(30);
+}
+
 static void alc_fixup_headset_mode_alc255(struct hda_codec *codec,
     const struct hda_fixup *fix, int action)
 {
  if (action == HDA_FIXUP_ACT_PRE_PROBE) {
-  /* Set to iphone type */
-  alc_write_coef_idx(codec, 0x1b, 0x880b);
-  alc_write_coef_idx(codec, 0x45, 0xd089);
-  alc_write_coef_idx(codec, 0x1b, 0x080b);
-  alc_write_coef_idx(codec, 0x46, 0x0004);
-  alc_write_coef_idx(codec, 0x1b, 0x0c0b);
-  msleep(30);
+  alc255_set_default_jack_type(codec);
  }
  alc_fixup_headset_mode(codec, fix, action);
 }

+static void alc_fixup_headset_mode_alc255_no_hp_mic(struct hda_codec 
*codec,
+    const struct hda_fixup *fix, int action)
+{
+ if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+  struct alc_spec *spec = codec->spec;
+  spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
+  alc255_set_default_jack_type(codec);
+ }
+ else
+  alc_fixup_headset_mode(codec, fix, action);
+}
+
 static void alc_fixup_auto_mute_via_amp(struct hda_codec *codec,
      const struct hda_fixup *fix, int action)
 {
@@ -3875,7 +3892,9 @@ enum {
  ALC290_FIXUP_SUBWOOFER_HSJACK,
  ALC269_FIXUP_THINKPAD_ACPI,
  ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+ ALC255_FIXUP_DELL2_MIC_NO_PRESENCE,
  ALC255_FIXUP_HEADSET_MODE,
+ ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC,
 };

 static const struct hda_fixup alc269_fixups[] = {
@@ -4248,10 +4267,23 @@ static const struct hda_fixup alc269_fixups[] = {
   .chained = true,
   .chain_id = ALC255_FIXUP_HEADSET_MODE
  },
+ [ALC255_FIXUP_DELL2_MIC_NO_PRESENCE] = {
+  .type = HDA_FIXUP_PINS,
+  .v.pins = (const struct hda_pintbl[]) {
+   { 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect 
*/
+   { }
+  },
+  .chained = true,
+  .chain_id = ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC
+ },
  [ALC255_FIXUP_HEADSET_MODE] = {
   .type = HDA_FIXUP_FUNC,
   .v.func = alc_fixup_headset_mode_alc255,
  },
+ [ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC] = {
+  .type = HDA_FIXUP_FUNC,
+  .v.func = alc_fixup_headset_mode_alc255_no_hp_mic,
+ },
 };

 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -4314,6 +4346,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = 
{
  SND_PCI_QUIRK(0x1028, 0x0658, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
  SND_PCI_QUIRK(0x1028, 0x065f, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
  SND_PCI_QUIRK(0x1028, 0x0662, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE),
+ SND_PCI_QUIRK(0x1028, 0x0668, "Dell", ALC255_FIXUP_DELL2_MIC_NO_PRESENCE),
+ SND_PCI_QUIRK(0x1028, 0x0669, "Dell", ALC255_FIXUP_DELL2_MIC_NO_PRESENCE),
  SND_PCI_QUIRK(0x1028, 0x15cc, "Dell X5 Precision", 
ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
  SND_PCI_QUIRK(0x1028, 0x15cd, "Dell X5 Precision", 
ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
  SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2), 
