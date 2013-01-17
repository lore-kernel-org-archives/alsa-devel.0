From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/9] ALSA: hda - Add suppress_auto_mute flag to
	hda_gen_spec
Date: Thu, 17 Jan 2013 17:54:48 +0100
Message-ID: <1358441694-32004-4-git-send-email-tiwai@suse.de>
References: <1358441694-32004-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E128265224
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 17:55:00 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id D3440A51CB
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 17:54:59 +0100 (CET)
In-Reply-To: <1358441694-32004-1-git-send-email-tiwai@suse.de>
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

A new flag to skip the auto-mute handling in the generic parser, just
like suppress_auto_mic flag.  It has to be set before calling
snd_hda_gen_parse_auto_config().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 6 ++++++
 sound/pci/hda/hda_generic.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 186a554..1ea9c2d 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -119,6 +119,9 @@ static void parse_user_hints(struct hda_codec *codec)
 	if (val >= 0)
 		codec->single_adc_amp = !!val;
 
+	val = snd_hda_get_bool_hint(codec, "auto_mute");
+	if (val >= 0)
+		spec->suppress_auto_mute = !val;
 	val = snd_hda_get_bool_hint(codec, "auto_mic");
 	if (val >= 0)
 		spec->suppress_auto_mic = !val;
@@ -3253,6 +3256,9 @@ static int check_auto_mute_availability(struct hda_codec *codec)
 	int present = 0;
 	int i, err;
 
+	if (spec->suppress_auto_mute)
+		return 0;
+
 	if (cfg->hp_pins[0])
 		present++;
 	if (cfg->line_out_pins[0])
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index d4abf87..59d08c6 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -177,6 +177,7 @@ struct hda_gen_spec {
 	unsigned int automute_speaker_possible:1; /* there are speakers and either LO or HP */
 	unsigned int automute_lo_possible:1;	  /* there are line outs and HP */
 	unsigned int keep_vref_in_automute:1; /* Don't clear VREF in automute */
+	unsigned int suppress_auto_mute:1; /* suppress input jack auto mute */
 	unsigned int suppress_auto_mic:1; /* suppress input jack auto switch */
 	unsigned int line_in_auto_switch:1; /* allow line-in auto switch */
 
-- 
1.8.1
