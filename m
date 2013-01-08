From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 095/112] ALSA: hda - Prefer binding the primary
	CLFE output
Date: Tue,  8 Jan 2013 12:39:28 +0100
Message-ID: <1357645185-7645-96-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 275A426522C
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:27 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id C6ACEA538D
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

When 5.1 or more multiple speakers with found but not enough DACs are
available, it's better to bind such pins to the DACs of the primary
outputs with the same channels rather than binding to the first DAC
(i.e. the front channel).  For the cases with two speaker pins, it's
rather regarded as front + bass combination, thus it's more practical
to still bind to the front, though.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 2b33d50..fa8302f 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -860,6 +860,27 @@ static struct badness_table extra_out_badness = {
 	.shared_surr_main = BAD_NO_EXTRA_SURR_DAC,
 };
 
+/* get the DAC of the primary output corresponding to the given array index */
+static hda_nid_t get_primary_out(struct hda_codec *codec, int idx)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+
+	if (cfg->line_outs > idx)
+		return spec->private_dac_nids[idx];
+	idx -= cfg->line_outs;
+	if (spec->multi_ios > idx)
+		return spec->multi_io[idx].dac;
+	return 0;
+}
+
+/* return the DAC if it's reachable, otherwise zero */
+static inline hda_nid_t try_dac(struct hda_codec *codec,
+				hda_nid_t dac, hda_nid_t pin)
+{
+	return is_reachable_path(codec, dac, pin) ? dac : 0;
+}
+
 /* try to assign DACs to pins and return the resultant badness */
 static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 			   const hda_nid_t *pins, hda_nid_t *dacs,
@@ -867,7 +888,6 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 			   const struct badness_table *bad)
 {
 	struct hda_gen_spec *spec = codec->spec;
-	struct auto_pin_cfg *cfg = &spec->autocfg;
 	int i, j;
 	int badness = 0;
 	hda_nid_t dac;
@@ -897,11 +917,12 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 		}
 		dac = dacs[i];
 		if (!dac) {
-			if (is_reachable_path(codec, dacs[0], pin))
-				dac = dacs[0];
-			else if (cfg->line_outs > i &&
-				 is_reachable_path(codec, spec->private_dac_nids[i], pin))
-				dac = spec->private_dac_nids[i];
+			if (num_outs > 2)
+				dac = try_dac(codec, get_primary_out(codec, i), pin);
+			if (!dac)
+				dac = try_dac(codec, dacs[0], pin);
+			if (!dac)
+				dac = try_dac(codec, get_primary_out(codec, i), pin);
 			if (dac) {
 				if (!i)
 					badness += bad->shared_primary;
-- 
1.8.0.1
