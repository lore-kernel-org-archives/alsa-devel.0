From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: S/PDIF-Out on Asus M3A-H/HDMI with ALC1200]
Date: Fri, 26 Dec 2008 10:48:38 +0800
Message-ID: <20081226024838.GA13302@localhost>
References: <49538A00.3070009@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id A4EB11037EE
	for <alsa-devel@alsa-project.org>; Fri, 26 Dec 2008 03:48:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49538A00.3070009@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thomas Schneider <nailstudio@gmx.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Thomas,

This patch adds the SPDIF pin as slave digital out which I hope to
create concurrent HDMI/SPDIF outputs for you.

It's against today's sound-2.6 git tree.

Thanks,
Fengguang
---
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 6f2fe0f..c9262f0 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -227,6 +227,7 @@ struct hda_multi_out {
 	hda_nid_t hp_nid;	/* optional DAC for HP, 0 when not exists */
 	hda_nid_t extra_out_nid[3];	/* optional DACs, 0 when not exists */
 	hda_nid_t dig_out_nid;	/* digital out audio widget */
+	hda_nid_t *slave_dig_outs;
 	int max_channels;	/* currently supported analog channels */
 	int dig_out_used;	/* current usage of digital out (HDA_DIG_XXX) */
 	int no_share_stream;	/* don't share a stream with multiple pins */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0bd4e6b..08bedee 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -336,6 +336,7 @@ struct alc_config_preset {
 	hda_nid_t *dac_nids;
 	hda_nid_t dig_out_nid;		/* optional */
 	hda_nid_t hp_nid;		/* optional */
+	hda_nid_t *slave_dig_outs;
 	unsigned int num_adc_nids;
 	hda_nid_t *adc_nids;
 	hda_nid_t *capsrc_nids;
@@ -810,6 +811,7 @@ static void setup_preset(struct alc_spec *spec,
 	spec->multiout.num_dacs = preset->num_dacs;
 	spec->multiout.dac_nids = preset->dac_nids;
 	spec->multiout.dig_out_nid = preset->dig_out_nid;
+	spec->multiout.slave_dig_outs = preset->slave_dig_outs;
 	spec->multiout.hp_nid = preset->hp_nid;
 
 	spec->num_mux_defs = preset->num_mux_defs;
@@ -3085,6 +3087,7 @@ static int alc_build_pcms(struct hda_codec *codec)
 	/* SPDIF for stream index #1 */
 	if (spec->multiout.dig_out_nid || spec->dig_in_nid) {
 		codec->num_pcms = 2;
+	        codec->slave_dig_outs = spec->multiout.slave_dig_outs;
 		info = spec->pcm_rec + 1;
 		info->name = spec->stream_name_digital;
 		info->pcm_type = HDA_PCM_TYPE_SPDIF;
@@ -8865,6 +8868,7 @@ static struct alc_config_preset alc883_presets[] = {
 		.dac_nids = alc883_dac_nids,
 		.dig_out_nid = ALC1200_DIGOUT_NID,
 		.dig_in_nid = ALC883_DIGIN_NID,
+		.slave_dig_outs = { ALC883_DIGOUT_NID, 0 },
 		.num_channel_mode = ARRAY_SIZE(alc883_sixstack_modes),
 		.channel_mode = alc883_sixstack_modes,
 		.input_mux = &alc883_capture_source,
