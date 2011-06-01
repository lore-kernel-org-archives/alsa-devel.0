From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 3/6] ALSA: hda: Virtualize SPDIF out controls
Date: Wed,  1 Jun 2011 11:14:18 -0600
Message-ID: <1306948461-2402-4-git-send-email-swarren@nvidia.com>
References: <1306948461-2402-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A10D1038C0
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 19:14:49 +0200 (CEST)
In-Reply-To: <1306948461-2402-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz, wfg@linux.intel.com
Cc: wni@nvidia.com, Stephen Warren <swarren@nvidia.com>, ndaga@nvidia.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The SPDIF output controls apply to converter widgets. A future change
will create a PCM device per pin widget, and hence a set of SPDIF output
controls per pin widget, for certain HDMI codecs. To support this, we
need the ability to virtualize the SPDIF output controls. Specifically:

* Controls can be "unassigned" from real hardware when a converter is
  not used for the PCM the control was created for.
* Control puts only write to hardware when they are assigned.
* Controls can be "assigned" to real hardware when a converter is picked
  to support output for a particular PCM.
* When a converter is assigned, the hardware is updated to the cached
  configuration.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/pci/hda/hda_codec.c      |   62 +++++++++++++++++++++++++++++----------
 sound/pci/hda/hda_codec.h      |    2 +
 sound/pci/hda/hda_local.h      |    4 ++-
 sound/pci/hda/patch_analog.c   |    4 ++-
 sound/pci/hda/patch_ca0110.c   |    3 +-
 sound/pci/hda/patch_cirrus.c   |    3 +-
 sound/pci/hda/patch_cmedia.c   |    4 ++-
 sound/pci/hda/patch_conexant.c |    1 +
 sound/pci/hda/patch_hdmi.c     |    3 +-
 sound/pci/hda/patch_realtek.c  |    1 +
 sound/pci/hda/patch_sigmatel.c |    4 ++-
 sound/pci/hda/patch_via.c      |    1 +
 12 files changed, 69 insertions(+), 23 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index e17e299..c63a067 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2663,10 +2663,8 @@ static int snd_hda_spdif_default_put(struct snd_kcontrol *kcontrol,
 	val |= spdif->ctls & 1;
 	change = spdif->ctls != val;
 	spdif->ctls = val;
-
-	if (change)
+	if (change && nid != (u16)-1)
 		set_dig_out_convert(codec, nid, val & 0xff, (val >> 8) & 0xff);
-
 	mutex_unlock(&codec->spdif_mutex);
 	return change;
 }
@@ -2684,6 +2682,17 @@ static int snd_hda_spdif_out_switch_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static inline void set_spdif_ctls(struct hda_codec *codec, hda_nid_t nid,
+				  int dig1, int dig2)
+{
+	set_dig_out_convert(codec, nid, dig1, dig2);
+	/* unmute amp switch (if any) */
+	if ((get_wcaps(codec, nid) & AC_WCAP_OUT_AMP) &&
+	    (dig1 & AC_DIG1_ENABLE))
+		snd_hda_codec_amp_stereo(codec, nid, HDA_OUTPUT, 0,
+					    HDA_AMP_MUTE, 0);
+}
+
 static int snd_hda_spdif_out_switch_put(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_value *ucontrol)
 {
@@ -2699,15 +2708,9 @@ static int snd_hda_spdif_out_switch_put(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.integer.value[0])
 		val |= AC_DIG1_ENABLE;
 	change = spdif->ctls != val;
-	if (change) {
-		spdif->ctls = val;
-		set_dig_out_convert(codec, nid, val & 0xff, -1);
-		/* unmute amp switch (if any) */
-		if ((get_wcaps(codec, nid) & AC_WCAP_OUT_AMP) &&
-		    (val & AC_DIG1_ENABLE))
-			snd_hda_codec_amp_stereo(codec, nid, HDA_OUTPUT, 0,
-						 HDA_AMP_MUTE, 0);
-	}
+	spdif->ctls = val;
+	if (change && nid != (u16)-1)
+		set_spdif_ctls(codec, nid, val & 0xff, -1);
 	mutex_unlock(&codec->spdif_mutex);
 	return change;
 }
@@ -2754,7 +2757,9 @@ static struct snd_kcontrol_new dig_mixes[] = {
  *
  * Returns 0 if successful, or a negative error code.
  */
-int snd_hda_create_spdif_out_ctls(struct hda_codec *codec, hda_nid_t nid)
+int snd_hda_create_spdif_out_ctls(struct hda_codec *codec,
+				  hda_nid_t associated_nid,
+				  hda_nid_t cvt_nid)
 {
 	int err;
 	struct snd_kcontrol *kctl;
@@ -2774,12 +2779,12 @@ int snd_hda_create_spdif_out_ctls(struct hda_codec *codec, hda_nid_t nid)
 			return -ENOMEM;
 		kctl->id.index = idx;
 		kctl->private_value = codec->spdif_out.used - 1;
-		err = snd_hda_ctl_add(codec, nid, kctl);
+		err = snd_hda_ctl_add(codec, associated_nid, kctl);
 		if (err < 0)
 			return err;
 	}
-	spdif->nid = nid;
-	spdif->ctls = snd_hda_codec_read(codec, nid, 0,
+	spdif->nid = cvt_nid;
+	spdif->ctls = snd_hda_codec_read(codec, cvt_nid, 0,
 					 AC_VERB_GET_DIGI_CONVERT_1, 0);
 	spdif->status = convert_to_spdif_status(spdif->ctls);
 	return 0;
@@ -2800,6 +2805,31 @@ struct hda_spdif_out *snd_hda_spdif_out_of_nid(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_HDA(snd_hda_spdif_out_of_nid);
 
+void snd_hda_spdif_ctls_unassign(struct hda_codec *codec, int idx)
+{
+	struct hda_spdif_out *spdif = snd_array_elem(&codec->spdif_out, idx);
+
+	mutex_lock(&codec->spdif_mutex);
+	spdif->nid = (u16)-1;
+	mutex_unlock(&codec->spdif_mutex);
+}
+EXPORT_SYMBOL_HDA(snd_hda_spdif_ctls_unassign);
+
+void snd_hda_spdif_ctls_assign(struct hda_codec *codec, int idx, hda_nid_t nid)
+{
+	struct hda_spdif_out *spdif = snd_array_elem(&codec->spdif_out, idx);
+	unsigned short val;
+
+	mutex_lock(&codec->spdif_mutex);
+	if (spdif->nid != nid) {
+		spdif->nid = nid;
+		val = spdif->ctls;
+		set_spdif_ctls(codec, nid, val & 0xff, (val >> 8) & 0xff);
+	}
+	mutex_unlock(&codec->spdif_mutex);
+}
+EXPORT_SYMBOL_HDA(snd_hda_spdif_ctls_assign);
+
 /*
  * SPDIF sharing with analog output
  */
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 1d21c06..96c35ca 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -954,6 +954,8 @@ struct hda_spdif_out {
 };
 struct hda_spdif_out *snd_hda_spdif_out_of_nid(struct hda_codec *codec,
 					       hda_nid_t nid);
+void snd_hda_spdif_ctls_unassign(struct hda_codec *codec, int idx);
+void snd_hda_spdif_ctls_assign(struct hda_codec *codec, int idx, hda_nid_t nid);
 
 /*
  * Mixer
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 08ec073..8b88c92 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -212,7 +212,9 @@ int snd_hda_mixer_bind_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 /*
  * SPDIF I/O
  */
-int snd_hda_create_spdif_out_ctls(struct hda_codec *codec, hda_nid_t nid);
+int snd_hda_create_spdif_out_ctls(struct hda_codec *codec,
+				  hda_nid_t associated_nid,
+				  hda_nid_t cvt_nid);
 int snd_hda_create_spdif_in_ctls(struct hda_codec *codec, hda_nid_t nid);
 
 /*
diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 696ac25..f3d5a95 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -213,7 +213,9 @@ static int ad198x_build_controls(struct hda_codec *codec)
 			return err;
 	}
 	if (spec->multiout.dig_out_nid) {
-		err = snd_hda_create_spdif_out_ctls(codec, spec->multiout.dig_out_nid);
+		err = snd_hda_create_spdif_out_ctls(codec,
+						    spec->multiout.dig_out_nid,
+						    spec->multiout.dig_out_nid);
 		if (err < 0)
 			return err;
 		err = snd_hda_create_spdif_share_sw(codec,
diff --git a/sound/pci/hda/patch_ca0110.c b/sound/pci/hda/patch_ca0110.c
index 61b9263..6b40684 100644
--- a/sound/pci/hda/patch_ca0110.c
+++ b/sound/pci/hda/patch_ca0110.c
@@ -240,7 +240,8 @@ static int ca0110_build_controls(struct hda_codec *codec)
 	}
 
 	if (spec->dig_out) {
-		err = snd_hda_create_spdif_out_ctls(codec, spec->dig_out);
+		err = snd_hda_create_spdif_out_ctls(codec, spec->dig_out,
+						    spec->dig_out);
 		if (err < 0)
 			return err;
 		err = snd_hda_create_spdif_share_sw(codec, &spec->multiout);
diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 26a1521..c7b5ca2 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -821,7 +821,8 @@ static int build_digital_output(struct hda_codec *codec)
 	if (!spec->multiout.dig_out_nid)
 		return 0;
 
-	err = snd_hda_create_spdif_out_ctls(codec, spec->multiout.dig_out_nid);
+	err = snd_hda_create_spdif_out_ctls(codec, spec->multiout.dig_out_nid,
+					    spec->multiout.dig_out_nid);
 	if (err < 0)
 		return err;
 	err = snd_hda_create_spdif_share_sw(codec, &spec->multiout);
diff --git a/sound/pci/hda/patch_cmedia.c b/sound/pci/hda/patch_cmedia.c
index ab3308d..9eaf99b 100644
--- a/sound/pci/hda/patch_cmedia.c
+++ b/sound/pci/hda/patch_cmedia.c
@@ -327,7 +327,9 @@ static int cmi9880_build_controls(struct hda_codec *codec)
 			return err;
 	}
 	if (spec->multiout.dig_out_nid) {
-		err = snd_hda_create_spdif_out_ctls(codec, spec->multiout.dig_out_nid);
+		err = snd_hda_create_spdif_out_ctls(codec,
+						    spec->multiout.dig_out_nid,
+						    spec->multiout.dig_out_nid);
 		if (err < 0)
 			return err;
 		err = snd_hda_create_spdif_share_sw(codec,
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 3e6b9a8..217ca9e 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -510,6 +510,7 @@ static int conexant_build_controls(struct hda_codec *codec)
 	}
 	if (spec->multiout.dig_out_nid) {
 		err = snd_hda_create_spdif_out_ctls(codec,
+						    spec->multiout.dig_out_nid,
 						    spec->multiout.dig_out_nid);
 		if (err < 0)
 			return err;
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 86b35a0..13ee444 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1095,7 +1095,8 @@ static int generic_hdmi_build_controls(struct hda_codec *codec)
 	int i;
 
 	for (i = 0; i < codec->num_pcms; i++) {
-		err = snd_hda_create_spdif_out_ctls(codec, spec->cvt[i]);
+		err = snd_hda_create_spdif_out_ctls(codec, spec->cvt[i],
+						    spec->cvt[i]);
 		if (err < 0)
 			return err;
 	}
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7a4e100..5c8a4ea 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3217,6 +3217,7 @@ static int alc_build_controls(struct hda_codec *codec)
 	}
 	if (spec->multiout.dig_out_nid) {
 		err = snd_hda_create_spdif_out_ctls(codec,
+						    spec->multiout.dig_out_nid,
 						    spec->multiout.dig_out_nid);
 		if (err < 0)
 			return err;
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 7f81cc2..7407095 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -1112,7 +1112,9 @@ static int stac92xx_build_controls(struct hda_codec *codec)
 	}
 
 	if (spec->multiout.dig_out_nid) {
-		err = snd_hda_create_spdif_out_ctls(codec, spec->multiout.dig_out_nid);
+		err = snd_hda_create_spdif_out_ctls(codec,
+						    spec->multiout.dig_out_nid,
+						    spec->multiout.dig_out_nid);
 		if (err < 0)
 			return err;
 		err = snd_hda_create_spdif_share_sw(codec,
diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 8304c74..89a0f2a 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -1497,6 +1497,7 @@ static int via_build_controls(struct hda_codec *codec)
 
 	if (spec->multiout.dig_out_nid) {
 		err = snd_hda_create_spdif_out_ctls(codec,
+						    spec->multiout.dig_out_nid,
 						    spec->multiout.dig_out_nid);
 		if (err < 0)
 			return err;
-- 
1.7.0.4
