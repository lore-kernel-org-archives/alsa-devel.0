From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] ALSA: hda - make alc882_auto_init_input_src
	aware of selectors
Date: Thu, 29 Jan 2009 13:18:31 -0200
Message-ID: <200901291318.32638.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 46C02103890
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 16:18:19 +0100 (CET)
Content-Disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

In the case of having a selector instead of mixer while initing input
sources, the case that happens with ALC889, we must select instead
of muting input. Problem was found while testing with hda-emu.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
---
 sound/pci/hda/patch_realtek.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 56adbb8..31a6d40 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6924,18 +6924,21 @@ static void alc882_auto_init_analog_input(struct hda_codec *codec)
 static void alc882_auto_init_input_src(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	const struct hda_input_mux *imux = spec->input_mux;
 	int c;
 
 	for (c = 0; c < spec->num_adc_nids; c++) {
 		hda_nid_t conn_list[HDA_MAX_NUM_INPUTS];
 		hda_nid_t nid = spec->capsrc_nids[c];
+		unsigned int mux_idx;
+		const struct hda_input_mux *imux;
 		int conns, mute, idx, item;
 
 		conns = snd_hda_get_connections(codec, nid, conn_list,
 						ARRAY_SIZE(conn_list));
 		if (conns < 0)
 			continue;
+		mux_idx = c >= spec->num_mux_defs ? 0 : c;
+		imux = &spec->input_mux[mux_idx];
 		for (idx = 0; idx < conns; idx++) {
 			/* if the current connection is the selected one,
 			 * unmute it as default - otherwise mute it
@@ -6948,8 +6951,20 @@ static void alc882_auto_init_input_src(struct hda_codec *codec)
 					break;
 				}
 			}
-			snd_hda_codec_write(codec, nid, 0,
-					    AC_VERB_SET_AMP_GAIN_MUTE, mute);
+			/* check if we have a selector or mixer
+			 * we could check for the widget type instead, but
+			 * just check for Amp-In presence (in case of mixer
+			 * without amp-in there is something wrong, this
+			 * function shouldn't be used or capsrc nid is wrong)
+			 */
+			if (get_wcaps(codec, nid) & AC_WCAP_IN_AMP)
+				snd_hda_codec_write(codec, nid, 0,
+						    AC_VERB_SET_AMP_GAIN_MUTE,
+						    mute);
+			else if (mute != AMP_IN_MUTE(idx))
+				snd_hda_codec_write(codec, nid, 0,
+						    AC_VERB_SET_CONNECT_SEL,
+						    idx);
 		}
 	}
 }
-- 
1.6.1
