From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH] ALSA: hda/ca0132 - Delay HP amp turnon.
Date: Mon, 25 Mar 2013 10:39:23 -0700
Message-ID: <1364233163-6385-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f201.google.com (mail-gg0-f201.google.com
 [209.85.161.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FB422625DD
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2013 18:40:07 +0100 (CET)
Received: by mail-gg0-f201.google.com with SMTP id q6so97380ggc.2
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2013 10:40:06 -0700 (PDT)
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
Cc: tiwai@suse.de, Chih-Chung Chang <chihchung@chromium.org>, Dylan Reid <dgreid@chromium.org>, ian_minett@creativelabs.com
List-Id: alsa-devel@alsa-project.org

From: Chih-Chung Chang <chihchung@chromium.org>

Turing on the headphone amp interferes with the impedance measurement
used to detect a TRRS style headset microphone.  Delay the HP turn on
until 500ms after the jack is detected, allowing the mic detection
state machine to run to completion.

Signed-off-by: Chih-Chung Chang <chihchung@chromium.org>
Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/patch_ca0132.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 0792b57..12eb21a 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -741,6 +741,9 @@ struct ca0132_spec {
 	long voicefx_val;
 	long cur_mic_boost;
 
+	struct hda_codec *codec;
+	struct delayed_work unsol_hp_work;
+
 #ifdef ENABLE_TUNING_CONTROLS
 	long cur_ctl_vals[TUNING_CTLS_COUNT];
 #endif
@@ -3227,6 +3230,14 @@ exit:
 	return err < 0 ? err : 0;
 }
 
+static void ca0132_unsol_hp_delayed(struct work_struct *work)
+{
+	struct ca0132_spec *spec = container_of(
+		to_delayed_work(work), struct ca0132_spec, unsol_hp_work);
+	ca0132_select_out(spec->codec);
+	snd_hda_jack_report_sync(spec->codec);
+}
+
 static void ca0132_set_dmic(struct hda_codec *codec, int enable);
 static int ca0132_mic_boost_set(struct hda_codec *codec, long val);
 static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val);
@@ -4399,8 +4410,7 @@ static void ca0132_process_dsp_response(struct hda_codec *codec)
 
 static void ca0132_unsol_event(struct hda_codec *codec, unsigned int res)
 {
-	snd_printdd(KERN_INFO "ca0132_unsol_event: 0x%x\n", res);
-
+	struct ca0132_spec *spec = codec->spec;
 
 	if (((res >> AC_UNSOL_RES_TAG_SHIFT) & 0x3f) == UNSOL_TAG_DSP) {
 		ca0132_process_dsp_response(codec);
@@ -4412,8 +4422,13 @@ static void ca0132_unsol_event(struct hda_codec *codec, unsigned int res)
 
 		switch (res) {
 		case UNSOL_TAG_HP:
-			ca0132_select_out(codec);
-			snd_hda_jack_report_sync(codec);
+			/* Delay enabling the HP amp, to let the mic-detection
+			 * state machine run.
+			 */
+			cancel_delayed_work_sync(&spec->unsol_hp_work);
+			queue_delayed_work(codec->bus->workq,
+					   &spec->unsol_hp_work,
+					   msecs_to_jiffies(500));
 			break;
 		case UNSOL_TAG_AMIC1:
 			ca0132_select_mic(codec);
@@ -4588,6 +4603,7 @@ static void ca0132_free(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
 
+	cancel_delayed_work_sync(&spec->unsol_hp_work);
 	snd_hda_power_up(codec);
 	snd_hda_sequence_write(codec, spec->base_exit_verbs);
 	ca0132_exit_chip(codec);
@@ -4653,6 +4669,7 @@ static int patch_ca0132(struct hda_codec *codec)
 	if (!spec)
 		return -ENOMEM;
 	codec->spec = spec;
+	spec->codec = codec;
 
 	spec->num_mixers = 1;
 	spec->mixers[0] = ca0132_mixer;
@@ -4663,6 +4680,8 @@ static int patch_ca0132(struct hda_codec *codec)
 	spec->init_verbs[1] = ca0132_init_verbs1;
 	spec->num_init_verbs = 2;
 
+	INIT_DELAYED_WORK(&spec->unsol_hp_work, ca0132_unsol_hp_delayed);
+
 	ca0132_init_chip(codec);
 
 	ca0132_config(codec);
-- 
1.8.1.3.605.g02339dd
