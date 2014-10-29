From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Correct kerneldoc comments
Date: Wed, 29 Oct 2014 16:10:34 +0100
Message-ID: <1414595435-11514-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C395A2604D3
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 16:10:37 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 44E73AAF1
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 15:10:37 +0000 (UTC)
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

Complete the missing parameters and fix anything wrong there.
Just comment changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_auto_parser.c |  15 +++++-
 sound/pci/hda/hda_codec.c       | 114 ++++++++++++++++++++++++++++++++++++++--
 sound/pci/hda/hda_eld.c         |   2 +-
 sound/pci/hda/hda_jack.c        |  21 ++++++++
 4 files changed, 146 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index fcc5e478c9a1..7388958b01af 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -464,8 +464,12 @@ EXPORT_SYMBOL_GPL(snd_hda_get_input_pin_attr);
 
 /**
  * hda_get_input_pin_label - Give a label for the given input pin
+ * @codec: the HDA codec
+ * @item: ping config item to refer
+ * @pin: the pin NID
+ * @check_location: flag to add the jack location prefix
  *
- * When check_location is true, the function checks the pin location
+ * When @check_location is true, the function checks the pin location
  * for mic and line-in pins, and set an appropriate prefix like "Front",
  * "Rear", "Internal".
  */
@@ -550,6 +554,9 @@ static int check_mic_location_need(struct hda_codec *codec,
 
 /**
  * hda_get_autocfg_input_label - Get a label for the given input
+ * @codec: the HDA codec
+ * @cfg: the parsed pin configuration
+ * @input: the input index number
  *
  * Get a label for the given input pin defined by the autocfg item.
  * Unlike hda_get_input_pin_label(), this function checks all inputs
@@ -677,6 +684,12 @@ static int fill_audio_out_name(struct hda_codec *codec, hda_nid_t nid,
 
 /**
  * snd_hda_get_pin_label - Get a label for the given I/O pin
+ * @codec: the HDA codec
+ * @nid: pin NID
+ * @cfg: the parsed pin configuration
+ * @label: the string buffer to store
+ * @maxlen: the max length of string buffer (including termination)
+ * @indexp: the pointer to return the index number (for multiple ctls)
  *
  * Get a label for the given pin.  This function works for both input and
  * output pins.  When @cfg is given as non-NULL, the function tries to get
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 0025bf4c2f44..e15254204c72 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -416,7 +416,6 @@ static int read_and_add_raw_conns(struct hda_codec *codec, hda_nid_t nid)
  * snd_hda_get_conn_list - get connection list
  * @codec: the HDA codec
  * @nid: NID to parse
- * @len: number of connection list entries
  * @listp: the pointer to store NID list
  *
  * Parses the connection list of the given widget and stores the pointer
@@ -2004,6 +2003,7 @@ EXPORT_SYMBOL_GPL(query_amp_caps);
  * @codec: the HD-audio codec
  * @nid: the NID to query
  * @dir: either #HDA_INPUT or #HDA_OUTPUT
+ * @bits: bit mask to check the result
  *
  * Check whether the widget has the given amp capability for the direction.
  */
@@ -2023,7 +2023,7 @@ EXPORT_SYMBOL_GPL(snd_hda_check_amp_caps);
  * snd_hda_override_amp_caps - Override the AMP capabilities
  * @codec: the CODEC to clean up
  * @nid: the NID to clean up
- * @direction: either #HDA_INPUT or #HDA_OUTPUT
+ * @dir: either #HDA_INPUT or #HDA_OUTPUT
  * @caps: the capability bits to set
  *
  * Override the cached AMP caps bits value by the given one.
@@ -2320,6 +2320,8 @@ static u32 get_amp_max_value(struct hda_codec *codec, hda_nid_t nid, int dir,
 
 /**
  * snd_hda_mixer_amp_volume_info - Info callback for a standard AMP mixer
+ * @kcontrol: referred ctl element
+ * @uinfo: pointer to get/store the data
  *
  * The control element is supposed to have the private_value field
  * set up via HDA_COMPOSE_AMP_VAL*() or related macros.
@@ -2381,6 +2383,8 @@ update_amp_value(struct hda_codec *codec, hda_nid_t nid,
 
 /**
  * snd_hda_mixer_amp_volume_get - Get callback for a standard AMP mixer volume
+ * @kcontrol: ctl element
+ * @ucontrol: pointer to get/store the data
  *
  * The control element is supposed to have the private_value field
  * set up via HDA_COMPOSE_AMP_VAL*() or related macros.
@@ -2406,6 +2410,8 @@ EXPORT_SYMBOL_GPL(snd_hda_mixer_amp_volume_get);
 
 /**
  * snd_hda_mixer_amp_volume_put - Put callback for a standard AMP mixer volume
+ * @kcontrol: ctl element
+ * @ucontrol: pointer to get/store the data
  *
  * The control element is supposed to have the private_value field
  * set up via HDA_COMPOSE_AMP_VAL*() or related macros.
@@ -2436,6 +2442,10 @@ EXPORT_SYMBOL_GPL(snd_hda_mixer_amp_volume_put);
 
 /**
  * snd_hda_mixer_amp_volume_put - TLV callback for a standard AMP mixer volume
+ * @kcontrol: ctl element
+ * @op_flag: operation flag
+ * @size: byte size of input TLV
+ * @_tlv: TLV data
  *
  * The control element is supposed to have the private_value field
  * set up via HDA_COMPOSE_AMP_VAL*() or related macros.
@@ -3012,6 +3022,8 @@ EXPORT_SYMBOL_GPL(snd_hda_sync_vmaster_hook);
 
 /**
  * snd_hda_mixer_amp_switch_info - Info callback for a standard AMP mixer switch
+ * @kcontrol: referred ctl element
+ * @uinfo: pointer to get/store the data
  *
  * The control element is supposed to have the private_value field
  * set up via HDA_COMPOSE_AMP_VAL*() or related macros.
@@ -3031,6 +3043,8 @@ EXPORT_SYMBOL_GPL(snd_hda_mixer_amp_switch_info);
 
 /**
  * snd_hda_mixer_amp_switch_get - Get callback for a standard AMP mixer switch
+ * @kcontrol: ctl element
+ * @ucontrol: pointer to get/store the data
  *
  * The control element is supposed to have the private_value field
  * set up via HDA_COMPOSE_AMP_VAL*() or related macros.
@@ -3057,6 +3071,8 @@ EXPORT_SYMBOL_GPL(snd_hda_mixer_amp_switch_get);
 
 /**
  * snd_hda_mixer_amp_switch_put - Put callback for a standard AMP mixer switch
+ * @kcontrol: ctl element
+ * @ucontrol: pointer to get/store the data
  *
  * The control element is supposed to have the private_value field
  * set up via HDA_COMPOSE_AMP_VAL*() or related macros.
@@ -3100,6 +3116,8 @@ EXPORT_SYMBOL_GPL(snd_hda_mixer_amp_switch_put);
 
 /**
  * snd_hda_mixer_bind_switch_get - Get callback for a bound volume control
+ * @kcontrol: ctl element
+ * @ucontrol: pointer to get/store the data
  *
  * The control element is supposed to have the private_value field
  * set up via HDA_BIND_MUTE*() macros.
@@ -3123,6 +3141,8 @@ EXPORT_SYMBOL_GPL(snd_hda_mixer_bind_switch_get);
 
 /**
  * snd_hda_mixer_bind_switch_put - Put callback for a bound volume control
+ * @kcontrol: ctl element
+ * @ucontrol: pointer to get/store the data
  *
  * The control element is supposed to have the private_value field
  * set up via HDA_BIND_MUTE*() macros.
@@ -3153,6 +3173,8 @@ EXPORT_SYMBOL_GPL(snd_hda_mixer_bind_switch_put);
 
 /**
  * snd_hda_mixer_bind_ctls_info - Info callback for a generic bound control
+ * @kcontrol: referred ctl element
+ * @uinfo: pointer to get/store the data
  *
  * The control element is supposed to have the private_value field
  * set up via HDA_BIND_VOL() or HDA_BIND_SW() macros.
@@ -3176,6 +3198,8 @@ EXPORT_SYMBOL_GPL(snd_hda_mixer_bind_ctls_info);
 
 /**
  * snd_hda_mixer_bind_ctls_get - Get callback for a generic bound control
+ * @kcontrol: ctl element
+ * @ucontrol: pointer to get/store the data
  *
  * The control element is supposed to have the private_value field
  * set up via HDA_BIND_VOL() or HDA_BIND_SW() macros.
@@ -3199,6 +3223,8 @@ EXPORT_SYMBOL_GPL(snd_hda_mixer_bind_ctls_get);
 
 /**
  * snd_hda_mixer_bind_ctls_put - Put callback for a generic bound control
+ * @kcontrol: ctl element
+ * @ucontrol: pointer to get/store the data
  *
  * The control element is supposed to have the private_value field
  * set up via HDA_BIND_VOL() or HDA_BIND_SW() macros.
@@ -3228,6 +3254,10 @@ EXPORT_SYMBOL_GPL(snd_hda_mixer_bind_ctls_put);
 
 /**
  * snd_hda_mixer_bind_tlv - TLV callback for a generic bound control
+ * @kcontrol: ctl element
+ * @op_flag: operation flag
+ * @size: byte size of input TLV
+ * @tlv: TLV data
  *
  * The control element is supposed to have the private_value field
  * set up via HDA_BIND_VOL() macro.
@@ -4305,6 +4335,7 @@ static struct hda_rate_tbl rate_bits[] = {
  * @channels: the number of channels
  * @format: the PCM format (SNDRV_PCM_FORMAT_XXX)
  * @maxbps: the max. bps
+ * @spdif_ctls: HD-audio SPDIF status bits (0 if irrelevant)
  *
  * Calculate the format bitset from the given rate, channels and th PCM format.
  *
@@ -4980,6 +5011,7 @@ static void __snd_hda_power_down(struct hda_codec *codec)
  * snd_hda_power_save - Power-up/down/sync the codec
  * @codec: HD-audio codec
  * @delta: the counter delta to change
+ * @d3wait: sync for D3 transition complete
  *
  * Change the power-up counter via @delta, and power up or down the hardware
  * appropriately.  For the power-down, queue to the delayed action.
@@ -5055,6 +5087,10 @@ EXPORT_SYMBOL_GPL(snd_hda_check_amp_list_power);
 
 /**
  * snd_hda_ch_mode_info - Info callback helper for the channel mode enum
+ * @codec: the HDA codec
+ * @uinfo: pointer to get/store the data
+ * @chmode: channel mode array
+ * @num_chmodes: channel mode array size
  */
 int snd_hda_ch_mode_info(struct hda_codec *codec,
 			 struct snd_ctl_elem_info *uinfo,
@@ -5074,6 +5110,11 @@ EXPORT_SYMBOL_GPL(snd_hda_ch_mode_info);
 
 /**
  * snd_hda_ch_mode_get - Get callback helper for the channel mode enum
+ * @codec: the HDA codec
+ * @ucontrol: pointer to get/store the data
+ * @chmode: channel mode array
+ * @num_chmodes: channel mode array size
+ * @max_channels: max number of channels
  */
 int snd_hda_ch_mode_get(struct hda_codec *codec,
 			struct snd_ctl_elem_value *ucontrol,
@@ -5095,6 +5136,11 @@ EXPORT_SYMBOL_GPL(snd_hda_ch_mode_get);
 
 /**
  * snd_hda_ch_mode_put - Put callback helper for the channel mode enum
+ * @codec: the HDA codec
+ * @ucontrol: pointer to get/store the data
+ * @chmode: channel mode array
+ * @num_chmodes: channel mode array size
+ * @max_channelsp: pointer to store the max channels
  */
 int snd_hda_ch_mode_put(struct hda_codec *codec,
 			struct snd_ctl_elem_value *ucontrol,
@@ -5123,6 +5169,8 @@ EXPORT_SYMBOL_GPL(snd_hda_ch_mode_put);
 
 /**
  * snd_hda_input_mux_info_info - Info callback helper for the input-mux enum
+ * @imux: imux helper object
+ * @uinfo: pointer to get/store the data
  */
 int snd_hda_input_mux_info(const struct hda_input_mux *imux,
 			   struct snd_ctl_elem_info *uinfo)
@@ -5144,6 +5192,11 @@ EXPORT_SYMBOL_GPL(snd_hda_input_mux_info);
 
 /**
  * snd_hda_input_mux_info_put - Put callback helper for the input-mux enum
+ * @codec: the HDA codec
+ * @imux: imux helper object
+ * @ucontrol: pointer to get/store the data
+ * @nid: input mux NID
+ * @cur_val: pointer to get/store the current imux value
  */
 int snd_hda_input_mux_put(struct hda_codec *codec,
 			  const struct hda_input_mux *imux,
@@ -5168,7 +5221,13 @@ int snd_hda_input_mux_put(struct hda_codec *codec,
 EXPORT_SYMBOL_GPL(snd_hda_input_mux_put);
 
 
-/*
+/**
+ * snd_hda_enum_helper_info - Helper for simple enum ctls
+ * @kcontrol: ctl element
+ * @uinfo: pointer to get/store the data
+ * @num_items: number of enum items
+ * @texts: enum item string array
+ *
  * process kcontrol info callback of a simple string enum array
  * when @num_items is 0 or @texts is NULL, assume a boolean enum array
  */
@@ -5257,6 +5316,8 @@ EXPORT_SYMBOL_GPL(snd_hda_bus_reboot_notify);
 
 /**
  * snd_hda_multi_out_dig_open - open the digital out in the exclusive mode
+ * @codec: the HDA codec
+ * @mout: hda_multi_out object
  */
 int snd_hda_multi_out_dig_open(struct hda_codec *codec,
 			       struct hda_multi_out *mout)
@@ -5273,6 +5334,11 @@ EXPORT_SYMBOL_GPL(snd_hda_multi_out_dig_open);
 
 /**
  * snd_hda_multi_out_dig_prepare - prepare the digital out stream
+ * @codec: the HDA codec
+ * @mout: hda_multi_out object
+ * @stream_tag: stream tag to assign
+ * @format: format id to assign
+ * @substream: PCM substream to assign
  */
 int snd_hda_multi_out_dig_prepare(struct hda_codec *codec,
 				  struct hda_multi_out *mout,
@@ -5289,6 +5355,8 @@ EXPORT_SYMBOL_GPL(snd_hda_multi_out_dig_prepare);
 
 /**
  * snd_hda_multi_out_dig_cleanup - clean-up the digital out stream
+ * @codec: the HDA codec
+ * @mout: hda_multi_out object
  */
 int snd_hda_multi_out_dig_cleanup(struct hda_codec *codec,
 				  struct hda_multi_out *mout)
@@ -5302,6 +5370,8 @@ EXPORT_SYMBOL_GPL(snd_hda_multi_out_dig_cleanup);
 
 /**
  * snd_hda_multi_out_dig_close - release the digital out stream
+ * @codec: the HDA codec
+ * @mout: hda_multi_out object
  */
 int snd_hda_multi_out_dig_close(struct hda_codec *codec,
 				struct hda_multi_out *mout)
@@ -5315,6 +5385,10 @@ EXPORT_SYMBOL_GPL(snd_hda_multi_out_dig_close);
 
 /**
  * snd_hda_multi_out_analog_open - open analog outputs
+ * @codec: the HDA codec
+ * @mout: hda_multi_out object
+ * @substream: PCM substream to assign
+ * @hinfo: PCM information to assign
  *
  * Open analog outputs and set up the hw-constraints.
  * If the digital outputs can be opened as slave, open the digital
@@ -5365,6 +5439,11 @@ EXPORT_SYMBOL_GPL(snd_hda_multi_out_analog_open);
 
 /**
  * snd_hda_multi_out_analog_prepare - Preapre the analog outputs.
+ * @codec: the HDA codec
+ * @mout: hda_multi_out object
+ * @stream_tag: stream tag to assign
+ * @format: format id to assign
+ * @substream: PCM substream to assign
  *
  * Set up the i/o for analog out.
  * When the digital out is available, copy the front out to digital out, too.
@@ -5442,6 +5521,8 @@ EXPORT_SYMBOL_GPL(snd_hda_multi_out_analog_prepare);
 
 /**
  * snd_hda_multi_out_analog_cleanup - clean up the setting for analog out
+ * @codec: the HDA codec
+ * @mout: hda_multi_out object
  */
 int snd_hda_multi_out_analog_cleanup(struct hda_codec *codec,
 				     struct hda_multi_out *mout)
@@ -5473,6 +5554,8 @@ EXPORT_SYMBOL_GPL(snd_hda_multi_out_analog_cleanup);
 
 /**
  * snd_hda_get_default_vref - Get the default (mic) VREF pin bits
+ * @codec: the HDA codec
+ * @pin: referred pin NID
  *
  * Guess the suitable VREF pin bits to be set as the pin-control value.
  * Note: the function doesn't set the AC_PINCTL_IN_EN bit.
@@ -5498,7 +5581,12 @@ unsigned int snd_hda_get_default_vref(struct hda_codec *codec, hda_nid_t pin)
 }
 EXPORT_SYMBOL_GPL(snd_hda_get_default_vref);
 
-/* correct the pin ctl value for matching with the pin cap */
+/**
+ * snd_hda_correct_pin_ctl - correct the pin ctl value for matching with the pin cap
+ * @codec: the HDA codec
+ * @pin: referred pin NID
+ * @val: pin ctl value to audit
+ */
 unsigned int snd_hda_correct_pin_ctl(struct hda_codec *codec,
 				     hda_nid_t pin, unsigned int val)
 {
@@ -5549,6 +5637,19 @@ unsigned int snd_hda_correct_pin_ctl(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_hda_correct_pin_ctl);
 
+/**
+ * _snd_hda_pin_ctl - Helper to set pin ctl value
+ * @codec: the HDA codec
+ * @pin: referred pin NID
+ * @val: pin control value to set
+ * @cached: access over codec pinctl cache or direct write
+ *
+ * This function is a helper to set a pin ctl value more safely.
+ * It corrects the pin ctl value via snd_hda_correct_pin_ctl(), stores the
+ * value in pin target array via snd_hda_codec_set_pin_target(), then
+ * actually writes the value via either snd_hda_codec_update_cache() or
+ * snd_hda_codec_write() depending on @cached flag.
+ */
 int _snd_hda_set_pin_ctl(struct hda_codec *codec, hda_nid_t pin,
 			 unsigned int val, bool cached)
 {
@@ -5565,6 +5666,11 @@ EXPORT_SYMBOL_GPL(_snd_hda_set_pin_ctl);
 
 /**
  * snd_hda_add_imux_item - Add an item to input_mux
+ * @codec: the HDA codec
+ * @imux: imux helper object
+ * @label: the name of imux item to assign
+ * @index: index number of imux item to assign
+ * @type_idx: pointer to store the resultant label index
  *
  * When the same label is used already in the existing items, the number
  * suffix is appended to the label.  This label index number is stored
diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index e1cd34d9011d..0e6d7534f491 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -371,7 +371,7 @@ error:
 	return ret;
 }
 
-/**
+/*
  * SNDRV_PCM_RATE_* and AC_PAR_PCM values don't match, print correct rates with
  * hdmi-specific routine.
  */
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index f56765ae73a7..b2d81ab22fb0 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -57,6 +57,8 @@ static u32 read_pin_sense(struct hda_codec *codec, hda_nid_t nid)
 
 /**
  * snd_hda_jack_tbl_get - query the jack-table entry for the given NID
+ * @codec: the HDA codec
+ * @nid: pin NID to refer to
  */
 struct hda_jack_tbl *
 snd_hda_jack_tbl_get(struct hda_codec *codec, hda_nid_t nid)
@@ -75,6 +77,8 @@ EXPORT_SYMBOL_GPL(snd_hda_jack_tbl_get);
 
 /**
  * snd_hda_jack_tbl_get_from_tag - query the jack-table entry for the given tag
+ * @codec: the HDA codec
+ * @tag: tag value to refer to
  */
 struct hda_jack_tbl *
 snd_hda_jack_tbl_get_from_tag(struct hda_codec *codec, unsigned char tag)
@@ -93,6 +97,8 @@ EXPORT_SYMBOL_GPL(snd_hda_jack_tbl_get_from_tag);
 
 /**
  * snd_hda_jack_tbl_new - create a jack-table entry for the given NID
+ * @codec: the HDA codec
+ * @nid: pin NID to assign
  */
 static struct hda_jack_tbl *
 snd_hda_jack_tbl_new(struct hda_codec *codec, hda_nid_t nid)
@@ -162,6 +168,7 @@ static void jack_detect_update(struct hda_codec *codec,
 
 /**
  * snd_hda_set_dirty_all - Mark all the cached as dirty
+ * @codec: the HDA codec
  *
  * This function sets the dirty flag to all entries of jack table.
  * It's called from the resume path in hda_codec.c.
@@ -218,6 +225,9 @@ EXPORT_SYMBOL_GPL(snd_hda_jack_detect_state);
 
 /**
  * snd_hda_jack_detect_enable - enable the jack-detection
+ * @codec: the HDA codec
+ * @nid: pin NID to enable
+ * @func: callback function to register
  *
  * In the case of error, the return value will be a pointer embedded with
  * errno.  Check and handle the return value appropriately with standard
@@ -266,6 +276,9 @@ EXPORT_SYMBOL_GPL(snd_hda_jack_detect_enable);
 
 /**
  * snd_hda_jack_set_gating_jack - Set gating jack.
+ * @codec: the HDA codec
+ * @gated_nid: gated pin NID
+ * @gating_nid: gating pin NID
  *
  * Indicates the gated jack is only valid when the gating jack is plugged.
  */
@@ -287,6 +300,7 @@ EXPORT_SYMBOL_GPL(snd_hda_jack_set_gating_jack);
 
 /**
  * snd_hda_jack_report_sync - sync the states of all jacks and report if changed
+ * @codec: the HDA codec
  */
 void snd_hda_jack_report_sync(struct hda_codec *codec)
 {
@@ -349,6 +363,11 @@ static void hda_free_jack_priv(struct snd_jack *jack)
 
 /**
  * snd_hda_jack_add_kctl - Add a kctl for the given pin
+ * @codec: the HDA codec
+ * @nid: pin NID to assign
+ * @name: string name for the jack
+ * @idx: index number for the jack
+ * @phantom_jack: flag to deal as a phantom jack
  *
  * This assigns a jack-detection kctl to the given pin.  The kcontrol
  * will have the given name and index.
@@ -456,6 +475,8 @@ static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
 
 /**
  * snd_hda_jack_add_kctls - Add kctls for all pins included in the given pincfg
+ * @codec: the HDA codec
+ * @cfg: pin config table to parse
  */
 int snd_hda_jack_add_kctls(struct hda_codec *codec,
 			   const struct auto_pin_cfg *cfg)
-- 
2.1.2
