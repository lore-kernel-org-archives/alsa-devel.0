From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - More kerneldoc comments
Date: Wed, 29 Oct 2014 16:10:35 +0100
Message-ID: <1414595435-11514-2-git-send-email-tiwai@suse.de>
References: <1414595435-11514-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C3CE02604D4
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 16:10:37 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4CFC9AC66
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 15:10:37 +0000 (UTC)
In-Reply-To: <1414595435-11514-1-git-send-email-tiwai@suse.de>
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

Put more kerneldoc comments to the exported functions.
Still the generic parser code and the HD-audio controller code aren't
covered yet, though.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_auto_parser.c |  51 +++++++++++++-
 sound/pci/hda/hda_beep.c        |  38 +++++++++++
 sound/pci/hda/hda_codec.c       | 148 ++++++++++++++++++++++++++++++++++++----
 sound/pci/hda/hda_jack.c        |  39 +++++++++++
 sound/pci/hda/hda_jack.h        |   5 ++
 sound/pci/hda/hda_sysfs.c       |  35 ++++++++--
 6 files changed, 297 insertions(+), 19 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 7388958b01af..1ede82200ee5 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -441,6 +441,13 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_hda_parse_pin_defcfg);
 
+/**
+ * snd_hda_get_input_pin_attr - Get the input pin attribute from pin config
+ * @def_conf: pin configuration value
+ *
+ * Guess the input pin attribute (INPUT_PIN_ATTR_XXX) from the given
+ * default pin configuration value.
+ */
 int snd_hda_get_input_pin_attr(unsigned int def_conf)
 {
 	unsigned int loc = get_defcfg_location(def_conf);
@@ -473,7 +480,6 @@ EXPORT_SYMBOL_GPL(snd_hda_get_input_pin_attr);
  * for mic and line-in pins, and set an appropriate prefix like "Front",
  * "Rear", "Internal".
  */
-
 static const char *hda_get_input_pin_label(struct hda_codec *codec,
 					   const struct auto_pin_cfg_item *item,
 					   hda_nid_t pin, bool check_location)
@@ -761,6 +767,14 @@ int snd_hda_get_pin_label(struct hda_codec *codec, hda_nid_t nid,
 }
 EXPORT_SYMBOL_GPL(snd_hda_get_pin_label);
 
+/**
+ * snd_hda_add_verbs - Add verbs to the init list
+ * @codec: the HDA codec
+ * @list: zero-terminated verb list to add
+ *
+ * Append the given verb list to the execution list.  The verbs will be
+ * performed at init and resume time via snd_hda_apply_verbs().
+ */
 int snd_hda_add_verbs(struct hda_codec *codec,
 		      const struct hda_verb *list)
 {
@@ -773,6 +787,10 @@ int snd_hda_add_verbs(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_hda_add_verbs);
 
+/**
+ * snd_hda_apply_verbs - Execute the init verb lists
+ * @codec: the HDA codec
+ */
 void snd_hda_apply_verbs(struct hda_codec *codec)
 {
 	int i;
@@ -783,6 +801,11 @@ void snd_hda_apply_verbs(struct hda_codec *codec)
 }
 EXPORT_SYMBOL_GPL(snd_hda_apply_verbs);
 
+/**
+ * snd_hda_apply_pincfgs - Set each pin config in the given list
+ * @codec: the HDA codec
+ * @cfg: NULL-terminated pin config table
+ */
 void snd_hda_apply_pincfgs(struct hda_codec *codec,
 			   const struct hda_pintbl *cfg)
 {
@@ -850,6 +873,11 @@ static void apply_fixup(struct hda_codec *codec, int id, int action, int depth)
 	}
 }
 
+/**
+ * snd_hda_apply_fixup - Apply the fixup chain with the given action
+ * @codec: the HDA codec
+ * @action: fixup action (HDA_FIXUP_ACT_XXX)
+ */
 void snd_hda_apply_fixup(struct hda_codec *codec, int action)
 {
 	if (codec->fixup_list)
@@ -868,6 +896,12 @@ static bool pin_config_match(struct hda_codec *codec,
 	return true;
 }
 
+/**
+ * snd_hda_pick_pin_fixup - Pick up a fixup matching with the pin quirk list
+ * @codec: the HDA codec
+ * @pin_quirk: zero-terminated pin quirk list
+ * @fixlist: the fixup list
+ */
 void snd_hda_pick_pin_fixup(struct hda_codec *codec,
 			    const struct snd_hda_pin_quirk *pin_quirk,
 			    const struct hda_fixup *fixlist)
@@ -894,6 +928,21 @@ void snd_hda_pick_pin_fixup(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_hda_pick_pin_fixup);
 
+/**
+ * snd_hda_pick_fixup - Pick up a fixup matching with PCI/codec SSID or model string
+ * @codec: the HDA codec
+ * @models: NULL-terminated model string list
+ * @quirk: zero-terminated PCI/codec SSID quirk list
+ * @fixlist: the fixup list
+ *
+ * Pick up a fixup entry matching with the given model string or SSID.
+ * If a fixup was already set beforehand, the function doesn't do anything.
+ * When a special model string "nofixup" is given, also no fixup is applied.
+ *
+ * The function tries to find the matching model name at first, if given.
+ * If nothing matched, try to look up the PCI SSID.
+ * If still nothing matched, try to look up the codec SSID.
+ */
 void snd_hda_pick_fixup(struct hda_codec *codec,
 			const struct hda_model_fixup *models,
 			const struct snd_pci_quirk *quirk,
diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index 8c6c50afc0b7..1e7de08e77cb 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -175,6 +175,11 @@ static int snd_hda_do_attach(struct hda_beep *beep)
 	return 0;
 }
 
+/**
+ * snd_hda_enable_beep_device - Turn on/off beep sound
+ * @codec: the HDA codec
+ * @enable: flag to turn on/off
+ */
 int snd_hda_enable_beep_device(struct hda_codec *codec, int enable)
 {
 	struct hda_beep *beep = codec->beep;
@@ -191,6 +196,20 @@ int snd_hda_enable_beep_device(struct hda_codec *codec, int enable)
 }
 EXPORT_SYMBOL_GPL(snd_hda_enable_beep_device);
 
+/**
+ * snd_hda_attach_beep_device - Attach a beep input device
+ * @codec: the HDA codec
+ * @nid: beep NID
+ *
+ * Attach a beep object to the given widget.  If beep hint is turned off
+ * explicitly or beep_mode of the codec is turned off, this doesn't nothing.
+ *
+ * The attached beep device has to be registered via
+ * snd_hda_register_beep_device() and released via snd_hda_detach_beep_device()
+ * appropriately.
+ *
+ * Currently, only one beep device is allowed to each codec.
+ */
 int snd_hda_attach_beep_device(struct hda_codec *codec, int nid)
 {
 	struct hda_beep *beep;
@@ -228,6 +247,10 @@ int snd_hda_attach_beep_device(struct hda_codec *codec, int nid)
 }
 EXPORT_SYMBOL_GPL(snd_hda_attach_beep_device);
 
+/**
+ * snd_hda_detach_beep_device - Detach the beep device
+ * @codec: the HDA codec
+ */
 void snd_hda_detach_beep_device(struct hda_codec *codec)
 {
 	struct hda_beep *beep = codec->beep;
@@ -240,6 +263,10 @@ void snd_hda_detach_beep_device(struct hda_codec *codec)
 }
 EXPORT_SYMBOL_GPL(snd_hda_detach_beep_device);
 
+/**
+ * snd_hda_register_beep_device - Register the beep device
+ * @codec: the HDA codec
+ */
 int snd_hda_register_beep_device(struct hda_codec *codec)
 {
 	struct hda_beep *beep = codec->beep;
@@ -269,6 +296,12 @@ static bool ctl_has_mute(struct snd_kcontrol *kcontrol)
 }
 
 /* get/put callbacks for beep mute mixer switches */
+
+/**
+ * snd_hda_mixer_amp_switch_get_beep - Get callback for beep controls
+ * @kcontrol: ctl element
+ * @ucontrol: pointer to get/store the data
+ */
 int snd_hda_mixer_amp_switch_get_beep(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol)
 {
@@ -283,6 +316,11 @@ int snd_hda_mixer_amp_switch_get_beep(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_hda_mixer_amp_switch_get_beep);
 
+/**
+ * snd_hda_mixer_amp_switch_put_beep - Put callback for beep controls
+ * @kcontrol: ctl element
+ * @ucontrol: pointer to get/store the data
+ */
 int snd_hda_mixer_amp_switch_put_beep(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol)
 {
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index e15254204c72..ca98f5209f8f 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -77,6 +77,10 @@ static struct hda_vendor_id hda_vendor_ids[] = {
 static DEFINE_MUTEX(preset_mutex);
 static LIST_HEAD(hda_preset_tables);
 
+/**
+ * snd_hda_add_codec_preset - Add a codec preset to the chain
+ * @preset: codec preset table to add
+ */
 int snd_hda_add_codec_preset(struct hda_codec_preset_list *preset)
 {
 	mutex_lock(&preset_mutex);
@@ -86,6 +90,10 @@ int snd_hda_add_codec_preset(struct hda_codec_preset_list *preset)
 }
 EXPORT_SYMBOL_GPL(snd_hda_add_codec_preset);
 
+/**
+ * snd_hda_delete_codec_preset - Delete a codec preset from the chain
+ * @preset: codec preset table to delete
+ */
 int snd_hda_delete_codec_preset(struct hda_codec_preset_list *preset)
 {
 	mutex_lock(&preset_mutex);
@@ -1187,7 +1195,16 @@ unsigned int snd_hda_codec_get_pincfg(struct hda_codec *codec, hda_nid_t nid)
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_get_pincfg);
 
-/* remember the current pinctl target value */
+/**
+ * snd_hda_codec_set_pin_target - remember the current pinctl target value
+ * @codec: the HDA codec
+ * @nid: pin NID
+ * @val: assigned pinctl value
+ *
+ * This function stores the given value to a pinctl target value in the
+ * pincfg table.  This isn't always as same as the actually written value
+ * but can be referred at any time via snd_hda_codec_get_pin_target().
+ */
 int snd_hda_codec_set_pin_target(struct hda_codec *codec, hda_nid_t nid,
 				 unsigned int val)
 {
@@ -1201,7 +1218,11 @@ int snd_hda_codec_set_pin_target(struct hda_codec *codec, hda_nid_t nid,
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_set_pin_target);
 
-/* return the current pinctl target value */
+/**
+ * snd_hda_codec_get_pin_target - return the current pinctl target value
+ * @codec: the HDA codec
+ * @nid: pin NID
+ */
 int snd_hda_codec_get_pin_target(struct hda_codec *codec, hda_nid_t nid)
 {
 	struct hda_pincfg *pin;
@@ -1573,6 +1594,13 @@ int snd_hda_codec_new(struct hda_bus *bus,
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_new);
 
+/**
+ * snd_hda_codec_update_widgets - Refresh widget caps and pin defaults
+ * @codec: the HDA codec
+ *
+ * Forcibly refresh the all widget caps and the init pin configurations of
+ * the given codec.
+ */
 int snd_hda_codec_update_widgets(struct hda_codec *codec)
 {
 	hda_nid_t fg;
@@ -2239,7 +2267,17 @@ int snd_hda_codec_amp_stereo(struct hda_codec *codec, hda_nid_t nid,
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_amp_stereo);
 
-/* Works like snd_hda_codec_amp_update() but it writes the value only at
+/**
+ * snd_hda_codec_amp_init - initialize the AMP value
+ * @codec: the HDA codec
+ * @nid: NID to read the AMP value
+ * @ch: channel (left=0 or right=1)
+ * @dir: #HDA_INPUT or #HDA_OUTPUT
+ * @idx: the index value (only for input direction)
+ * @mask: bit mask to set
+ * @val: the bits value to set
+ *
+ * Works like snd_hda_codec_amp_update() but it writes the value only at
  * the first access.  If the amp was already initialized / updated beforehand,
  * this does nothing.
  */
@@ -2250,6 +2288,17 @@ int snd_hda_codec_amp_init(struct hda_codec *codec, hda_nid_t nid, int ch,
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_amp_init);
 
+/**
+ * snd_hda_codec_amp_init_stereo - initialize the stereo AMP value
+ * @codec: the HDA codec
+ * @nid: NID to read the AMP value
+ * @dir: #HDA_INPUT or #HDA_OUTPUT
+ * @idx: the index value (only for input direction)
+ * @mask: bit mask to set
+ * @val: the bits value to set
+ *
+ * Call snd_hda_codec_amp_init() for both stereo channels.
+ */
 int snd_hda_codec_amp_init_stereo(struct hda_codec *codec, hda_nid_t nid,
 				  int dir, int idx, int mask, int val)
 {
@@ -2644,7 +2693,10 @@ void snd_hda_ctls_clear(struct hda_codec *codec)
 	snd_array_free(&codec->nids);
 }
 
-/* pseudo device locking
+/**
+ * snd_hda_lock_devices - pseudo device locking
+ * @bus: the BUS
+ *
  * toggle card->shutdown to allow/disallow the device access (as a hack)
  */
 int snd_hda_lock_devices(struct hda_bus *bus)
@@ -2681,6 +2733,10 @@ int snd_hda_lock_devices(struct hda_bus *bus)
 }
 EXPORT_SYMBOL_GPL(snd_hda_lock_devices);
 
+/**
+ * snd_hda_unlock_devices - pseudo device unlocking
+ * @bus: the BUS
+ */
 void snd_hda_unlock_devices(struct hda_bus *bus)
 {
 	struct snd_card *card = bus->card;
@@ -2867,7 +2923,7 @@ static int add_slave(struct hda_codec *codec,
 }
 
 /**
- * snd_hda_add_vmaster - create a virtual master control and add slaves
+ * __snd_hda_add_vmaster - create a virtual master control and add slaves
  * @codec: HD-audio codec
  * @name: vmaster control name
  * @tlv: TLV data (optional)
@@ -2970,10 +3026,15 @@ static struct snd_kcontrol_new vmaster_mute_mode = {
 	.put = vmaster_mute_mode_put,
 };
 
-/*
- * Add a mute-LED hook with the given vmaster switch kctl
- * "Mute-LED Mode" control is automatically created and associated with
- * the given hook.
+/**
+ * snd_hda_add_vmaster_hook - Add a vmaster hook for mute-LED
+ * @codec: the HDA codec
+ * @hook: the vmaster hook object
+ * @expose_enum_ctl: flag to create an enum ctl
+ *
+ * Add a mute-LED hook with the given vmaster switch kctl.
+ * When @expose_enum_ctl is set, "Mute-LED Mode" control is automatically
+ * created and associated with the given hook.
  */
 int snd_hda_add_vmaster_hook(struct hda_codec *codec,
 			     struct hda_vmaster_mute_hook *hook,
@@ -2995,9 +3056,12 @@ int snd_hda_add_vmaster_hook(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_hda_add_vmaster_hook);
 
-/*
- * Call the hook with the current value for synchronization
- * Should be called in init callback
+/**
+ * snd_hda_sync_vmaster_hook - Sync vmaster hook
+ * @hook: the vmaster hook
+ *
+ * Call the hook with the current value for synchronization.
+ * Should be called in init callback.
  */
 void snd_hda_sync_vmaster_hook(struct hda_vmaster_mute_hook *hook)
 {
@@ -3599,7 +3663,11 @@ int snd_hda_create_dig_out_ctls(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_hda_create_dig_out_ctls);
 
-/* get the hda_spdif_out entry from the given NID
+/**
+ * snd_hda_spdif_out_of_nid - get the hda_spdif_out entry from the given NID
+ * @codec: the HDA codec
+ * @nid: widget NID
+ *
  * call within spdif_mutex lock
  */
 struct hda_spdif_out *snd_hda_spdif_out_of_nid(struct hda_codec *codec,
@@ -3616,6 +3684,13 @@ struct hda_spdif_out *snd_hda_spdif_out_of_nid(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_hda_spdif_out_of_nid);
 
+/**
+ * snd_hda_spdif_ctls_unassign - Unassign the given SPDIF ctl
+ * @codec: the HDA codec
+ * @idx: the SPDIF ctl index
+ *
+ * Unassign the widget from the given SPDIF control.
+ */
 void snd_hda_spdif_ctls_unassign(struct hda_codec *codec, int idx)
 {
 	struct hda_spdif_out *spdif;
@@ -3627,6 +3702,14 @@ void snd_hda_spdif_ctls_unassign(struct hda_codec *codec, int idx)
 }
 EXPORT_SYMBOL_GPL(snd_hda_spdif_ctls_unassign);
 
+/**
+ * snd_hda_spdif_ctls_assign - Assign the SPDIF controls to the given NID
+ * @codec: the HDA codec
+ * @idx: the SPDIF ctl idx
+ * @nid: widget NID
+ *
+ * Assign the widget to the SPDIF control with the given index.
+ */
 void snd_hda_spdif_ctls_assign(struct hda_codec *codec, int idx, hda_nid_t nid)
 {
 	struct hda_spdif_out *spdif;
@@ -3946,6 +4029,16 @@ void snd_hda_codec_flush_cache(struct hda_codec *codec)
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_flush_cache);
 
+/**
+ * snd_hda_codec_set_power_to_all - Set the power state to all widgets
+ * @codec: the HDA codec
+ * @fg: function group (not used now)
+ * @power_state: the power state to set (AC_PWRST_*)
+ *
+ * Set the given power state to all widgets that have the power control.
+ * If the codec has power_filter set, it evaluates the power state and
+ * filter out if it's unchanged as D3.
+ */
 void snd_hda_codec_set_power_to_all(struct hda_codec *codec, hda_nid_t fg,
 				    unsigned int power_state)
 {
@@ -4010,7 +4103,15 @@ static unsigned int hda_sync_power_state(struct hda_codec *codec,
 	return state;
 }
 
-/* don't power down the widget if it controls eapd and EAPD_BTLENABLE is set */
+/**
+ * snd_hda_codec_eapd_power_filter - A power filter callback for EAPD
+ * @codec: the HDA codec
+ * @nid: widget NID
+ * @power_state: power state to evalue
+ *
+ * Don't power down the widget if it controls eapd and EAPD_BTLENABLE is set.
+ * This can be used a codec power_filter callback.
+ */
 unsigned int snd_hda_codec_eapd_power_filter(struct hda_codec *codec,
 					     hda_nid_t nid,
 					     unsigned int power_state)
@@ -4671,6 +4772,17 @@ static int set_pcm_default_values(struct hda_codec *codec,
 /*
  * codec prepare/cleanup entries
  */
+/**
+ * snd_hda_codec_prepare - Prepare a stream
+ * @codec: the HDA codec
+ * @hinfo: PCM information
+ * @stream: stream tag to assign
+ * @format: format id to assign
+ * @substream: PCM substream to assign
+ *
+ * Calls the prepare callback set by the codec with the given arguments.
+ * Clean up the inactive streams when successful.
+ */
 int snd_hda_codec_prepare(struct hda_codec *codec,
 			  struct hda_pcm_stream *hinfo,
 			  unsigned int stream,
@@ -4687,6 +4799,14 @@ int snd_hda_codec_prepare(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_prepare);
 
+/**
+ * snd_hda_codec_cleanup - Prepare a stream
+ * @codec: the HDA codec
+ * @hinfo: PCM information
+ * @substream: PCM substream
+ *
+ * Calls the cleanup callback set by the codec with the given arguments.
+ */
 void snd_hda_codec_cleanup(struct hda_codec *codec,
 			   struct hda_pcm_stream *hinfo,
 			   struct snd_pcm_substream *substream)
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index b2d81ab22fb0..e664307617bd 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -20,6 +20,16 @@
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
 
+/**
+ * is_jack_detectable - Check whether the given pin is jack-detectable
+ * @codec: the HDA codec
+ * @nid: pin NID
+ *
+ * Check whether the given pin is capable to report the jack detection.
+ * The jack detection might not work by various reasons, e.g. the jack
+ * detection is prohibited in the codec level, the pin config has
+ * AC_DEFCFG_MISC_NO_PRESENCE bit, no unsol support, etc.
+ */
 bool is_jack_detectable(struct hda_codec *codec, hda_nid_t nid)
 {
 	if (codec->no_jack_detect)
@@ -268,6 +278,14 @@ snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
 }
 EXPORT_SYMBOL_GPL(snd_hda_jack_detect_enable_callback);
 
+/**
+ * snd_hda_jack_detect_enable - Enable the jack detection on the given pin
+ * @codec: the HDA codec
+ * @nid: pin NID to enable jack detection
+ *
+ * Enable the jack detection with the default callback.  Returns zero if
+ * successful or a negative error code.
+ */
 int snd_hda_jack_detect_enable(struct hda_codec *codec, hda_nid_t nid)
 {
 	return PTR_ERR_OR_ZERO(snd_hda_jack_detect_enable_callback(codec, nid, NULL));
@@ -410,6 +428,15 @@ static int __snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 	return 0;
 }
 
+/**
+ * snd_hda_jack_add_kctl - Add a jack kctl for the given pin
+ * @codec: the HDA codec
+ * @nid: pin NID
+ * @name: the name string for the jack ctl
+ * @idx: the ctl index for the jack ctl
+ *
+ * This is a simple helper calling __snd_hda_jack_add_kctl().
+ */
 int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
 			  const char *name, int idx)
 {
@@ -552,6 +579,11 @@ static void call_jack_callback(struct hda_codec *codec,
 	}
 }
 
+/**
+ * snd_hda_jack_unsol_event - Handle an unsolicited event
+ * @codec: the HDA codec
+ * @res: the unsolicited event data
+ */
 void snd_hda_jack_unsol_event(struct hda_codec *codec, unsigned int res)
 {
 	struct hda_jack_tbl *event;
@@ -567,6 +599,13 @@ void snd_hda_jack_unsol_event(struct hda_codec *codec, unsigned int res)
 }
 EXPORT_SYMBOL_GPL(snd_hda_jack_unsol_event);
 
+/**
+ * snd_hda_jack_poll_all - Poll all jacks
+ * @codec: the HDA codec
+ *
+ * Poll all detectable jacks with dirty flag, update the status, call
+ * callbacks and call snd_hda_jack_report_sync() if any changes are found.
+ */
 void snd_hda_jack_poll_all(struct hda_codec *codec)
 {
 	struct hda_jack_tbl *jack = codec->jacktbl.list;
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index 13cb375454f6..b279e327a23b 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -72,6 +72,11 @@ enum {
 
 int snd_hda_jack_detect_state(struct hda_codec *codec, hda_nid_t nid);
 
+/**
+ * snd_hda_jack_detect - Detect the jack
+ * @codec: the HDA codec
+ * @nid: pin NID to check jack detection
+ */
 static inline bool snd_hda_jack_detect(struct hda_codec *codec, hda_nid_t nid)
 {
 	return snd_hda_jack_detect_state(codec, nid) != HDA_JACK_NOT_PRESENT;
diff --git a/sound/pci/hda/hda_sysfs.c b/sound/pci/hda/hda_sysfs.c
index 9b49f156a12e..bef721592c3a 100644
--- a/sound/pci/hda/hda_sysfs.c
+++ b/sound/pci/hda/hda_sysfs.c
@@ -417,8 +417,13 @@ static DEVICE_ATTR_RW(user_pin_configs);
 static DEVICE_ATTR_WO(reconfig);
 static DEVICE_ATTR_WO(clear);
 
-/*
- * Look for hint string
+/**
+ * snd_hda_get_hint - Look for hint string
+ * @codec: the HDA codec
+ * @key: the hint key string
+ *
+ * Look for a hint key/value pair matching with the given key string
+ * and returns the value string.  If nothing found, returns NULL.
  */
 const char *snd_hda_get_hint(struct hda_codec *codec, const char *key)
 {
@@ -427,6 +432,15 @@ const char *snd_hda_get_hint(struct hda_codec *codec, const char *key)
 }
 EXPORT_SYMBOL_GPL(snd_hda_get_hint);
 
+/**
+ * snd_hda_get_bool_hint - Get a boolean hint value
+ * @codec: the HDA codec
+ * @key: the hint key string
+ *
+ * Look for a hint key/value pair matching with the given key string
+ * and returns a boolean value parsed from the value.  If no matching
+ * key is found, return a negative value.
+ */
 int snd_hda_get_bool_hint(struct hda_codec *codec, const char *key)
 {
 	const char *p;
@@ -453,6 +467,16 @@ int snd_hda_get_bool_hint(struct hda_codec *codec, const char *key)
 }
 EXPORT_SYMBOL_GPL(snd_hda_get_bool_hint);
 
+/**
+ * snd_hda_get_bool_hint - Get a boolean hint value
+ * @codec: the HDA codec
+ * @key: the hint key string
+ * @valp: pointer to store a value
+ *
+ * Look for a hint key/value pair matching with the given key string
+ * and stores the integer value to @valp.  If no matching key is found,
+ * return a negative error code.  Otherwise it returns zero.
+ */
 int snd_hda_get_int_hint(struct hda_codec *codec, const char *key, int *valp)
 {
 	const char *p;
@@ -690,8 +714,11 @@ static int get_line_from_fw(char *buf, int size, size_t *fw_size_p,
 	return 1;
 }
 
-/*
- * load a "patch" firmware file and parse it
+/**
+ * snd_hda_load_patch - load a "patch" firmware file and parse it
+ * @bus: HD-audio bus
+ * @fw_size: the firmware byte size
+ * @fw_buf: the firmware data
  */
 int snd_hda_load_patch(struct hda_bus *bus, size_t fw_size, const void *fw_buf)
 {
-- 
2.1.2
