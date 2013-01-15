From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/20] ALSA: hda - Return "Headphone Mic" from
	hda_get_autocfg_input_label()
Date: Tue, 15 Jan 2013 12:05:29 +0100
Message-ID: <1358247947-13992-3-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F656265317
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 6B7CFA520D
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:48 +0100 (CET)
In-Reply-To: <1358247947-13992-1-git-send-email-tiwai@suse.de>
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

Instead of handling special cases in the caller side, give a proper
name string "Headphone Mic" from hda_get_autocfg_input_label() when
the headhpone jack pin is specified as an input.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_auto_parser.c | 2 ++
 sound/pci/hda/hda_generic.c     | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 6a01c01..e5b20219 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -395,6 +395,8 @@ static const char *hda_get_input_pin_label(struct hda_codec *codec,
 		return "SPDIF In";
 	case AC_JACK_DIG_OTHER_IN:
 		return "Digital In";
+	case AC_JACK_HP_OUT:
+		return "Headphone Mic";
 	default:
 		return "Misc";
 	}
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index f07b326..aa4e639 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2085,8 +2085,6 @@ static int create_input_ctls(struct hda_codec *codec)
 			continue;
 
 		label = hda_get_autocfg_input_label(codec, cfg, i);
-		if (spec->shared_mic_hp && !strcmp(label, "Misc"))
-			label = "Headphone Mic";
 		if (prev_label && !strcmp(label, prev_label))
 			type_idx++;
 		else
@@ -2540,8 +2538,6 @@ static int parse_mic_boost(struct hda_codec *codec)
 			unsigned int val;
 
 			label = hda_get_autocfg_input_label(codec, cfg, i);
-			if (spec->shared_mic_hp && !strcmp(label, "Misc"))
-				label = "Headphone Mic";
 			if (prev_label && !strcmp(label, prev_label))
 				type_idx++;
 			else
-- 
1.8.1
