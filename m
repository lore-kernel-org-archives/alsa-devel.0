From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add TLV_DB_SCALE_MUTE bit for
	relevant controls
Date: Tue,  2 Sep 2014 10:34:29 +0200
Message-ID: <1409646869-18224-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B61F265282
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 10:34:34 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B6225AD97
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 08:34:32 +0000 (UTC)
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

The DACs on Sigmatel/IDT codecs do mute at the lowest volume level,
and in the earlier drivers, we passed TLV_DB_SCALE_MUTE bit for each
volume control element like Speaker and Headphone as well as Master.
Along with the translation to the generic parser, however, the TLV bit
was lost for the slave controls (e.g. Speaker) but set only to
Master.  In theory this should have sufficed, but apps, particularly
PA, do care the slave volume bits, so we seem to see a regression in
the volume controls.

This patch adds a flag to hda_gen_spec to specify the DAC mute
feature, and adds the TLV bit properly for all relevant volume
controls.  Also, the TLV bit for vmaster is set in hda_generic.c, so
that we can get rid of all tricks from the codec driver side.

As the similar hack is applied to Conexant 5051 stuff, we can get rid
of it as well.

BugLink: https://bugs.launchpad.net/bugs/1357928
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c    | 9 ++++++++-
 sound/pci/hda/hda_generic.h    | 1 +
 sound/pci/hda/patch_conexant.c | 8 ++------
 sound/pci/hda/patch_sigmatel.c | 5 +----
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index b956449ddada..95121e818b4d 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -31,6 +31,7 @@
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/jack.h>
+#include <sound/tlv.h>
 #include "hda_codec.h"
 #include "hda_local.h"
 #include "hda_auto_parser.h"
@@ -1105,6 +1106,7 @@ enum {
  */
 static int assign_out_path_ctls(struct hda_codec *codec, struct nid_path *path)
 {
+	struct hda_gen_spec *spec = codec->spec;
 	hda_nid_t nid;
 	unsigned int val;
 	int badness = 0;
@@ -1119,6 +1121,8 @@ static int assign_out_path_ctls(struct hda_codec *codec, struct nid_path *path)
 	nid = look_for_out_vol_nid(codec, path);
 	if (nid) {
 		val = HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT);
+		if (spec->dac_min_mute)
+			val |= HDA_AMP_VAL_MIN_MUTE;
 		if (is_ctl_used(codec, val, NID_PATH_VOL_CTL))
 			badness += BAD_SHARED_VOL;
 		else
@@ -1880,9 +1884,12 @@ static int parse_output_paths(struct hda_codec *codec)
 		path = snd_hda_get_path_from_idx(codec, spec->out_paths[0]);
 		if (path)
 			spec->vmaster_nid = look_for_out_vol_nid(codec, path);
-		if (spec->vmaster_nid)
+		if (spec->vmaster_nid) {
 			snd_hda_set_vmaster_tlv(codec, spec->vmaster_nid,
 						HDA_OUTPUT, spec->vmaster_tlv);
+			if (spec->dac_min_mute)
+				spec->vmaster_tlv[3] |= TLV_DB_SCALE_MUTE;
+		}
 	}
 
 	/* set initial pinctl targets */
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index bb2dea743986..3f95f1d3f1f8 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -231,6 +231,7 @@ struct hda_gen_spec {
 	unsigned int add_stereo_mix_input:1; /* add aamix as a capture src */
 	unsigned int add_jack_modes:1; /* add i/o jack mode enum ctls */
 	unsigned int power_down_unused:1; /* power down unused widgets */
+	unsigned int dac_min_mute:1; /* minimal = mute for DACs */
 
 	/* other internal flags */
 	unsigned int no_analog:1; /* digital I/O only */
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 6f2fa838b635..c0b03c112187 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -26,7 +26,6 @@
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/jack.h>
-#include <sound/tlv.h>
 
 #include "hda_codec.h"
 #include "hda_local.h"
@@ -779,6 +778,7 @@ static const struct hda_model_fixup cxt5066_fixup_models[] = {
  */
 static void add_cx5051_fake_mutes(struct hda_codec *codec)
 {
+	struct conexant_spec *spec = codec->spec;
 	static hda_nid_t out_nids[] = {
 		0x10, 0x11, 0
 	};
@@ -788,6 +788,7 @@ static void add_cx5051_fake_mutes(struct hda_codec *codec)
 		snd_hda_override_amp_caps(codec, *p, HDA_OUTPUT,
 					  AC_AMPCAP_MIN_MUTE |
 					  query_amp_caps(codec, *p, HDA_OUTPUT));
+	spec->gen.dac_min_mute = true;
 }
 
 static int patch_conexant_auto(struct hda_codec *codec)
@@ -860,11 +861,6 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	if (codec->vendor_id == 0x14f15051) {
-		/* minimum value is actually mute */
-		spec->gen.vmaster_tlv[3] |= TLV_DB_SCALE_MUTE;
-	}
-
 	codec->patch_ops = cx_auto_patch_ops;
 
 	/* Some laptops with Conexant chips show stalls in S3 resume,
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index ea823e1100da..f26ec04a29b5 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -32,7 +32,6 @@
 #include <linux/module.h>
 #include <sound/core.h>
 #include <sound/jack.h>
-#include <sound/tlv.h>
 #include "hda_codec.h"
 #include "hda_local.h"
 #include "hda_auto_parser.h"
@@ -4227,9 +4226,6 @@ static int stac_parse_auto_config(struct hda_codec *codec)
 	if (err < 0)
 		return err;
 
-	/* minimum value is actually mute */
-	spec->gen.vmaster_tlv[3] |= TLV_DB_SCALE_MUTE;
-
 	/* setup analog beep controls */
 	if (spec->anabeep_nid > 0) {
 		err = stac_auto_create_beep_ctls(codec,
@@ -4413,6 +4409,7 @@ static int alloc_stac_spec(struct hda_codec *codec)
 	snd_hda_gen_spec_init(&spec->gen);
 	codec->spec = spec;
 	codec->no_trigger_sense = 1; /* seems common with STAC/IDT codecs */
+	spec->gen.dac_min_mute = true;
 	return 0;
 }
 
-- 
2.1.0
