From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/12] ALSA: hda - Set the pin targets after
	deciding output config
Date: Mon, 21 Jan 2013 17:06:09 +0100
Message-ID: <1358784377-26102-5-git-send-email-tiwai@suse.de>
References: <1358784377-26102-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E56C26163F
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 17:06:19 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id D9C0FA50E4
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 17:06:18 +0100 (CET)
In-Reply-To: <1358784377-26102-1-git-send-email-tiwai@suse.de>
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

Since fill_and_eval_dacs() may be called repeatedly with different
configurations, setting pinctls at each time there isn't optimal.
We can set it better only once after deciding the output configuration
in parse_output_paths().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 37d7ed7..7b739b5 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1352,7 +1352,6 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 	struct hda_gen_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	int i, err, badness;
-	unsigned int val;
 
 	/* set num_dacs once to full for look_for_dac() */
 	spec->multiout.num_dacs = cfg->line_outs;
@@ -1489,20 +1488,6 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
 				   spec->multiout.extra_out_nid,
 				   spec->speaker_paths);
 
-	/* set initial pinctl targets */
-	if (spec->prefer_hp_amp || cfg->line_out_type == AUTO_PIN_HP_OUT)
-		val = PIN_HP;
-	else
-		val = PIN_OUT;
-	set_pin_targets(codec, cfg->line_outs, cfg->line_out_pins, val);
-	if (cfg->line_out_type != AUTO_PIN_HP_OUT)
-		set_pin_targets(codec, cfg->hp_outs, cfg->hp_pins, PIN_HP);
-	if (cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
-		val = spec->prefer_hp_amp ? PIN_HP : PIN_OUT;
-		set_pin_targets(codec, cfg->speaker_outs,
-				cfg->speaker_pins, val);
-	}
-
 	return badness;
 }
 
@@ -1604,6 +1589,7 @@ static int parse_output_paths(struct hda_codec *codec)
 	struct hda_gen_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	struct auto_pin_cfg *best_cfg;
+	unsigned int val;
 	int best_badness = INT_MAX;
 	int badness;
 	bool fill_hardwired = true, fill_mio_first = true;
@@ -1693,6 +1679,20 @@ static int parse_output_paths(struct hda_codec *codec)
 						HDA_OUTPUT, spec->vmaster_tlv);
 	}
 
+	/* set initial pinctl targets */
+	if (spec->prefer_hp_amp || cfg->line_out_type == AUTO_PIN_HP_OUT)
+		val = PIN_HP;
+	else
+		val = PIN_OUT;
+	set_pin_targets(codec, cfg->line_outs, cfg->line_out_pins, val);
+	if (cfg->line_out_type != AUTO_PIN_HP_OUT)
+		set_pin_targets(codec, cfg->hp_outs, cfg->hp_pins, PIN_HP);
+	if (cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
+		val = spec->prefer_hp_amp ? PIN_HP : PIN_OUT;
+		set_pin_targets(codec, cfg->speaker_outs,
+				cfg->speaker_pins, val);
+	}
+
 	kfree(best_cfg);
 	return 0;
 }
-- 
1.8.1.1
