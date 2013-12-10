From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Mute all aamix inputs as default
Date: Tue, 10 Dec 2013 21:19:19 +0100
Message-ID: <1386706759-24427-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A30B261A95
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 21:19:22 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id CEEA7A7F13
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 21:19:19 +0100 (CET)
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

Not all channels have been initialized, so far, especially when aamix
NID itself doesn't have amps but its leaves have.  This patch fixes
these holes.  Otherwise you might get unexpected loopback inputs,
e.g. from surround channels.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index c4671d00babd..249cd4615908 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -4297,6 +4297,26 @@ static unsigned int snd_hda_gen_path_power_filter(struct hda_codec *codec,
 	return AC_PWRST_D3;
 }
 
+/* mute all aamix inputs initially; parse up to the first leaves */
+static void mute_all_mixer_nid(struct hda_codec *codec, hda_nid_t mix)
+{
+	int i, nums;
+	const hda_nid_t *conn;
+	bool has_amp;
+
+	nums = snd_hda_get_conn_list(codec, mix, &conn);
+	has_amp = nid_has_mute(codec, mix, HDA_INPUT);
+	for (i = 0; i < nums; i++) {
+		if (has_amp)
+			snd_hda_codec_amp_stereo(codec, mix,
+						 HDA_INPUT, i,
+						 0xff, HDA_AMP_MUTE);
+		else if (nid_has_volume(codec, conn[i], HDA_OUTPUT))
+			snd_hda_codec_amp_stereo(codec, conn[i],
+						 HDA_OUTPUT, 0,
+						 0xff, HDA_AMP_MUTE);
+	}
+}
 
 /*
  * Parse the given BIOS configuration and set up the hda_gen_spec
@@ -4435,6 +4455,10 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
 		}
 	}
 
+	/* mute all aamix input initially */
+	if (spec->mixer_nid)
+		mute_all_mixer_nid(codec, spec->mixer_nid);
+
  dig_only:
 	parse_digital(codec);
 
-- 
1.8.5
