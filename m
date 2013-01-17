From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/9] ALSA: hda - Record the current speaker /
	LO mute status in hda_gen_spec
Date: Thu, 17 Jan 2013 17:54:47 +0100
Message-ID: <1358441694-32004-3-git-send-email-tiwai@suse.de>
References: <1358441694-32004-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ACC2265205
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2013 17:55:00 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id D3279A51C9
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

... to be referred by the codec driver.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 2 ++
 sound/pci/hda/hda_generic.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 0d6c4f7..186a554 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3047,6 +3047,7 @@ void snd_hda_gen_update_outputs(struct hda_codec *codec)
 	else
 		on = spec->hp_jack_present | spec->line_jack_present;
 	on |= spec->master_mute;
+	spec->speaker_muted = on;
 	do_automute(codec, ARRAY_SIZE(spec->autocfg.speaker_pins),
 		    spec->autocfg.speaker_pins, on);
 
@@ -3060,6 +3061,7 @@ void snd_hda_gen_update_outputs(struct hda_codec *codec)
 	else
 		on = spec->hp_jack_present;
 	on |= spec->master_mute;
+	spec->line_out_muted = on;
 	do_automute(codec, ARRAY_SIZE(spec->autocfg.line_out_pins),
 		    spec->autocfg.line_out_pins, on);
 }
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 6ba5805..d4abf87 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -170,6 +170,8 @@ struct hda_gen_spec {
 	unsigned int auto_mic:1;
 	unsigned int automute_speaker:1; /* automute speaker outputs */
 	unsigned int automute_lo:1; /* automute LO outputs */
+	unsigned int speaker_muted:1; /* current status of speaker mute */
+	unsigned int line_out_muted:1; /* current status of LO mute */
 	unsigned int detect_hp:1;	/* Headphone detection enabled */
 	unsigned int detect_lo:1;	/* Line-out detection enabled */
 	unsigned int automute_speaker_possible:1; /* there are speakers and either LO or HP */
-- 
1.8.1
