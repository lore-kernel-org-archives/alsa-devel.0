From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2] ALSA: hda - Add a headset mic model for
	ALC269 and friends
Date: Thu, 10 Oct 2013 12:19:23 +0200
Message-ID: <1381400364-6067-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id BCD872607B6
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 12:19:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: 1227093@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 Documentation/sound/alsa/HD-Audio-Models.txt |    1 +
 sound/pci/hda/patch_realtek.c                |   15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index f911e36..ba143cd 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -28,6 +28,7 @@ ALC269/270/275/276/28x/29x
   alc269-dmic		Enable ALC269(VA) digital mic workaround
   alc271-dmic		Enable ALC271X digital mic workaround
   inv-dmic		Inverted internal mic workaround
+  headset-mic           Indicates a combined headset (mic+headphone jack)
   lenovo-dock   	Enables docking station I/O for some Lenovos
   dell-headset-multi	Headset jack, which can also be used as mic-in
   dell-headset-dock	Headset jack (without mic-in), and also dock I/O
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ed9deb6..8cb3350 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2819,6 +2819,15 @@ static void alc269_fixup_hweq(struct hda_codec *codec,
 	alc_write_coef_idx(codec, 0x1e, coef | 0x80);
 }
 
+static void alc269_fixup_headset_mic(struct hda_codec *codec,
+				       const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
+}
+
 static void alc271_fixup_dmic(struct hda_codec *codec,
 			      const struct hda_fixup *fix, int action)
 {
@@ -3516,6 +3525,7 @@ enum {
 	ALC271_FIXUP_DMIC,
 	ALC269_FIXUP_PCM_44K,
 	ALC269_FIXUP_STEREO_DMIC,
+	ALC269_FIXUP_HEADSET_MIC,
 	ALC269_FIXUP_QUANTA_MUTE,
 	ALC269_FIXUP_LIFEBOOK,
 	ALC269_FIXUP_AMIC,
@@ -3614,6 +3624,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_stereo_dmic,
 	},
+	[ALC269_FIXUP_HEADSET_MIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_headset_mic,
+	},
 	[ALC269_FIXUP_QUANTA_MUTE] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_quanta_mute,
@@ -3979,6 +3993,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC269_FIXUP_STEREO_DMIC, .name = "alc269-dmic"},
 	{.id = ALC271_FIXUP_DMIC, .name = "alc271-dmic"},
 	{.id = ALC269_FIXUP_INV_DMIC, .name = "inv-dmic"},
+	{.id = ALC269_FIXUP_HEADSET_MIC, .name = "headset-mic"},
 	{.id = ALC269_FIXUP_LENOVO_DOCK, .name = "lenovo-dock"},
 	{.id = ALC269_FIXUP_HP_GPIO_LED, .name = "hp-gpio-led"},
 	{.id = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE, .name = "dell-headset-multi"},
-- 
1.7.9.5
