From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - avoid unneccesary indices on
	"Headphone Jack" controls
Date: Wed,  3 Oct 2012 11:12:53 +0200
Message-ID: <1349255573-11321-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B5ED12615D4
 for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2012 11:12:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: David Henningsson <david.henningsson@canonical.com>, 1060729@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

In case there is one "Headphone Jack" and one "Dock Headphone Jack",
one of them will get an index, even though that is not needed.
This patch fixes that issue.

BugLink: https://bugs.launchpad.net/bugs/1060729
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_auto_parser.c |   49 +++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 12 deletions(-)

Alsa-info at: https://launchpadlibrarian.net/118211803/AlsaInfo

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index a98e25e..4ec6dc8 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -498,6 +498,38 @@ static const char *check_output_sfx(hda_nid_t nid, const hda_nid_t *pins,
 	return channel_sfx[i];
 }
 
+static const char *check_output_pfx(struct hda_codec *codec, hda_nid_t nid)
+{
+	unsigned int def_conf = snd_hda_codec_get_pincfg(codec, nid);
+	int attr = snd_hda_get_input_pin_attr(def_conf);
+
+	/* check the location */
+	switch (attr) {
+	case INPUT_PIN_ATTR_DOCK:
+		return "Dock ";
+	case INPUT_PIN_ATTR_FRONT:
+		return "Front ";
+	}
+	return "";
+}
+
+static int get_hp_label_index(struct hda_codec *codec, hda_nid_t nid,
+			      const hda_nid_t *pins, int num_pins)
+{
+	int i, j, idx = 0;
+
+	const char *pfx = check_output_pfx(codec, nid);
+
+	i = find_idx_in_nid_list(nid, pins, num_pins);
+	if (i < 0)
+		return -1;
+	for (j = 0; j < i; j++)
+		if (pfx == check_output_pfx(codec, pins[j]))
+			idx++;
+
+	return idx;
+}
+
 static int fill_audio_out_name(struct hda_codec *codec, hda_nid_t nid,
 			       const struct auto_pin_cfg *cfg,
 			       const char *name, char *label, int maxlen,
@@ -505,20 +537,13 @@ static int fill_audio_out_name(struct hda_codec *codec, hda_nid_t nid,
 {
 	unsigned int def_conf = snd_hda_codec_get_pincfg(codec, nid);
 	int attr = snd_hda_get_input_pin_attr(def_conf);
-	const char *pfx = "", *sfx = "";
+	const char *pfx, *sfx = "";
 
 	/* handle as a speaker if it's a fixed line-out */
 	if (!strcmp(name, "Line Out") && attr == INPUT_PIN_ATTR_INT)
 		name = "Speaker";
-	/* check the location */
-	switch (attr) {
-	case INPUT_PIN_ATTR_DOCK:
-		pfx = "Dock ";
-		break;
-	case INPUT_PIN_ATTR_FRONT:
-		pfx = "Front ";
-		break;
-	}
+	pfx = check_output_pfx(codec, nid);
+
 	if (cfg) {
 		/* try to give a unique suffix if needed */
 		sfx = check_output_sfx(nid, cfg->line_out_pins, cfg->line_outs,
@@ -528,8 +553,8 @@ static int fill_audio_out_name(struct hda_codec *codec, hda_nid_t nid,
 					       indexp);
 		if (!sfx) {
 			/* don't add channel suffix for Headphone controls */
-			int idx = find_idx_in_nid_list(nid, cfg->hp_pins,
-						       cfg->hp_outs);
+			int idx = get_hp_label_index(codec, nid, cfg->hp_pins,
+						     cfg->hp_outs);
 			if (idx >= 0)
 				*indexp = idx;
 			sfx = "";
-- 
1.7.9.5
