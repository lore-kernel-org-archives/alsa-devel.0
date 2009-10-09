From: <LoganLi@viatech.com.cn>
Subject: [PATCH 11/30] ALSA: HDA VIA: When changing input
	source, update power state.
Date: Fri, 9 Oct 2009 18:40:28 +0800
Message-ID: <5B2BE0DB92BC8F4694F815C2F34E0D5F123C38@exchbj03.viatech.com.bj>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id D3C1B103AFD
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 12:40:22 +0200 (CEST)
Content-class: urn:content-classes:message
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
 pci/hda/patch_via.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/pci/hda/patch_via.c
+++ b/pci/hda/patch_via.c
@@ -549,6 +549,14 @@
 
 	if (!spec->mux_nids[adc_idx])
 		return -EINVAL;
+	/* switch to D0 beofre change index */
+	if (snd_hda_codec_read(codec, spec->mux_nids[adc_idx], 0,
+			       AC_VERB_GET_POWER_STATE, 0x00) !=
AC_PWRST_D0)
+		snd_hda_codec_write(codec, spec->mux_nids[adc_idx], 0,
+				    AC_VERB_SET_POWER_STATE,
AC_PWRST_D0);
+	/* update jack power state */
+	set_jack_power_state(codec);
+
 	return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
 				     spec->mux_nids[adc_idx],
 				     &spec->cur_mux[adc_idx]);
