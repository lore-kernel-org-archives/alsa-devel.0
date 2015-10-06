From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 10/18] ALSA: hda: move patch_cirrus to use hdac
	helpers
Date: Tue,  6 Oct 2015 16:07:47 +0100
Message-ID: <1444144075-28963-11-git-send-email-vinod.koul@intel.com>
References: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D1E426592A
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:10:32 +0200 (CEST)
In-Reply-To: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Move patch_cirrus to use newly moved snd_hdac_read/write_codec()
APIs

This was done using coccinelle script

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/patch_cirrus.c | 52 +++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 584a0343ab0c..f07b90bb438f 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -142,9 +142,9 @@ enum {
 static inline int cs_vendor_coef_get(struct hda_codec *codec, unsigned int idx)
 {
 	struct cs_spec *spec = codec->spec;
-	snd_hda_codec_write(codec, spec->vendor_nid, 0,
-			    AC_VERB_SET_COEF_INDEX, idx);
-	return snd_hda_codec_read(codec, spec->vendor_nid, 0,
+	snd_hdac_codec_write(&codec->core, spec->vendor_nid, 0,
+			     AC_VERB_SET_COEF_INDEX, idx);
+	return snd_hdac_codec_read(&codec->core, spec->vendor_nid, 0,
 				  AC_VERB_GET_PROC_COEF, 0);
 }
 
@@ -152,10 +152,10 @@ static inline void cs_vendor_coef_set(struct hda_codec *codec, unsigned int idx,
 				      unsigned int coef)
 {
 	struct cs_spec *spec = codec->spec;
-	snd_hda_codec_write(codec, spec->vendor_nid, 0,
-			    AC_VERB_SET_COEF_INDEX, idx);
-	snd_hda_codec_write(codec, spec->vendor_nid, 0,
-			    AC_VERB_SET_PROC_COEF, coef);
+	snd_hdac_codec_write(&codec->core, spec->vendor_nid, 0,
+			     AC_VERB_SET_COEF_INDEX, idx);
+	snd_hdac_codec_write(&codec->core, spec->vendor_nid, 0,
+			     AC_VERB_SET_PROC_COEF, coef);
 }
 
 /*
@@ -176,8 +176,8 @@ static void cs_automute(struct hda_codec *codec)
 	if (spec->gpio_eapd_hp || spec->gpio_eapd_speaker) {
 		spec->gpio_data = spec->gen.hp_jack_present ?
 			spec->gpio_eapd_hp : spec->gpio_eapd_speaker;
-		snd_hda_codec_write(codec, 0x01, 0,
-				    AC_VERB_SET_GPIO_DATA, spec->gpio_data);
+		snd_hdac_codec_write(&codec->core, 0x01, 0,
+				     AC_VERB_SET_GPIO_DATA, spec->gpio_data);
 	}
 }
 
@@ -316,12 +316,13 @@ static int cs_init(struct hda_codec *codec)
 	snd_hda_gen_init(codec);
 
 	if (spec->gpio_mask) {
-		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK,
-				    spec->gpio_mask);
-		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DIRECTION,
-				    spec->gpio_dir);
-		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA,
-				    spec->gpio_data);
+		snd_hdac_codec_write(&codec->core, 0x01, 0,
+				     AC_VERB_SET_GPIO_MASK, spec->gpio_mask);
+		snd_hdac_codec_write(&codec->core, 0x01, 0,
+				     AC_VERB_SET_GPIO_DIRECTION,
+				     spec->gpio_dir);
+		snd_hdac_codec_write(&codec->core, 0x01, 0,
+				     AC_VERB_SET_GPIO_DATA, spec->gpio_data);
 	}
 
 	if (spec->vendor_nid == CS420X_VENDOR_NID) {
@@ -1033,12 +1034,13 @@ static int cs421x_init(struct hda_codec *codec)
 	snd_hda_gen_init(codec);
 
 	if (spec->gpio_mask) {
-		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_MASK,
-				    spec->gpio_mask);
-		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DIRECTION,
-				    spec->gpio_dir);
-		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA,
-				    spec->gpio_data);
+		snd_hdac_codec_write(&codec->core, 0x01, 0,
+				     AC_VERB_SET_GPIO_MASK, spec->gpio_mask);
+		snd_hdac_codec_write(&codec->core, 0x01, 0,
+				     AC_VERB_SET_GPIO_DIRECTION,
+				     spec->gpio_dir);
+		snd_hdac_codec_write(&codec->core, 0x01, 0,
+				     AC_VERB_SET_GPIO_DATA, spec->gpio_data);
 	}
 
 	init_input_coef(codec);
@@ -1111,10 +1113,10 @@ static int cs421x_suspend(struct hda_codec *codec)
 
 	snd_hda_shutup_pins(codec);
 
-	snd_hda_codec_write(codec, CS4210_DAC_NID, 0,
-			    AC_VERB_SET_POWER_STATE,  AC_PWRST_D3);
-	snd_hda_codec_write(codec, CS4210_ADC_NID, 0,
-			    AC_VERB_SET_POWER_STATE,  AC_PWRST_D3);
+	snd_hdac_codec_write(&codec->core, CS4210_DAC_NID, 0,
+			     AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+	snd_hdac_codec_write(&codec->core, CS4210_ADC_NID, 0,
+			     AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
 
 	if (spec->vendor_nid == CS4210_VENDOR_NID) {
 		coef = cs_vendor_coef_get(codec, CS421X_IDX_DEV_CFG);
-- 
2.4.3
