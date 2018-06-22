From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/16] ALSA: hda/realtek - Allow skipping
	spec->init_amp detection
Date: Fri, 22 Jun 2018 11:53:37 +0200
Message-ID: <20180622095352.19451-2-tiwai@suse.de>
References: <20180622095352.19451-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F06C2676D9
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 11:53:54 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 502DEAE5C
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 09:53:54 +0000 (UTC)
In-Reply-To: <20180622095352.19451-1-tiwai@suse.de>
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

Some devices have the overrides of spec->init_amp at
HDA_FIXUP_ACT_PROBE just because alc_ssid_check() gives the
false-positive values from the SSID.

For more consistent behavior, define the logic in the following way:

- Define ALC_INIT_UNDEFINED as the default value before calling
  alc_ssid_check()
- Each fixup may set up spec->init_amp with another value at
  HDA_FIXUP_ACT_PRE_PROBE
- At detection, check whether spec->init_amp is ALC_INIT_UNDEFINED or
  not; if it's different, we skip the detection

Also, it turned out that ASUS TX300 requires the spec->init_amp
override, too; currently it ignores the GPIO bits implicitly by its
static init verb, but this will be changed in the later patchset.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 44 +++++++++++++++++------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7934c5df4d80..1f054e5ae2b3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -43,6 +43,7 @@
 
 /* extra amp-initialization sequence types */
 enum {
+	ALC_INIT_UNDEFINED,
 	ALC_INIT_NONE,
 	ALC_INIT_DEFAULT,
 	ALC_INIT_GPIO1,
@@ -656,20 +657,22 @@ static int alc_subsystem_id(struct hda_codec *codec, const hda_nid_t *ports)
 	 * 7~6 : Reserved
 	*/
 	tmp = (ass & 0x38) >> 3;	/* external Amp control */
-	switch (tmp) {
-	case 1:
-		spec->init_amp = ALC_INIT_GPIO1;
-		break;
-	case 3:
-		spec->init_amp = ALC_INIT_GPIO2;
-		break;
-	case 7:
-		spec->init_amp = ALC_INIT_GPIO3;
-		break;
-	case 5:
-	default:
-		spec->init_amp = ALC_INIT_DEFAULT;
-		break;
+	if (spec->init_amp == ALC_INIT_UNDEFINED) {
+		switch (tmp) {
+		case 1:
+			spec->init_amp = ALC_INIT_GPIO1;
+			break;
+		case 3:
+			spec->init_amp = ALC_INIT_GPIO2;
+			break;
+		case 7:
+			spec->init_amp = ALC_INIT_GPIO3;
+			break;
+		case 5:
+		default:
+			spec->init_amp = ALC_INIT_DEFAULT;
+			break;
+		}
 	}
 
 	/* is laptop or Desktop and enable the function "Mute internal speaker
@@ -1589,8 +1592,6 @@ static void alc260_fixup_kn1(struct hda_codec *codec,
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
 		snd_hda_apply_pincfgs(codec, pincfgs);
-		break;
-	case HDA_FIXUP_ACT_PROBE:
 		spec->init_amp = ALC_INIT_NONE;
 		break;
 	}
@@ -1600,7 +1601,7 @@ static void alc260_fixup_fsc_s7020(struct hda_codec *codec,
 				   const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
-	if (action == HDA_FIXUP_ACT_PROBE)
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
 		spec->init_amp = ALC_INIT_NONE;
 }
 
@@ -3892,6 +3893,7 @@ static void alc280_fixup_hp_gpio2_mic_hotkey(struct hda_codec *codec,
 	struct alc_spec *spec = codec->spec;
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->init_amp = ALC_INIT_DEFAULT;
 		if (alc_register_micmute_input_device(codec) != 0)
 			return;
 
@@ -3914,9 +3916,6 @@ static void alc280_fixup_hp_gpio2_mic_hotkey(struct hda_codec *codec,
 		return;
 
 	switch (action) {
-	case HDA_FIXUP_ACT_PROBE:
-		spec->init_amp = ALC_INIT_DEFAULT;
-		break;
 	case HDA_FIXUP_ACT_FREE:
 		input_unregister_device(spec->kb_dev);
 		spec->kb_dev = NULL;
@@ -3937,6 +3936,7 @@ static void alc233_fixup_lenovo_line2_mic_hotkey(struct hda_codec *codec,
 	struct alc_spec *spec = codec->spec;
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->init_amp = ALC_INIT_DEFAULT;
 		if (alc_register_micmute_input_device(codec) != 0)
 			return;
 
@@ -3955,9 +3955,6 @@ static void alc233_fixup_lenovo_line2_mic_hotkey(struct hda_codec *codec,
 		return;
 
 	switch (action) {
-	case HDA_FIXUP_ACT_PROBE:
-		spec->init_amp = ALC_INIT_DEFAULT;
-		break;
 	case HDA_FIXUP_ACT_FREE:
 		input_unregister_device(spec->kb_dev);
 		spec->kb_dev = NULL;
@@ -5227,6 +5224,7 @@ static void alc282_fixup_asus_tx300(struct hda_codec *codec,
 
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
+		spec->init_amp = ALC_INIT_DEFAULT;
 		snd_hda_add_verbs(codec, gpio2_verbs);
 		snd_hda_apply_pincfgs(codec, dock_pins);
 		spec->gen.auto_mute_via_amp = 1;
-- 
2.17.1
