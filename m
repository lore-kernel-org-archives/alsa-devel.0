From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 2/3] ALSA: hda - make VIA codec use generic
	unsol event handler
Date: Mon,  8 Oct 2012 15:44:14 +0200
Message-ID: <1349703855-7775-2-git-send-email-david.henningsson@canonical.com>
References: <1349703855-7775-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F7A6261726
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2012 15:44:25 +0200 (CEST)
In-Reply-To: <1349703855-7775-1-git-send-email-david.henningsson@canonical.com>
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

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_via.c |   47 ++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 430cb33..eae466a 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -1684,23 +1684,6 @@ static void via_hp_automute(struct hda_codec *codec)
 	via_line_automute(codec, present);
 }
 
-/* unsolicited event for jack sensing */
-static void via_unsol_event(struct hda_codec *codec,
-				  unsigned int res)
-{
-	res >>= 26;
-	res = snd_hda_jack_get_action(codec, res);
-
-	if (res & VIA_JACK_EVENT)
-		set_widgets_power_state(codec);
-
-	res &= ~VIA_JACK_EVENT;
-
-	if (res == VIA_HP_EVENT || res == VIA_LINE_EVENT)
-		via_hp_automute(codec);
-	snd_hda_jack_report_sync(codec);
-}
-
 #ifdef CONFIG_PM
 static int via_suspend(struct hda_codec *codec)
 {
@@ -1736,7 +1719,7 @@ static const struct hda_codec_ops via_patch_ops = {
 	.build_pcms = via_build_pcms,
 	.init = via_init,
 	.free = via_free,
-	.unsol_event = via_unsol_event,
+	.unsol_event = snd_hda_jack_unsol_event,
 #ifdef CONFIG_PM
 	.suspend = via_suspend,
 	.check_power_status = via_check_power_status,
@@ -2714,6 +2697,17 @@ static void via_auto_init_dig_in(struct hda_codec *codec)
 	snd_hda_set_pin_ctl(codec, spec->autocfg.dig_in_pin, PIN_IN);
 }
 
+static void via_jack_output_event(struct hda_codec *codec, struct hda_jack_tbl *tbl)
+{
+	set_widgets_power_state(codec);
+	via_hp_automute(codec);
+}
+
+static void via_jack_powerstate_event(struct hda_codec *codec, struct hda_jack_tbl *tbl)
+{
+	set_widgets_power_state(codec);
+}
+
 /* initialize the unsolicited events */
 static void via_auto_init_unsol_event(struct hda_codec *codec)
 {
@@ -2721,26 +2715,31 @@ static void via_auto_init_unsol_event(struct hda_codec *codec)
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	unsigned int ev;
 	int i;
+	hda_jack_callback cb;
 
 	if (cfg->hp_pins[0] && is_jack_detectable(codec, cfg->hp_pins[0]))
-		snd_hda_jack_detect_enable(codec, cfg->hp_pins[0],
-					   VIA_HP_EVENT | VIA_JACK_EVENT);
+		snd_hda_jack_detect_enable_callback(codec, cfg->hp_pins[0],
+						    VIA_HP_EVENT | VIA_JACK_EVENT,
+						    via_jack_output_event);
 
 	if (cfg->speaker_pins[0])
 		ev = VIA_LINE_EVENT;
 	else
 		ev = 0;
+	cb = ev ? via_jack_output_event : via_jack_powerstate_event;
+
 	for (i = 0; i < cfg->line_outs; i++) {
 		if (cfg->line_out_pins[i] &&
 		    is_jack_detectable(codec, cfg->line_out_pins[i]))
-			snd_hda_jack_detect_enable(codec, cfg->line_out_pins[i],
-						   ev | VIA_JACK_EVENT);
+			snd_hda_jack_detect_enable_callback(codec, cfg->line_out_pins[i],
+							    ev | VIA_JACK_EVENT, cb);
 	}
 
 	for (i = 0; i < cfg->num_inputs; i++) {
 		if (is_jack_detectable(codec, cfg->inputs[i].pin))
-			snd_hda_jack_detect_enable(codec, cfg->inputs[i].pin,
-						   VIA_JACK_EVENT);
+			snd_hda_jack_detect_enable_callback(codec, cfg->inputs[i].pin,
+							    VIA_JACK_EVENT,
+							    via_jack_powerstate_event);
 	}
 }
 
-- 
1.7.9.5
