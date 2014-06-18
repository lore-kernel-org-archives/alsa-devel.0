From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Kill the rest of snd_print*()
	usages
Date: Wed, 18 Jun 2014 16:35:32 +0200
Message-ID: <1403102132-1708-2-git-send-email-tiwai@suse.de>
References: <1403102132-1708-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F526261A1D
 for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2014 16:35:33 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B5BABAD18
 for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2014 14:35:32 +0000 (UTC)
In-Reply-To: <1403102132-1708-1-git-send-email-tiwai@suse.de>
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

Pass the codec object so that we can replace all the rest of
snd_print*() usages with the proper device-specific print helpers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c      | 35 +++++++++++++++++++++--------------
 sound/pci/hda/hda_codec.h      |  3 ++-
 sound/pci/hda/hda_controller.c |  3 ++-
 sound/pci/hda/hda_generic.c    |  2 +-
 sound/pci/hda/hda_local.h      |  3 ++-
 sound/pci/hda/patch_ca0132.c   |  6 +++---
 sound/pci/hda/patch_sigmatel.c |  2 +-
 7 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 4c20277a6835..d91cb7f5961a 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2727,7 +2727,7 @@ int snd_hda_codec_reset(struct hda_codec *codec)
 	return 0;
 }
 
-typedef int (*map_slave_func_t)(void *, struct snd_kcontrol *);
+typedef int (*map_slave_func_t)(struct hda_codec *, void *, struct snd_kcontrol *);
 
 /* apply the function to all matching slave ctls in the mixer list */
 static int map_slaves(struct hda_codec *codec, const char * const *slaves,
@@ -2751,7 +2751,7 @@ static int map_slaves(struct hda_codec *codec, const char * const *slaves,
 				name = tmpname;
 			}
 			if (!strcmp(sctl->id.name, name)) {
-				err = func(data, sctl);
+				err = func(codec, data, sctl);
 				if (err)
 					return err;
 				break;
@@ -2761,13 +2761,15 @@ static int map_slaves(struct hda_codec *codec, const char * const *slaves,
 	return 0;
 }
 
-static int check_slave_present(void *data, struct snd_kcontrol *sctl)
+static int check_slave_present(struct hda_codec *codec,
+			       void *data, struct snd_kcontrol *sctl)
 {
 	return 1;
 }
 
 /* guess the value corresponding to 0dB */
-static int get_kctl_0dB_offset(struct snd_kcontrol *kctl, int *step_to_check)
+static int get_kctl_0dB_offset(struct hda_codec *codec,
+			       struct snd_kcontrol *kctl, int *step_to_check)
 {
 	int _tlv[4];
 	const int *tlv = NULL;
@@ -2788,7 +2790,7 @@ static int get_kctl_0dB_offset(struct snd_kcontrol *kctl, int *step_to_check)
 		if (!step)
 			return -1;
 		if (*step_to_check && *step_to_check != step) {
-			snd_printk(KERN_ERR "hda_codec: Mismatching dB step for vmaster slave (%d!=%d)\n",
+			codec_err(codec, "Mismatching dB step for vmaster slave (%d!=%d)\n",
 -				   *step_to_check, step);
 			return -1;
 		}
@@ -2813,16 +2815,18 @@ static int put_kctl_with_value(struct snd_kcontrol *kctl, int val)
 }
 
 /* initialize the slave volume with 0dB */
-static int init_slave_0dB(void *data, struct snd_kcontrol *slave)
+static int init_slave_0dB(struct hda_codec *codec,
+			  void *data, struct snd_kcontrol *slave)
 {
-	int offset = get_kctl_0dB_offset(slave, data);
+	int offset = get_kctl_0dB_offset(codec, slave, data);
 	if (offset > 0)
 		put_kctl_with_value(slave, offset);
 	return 0;
 }
 
 /* unmute the slave */
-static int init_slave_unmute(void *data, struct snd_kcontrol *slave)
+static int init_slave_unmute(struct hda_codec *codec,
+			     void *data, struct snd_kcontrol *slave)
 {
 	return put_kctl_with_value(slave, 1);
 }
@@ -4280,6 +4284,7 @@ static struct hda_rate_tbl rate_bits[] = {
 
 /**
  * snd_hda_calc_stream_format - calculate format bitset
+ * @codec: HD-audio codec
  * @rate: the sample rate
  * @channels: the number of channels
  * @format: the PCM format (SNDRV_PCM_FORMAT_XXX)
@@ -4289,7 +4294,8 @@ static struct hda_rate_tbl rate_bits[] = {
  *
  * Return zero if invalid.
  */
-unsigned int snd_hda_calc_stream_format(unsigned int rate,
+unsigned int snd_hda_calc_stream_format(struct hda_codec *codec,
+					unsigned int rate,
 					unsigned int channels,
 					unsigned int format,
 					unsigned int maxbps,
@@ -4304,12 +4310,12 @@ unsigned int snd_hda_calc_stream_format(unsigned int rate,
 			break;
 		}
 	if (!rate_bits[i].hz) {
-		snd_printdd("invalid rate %d\n", rate);
+		codec_dbg(codec, "invalid rate %d\n", rate);
 		return 0;
 	}
 
 	if (channels == 0 || channels > 8) {
-		snd_printdd("invalid channels %d\n", channels);
+		codec_dbg(codec, "invalid channels %d\n", channels);
 		return 0;
 	}
 	val |= channels - 1;
@@ -4332,7 +4338,7 @@ unsigned int snd_hda_calc_stream_format(unsigned int rate,
 			val |= AC_FMT_BITS_20;
 		break;
 	default:
-		snd_printdd("invalid format width %d\n",
+		codec_dbg(codec, "invalid format width %d\n",
 			  snd_pcm_format_width(format));
 		return 0;
 	}
@@ -5670,12 +5676,13 @@ EXPORT_SYMBOL_GPL(_snd_hda_set_pin_ctl);
  * suffix is appended to the label.  This label index number is stored
  * to type_idx when non-NULL pointer is given.
  */
-int snd_hda_add_imux_item(struct hda_input_mux *imux, const char *label,
+int snd_hda_add_imux_item(struct hda_codec *codec,
+			  struct hda_input_mux *imux, const char *label,
 			  int index, int *type_idx)
 {
 	int i, label_idx = 0;
 	if (imux->num_items >= HDA_MAX_NUM_INPUTS) {
-		snd_printd(KERN_ERR "hda_codec: Too many imux items!\n");
+		codec_err(codec, "hda_codec: Too many imux items!\n");
 		return -EINVAL;
 	}
 	for (i = 0; i < imux->num_items; i++) {
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index a4233136cb93..bbc5a1392c75 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -537,7 +537,8 @@ void __snd_hda_codec_cleanup_stream(struct hda_codec *codec, hda_nid_t nid,
 				    int do_now);
 #define snd_hda_codec_cleanup_stream(codec, nid) \
 	__snd_hda_codec_cleanup_stream(codec, nid, 0)
-unsigned int snd_hda_calc_stream_format(unsigned int rate,
+unsigned int snd_hda_calc_stream_format(struct hda_codec *codec,
+					unsigned int rate,
 					unsigned int channels,
 					unsigned int format,
 					unsigned int maxbps,
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 480bbddbd801..875e0ebf56eb 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -481,7 +481,8 @@ static int azx_pcm_prepare(struct snd_pcm_substream *substream)
 	}
 
 	azx_stream_reset(chip, azx_dev);
-	format_val = snd_hda_calc_stream_format(runtime->rate,
+	format_val = snd_hda_calc_stream_format(apcm->codec,
+						runtime->rate,
 						runtime->channels,
 						runtime->format,
 						hinfo->maxbps,
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 16133881e967..26c3c7868033 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3054,7 +3054,7 @@ static int parse_capture_source(struct hda_codec *codec, hda_nid_t pin,
 			if (spec->hp_mic_pin == pin)
 				spec->hp_mic_mux_idx = imux->num_items;
 			spec->imux_pins[imux->num_items] = pin;
-			snd_hda_add_imux_item(imux, label, cfg_idx, NULL);
+			snd_hda_add_imux_item(codec, imux, label, cfg_idx, NULL);
 			imux_added = true;
 			if (spec->dyn_adc_switch)
 				spec->dyn_adc_idx[imux_idx] = c;
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 7820fd2d9ba8..8e11b58bc9fb 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -268,7 +268,8 @@ int snd_hda_input_mux_put(struct hda_codec *codec,
 			  const struct hda_input_mux *imux,
 			  struct snd_ctl_elem_value *ucontrol, hda_nid_t nid,
 			  unsigned int *cur_val);
-int snd_hda_add_imux_item(struct hda_input_mux *imux, const char *label,
+int snd_hda_add_imux_item(struct hda_codec *codec,
+			  struct hda_input_mux *imux, const char *label,
 			  int index, int *type_index_ret);
 
 /*
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 092f2bd030bd..4f3aba78f720 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2046,14 +2046,14 @@ enum dma_state {
 	DMA_STATE_RUN   = 1
 };
 
-static int dma_convert_to_hda_format(
+static int dma_convert_to_hda_format(struct hda_codec *codec,
 		unsigned int sample_rate,
 		unsigned short channels,
 		unsigned short *hda_format)
 {
 	unsigned int format_val;
 
-	format_val = snd_hda_calc_stream_format(
+	format_val = snd_hda_calc_stream_format(codec,
 				sample_rate,
 				channels,
 				SNDRV_PCM_FORMAT_S32_LE,
@@ -2452,7 +2452,7 @@ static int dspxfr_image(struct hda_codec *codec,
 	}
 
 	dma_engine->codec = codec;
-	dma_convert_to_hda_format(sample_rate, channels, &hda_format);
+	dma_convert_to_hda_format(codec, sample_rate, channels, &hda_format);
 	dma_engine->m_converter_format = hda_format;
 	dma_engine->buf_size = (ovly ? DSP_DMA_WRITE_BUFLEN_OVLY :
 			DSP_DMA_WRITE_BUFLEN_INIT) * 2;
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 75515b494034..a9c815e86a6a 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -1011,7 +1011,7 @@ static int stac_create_spdif_mux_ctls(struct hda_codec *codec)
 	for (i = 0; i < num_cons; i++) {
 		if (snd_BUG_ON(!labels[i]))
 			return -EINVAL;
-		snd_hda_add_imux_item(&spec->spdif_mux, labels[i], i, NULL);
+		snd_hda_add_imux_item(codec, &spec->spdif_mux, labels[i], i, NULL);
 	}
 
 	kctl = snd_hda_gen_add_kctl(&spec->gen, NULL, &stac_smux_mixer);
-- 
1.9.3
