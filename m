From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 012/112] ALSA: hda/realtek - Fix initialization
	of input amps in output paths
Date: Tue,  8 Jan 2013 12:38:05 +0100
Message-ID: <1357645185-7645-13-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 14E1426516E
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 27AE1A51FD
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

When initializing the output paths, we assumed the input amps have
almost two inputs blindly.  It's not only generic but even incorrect
for some codecs like ALC268 & co.  Also, the same assumption (two
sources) exists for the bind input-amp controls.

This patch changes the codes in these places to handle the input
connections in a more generic way.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1abcd8e..981d505 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3621,9 +3621,10 @@ static int alc_auto_add_sw_ctl(struct hda_codec *codec,
 	val = amp_val_replace_channels(val, chs);
 	if (get_amp_direction_(val) == HDA_INPUT) {
 		hda_nid_t nid = get_amp_nid_(val);
-		if (snd_hda_get_num_conns(codec, nid) > 1) {
+		int nums = snd_hda_get_num_conns(codec, nid);
+		if (nums > 1) {
 			type = ALC_CTL_BIND_MUTE;
-			val |= 2 << 19; /* FIXME: fixed two widgets, so far */
+			val |= nums << 19;
 		}
 	}
 	return __add_pb_sw_ctrl(codec->spec, type, pfx, cidx, val);
@@ -3909,6 +3910,7 @@ static void alc_auto_set_output_and_unmute(struct hda_codec *codec,
 					   hda_nid_t pin, int pin_type,
 					   hda_nid_t dac, bool force)
 {
+	struct alc_spec *spec = codec->spec;
 	int i, val;
 	struct nid_path *path;
 
@@ -3928,13 +3930,19 @@ static void alc_auto_set_output_and_unmute(struct hda_codec *codec,
 		    (get_wcaps(codec, nid) & AC_WCAP_IN_AMP) &&
 		    (force || !is_out_ctl_present(codec, path, nid,
 						  HDA_INPUT))) {
+			hda_nid_t conn[16];
+			int n, nums;
+			nums = snd_hda_get_connections(codec, nid, conn,
+						       ARRAY_SIZE(conn));
 			val = get_default_amp_val(codec, nid, HDA_INPUT);
-			snd_hda_codec_write(codec, nid, 0,
-					    AC_VERB_SET_AMP_GAIN_MUTE,
-					    AMP_IN_UNMUTE(0) | val);
-			snd_hda_codec_write(codec, nid, 0,
+			for (n = 0; n < nums; n++) {
+				if (n != path->idx[i] &&
+				    conn[n] != spec->mixer_nid)
+					continue;
+				snd_hda_codec_write(codec, nid, 0,
 					    AC_VERB_SET_AMP_GAIN_MUTE,
-					    AMP_IN_UNMUTE(1) | val);
+					    AMP_IN_UNMUTE(n) | val);
+			}
 		}
 		if ((get_wcaps(codec, nid) & AC_WCAP_OUT_AMP) &&
 		    (force || !is_out_ctl_present(codec, path, nid,
-- 
1.8.0.1
