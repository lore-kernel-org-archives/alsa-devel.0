From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 085/112] ALSA: hda - Initialize output paths
	with current active states
Date: Tue,  8 Jan 2013 12:39:18 +0100
Message-ID: <1357645185-7645-86-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C891226521A
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id A2023A535B
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

Set path->active flag at the path creation time and let the paths
initialized according to the current path->active state in
set_output_and_unmute().  This allows to modify the active flag of
some output paths dynamically, e.g. switching the front output route
with or without aamix like patch_via.c.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 08eced0..5051350 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -873,8 +873,10 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 		}
 		if (!path)
 			dac = dacs[i] = 0;
-		else
+		else {
 			print_nid_path("output", path);
+			path->active = true;
+		}
 		if (dac)
 			badness += assign_out_path_ctls(codec, pin, dac);
 	}
@@ -1045,6 +1047,7 @@ static bool map_singles(struct hda_codec *codec, int outs,
 			dacs[i] = dac;
 			found = true;
 			print_nid_path("output", path);
+			path->active = true;
 		}
 	}
 	return found;
@@ -2416,6 +2419,7 @@ static void parse_digital(struct hda_codec *codec)
 		if (!path)
 			continue;
 		print_nid_path("digout", path);
+		path->active = true;
 		if (!nums) {
 			spec->multiout.dig_out_nid = dig_nid;
 			spec->dig_out_type = spec->autocfg.dig_out_type[0];
@@ -3554,10 +3558,8 @@ static void set_output_and_unmute(struct hda_codec *codec, hda_nid_t pin,
 	path = snd_hda_get_nid_path(codec, dac, pin);
 	if (!path)
 		return;
-	if (path->active)
-		return;
-	snd_hda_activate_path(codec, path, true, true);
-	set_pin_eapd(codec, pin, true);
+	snd_hda_activate_path(codec, path, path->active, true);
+	set_pin_eapd(codec, pin, path->active);
 }
 
 /* initialize primary output paths */
-- 
1.8.0.1
