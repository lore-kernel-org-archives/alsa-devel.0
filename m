From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/13] ALSA: hda/via - Fix wrong checks of
	power state bits
Date: Thu, 24 Jan 2013 18:37:57 +0100
Message-ID: <1359049082-5880-9-git-send-email-tiwai@suse.de>
References: <1359049082-5880-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 87CA32616DC
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:15 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id ECF18A51B7
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:14 +0100 (CET)
In-Reply-To: <1359049082-5880-1-git-send-email-tiwai@suse.de>
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

AC_VERB_GET_POWER_STATE returns the combined bits of the actual state
and the target state.  Thus, comparing the obtained value directly
with the target value can't work.  The value has to be shifted and
masked properly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_via.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 9d9583c..5bd4b0c 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -240,8 +240,10 @@ static void set_widgets_power_state(struct hda_codec *codec)
 static void update_power_state(struct hda_codec *codec, hda_nid_t nid,
 			       unsigned int parm)
 {
-	if (snd_hda_codec_read(codec, nid, 0,
-			       AC_VERB_GET_POWER_STATE, 0) == parm)
+	unsigned int state = snd_hda_codec_read(codec, nid, 0,
+						AC_VERB_GET_POWER_STATE, 0);
+	state = (state >> 4) & 0x0f;
+	if (state == parm)
 		return;
 	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_POWER_STATE, parm);
 }
@@ -251,8 +253,10 @@ static void update_conv_power_state(struct hda_codec *codec, hda_nid_t nid,
 {
 	struct via_spec *spec = codec->spec;
 	unsigned int format;
-	if (snd_hda_codec_read(codec, nid, 0,
-			       AC_VERB_GET_POWER_STATE, 0) == parm)
+	unsigned int state = snd_hda_codec_read(codec, nid, 0,
+						AC_VERB_GET_POWER_STATE, 0);
+	state = (state >> 4) & 0x0f;
+	if (state == parm)
 		return;
 	format = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONV, 0);
 	if (format && (spec->dac_stream_tag[index] != format))
-- 
1.8.1.1
