From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 6/7] ALSA: hda - Remove superfluous hooks
	from VIA driver
Date: Thu, 11 Sep 2014 16:19:16 +0200
Message-ID: <1410445157-23198-7-git-send-email-tiwai@suse.de>
References: <1410445157-23198-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 250872656F6
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 16:19:21 +0200 (CEST)
In-Reply-To: <1410445157-23198-1-git-send-email-tiwai@suse.de>
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

Like the previous fix for STAC/IDT codecs, the automute hooks in VIA
driver can be also removed by enabling the power control callback for
all pins.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_via.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 8d234ab9f06b..6c206b6c8d65 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -118,7 +118,6 @@ static void via_playback_pcm_hook(struct hda_pcm_stream *hinfo,
 				  struct hda_codec *codec,
 				  struct snd_pcm_substream *substream,
 				  int action);
-static void via_hp_automute(struct hda_codec *codec, struct hda_jack_callback *tbl);
 
 static struct via_spec *via_new_spec(struct hda_codec *codec)
 {
@@ -575,20 +574,6 @@ static const struct snd_kcontrol_new vt1708_jack_detect_ctl[] = {
 	{} /* terminator */
 };
 
-static void via_hp_automute(struct hda_codec *codec,
-			    struct hda_jack_callback *tbl)
-{
-	set_widgets_power_state(codec);
-	snd_hda_gen_hp_automute(codec, tbl);
-}
-
-static void via_line_automute(struct hda_codec *codec,
-			      struct hda_jack_callback *tbl)
-{
-	set_widgets_power_state(codec);
-	snd_hda_gen_line_automute(codec, tbl);
-}
-
 static void via_jack_powerstate_event(struct hda_codec *codec,
 				      struct hda_jack_callback *tbl)
 {
@@ -602,22 +587,16 @@ static void via_set_jack_unsol_events(struct hda_codec *codec)
 	hda_nid_t pin;
 	int i;
 
-	spec->gen.hp_automute_hook = via_hp_automute;
-	if (cfg->speaker_pins[0])
-		spec->gen.line_automute_hook = via_line_automute;
-
 	for (i = 0; i < cfg->line_outs; i++) {
 		pin = cfg->line_out_pins[i];
-		if (pin && !snd_hda_jack_tbl_get(codec, pin) &&
-		    is_jack_detectable(codec, pin))
+		if (pin && is_jack_detectable(codec, pin))
 			snd_hda_jack_detect_enable_callback(codec, pin,
 							    via_jack_powerstate_event);
 	}
 
 	for (i = 0; i < cfg->num_inputs; i++) {
 		pin = cfg->line_out_pins[i];
-		if (pin && !snd_hda_jack_tbl_get(codec, pin) &&
-		    is_jack_detectable(codec, pin))
+		if (pin && is_jack_detectable(codec, pin))
 			snd_hda_jack_detect_enable_callback(codec, pin,
 							    via_jack_powerstate_event);
 	}
-- 
2.1.0
