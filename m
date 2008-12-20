From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: dinput_mux check
Date: Sat, 20 Dec 2008 17:36:28 -0500
Message-ID: <494D736C.3000503@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id C12951037E3
	for <alsa-devel@alsa-project.org>; Sat, 20 Dec 2008 23:36:42 +0100 (CET)
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
Cc: takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Add check to determine if dinput_mux is set by any of patch_stac*() functions,
otherwise a invalid pointer my be referenced causing gibberish to mixer values.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index 70181d5..fa87893 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -3601,7 +3601,8 @@ static int stac92xx_parse_auto_config(struct hda_codec *codec, hda_nid_t dig_out
 		spec->mixers[spec->num_mixers++] = spec->kctls.list;
 
 	spec->input_mux = &spec->private_imux;
-	spec->dinput_mux = &spec->private_dimux;
+	if (!spec->dinput_mux)
+		spec->dinput_mux = &spec->private_dimux;
 	spec->sinput_mux = &spec->private_smux;
 	spec->mono_mux = &spec->private_mono_mux;
 	spec->amp_mux = &spec->private_amp_mux;
