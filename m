From: Chih-Chung Chang <chihchung@chromium.org>
Subject: [PATCH 1/1] ALSA: hda - Fix jack gating when
	auto_{mute, mic} is suppressed.
Date: Mon,  5 Aug 2013 12:09:21 +0800
Message-ID: <1375675761-32289-1-git-send-email-chihchung@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f201.google.com (mail-gh0-f201.google.com
 [209.85.160.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D0FF2615EC
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 06:11:59 +0200 (CEST)
Received: by mail-gh0-f201.google.com with SMTP id r14so284998ghr.0
 for <alsa-devel@alsa-project.org>; Sun, 04 Aug 2013 21:11:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, chihchung@chromium.org, alsa-devel@alsa-project.org, kailang@realtek.com.tw, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org

The snd_hda_jack_set_gating_jack() call didn't work when
auto_{mute,mic} is suppressed because (1) am_entry is
not filled with nid of the mic pin. (2) The jacks are not
created (by snd_hda_jack_detect_enable_callback) before the
snd_hda_jack_set_gating_jack call.

Now we use the first input pin nid directly, and create the jack if it
doesn't exist yet.

Signed-off-by: Chih-Chung Chang <chihchung@chromium.org>

diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 3fd2973..aa02c0f 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -247,8 +247,8 @@ EXPORT_SYMBOL_HDA(snd_hda_jack_detect_enable);
 int snd_hda_jack_set_gating_jack(struct hda_codec *codec, hda_nid_t gated_nid,
 				 hda_nid_t gating_nid)
 {
-	struct hda_jack_tbl *gated = snd_hda_jack_tbl_get(codec, gated_nid);
-	struct hda_jack_tbl *gating = snd_hda_jack_tbl_get(codec, gating_nid);
+	struct hda_jack_tbl *gated = snd_hda_jack_tbl_new(codec, gated_nid);
+	struct hda_jack_tbl *gating = snd_hda_jack_tbl_new(codec, gating_nid);
 
 	if (!gated || !gating)
 		return -EINVAL;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8bd2261..2b64de5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3258,11 +3258,12 @@ static void alc271_hp_gate_mic_jack(struct hda_codec *codec,
 	struct alc_spec *spec = codec->spec;
 
 	if (action == HDA_FIXUP_ACT_PROBE) {
-		if (snd_BUG_ON(!spec->gen.am_entry[1].pin ||
-			       !spec->gen.autocfg.hp_pins[0]))
+		int mic_pin = spec->gen.autocfg.inputs[0].pin;
+		int hp_pin = spec->gen.autocfg.hp_pins[0];
+
+		if (snd_BUG_ON(!mic_pin || !hp_pin))
 			return;
-		snd_hda_jack_set_gating_jack(codec, spec->gen.am_entry[1].pin,
-					     spec->gen.autocfg.hp_pins[0]);
+		snd_hda_jack_set_gating_jack(codec, mic_pin, hp_pin);
 	}
 }
 
-- 
1.8.3
