From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 3/3] ALSA: hda - Don't add unnecessary indices
	on HDMI and SPDIF
Date: Fri, 18 Jan 2013 15:43:03 +0100
Message-ID: <1358520183-2908-4-git-send-email-david.henningsson@canonical.com>
References: <1358520183-2908-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 824BC265F42
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 15:43:03 +0100 (CET)
In-Reply-To: <1358520183-2908-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

If there's one each of HDMI and SPDIF, we should not add an index
on the one that comes second.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_auto_parser.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index a4810c7..dcb6575 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -603,6 +603,7 @@ int snd_hda_get_pin_label(struct hda_codec *codec, hda_nid_t nid,
 	unsigned int def_conf = snd_hda_codec_get_pincfg(codec, nid);
 	const char *name = NULL;
 	int i;
+	bool hdmi;
 
 	if (indexp)
 		*indexp = 0;
@@ -621,16 +622,17 @@ int snd_hda_get_pin_label(struct hda_codec *codec, hda_nid_t nid,
 					   label, maxlen, indexp);
 	case AC_JACK_SPDIF_OUT:
 	case AC_JACK_DIG_OTHER_OUT:
-		if (get_defcfg_location(def_conf) == AC_JACK_LOC_HDMI)
-			name = "HDMI";
-		else
-			name = "SPDIF";
-		if (cfg && indexp) {
-			i = find_idx_in_nid_list(nid, cfg->dig_out_pins,
-						 cfg->dig_outs);
-			if (i >= 0)
-				*indexp = i;
-		}
+		hdmi = get_defcfg_location(def_conf) == AC_JACK_LOC_HDMI;
+		name = hdmi ? "HDMI" : "SPDIF";
+		if (cfg && indexp)
+			for (i = 0; i < cfg->dig_outs; i++) {
+				unsigned int c;
+				if (cfg->dig_out_pins[i] == nid)
+					break;
+				c = snd_hda_codec_get_pincfg(codec, cfg->dig_out_pins[i]);
+				if (hdmi == (get_defcfg_location(c) == AC_JACK_LOC_HDMI))
+					(*indexp)++;
+			}
 		break;
 	default:
 		if (cfg) {
-- 
1.7.9.5
