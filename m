From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Don't access stereo amps for mono
	channel widgets
Date: Fri, 13 Mar 2015 07:41:05 +0100
Message-ID: <1426228865-12377-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D8A726055F
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 07:41:06 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 27E4BAAC9
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 06:41:06 +0000 (UTC)
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

The current HDA generic parser initializes / modifies the amp values
always in stereo, but this seems causing the problem on ALC3229 codec
that has a few mono channel widgets: namely, these mono widgets react
to actions for both channels equally.

In the driver code, we do care the mono channel and create a control
only for the left channel (as defined in HD-audio spec) for such a
node.  When the control is updated, only the left channel value is
changed.  However, in the resume, the right channel value is also
restored from the initial value we took as stereo, and this overwrites
the left channel value.  This ends up being the silent output as the
right channel has been never touched and remains muted.

This patch covers the places where unconditional stereo amp accesses
are done and converts to the conditional accesses.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=94581
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index b680b4ec6331..fe18071bf93a 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -692,7 +692,23 @@ static void init_amp(struct hda_codec *codec, hda_nid_t nid, int dir, int idx)
 {
 	unsigned int caps = query_amp_caps(codec, nid, dir);
 	int val = get_amp_val_to_activate(codec, nid, dir, caps, false);
-	snd_hda_codec_amp_init_stereo(codec, nid, dir, idx, 0xff, val);
+
+	if (get_wcaps(codec, nid) & AC_WCAP_STEREO)
+		snd_hda_codec_amp_init_stereo(codec, nid, dir, idx, 0xff, val);
+	else
+		snd_hda_codec_amp_init(codec, nid, 0, dir, idx, 0xff, val);
+}
+
+/* update the amp, doing in stereo or mono depending on NID */
+static int update_amp(struct hda_codec *codec, hda_nid_t nid, int dir, int idx,
+		      unsigned int mask, unsigned int val)
+{
+	if (get_wcaps(codec, nid) & AC_WCAP_STEREO)
+		return snd_hda_codec_amp_stereo(codec, nid, dir, idx,
+						mask, val);
+	else
+		return snd_hda_codec_amp_update(codec, nid, 0, dir, idx,
+						mask, val);
 }
 
 /* calculate amp value mask we can modify;
@@ -732,7 +748,7 @@ static void activate_amp(struct hda_codec *codec, hda_nid_t nid, int dir,
 		return;
 
 	val &= mask;
-	snd_hda_codec_amp_stereo(codec, nid, dir, idx, mask, val);
+	update_amp(codec, nid, dir, idx, mask, val);
 }
 
 static void activate_amp_out(struct hda_codec *codec, struct nid_path *path,
@@ -4424,13 +4440,11 @@ static void mute_all_mixer_nid(struct hda_codec *codec, hda_nid_t mix)
 	has_amp = nid_has_mute(codec, mix, HDA_INPUT);
 	for (i = 0; i < nums; i++) {
 		if (has_amp)
-			snd_hda_codec_amp_stereo(codec, mix,
-						 HDA_INPUT, i,
-						 0xff, HDA_AMP_MUTE);
+			update_amp(codec, mix, HDA_INPUT, i,
+				   0xff, HDA_AMP_MUTE);
 		else if (nid_has_volume(codec, conn[i], HDA_OUTPUT))
-			snd_hda_codec_amp_stereo(codec, conn[i],
-						 HDA_OUTPUT, 0,
-						 0xff, HDA_AMP_MUTE);
+			update_amp(codec, conn[i], HDA_OUTPUT, 0,
+				   0xff, HDA_AMP_MUTE);
 	}
 }
 
-- 
2.3.2
