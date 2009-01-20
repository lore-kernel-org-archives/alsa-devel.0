From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: default dmuxes to first entry in
	dinput_mux
Date: Mon, 19 Jan 2009 22:41:56 -0500
Message-ID: <49754804.8060508@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 2437A24399
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 04:42:20 +0100 (CET)
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

When using a custom spec->dinput_mux sometimes the value selected is
incorrect due to not have a previously selected default. To remedy this
patch selects the first items index in spec->dinput_mux and sets all the
dmuxes thusly to it. 

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index e2b673a..3f5dc1b 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -3663,7 +3663,17 @@ static int stac92xx_parse_auto_config(struct hda_codec *codec, hda_nid_t dig_out
 		spec->mixers[spec->num_mixers++] = spec->kctls.list;
 
 	spec->input_mux = &spec->private_imux;
-	if (!spec->dinput_mux)
+	if (spec->dinput_mux) {
+		int idx = spec->dinput_mux->items[0].index;
+		int i;
+
+		/* sometimes using a custom dinput_mux causes the incorrect
+ 		 * value to selected on startup, but sure a valid one is
+ 		 * selected by default */
+		for (i = 0; i < spec->num_dmuxes; i++)
+			snd_hda_codec_write_cache(codec, spec->dmux_nids[i], 0,
+				 AC_VERB_SET_CONNECT_SEL, idx);
+	} else
 		spec->dinput_mux = &spec->private_dimux;
 	spec->sinput_mux = &spec->private_smux;
 	spec->mono_mux = &spec->private_mono_mux;
