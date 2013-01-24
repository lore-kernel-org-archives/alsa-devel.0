From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/13] ALSA: hda - Add
	snd_hda_check_power_state() helper function
Date: Thu, 24 Jan 2013 18:38:00 +0100
Message-ID: <1359049082-5880-12-git-send-email-tiwai@suse.de>
References: <1359049082-5880-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B74F0261701
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:15 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 0C637A51CA
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2013 18:38:15 +0100 (CET)
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

... for small refactoring.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c |  9 ++-------
 sound/pci/hda/hda_local.h | 13 +++++++++++++
 sound/pci/hda/patch_via.c | 11 +++--------
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 2311114..f82a64d 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3779,18 +3779,13 @@ static void sync_power_up_states(struct hda_codec *codec)
 
 	for (i = 0; i < codec->num_nodes; i++, nid++) {
 		unsigned int wcaps = get_wcaps(codec, nid);
-		unsigned int state, target;
+		unsigned int target;
 		if (!(wcaps & AC_WCAP_POWER))
 			continue;
 		target = codec->power_filter(codec, nid, AC_PWRST_D0);
 		if (target == AC_PWRST_D0)
 			continue;
-		state = snd_hda_codec_read(codec, nid, 0,
-					   AC_VERB_GET_POWER_STATE, 0);
-		if (state & AC_PWRST_ERROR)
-			continue;
-		state = (state >> 4) & 0x0f;
-		if (state != target)
+		if (!snd_hda_check_power_state(codec, nid, target))
 			snd_hda_codec_write(codec, nid, 0,
 					    AC_VERB_SET_POWER_STATE, target);
 	}
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 2ff62dc..05f1d59 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -657,6 +657,19 @@ int snd_hda_check_amp_list_power(struct hda_codec *codec,
 				 struct hda_loopback_check *check,
 				 hda_nid_t nid);
 
+/* check whether the actual power state matches with the target state */
+static inline bool
+snd_hda_check_power_state(struct hda_codec *codec, hda_nid_t nid,
+			  unsigned int target_state)
+{
+	unsigned int state = snd_hda_codec_read(codec, nid, 0,
+						AC_VERB_GET_POWER_STATE, 0);
+	if (state & AC_PWRST_ERROR)
+		return true;
+	state = (state >> 4) & 0x0f;
+	return (state != target_state);
+}
+
 /*
  * AMP control callbacks
  */
diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 5bd4b0c..9641c0e 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -240,10 +240,7 @@ static void set_widgets_power_state(struct hda_codec *codec)
 static void update_power_state(struct hda_codec *codec, hda_nid_t nid,
 			       unsigned int parm)
 {
-	unsigned int state = snd_hda_codec_read(codec, nid, 0,
-						AC_VERB_GET_POWER_STATE, 0);
-	state = (state >> 4) & 0x0f;
-	if (state == parm)
+	if (snd_hda_check_power_state(codec, nid, parm))
 		return;
 	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_POWER_STATE, parm);
 }
@@ -253,10 +250,8 @@ static void update_conv_power_state(struct hda_codec *codec, hda_nid_t nid,
 {
 	struct via_spec *spec = codec->spec;
 	unsigned int format;
-	unsigned int state = snd_hda_codec_read(codec, nid, 0,
-						AC_VERB_GET_POWER_STATE, 0);
-	state = (state >> 4) & 0x0f;
-	if (state == parm)
+
+	if (snd_hda_check_power_state(codec, nid, parm))
 		return;
 	format = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONV, 0);
 	if (format && (spec->dac_stream_tag[index] != format))
-- 
1.8.1.1
