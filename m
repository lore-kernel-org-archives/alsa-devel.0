From: Logan Li <loganli@viatech.com.cn>
Subject: [PATCH 11/30] ALSA: HDA VIA: When changing input
 source, update power state.
Date: Sat, 10 Oct 2009 19:07:55 +0800
Message-ID: <4AD06B0B.4090202@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D530103B99
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Oct 2009 13:07:47 +0200 (CEST)
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
Cc: tiwai@suse.de, HaraldWelte@viatech.com, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: HDA VIA: When changing input source, update power state.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -549,6 +549,14 @@
 
 	if (!spec->mux_nids[adc_idx])
 		return -EINVAL;
+	/* switch to D0 beofre change index */
+	if (snd_hda_codec_read(codec, spec->mux_nids[adc_idx], 0,
+			       AC_VERB_GET_POWER_STATE, 0x00) != AC_PWRST_D0)
+		snd_hda_codec_write(codec, spec->mux_nids[adc_idx], 0,
+				    AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+	/* update jack power state */
+	set_jack_power_state(codec);
+
 	return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
 				     spec->mux_nids[adc_idx],
 				     &spec->cur_mux[adc_idx]);
