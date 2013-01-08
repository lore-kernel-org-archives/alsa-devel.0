From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 091/112] ALSA: hda - Initialize digital-input
	path properly
Date: Tue,  8 Jan 2013 12:39:24 +0100
Message-ID: <1357645185-7645-92-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 03CDC265225
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:27 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id BC7B4A5388
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

Call the path activation for the digital input pin properly, not only
setting the pin control.  Also add spec->digin_path for keeping the
path index.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 8 +++++++-
 sound/pci/hda/hda_generic.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 2296839..65883c7 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2519,6 +2519,7 @@ static void parse_digital(struct hda_codec *codec)
 				print_nid_path("digin", path);
 				path->active = true;
 				spec->dig_in_nid = dig_nid;
+				spec->digin_path = snd_hda_get_path_idx(codec, path);
 				break;
 			}
 		}
@@ -3786,8 +3787,13 @@ static void init_digital(struct hda_codec *codec)
 				      spec->digout_paths[i]);
 	}
 	pin = spec->autocfg.dig_in_pin;
-	if (pin)
+	if (pin) {
+		struct nid_path *path;
 		snd_hda_set_pin_ctl_cache(codec, pin, PIN_IN);
+		path = snd_hda_get_path_from_idx(codec, spec->digin_path);
+		if (path)
+			snd_hda_activate_path(codec, path, path->active, false);
+	}
 }
 
 /* clear unsol-event tags on unused pins; Conexant codecs seem to leave
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 71d409f..ba8de12 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -136,6 +136,7 @@ struct hda_gen_spec {
 	int speaker_paths[AUTO_CFG_MAX_OUTS];
 	int digout_paths[AUTO_CFG_MAX_OUTS];
 	int loopback_paths[HDA_MAX_NUM_INPUTS];
+	int digin_path;
 
 	/* auto-mic stuff */
 	int am_num_entries;
-- 
1.8.0.1
