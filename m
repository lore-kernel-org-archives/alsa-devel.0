From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] enable concurrent digital outputs for ALC1200
Date: Fri, 6 Feb 2009 15:02:27 +0800
Message-ID: <20090206070227.GA17793@localhost>
References: <49538A00.3070009@gmx.net> <20081226024838.GA13302@localhost>
	<4954CE2A.2040309@gmx.net> <20081230095414.GA1206@localhost>
	<495FEA39.1000404@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 671082445A
	for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2009 08:02:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <495FEA39.1000404@gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Thomas Schneider <nailstudio@gmx.net>
List-Id: alsa-devel@alsa-project.org

Add the SPDIF pin as slave digital out to enable concurrent
HDMI/SPDIF outputs for ASUS M3A-H/HDMI with ALC1200 codec.

Tested-by: Thomas Schneider <nailstudio@gmx.net>
Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_local.h     |    1 +
 sound/pci/hda/patch_realtek.c |    8 ++++++++
 2 files changed, 9 insertions(+)

--- sound-2.6.orig/sound/pci/hda/hda_local.h
+++ sound-2.6/sound/pci/hda/hda_local.h
@@ -229,6 +229,7 @@ struct hda_multi_out {
 	hda_nid_t hp_nid;	/* optional DAC for HP, 0 when not exists */
 	hda_nid_t extra_out_nid[3];	/* optional DACs, 0 when not exists */
 	hda_nid_t dig_out_nid;	/* digital out audio widget */
+	hda_nid_t *slave_dig_outs;
 	int max_channels;	/* currently supported analog channels */
 	int dig_out_used;	/* current usage of digital out (HDA_DIG_XXX) */
 	int no_share_stream;	/* don't share a stream with multiple pins */
--- sound-2.6.orig/sound/pci/hda/patch_realtek.c
+++ sound-2.6/sound/pci/hda/patch_realtek.c
@@ -349,6 +349,7 @@ struct alc_config_preset {
 	hda_nid_t *dac_nids;
 	hda_nid_t dig_out_nid;		/* optional */
 	hda_nid_t hp_nid;		/* optional */
+	hda_nid_t *slave_dig_outs;
 	unsigned int num_adc_nids;
 	hda_nid_t *adc_nids;
 	hda_nid_t *capsrc_nids;
@@ -824,6 +825,7 @@ static void setup_preset(struct alc_spec
 	spec->multiout.num_dacs = preset->num_dacs;
 	spec->multiout.dac_nids = preset->dac_nids;
 	spec->multiout.dig_out_nid = preset->dig_out_nid;
+	spec->multiout.slave_dig_outs = preset->slave_dig_outs;
 	spec->multiout.hp_nid = preset->hp_nid;
 
 	spec->num_mux_defs = preset->num_mux_defs;
@@ -3107,6 +3109,7 @@ static int alc_build_pcms(struct hda_cod
 	/* SPDIF for stream index #1 */
 	if (spec->multiout.dig_out_nid || spec->dig_in_nid) {
 		codec->num_pcms = 2;
+	        codec->slave_dig_outs = spec->multiout.slave_dig_outs;
 		info = spec->pcm_rec + 1;
 		info->name = spec->stream_name_digital;
 		if (spec->dig_out_type)
@@ -8603,6 +8606,10 @@ static struct snd_pci_quirk alc883_cfg_t
 	{}
 };
 
+static hda_nid_t alc1200_slave_dig_outs[] = {
+	ALC883_DIGOUT_NID, 0,
+};
+
 static struct alc_config_preset alc883_presets[] = {
 	[ALC883_3ST_2ch_DIG] = {
 		.mixers = { alc883_3ST_2ch_mixer },
@@ -8943,6 +8950,7 @@ static struct alc_config_preset alc883_p
 		.dac_nids = alc883_dac_nids,
 		.dig_out_nid = ALC1200_DIGOUT_NID,
 		.dig_in_nid = ALC883_DIGIN_NID,
+		.slave_dig_outs = alc1200_slave_dig_outs,
 		.num_channel_mode = ARRAY_SIZE(alc883_sixstack_modes),
 		.channel_mode = alc883_sixstack_modes,
 		.input_mux = &alc883_capture_source,
