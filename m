From: Mike Waychison <mikew@google.com>
Subject: [PATCH] ALSA: hda - Fix unused warnings when
	!SND_HDA_NEEDS_RESUME
Date: Tue, 19 Apr 2011 14:02:17 -0700
Message-ID: <1303246937-11302-1-git-send-email-mikew__22063.3865720176$1303279935$gmane$org@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A2FE103816
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Apr 2011 23:02:31 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Raymond Yau <superquad.vortex2@gmail.com>, David Henningsson <david.henningsson@canonical.com>
Cc: Mike Waychison <mikew@google.com>
List-Id: alsa-devel@alsa-project.org

When SND_HDA_NEEDS_RESUME is not defined, the compiler identifies that
the following symbols are static but not used:

  restore_shutup_pins
  hda_cleanup_all_streams
  ad198x_power_eapd
  ad198x_power_eapd_write

Fix warnings by moving the above functions to be SND_HDA_NEEDS_RESUME
guards.

Signed-off-by: Mike Waychison <mikew@google.com>
---
Applies to v2.6.39-rc4.
Compile tested with and without CONFIG_SND_HDA_POWER_SAVE.
---
 sound/pci/hda/hda_codec.c    |   58 +++++++++++++++++++++---------------------
 sound/pci/hda/patch_analog.c |   28 ++++++++++----------
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 430f41d..fbb046f 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -937,23 +937,6 @@ void snd_hda_shutup_pins(struct hda_codec *codec)
 }
 EXPORT_SYMBOL_HDA(snd_hda_shutup_pins);
 
-/* Restore the pin controls cleared previously via snd_hda_shutup_pins() */
-static void restore_shutup_pins(struct hda_codec *codec)
-{
-	int i;
-	if (!codec->pins_shutup)
-		return;
-	if (codec->bus->shutdown)
-		return;
-	for (i = 0; i < codec->init_pins.used; i++) {
-		struct hda_pincfg *pin = snd_array_elem(&codec->init_pins, i);
-		snd_hda_codec_write(codec, pin->nid, 0,
-				    AC_VERB_SET_PIN_WIDGET_CONTROL,
-				    pin->ctrl);
-	}
-	codec->pins_shutup = 0;
-}
-
 static void init_hda_cache(struct hda_cache_rec *cache,
 			   unsigned int record_size);
 static void free_hda_cache(struct hda_cache_rec *cache);
@@ -1329,18 +1312,6 @@ static void purify_inactive_streams(struct hda_codec *codec)
 	}
 }
 
-/* clean up all streams; called from suspend */
-static void hda_cleanup_all_streams(struct hda_codec *codec)
-{
-	int i;
-
-	for (i = 0; i < codec->cvt_setups.used; i++) {
-		struct hda_cvt_setup *p = snd_array_elem(&codec->cvt_setups, i);
-		if (p->stream_tag)
-			really_cleanup_stream(codec, p);
-	}
-}
-
 /*
  * amp access functions
  */
@@ -3049,6 +3020,18 @@ static inline void hda_exec_init_verbs(struct hda_codec *codec) {}
 #endif
 
 #ifdef SND_HDA_NEEDS_RESUME
+/* clean up all streams; called from suspend */
+static void hda_cleanup_all_streams(struct hda_codec *codec)
+{
+	int i;
+
+	for (i = 0; i < codec->cvt_setups.used; i++) {
+		struct hda_cvt_setup *p = snd_array_elem(&codec->cvt_setups, i);
+		if (p->stream_tag)
+			really_cleanup_stream(codec, p);
+	}
+}
+
 /*
  * call suspend and power-down; used both from PM and power-save
  */
@@ -3069,6 +3052,23 @@ static void hda_call_codec_suspend(struct hda_codec *codec)
 #endif
 }
 
+/* Restore the pin controls cleared previously via snd_hda_shutup_pins() */
+static void restore_shutup_pins(struct hda_codec *codec)
+{
+	int i;
+	if (!codec->pins_shutup)
+		return;
+	if (codec->bus->shutdown)
+		return;
+	for (i = 0; i < codec->init_pins.used; i++) {
+		struct hda_pincfg *pin = snd_array_elem(&codec->init_pins, i);
+		snd_hda_codec_write(codec, pin->nid, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL,
+				    pin->ctrl);
+	}
+	codec->pins_shutup = 0;
+}
+
 /*
  * kick up codec; used both from PM and power-save
  */
diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 2942d2a..bcabcee 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -507,6 +507,20 @@ static void ad198x_free_kctls(struct hda_codec *codec)
 	snd_array_free(&spec->kctls);
 }
 
+static void ad198x_free(struct hda_codec *codec)
+{
+	struct ad198x_spec *spec = codec->spec;
+
+	if (!spec)
+		return;
+
+	ad198x_shutup(codec);
+	ad198x_free_kctls(codec);
+	kfree(spec);
+	snd_hda_detach_beep_device(codec);
+}
+
+#ifdef SND_HDA_NEEDS_RESUME
 static void ad198x_power_eapd_write(struct hda_codec *codec, hda_nid_t front,
 				hda_nid_t hp)
 {
@@ -547,20 +561,6 @@ static void ad198x_power_eapd(struct hda_codec *codec)
 	}
 }
 
-static void ad198x_free(struct hda_codec *codec)
-{
-	struct ad198x_spec *spec = codec->spec;
-
-	if (!spec)
-		return;
-
-	ad198x_shutup(codec);
-	ad198x_free_kctls(codec);
-	kfree(spec);
-	snd_hda_detach_beep_device(codec);
-}
-
-#ifdef SND_HDA_NEEDS_RESUME
 static int ad198x_suspend(struct hda_codec *codec, pm_message_t state)
 {
 	ad198x_shutup(codec);
-- 
1.7.3.1
