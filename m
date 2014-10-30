From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/8] ALSA: hda - Add kerneldoc comments to
	hda_generic.c
Date: Thu, 30 Oct 2014 16:06:14 +0100
Message-ID: <1414681581-4619-2-git-send-email-tiwai@suse.de>
References: <1414681581-4619-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A9D50260611
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 16:06:23 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 8CFE1AC01
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 15:06:23 +0000 (UTC)
In-Reply-To: <1414681581-4619-1-git-send-email-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 164 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 135 insertions(+), 29 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 06d721085e72..63b69f750d8e 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -40,7 +40,12 @@
 #include "hda_generic.h"
 
 
-/* initialize hda_gen_spec struct */
+/**
+ * snd_hda_gen_spec_init - initialize hda_gen_spec struct
+ * @spec: hda_gen_spec object to initialize
+ *
+ * Initialize the given hda_gen_spec object.
+ */
 int snd_hda_gen_spec_init(struct hda_gen_spec *spec)
 {
 	snd_array_init(&spec->kctls, sizeof(struct snd_kcontrol_new), 32);
@@ -51,6 +56,17 @@ int snd_hda_gen_spec_init(struct hda_gen_spec *spec)
 }
 EXPORT_SYMBOL_GPL(snd_hda_gen_spec_init);
 
+/**
+ * snd_hda_gen_add_kctl - Add a new kctl_new struct from the template
+ * @spec: hda_gen_spec object
+ * @name: name string to override the template, NULL if unchanged
+ * @temp: template for the new kctl
+ *
+ * Add a new kctl (actually snd_kcontrol_new to be instantiated later)
+ * element based on the given snd_kcontrol_new template @temp and the
+ * name string @name to the list in @spec.
+ * Returns the newly created object or NULL as error.
+ */
 struct snd_kcontrol_new *
 snd_hda_gen_add_kctl(struct hda_gen_spec *spec, const char *name,
 		     const struct snd_kcontrol_new *temp)
@@ -259,8 +275,14 @@ static struct nid_path *get_nid_path(struct hda_codec *codec,
 	return NULL;
 }
 
-/* get the path between the given NIDs;
- * passing 0 to either @pin or @dac behaves as a wildcard
+/**
+ * snd_hda_get_nid_path - get the path between the given NIDs
+ * @codec: the HDA codec
+ * @from_nid: the NID where the path start from
+ * @to_nid: the NID where the path ends at
+ *
+ * Return the found nid_path object or NULL for error.
+ * Passing 0 to either @from_nid or @to_nid behaves as a wildcard.
  */
 struct nid_path *snd_hda_get_nid_path(struct hda_codec *codec,
 				      hda_nid_t from_nid, hda_nid_t to_nid)
@@ -269,8 +291,14 @@ struct nid_path *snd_hda_get_nid_path(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_hda_get_nid_path);
 
-/* get the index number corresponding to the path instance;
- * the index starts from 1, for easier checking the invalid value
+/**
+ * snd_hda_get_path_idx - get the index number corresponding to the path
+ * instance
+ * @codec: the HDA codec
+ * @path: nid_path object
+ *
+ * The returned index starts from 1, i.e. the actual array index with offset 1,
+ * and zero is handled as an invalid path
  */
 int snd_hda_get_path_idx(struct hda_codec *codec, struct nid_path *path)
 {
@@ -287,7 +315,12 @@ int snd_hda_get_path_idx(struct hda_codec *codec, struct nid_path *path)
 }
 EXPORT_SYMBOL_GPL(snd_hda_get_path_idx);
 
-/* get the path instance corresponding to the given index number */
+/**
+ * snd_hda_get_path_from_idx - get the path instance corresponding to the
+ * given index number
+ * @codec: the HDA codec
+ * @idx: the path index
+ */
 struct nid_path *snd_hda_get_path_from_idx(struct hda_codec *codec, int idx)
 {
 	struct hda_gen_spec *spec = codec->spec;
@@ -415,7 +448,18 @@ static bool __parse_nid_path(struct hda_codec *codec,
 	return true;
 }
 
-/* parse the widget path from the given nid to the target nid;
+/**
+ * snd_hda_parse_nid_path - parse the widget path from the given nid to
+ * the target nid
+ * @codec: the HDA codec
+ * @from_nid: the NID where the path start from
+ * @to_nid: the NID where the path ends at
+ * @anchor_nid: the anchor indication
+ * @path: the path object to store the result
+ *
+ * Returns true if a matching path is found.
+ *
+ * The parsing behavior depends on parameters:
  * when @from_nid is 0, try to find an empty DAC;
  * when @anchor_nid is set to a positive value, only paths through the widget
  * with the given value are evaluated.
@@ -436,9 +480,15 @@ bool snd_hda_parse_nid_path(struct hda_codec *codec, hda_nid_t from_nid,
 }
 EXPORT_SYMBOL_GPL(snd_hda_parse_nid_path);
 
-/*
- * parse the path between the given NIDs and add to the path list.
- * if no valid path is found, return NULL
+/**
+ * snd_hda_add_new_path - parse the path between the given NIDs and
+ * add to the path list
+ * @codec: the HDA codec
+ * @from_nid: the NID where the path start from
+ * @to_nid: the NID where the path ends at
+ * @anchor_nid: the anchor indication, see snd_hda_parse_nid_path()
+ *
+ * If no valid path is found, returns NULL.
  */
 struct nid_path *
 snd_hda_add_new_path(struct hda_codec *codec, hda_nid_t from_nid,
@@ -724,8 +774,14 @@ static void activate_amp_in(struct hda_codec *codec, struct nid_path *path,
 	}
 }
 
-/* activate or deactivate the given path
- * if @add_aamix is set, enable the input from aa-mix NID as well (if any)
+/**
+ * snd_hda_activate_path - activate or deactivate the given path
+ * @codec: the HDA codec
+ * @path: the path to activate/deactivate
+ * @enable: flag to activate or not
+ * @add_aamix: enable the input from aamix NID
+ *
+ * If @add_aamix is set, enable the input from aa-mix NID as well (if any).
  */
 void snd_hda_activate_path(struct hda_codec *codec, struct nid_path *path,
 			   bool enable, bool add_aamix)
@@ -3883,7 +3939,12 @@ static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
 	}
 }
 
-/* Toggle outputs muting */
+/**
+ * snd_hda_gen_update_outputs - Toggle outputs muting
+ * @codec: the HDA codec
+ *
+ * Update the mute status of all outputs based on the current jack states.
+ */
 void snd_hda_gen_update_outputs(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
@@ -3944,7 +4005,11 @@ static void call_update_outputs(struct hda_codec *codec)
 		snd_ctl_sync_vmaster(spec->vmaster_mute.sw_kctl, false);
 }
 
-/* standard HP-automute helper */
+/**
+ * snd_hda_gen_hp_automute - standard HP-automute helper
+ * @codec: the HDA codec
+ * @jack: jack object, NULL for the whole
+ */
 void snd_hda_gen_hp_automute(struct hda_codec *codec,
 			     struct hda_jack_callback *jack)
 {
@@ -3965,7 +4030,11 @@ void snd_hda_gen_hp_automute(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_hda_gen_hp_automute);
 
-/* standard line-out-automute helper */
+/**
+ * snd_hda_gen_line_automute - standard line-out-automute helper
+ * @codec: the HDA codec
+ * @jack: jack object, NULL for the whole
+ */
 void snd_hda_gen_line_automute(struct hda_codec *codec,
 			       struct hda_jack_callback *jack)
 {
@@ -3986,7 +4055,11 @@ void snd_hda_gen_line_automute(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_hda_gen_line_automute);
 
-/* standard mic auto-switch helper */
+/**
+ * snd_hda_gen_mic_autoswitch - standard mic auto-switch helper
+ * @codec: the HDA codec
+ * @jack: jack object, NULL for the whole
+ */
 void snd_hda_gen_mic_autoswitch(struct hda_codec *codec,
 				struct hda_jack_callback *jack)
 {
@@ -4318,7 +4391,13 @@ static int check_auto_mic_availability(struct hda_codec *codec)
 	return 0;
 }
 
-/* power_filter hook; make inactive widgets into power down */
+/**
+ * snd_hda_gen_path_power_filter - power_filter hook to make inactive widgets
+ * into power down
+ * @codec: the HDA codec
+ * @nid: NID to evalute
+ * @power_state: target power state
+ */
 unsigned int snd_hda_gen_path_power_filter(struct hda_codec *codec,
 						  hda_nid_t nid,
 						  unsigned int power_state)
@@ -4354,8 +4433,11 @@ static void mute_all_mixer_nid(struct hda_codec *codec, hda_nid_t mix)
 	}
 }
 
-/*
- * Parse the given BIOS configuration and set up the hda_gen_spec
+/**
+ * snd_hda_gen_parse_auto_config - Parse the given BIOS configuration and
+ * set up the hda_gen_spec
+ * @codec: the HDA codec
+ * @cfg: Parsed pin configuration
  *
  * return 1 if successful, 0 if the proper config is not found,
  * or a negative error code
@@ -4541,6 +4623,12 @@ static const char * const slave_pfxs[] = {
 	NULL,
 };
 
+/**
+ * snd_hda_gen_build_controls - Build controls from the parsed results
+ * @codec: the HDA codec
+ *
+ * Pass this to build_controls patch_ops.
+ */
 int snd_hda_gen_build_controls(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
@@ -5018,7 +5106,12 @@ static void fill_pcm_stream_name(char *str, size_t len, const char *sfx,
 	strlcat(str, sfx, len);
 }
 
-/* build PCM streams based on the parsed results */
+/**
+ * snd_hda_gen_build_pcms - build PCM streams based on the parsed results
+ * @codec: the HDA codec
+ *
+ * Pass this to build_pcms patch_ops.
+ */
 int snd_hda_gen_build_pcms(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
@@ -5313,9 +5406,11 @@ static void clear_unsol_on_unused_pins(struct hda_codec *codec)
 	}
 }
 
-/*
- * initialize the generic spec;
- * this can be put as patch_ops.init function
+/**
+ * snd_hda_gen_init - initialize the generic spec
+ * @codec: the HDA codec
+ *
+ * This can be put as patch_ops init function.
  */
 int snd_hda_gen_init(struct hda_codec *codec)
 {
@@ -5351,9 +5446,11 @@ int snd_hda_gen_init(struct hda_codec *codec)
 }
 EXPORT_SYMBOL_GPL(snd_hda_gen_init);
 
-/*
- * free the generic spec;
- * this can be put as patch_ops.free function
+/**
+ * snd_hda_gen_free - free the generic spec
+ * @codec: the HDA codec
+ *
+ * This can be put as patch_ops free function.
  */
 void snd_hda_gen_free(struct hda_codec *codec)
 {
@@ -5365,9 +5462,12 @@ void snd_hda_gen_free(struct hda_codec *codec)
 EXPORT_SYMBOL_GPL(snd_hda_gen_free);
 
 #ifdef CONFIG_PM
-/*
- * check the loopback power save state;
- * this can be put as patch_ops.check_power_status function
+/**
+ * snd_hda_gen_check_power_status - check the loopback power save state
+ * @codec: the HDA codec
+ * @nid: NID to inspect
+ *
+ * This can be put as patch_ops check_power_status function.
  */
 int snd_hda_gen_check_power_status(struct hda_codec *codec, hda_nid_t nid)
 {
@@ -5393,6 +5493,12 @@ static const struct hda_codec_ops generic_patch_ops = {
 #endif
 };
 
+/**
+ * snd_hda_parse_generic_codec - Generic codec parser
+ * @codec: the HDA codec
+ *
+ * This should be called from the HDA codec core.
+ */
 int snd_hda_parse_generic_codec(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec;
-- 
2.1.2
