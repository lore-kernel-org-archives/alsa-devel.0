From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC v2 7/7] ALSA: hda - Use standard hda_jack
	infrastructure for CA0132 driver
Date: Mon, 15 Sep 2014 14:48:23 +0200
Message-ID: <1410785303-19454-8-git-send-email-tiwai@suse.de>
References: <1410785303-19454-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 976902619F2
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 14:48:27 +0200 (CEST)
In-Reply-To: <1410785303-19454-1-git-send-email-tiwai@suse.de>
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

For its headphone, mic and DSP responses, we can use the standard
hda_jack infrastructure in CA0132 driver, too.  The only point to
handle carefully is the delayed headphone jack handling.  It tries to
react after a certain delay.  Here we use the existing block_report
flag in hda_jack_tbl (that was implemented for HDMI).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_ca0132.c | 76 ++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 42 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 39fae52258f0..4f7ffa8c4a0d 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -3224,8 +3224,14 @@ static void ca0132_unsol_hp_delayed(struct work_struct *work)
 {
 	struct ca0132_spec *spec = container_of(
 		to_delayed_work(work), struct ca0132_spec, unsol_hp_work);
+	struct hda_jack_tbl *jack;
+
 	ca0132_select_out(spec->codec);
-	snd_hda_jack_report_sync(spec->codec);
+	jack = snd_hda_jack_tbl_get(spec->codec, UNSOL_TAG_HP);
+	if (jack) {
+		jack->block_report = 0;
+		snd_hda_jack_report_sync(spec->codec);
+	}
 }
 
 static void ca0132_set_dmic(struct hda_codec *codec, int enable);
@@ -4114,12 +4120,6 @@ static void init_input(struct hda_codec *codec, hda_nid_t pin, hda_nid_t adc)
 	}
 }
 
-static void ca0132_init_unsol(struct hda_codec *codec)
-{
-	snd_hda_jack_detect_enable(codec, UNSOL_TAG_HP);
-	snd_hda_jack_detect_enable(codec, UNSOL_TAG_AMIC1);
-}
-
 static void refresh_amp_caps(struct hda_codec *codec, hda_nid_t nid, int dir)
 {
 	unsigned int caps;
@@ -4390,7 +4390,8 @@ static void ca0132_download_dsp(struct hda_codec *codec)
 		ca0132_set_dsp_msr(codec, true);
 }
 
-static void ca0132_process_dsp_response(struct hda_codec *codec)
+static void ca0132_process_dsp_response(struct hda_codec *codec,
+					struct hda_jack_callback *callback)
 {
 	struct ca0132_spec *spec = codec->spec;
 
@@ -4403,38 +4404,31 @@ static void ca0132_process_dsp_response(struct hda_codec *codec)
 	dspio_clear_response_queue(codec);
 }
 
-static void ca0132_unsol_event(struct hda_codec *codec, unsigned int res)
+static void hp_callback(struct hda_codec *codec, struct hda_jack_callback *cb)
 {
 	struct ca0132_spec *spec = codec->spec;
-	unsigned int tag = (res >> AC_UNSOL_RES_TAG_SHIFT) & 0x3f;
 
-	if (tag == UNSOL_TAG_DSP) {
-		ca0132_process_dsp_response(codec);
-	} else {
-		struct hda_jack_tbl *jack;
-
-		codec_dbg(codec, "snd_hda_jack_get_action: 0x%x\n", res);
-		jack = snd_hda_jack_tbl_get_from_tag(codec, tag);
-		if (!jack)
-			return;
-		switch (jack->nid) {
-		case UNSOL_TAG_HP:
-			/* Delay enabling the HP amp, to let the mic-detection
-			 * state machine run.
-			 */
-			cancel_delayed_work_sync(&spec->unsol_hp_work);
-			queue_delayed_work(codec->bus->workq,
-					   &spec->unsol_hp_work,
-					   msecs_to_jiffies(500));
-			break;
-		case UNSOL_TAG_AMIC1:
-			ca0132_select_mic(codec);
-			snd_hda_jack_report_sync(codec);
-			break;
-		default:
-			break;
-		}
-	}
+	/* Delay enabling the HP amp, to let the mic-detection
+	 * state machine run.
+	 */
+	cancel_delayed_work_sync(&spec->unsol_hp_work);
+	queue_delayed_work(codec->bus->workq, &spec->unsol_hp_work,
+			   msecs_to_jiffies(500));
+	cb->tbl->block_report = 1;
+}
+
+static void amic_callback(struct hda_codec *codec, struct hda_jack_callback *cb)
+{
+	ca0132_select_mic(codec);
+}
+
+static void ca0132_init_unsol(struct hda_codec *codec)
+{
+	snd_hda_jack_detect_enable_callback(codec, UNSOL_TAG_HP, hp_callback);
+	snd_hda_jack_detect_enable_callback(codec, UNSOL_TAG_AMIC1,
+					    amic_callback);
+	snd_hda_jack_detect_enable_callback(codec, UNSOL_TAG_DSP,
+					    ca0132_process_dsp_response);
 }
 
 /*
@@ -4445,8 +4439,6 @@ static void ca0132_unsol_event(struct hda_codec *codec, unsigned int res)
 static struct hda_verb ca0132_base_init_verbs[] = {
 	/*enable ct extension*/
 	{0x15, VENDOR_CHIPIO_CT_EXTENSIONS_ENABLE, 0x1},
-	/*enable DSP node unsol, needed for DSP download*/
-	{0x16, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | UNSOL_TAG_DSP},
 	{}
 };
 
@@ -4563,6 +4555,8 @@ static int ca0132_init(struct hda_codec *codec)
 
 	snd_hda_power_up(codec);
 
+	ca0132_init_unsol(codec);
+
 	ca0132_init_params(codec);
 	ca0132_init_flags(codec);
 	snd_hda_sequence_write(codec, spec->base_init_verbs);
@@ -4585,8 +4579,6 @@ static int ca0132_init(struct hda_codec *codec)
 	for (i = 0; i < spec->num_init_verbs; i++)
 		snd_hda_sequence_write(codec, spec->init_verbs[i]);
 
-	ca0132_init_unsol(codec);
-
 	ca0132_select_out(codec);
 	ca0132_select_mic(codec);
 
@@ -4614,7 +4606,7 @@ static struct hda_codec_ops ca0132_patch_ops = {
 	.build_pcms = ca0132_build_pcms,
 	.init = ca0132_init,
 	.free = ca0132_free,
-	.unsol_event = ca0132_unsol_event,
+	.unsol_event = snd_hda_jack_unsol_event,
 };
 
 static void ca0132_config(struct hda_codec *codec)
-- 
2.1.0
