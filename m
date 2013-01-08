From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 018/112] ALSA: hda/realtek - Consolidate
	is_reachable_path()
Date: Tue,  8 Jan 2013 12:38:11 +0100
Message-ID: <1357645185-7645-19-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BEBAD26519E
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:24 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 3D977A5206
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
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

alc_auto_is_dac_reachable() can be replaced fully with
is_reachable_path().  The only difference is the order of arguments.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 84f6781..fc5f80b5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2902,15 +2902,6 @@ static bool alc_is_dac_already_used(struct hda_codec *codec, hda_nid_t nid)
 	return false;
 }
 
-/* check whether the DAC is reachable from the pin */
-static bool alc_auto_is_dac_reachable(struct hda_codec *codec,
-				      hda_nid_t pin, hda_nid_t dac)
-{
-	if (!pin || !dac)
-		return false;
-	return snd_hda_get_conn_index(codec, pin, dac, true) >= 0;
-}
-
 /* look for an empty DAC slot */
 static hda_nid_t alc_auto_look_for_dac(struct hda_codec *codec, hda_nid_t pin)
 {
@@ -2921,7 +2912,7 @@ static hda_nid_t alc_auto_look_for_dac(struct hda_codec *codec, hda_nid_t pin)
 		hda_nid_t nid = spec->all_dacs[i];
 		if (!nid || alc_is_dac_already_used(codec, nid))
 			continue;
-		if (alc_auto_is_dac_reachable(codec, pin, nid))
+		if (is_reachable_path(codec, nid, pin))
 			return nid;
 	}
 	return 0;
@@ -3013,7 +3004,7 @@ static hda_nid_t get_dac_if_single(struct hda_codec *codec, hda_nid_t pin)
 		hda_nid_t nid = spec->all_dacs[i];
 		if (!nid || alc_is_dac_already_used(codec, nid))
 			continue;
-		if (alc_auto_is_dac_reachable(codec, pin, nid)) {
+		if (is_reachable_path(codec, nid, pin)) {
 			if (nid_found)
 				return 0;
 			nid_found = nid;
@@ -3189,7 +3180,7 @@ static int alc_auto_fill_dacs(struct hda_codec *codec, int num_outs,
 			dacs[i] = alc_auto_look_for_dac(codec, pin);
 		if (!dacs[i] && !i) {
 			for (j = 1; j < num_outs; j++) {
-				if (alc_auto_is_dac_reachable(codec, pin, dacs[j])) {
+				if (is_reachable_path(codec, dacs[j], pin)) {
 					dacs[0] = dacs[j];
 					dacs[j] = 0;
 					break;
@@ -3198,11 +3189,10 @@ static int alc_auto_fill_dacs(struct hda_codec *codec, int num_outs,
 		}
 		dac = dacs[i];
 		if (!dac) {
-			if (alc_auto_is_dac_reachable(codec, pin, dacs[0]))
+			if (is_reachable_path(codec, dacs[0], pin))
 				dac = dacs[0];
 			else if (cfg->line_outs > i &&
-				 alc_auto_is_dac_reachable(codec, pin,
-					spec->private_dac_nids[i]))
+				 is_reachable_path(codec, spec->private_dac_nids[i], pin))
 				dac = spec->private_dac_nids[i];
 			if (dac) {
 				if (!i)
@@ -3211,8 +3201,7 @@ static int alc_auto_fill_dacs(struct hda_codec *codec, int num_outs,
 					badness += bad->shared_surr;
 				else
 					badness += bad->shared_clfe;
-			} else if (alc_auto_is_dac_reachable(codec, pin,
-					spec->private_dac_nids[0])) {
+			} else if (is_reachable_path(codec, spec->private_dac_nids[0], pin)) {
 				dac = spec->private_dac_nids[0];
 				badness += bad->shared_surr_main;
 			} else if (!i)
@@ -4141,7 +4130,7 @@ static int alc_auto_fill_multi_ios(struct hda_codec *codec,
 
 			if (offset && offset + spec->multi_ios < dacs) {
 				dac = spec->private_dac_nids[offset + spec->multi_ios];
-				if (!alc_auto_is_dac_reachable(codec, nid, dac))
+				if (!is_reachable_path(codec, dac, nid))
 					dac = 0;
 			}
 			if (hardwired)
-- 
1.8.0.1
