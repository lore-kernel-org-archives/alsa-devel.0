From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: [PATCH 2/8] ALSA: VIA HDA: Fix stereo mixer recording
	no sound issue
Date: Tue, 22 Mar 2011 14:29:09 +0800
Message-ID: <4D8841B5.6050908@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 29E3C10381A
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 07:29:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: VIA HDA: Fix stereo mixer recording no sound issue.

Modify function via_mux_enum_put() to fix stereo mixer recording 
no sound issue.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
---
 sound/pci/hda/patch_via.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -633,6 +633,7 @@
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct via_spec *spec = codec->spec;
 	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	int ret;
 
 	if (!spec->mux_nids[adc_idx])
 		return -EINVAL;
@@ -641,12 +642,14 @@
 			       AC_VERB_GET_POWER_STATE, 0x00) != AC_PWRST_D0)
 		snd_hda_codec_write(codec, spec->mux_nids[adc_idx], 0,
 				    AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
-	/* update jack power state */
-	set_widgets_power_state(codec);
 
-	return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
+	ret = snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
 				     spec->mux_nids[adc_idx],
 				     &spec->cur_mux[adc_idx]);
+	/* update jack power state */
+	set_widgets_power_state(codec);
+
+	return ret;
 }
 
 static int via_independent_hp_info(struct snd_kcontrol *kcontrol,
