From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Fix missing ELD info when using
	jackpoll_ms parameter
Date: Wed,  4 Dec 2013 10:19:41 +0800
Message-ID: <1386123581-2698-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0263F2652FD
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 03:19:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

In the case of using jackpoll_ms instead of unsol events, the jack
was correctly detected, but ELD info was not refreshed on plug-in.

And without ELD info, no proper restriction of pcm, which can in turn
break sound output on some devices.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_hdmi.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

@Takashi; feel free to add stable if you think it's worth it. (After all using
the jackpoll_ms parameter is not something we usually do.) It's still a bug fix
so sending to Linus tree should be okay, I believe.

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 4098196..f0a8ea8 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1142,32 +1142,34 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 
 static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll);
 
-static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
+static void jack_callback(struct hda_codec *codec, struct hda_jack_tbl *jack)
 {
 	struct hdmi_spec *spec = codec->spec;
+	int pin_idx = pin_nid_to_pin_index(spec, jack->nid);
+	if (pin_idx < 0)
+		return;
+
+	if (hdmi_present_sense(get_pin(spec, pin_idx), 1))
+		snd_hda_jack_report_sync(codec);
+}
+
+static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
+{
 	int tag = res >> AC_UNSOL_RES_TAG_SHIFT;
-	int pin_nid;
-	int pin_idx;
 	struct hda_jack_tbl *jack;
 	int dev_entry = (res & AC_UNSOL_RES_DE) >> AC_UNSOL_RES_DE_SHIFT;
 
 	jack = snd_hda_jack_tbl_get_from_tag(codec, tag);
 	if (!jack)
 		return;
-	pin_nid = jack->nid;
 	jack->jack_dirty = 1;
 
 	_snd_printd(SND_PR_VERBOSE,
 		"HDMI hot plug event: Codec=%d Pin=%d Device=%d Inactive=%d Presence_Detect=%d ELD_Valid=%d\n",
-		codec->addr, pin_nid, dev_entry, !!(res & AC_UNSOL_RES_IA),
+		codec->addr, jack->nid, dev_entry, !!(res & AC_UNSOL_RES_IA),
 		!!(res & AC_UNSOL_RES_PD), !!(res & AC_UNSOL_RES_ELDV));
 
-	pin_idx = pin_nid_to_pin_index(spec, pin_nid);
-	if (pin_idx < 0)
-		return;
-
-	if (hdmi_present_sense(get_pin(spec, pin_idx), 1))
-		snd_hda_jack_report_sync(codec);
+	jack_callback(codec, jack);
 }
 
 static void hdmi_non_intrinsic_event(struct hda_codec *codec, unsigned int res)
@@ -2080,7 +2082,8 @@ static int generic_hdmi_init(struct hda_codec *codec)
 		hda_nid_t pin_nid = per_pin->pin_nid;
 
 		hdmi_init_pin(codec, pin_nid);
-		snd_hda_jack_detect_enable(codec, pin_nid, pin_nid);
+		snd_hda_jack_detect_enable_callback(codec, pin_nid, pin_nid,
+			codec->jackpoll_interval > 0 ? jack_callback : NULL);
 	}
 	return 0;
 }
-- 
1.7.9.5
